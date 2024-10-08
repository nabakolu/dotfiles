-- This project is licensed under the MIT License (see LICENSE).

--- A tiling layout featuring two visible tiled clients.
--
-- @author James Reed &lt;jcrd@tuta.io&gt;
-- @copyright 2019-2020 James Reed
-- @module awesome-deck

local awful = require("awful")
local gears = require("gears")

local deck = {}

--- Override this function to change how deck determines the current tag.
--- The function takes the current screen.
--
-- @param s The current screen.
-- @usage deck.get_tag = custom_get_tag
-- @function get_tag
function deck.get_tag(s)
    return s.selected_tag
end

local function arrange(p, ornt, mirror)
    ornt = ornt or "horizontal"

    local w = "width"
    local x = "x"
    if ornt == "vertical" then
        w = "height"
        x = "y"
    end

    local tag = p.tag or deck.get_tag(screen[p.screen])
    local mwfact = tag.master_width_factor
    local cls = p.clients
    local wa = p.workarea

    if #cls == 0 then
        return
    end

    -- Client geometries are directly manipulated by awesome.
    -- See https://github.com/awesomeWM/awesome/issues/2676
    local function new_geom(g)
        return {x = g.x, y = g.y, width = g.width, height = g.height}
    end

    local function set_geom(c, g)
        p.geometries[c] = new_geom(g)
    end

    local function arrange_stack(g)
        for i, c in ipairs(cls) do
            if i > 1 then
                set_geom(c, g)
            end
        end
    end

    local master = cls[1]

    if #cls == 1 then
        set_geom(master, wa)
    else
        local mw = wa[w] * mwfact
        local master_g = new_geom(wa)
        local stack_g = new_geom(wa)

        master_g[w] = mw
        stack_g[x] = wa[x] + mw
        stack_g[w] = wa[w] - mw

        if mirror then
            set_geom(master, stack_g)
            arrange_stack(master_g)
        else
            set_geom(master, master_g)
            arrange_stack(stack_g)
        end
    end
end

deck.layout = {}

--- Check if a layout is a deck layout.
--
-- @param layout The layout or the current layout if nil.
-- @return `true` if layout is a deck layout.
-- @function layout
setmetatable(deck.layout, {__call = function (_, layout)
    return gears.string.startswith(awful.layout.getname(layout), "deck")
end})

function deck.layout.skip_gap(nclients)
    return nclients == 1
end

--- Horizontally tiled layout with stack on the right.
--
-- @function layout.right
deck.layout.right = {
    name = "deck.layout.right",
    arrange = arrange,
    skip_gap = deck.layout.skip_gap,
}

--- Horizontally tiled layout with stack on the left.
--
-- @function layout.left
deck.layout.left = {
    name = "deck.layout.left",
    arrange = function (p) arrange(p, "horizontal", true) end,
    skip_gap = deck.layout.skip_gap,
}

--- Vertically tiled layout with stack on the bottom.
--
-- @function layout.bottom
deck.layout.bottom = {
    name = "deck.layout.bottom",
    arrange = function (p) arrange(p, "vertical") end,
    skip_gap = deck.layout.skip_gap,
}

--- Vertically tiled layout with stack on the top.
--
-- @function layout.top
deck.layout.top = {
    name = "deck.layout.top",
    arrange = function (p) arrange(p, "vertical", true) end,
    skip_gap = deck.layout.skip_gap,
}

local function set_focus(c, name)
    if c then
        c:emit_signal("request::activate", name, {raise=true})
    end
end

local function get_clients(s)
    local m = awful.client.getmaster(s)
    for _, c in ipairs(s.tiled_clients) do
        if c ~= m then
            return m, c
        end
    end
    return m, nil
end

local function with_focus(func, c)
    c = c or client.focus
    if c then
        return func(c, get_clients(c.screen))
    end
end

deck.focus = {}

--- Focus a client in the stack by its relative index.
-- @param i The index.
-- @return `true` if conditions were met to search for a client.
-- If `false`, a fallback `focus.byidx` method should be used.
-- @function focus.byidx
function deck.focus.byidx(i)
    local name = "deck.focus.byidx"
    if not deck.layout() then
        return false
    end
    return with_focus(function (c, master, stack)
        if c.floating then
            return false
        end
        if c == master then
            if not stack then
                return false
            end
            c = stack
        end
        local n = awful.client.next(i, c)
        while n and n ~= c do
            if n ~= master then
                set_focus(n, name)
                break
            end
            n = awful.client.next(i, n)
        end
        return true
    end)
end

--- If the master client is focused, focus the visible client in the stack, and
--- vice versa.
-- @function focus.other
function deck.focus.other()
    local name = "deck.focus.other"
    with_focus(function (c, master, stack)
        if c == master then
            set_focus(stack, name)
        else
            set_focus(master, name)
        end
    end)
end

deck.master = {}

--- Swap master client with top stack, focusing stack.
-- @param no_swap If `true`, only swaps if master client is focused.
-- @function master.demote
function deck.master.demote(no_swap)
    local name = "deck.master.demote"
    with_focus(function (c, master, stack)
        if c == stack and no_swap then
            return
        end
        awful.client.setmaster(stack)
        if c ~= master then
            set_focus(master, name)
        end
    end)
end

--- Swap top stack client with master, focusing master.
-- @param no_swap If `true`, only swaps if top stack client is focused.
-- @function master.promote
function deck.master.promote(no_swap)
    local name = "deck.master.promote"
    with_focus(function (c, master, stack)
        if c == master and no_swap then
            return
        end
        if master then
            master:raise()
        end
        awful.client.setmaster(stack)
        set_focus(stack, name)
    end)
end

--- Send master client to bottom of stack and replace with top stack client,
--- maintaining focus.
-- @function master.cycle
function deck.master.cycle()
    local name = "deck.master.cycle"
    with_focus(function (c, master, stack)
        if master then
            master:lower()
        end
        local next = awful.client.next(1, stack, true)
        awful.client.setmaster(stack)
        if c == stack then
            stack = next
        end
        set_focus(stack, name)
    end)
end

return deck
