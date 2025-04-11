local awful = require("awful")
local wibox = require("wibox")


local layoutbox = wibox.widget.textbox()

local function update_layoutbox()
    local layout = awful.layout.get()
    local symbol = tostring(layout.name)

    if layout.name == "max" then
        symbol = "󰝤 "
    elseif layout.name == "tile" then
        symbol = "󰙀 "
    elseif layout.name == "tilebottom" then
        symbol = "󱢈 "
    elseif layout.name == "horizontal" then
        symbol = "󰕭 "
    elseif layout.name == "fairv" then
        symbol = "󰕰 "
    elseif layout.name == "vertical" then
        symbol = "󰜨 "
    elseif layout.name == "floating" then
        symbol = "󰪏 "
    elseif layout.name == "deck.layout.right" then
        symbol = " "
    end

    layoutbox.markup = symbol
end

update_layoutbox()

tag.connect_signal("property::layout", update_layoutbox)

return layoutbox
