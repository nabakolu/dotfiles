local gears = require('gears')
local awful = require('awful')
local naughty = require('naughty')
local hotkeys_popup = require("awful.hotkeys_popup")
local vertical = require('layouts.vertical')
local horizontal = require('layouts.horizontal')
local deck = require('layouts.deck')


globalkeys = gears.table.join(
    -- awesome
    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),
    awful.key({ modkey, }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "e", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey, }, "Delete", function() naughty.destroy_all_notifications() end,
        { description = "close all notifications", group = "awesome" }),
    awful.key({ modkey, }, "b", function() awful.screen.focused().mywibar.visible = not awful.screen.focused().mywibar.visible end,
        { description = "toggle top bar", group = "awesome" }),
    awful.key({ modkey, }, "w", function() awful.spawn("dswitcher") end,
        { description = "window switcher", group = "awesome" }),
    awful.key({ modkey, "Control"}, "k", function () awful.screen.focus_relative(1) end, 
        {description = "Focus the next screen", group = "screens"}),
    awful.key({ modkey, "Control"}, "j", function () awful.screen.focus_relative(-1) end, 
        {description = "Focus the previous screen", group = "screens"}),

    -- client
    awful.key({ modkey, }, "Right",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, }, "Left",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ), awful.key({ modkey, }, "l",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, }, "h",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key({ modkey, }, "y",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, }, "x",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key({ modkey, }, "Down", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, }, "Up", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),

    -- layout
    awful.key({ modkey, }, "i", function() awful.layout.set(awful.layout.suit.max) end,
        { description = "monocle layout", group = "layout" }),
    awful.key({ modkey, }, "t", function() awful.layout.set(awful.layout.suit.tile) end,
        { description = "tiling layout", group = "layout" }),
    awful.key({ modkey, "Shift" }, "t", function() awful.layout.set(awful.layout.suit.fair) end,
        { description = "fair layout", group = "layout" }),
    awful.key({ modkey, "Shift", "Control" }, "t", function() awful.layout.set(awful.layout.suit.tile.bottom) end,
        { description = "horizontal tiling layout", group = "layout" }),
    awful.key({ modkey, "Shift" }, "v", function() awful.layout.set(vertical) end,
        { description = "vertical layout", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function() awful.layout.set(horizontal) end,
        { description = "horizontal layout", group = "layout" }),
    awful.key({ modkey, "Shift" }, "i", function() awful.layout.set(deck.layout.right) end,
        { description = "deck layout", group = "layout" }),


    -- spawn
    awful.key({ modkey, "Control" }, "Return", function()
        awful.spawn(floating_terminal)
    end,
        { description = "floating terminal", group = "applications" }),
    awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
        { description = "terminal", group = "applications" }),

    awful.key({ modkey, "Control" }, "BackSpace", function()
        awful.spawn(floating_terminal .. " -e lf")
    end,
        { description = "floating lf", group = "applications" }),
    awful.key({ modkey, }, "BackSpace", function() awful.spawn(terminal .. " -e lf") end,
        { description = "lf", group = "applications" }),

    awful.key({ modkey, }, "f", function() awful.spawn.with_shell("qutebrowser --qt-arg stylesheet ~/.config/qutebrowser/qss/fix-tooltips.qss") end,
        { description = "qutebrowser", group = "applications" }),

    awful.key({ modkey, "Control" }, "p", function()
        awful.spawn(floating_terminal .. " -e pulsemixer")
    end,
        { description = "floating pulsemixer", group = "applications" }),
    awful.key({ modkey, }, "p", function() awful.spawn(terminal .. " -e pulsemixer") end,
        { description = "pulsemixer", group = "applications" }),

    awful.key({ modkey, "Control" }, "m", function()
        awful.spawn(floating_terminal .. " -e mocp")
    end,
        { description = "floating mocp", group = "applications" }),
    awful.key({ modkey, }, "m", function() awful.spawn(terminal .. " -e mocp") end,
        { description = "mocp", group = "applications" }),

    awful.key({ modkey, "Control" }, "n", function()
        awful.spawn(floating_terminal .. " -e neomutt")
    end,
        { description = "floating neomutt", group = "applications" }),
    awful.key({ modkey, }, "n", function() awful.spawn(terminal .. " -e neomutt") end,
        { description = "neomutt", group = "applications" }),

    awful.key({ modkey, "Shift", "Control" }, "n", function()
        awful.spawn(floating_terminal .. " -e newsboat")
    end,
        { description = "floating newsboat", group = "applications" }),
    awful.key({ modkey, "Shift" }, "n", function() awful.spawn(terminal .. " -e newsboat") end,
        { description = "newsboat", group = "applications" }),

    awful.key({ modkey, }, "d", function() awful.spawn("j4-dmenu-desktop --case-insensitive --no-generic") end,
        { description = "app launcher", group = "applications" }),

    -- audio
    awful.key({}, "XF86AudioPlay", function() awful.spawn("mocp -G") end,
        { description = "toggle play/pause", group = "audio" }),
    awful.key({}, "XF86AudioStop", function() awful.spawn("mocp -s") end,
        { description = "stop", group = "audio" }),
    awful.key({}, "XF86AudioNext", function() awful.spawn("mocp -f") end,
        { description = "next track", group = "audio" }),
    awful.key({}, "XF86AudioPrev", function() awful.spawn("mocp -r") end,
        { description = "previous track", group = "audio" }),

    -- volume
    awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn("pamixer -i 1"); awesome.emit_signal('update-pulse-volume') end,
        { description = "raise volume", group = "volume" }),
    awful.key({}, "XF86AudioLowerVolume", function() awful.spawn("pamixer -d 1") ; awesome.emit_signal('update-pulse-volume')end,
        { description = "lower volume", group = "volume" }),
    awful.key({}, "XF86AudioMute", function() awful.spawn("pamixer -t"); awesome.emit_signal('update-pulse-icon')end,
        { description = "toggle mute", group = "volume" }),

    -- brightness
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn("brightnessctl set 5%-") end,
        { description = "lower brightness", group = "brightness" }),
    awful.key({}, "XF86MonBrightnessUp", function() awful.spawn("brightnessctl set +5%") end,
        { description = "increase brightness", group = "brightness" }),

    -- misc
    awful.key({ modkey, }, "u", function() awful.spawn("dmenuunicode") end,
        { description = "emoji selection", group = "misc" }),
    awful.key({ modkey, }, "e", function() awful.spawn("power") end,
        { description = "power menu", group = "misc" }),
    awful.key({ modkey, }, "g", function() awful.spawn("clipmenu") end,
        { description = "clipmenu", group = "misc" }),
    awful.key({ modkey, }, "o", function() awful.spawn("urlopener.sh") end,
        { description = "urlopener", group = "misc" }),
    awful.key({ modkey, }, "Print", function() awful.spawn("screenshot") end,
        { description = "screen", group = "misc" }),
    awful.key({ modkey, }, "Home", function() awful.spawn("screenshot") end,
        { description = "screen", group = "misc" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.spawn("lock") end,
        { description = "lock screen", group = "misc" }),
    awful.key({ modkey, "Shift" }, "d", function() awful.spawn("dmenu_run") end,
        { description = "run prompt", group = "misc" }),
    awful.key({ modkey, }, "#", function() awful.spawn("toggle_p.sh") end,
        { description = "toggle picom", group = "misc" })
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 5 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

root.keys(globalkeys)
