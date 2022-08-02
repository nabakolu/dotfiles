-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/nabakolu/theme.lua")


-- This is used later as the default terminal and editor to run.
terminal = "st"
floating_terminal = "st -c FLOATING"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.floating,
}
-- }}}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal(
            "request::activate",
            "tasklist",
            { raise = true }
        )
    end),
    awful.button({}, 2, function(c)
        c:kill()
    end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)

    -- Each screen has its own tag table.
    awful.tag({ "  ", "  ", "  ", "  ", "  " }, s, awful.layout.layouts[1])

    -- Create a taglist widget
    s.mytaglist = wibox.widget {
        {
            awful.widget.taglist {
                screen  = s,
                filter  = awful.widget.taglist.filter.all,
                buttons = taglist_buttons
            }
            ,
            left   = 10,
            top    = 0,
            bottom = 0,
            right  = 10,
            widget = wibox.container.margin,
        },
        bg         = beautiful.taglist_bg,
        shape      = gears.shape.rounded_rect,
        shape_clip = true,
        widget     = wibox.container.background,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen          = s,
        filter          = awful.widget.tasklist.filter.currenttags,
        buttons         = tasklist_buttons,
        style           = {
            border_width = 1,
            shape        = gears.shape.rounded_bar,
        },
        layout          = {
            spacing = 2,
            layout  = wibox.layout.flex.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id     = "icon_role",
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left   = 10,
                right  = 10,
                widget = wibox.container.margin
            },
            id     = "background_role",
            widget = wibox.container.background,
        },
    }

    -- textclock
    s.myclock = wibox.widget {
        {
            wibox.widget.textclock(' %a %b %d  %H:%M'),
            left   = 10,
            top    = 0,
            bottom = 0,
            right  = 10,
            widget = wibox.container.margin,
        },

        bg         = beautiful.bg_textclock,
        fg         = beautiful.fg_textclock,
        shape      = gears.shape.rounded_rect,
        shape_clip = true,
        widget     = wibox.container.background,
    }

    -- systray
    s.mysystray = wibox.widget {
        {
            wibox.widget.systray(),
            left   = 10,
            top    = 0,
            bottom = 0,
            right  = 10,
            widget = wibox.container.margin,
        },
        bg         = beautiful.bg_systray,
        shape      = gears.shape.rounded_rect,
        shape_clip = true,
        widget     = wibox.container.background,
    }

    local pulse = require("widgets.pulse")
    s.myaudio_widget = wibox.widget {
        {
            pulse,
            left   = 10,
            top    = 0,
            bottom = 0,
            right  = 10,
            widget = wibox.container.margin,
        },
        bg         = beautiful.bg_audio,
        fg         = beautiful.fg_audio,
        shape      = gears.shape.rounded_rect,
        shape_clip = true,
        widget     = wibox.container.background,
    }

    local wifi = require("widgets.wifi")
    s.mywifi = wibox.widget {
        {
            wifi,
            left   = 3,
            top    = 0,
            bottom = 0,
            right  = 5,
            widget = wibox.container.margin,
        },
        bg         = beautiful.bg_wifi,
        fg         = beautiful.fg_wifi,
        shape      = gears.shape.rounded_rect,
        shape_clip = true,
        widget     = wibox.container.background,
    }

    s.myspacing = wibox.widget {
        {
            forced_width = 10,
            widget       = wibox.widget { widget = wibox.widget.textbox }
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
    }

    -- Create the wibox
    s.mywibar = awful.wibar({ position = "top", screen = s, fg = beautiful.bg_bar, height = 16 })

    -- Add widgets to the wibox
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.myspacing,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 4,
            s.myspacing,
            s.mywifi,
            s.myaudio_widget,
            s.mysystray,
            s.myclock,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(

))
-- }}}

-- {{{ Key bindings
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

    awful.key({ modkey, }, "d", function() awful.spawn("j4-dmenu-desktop --no-generic") end,
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

clientkeys = gears.table.join(
    awful.key({ modkey, "Shift"}, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift" }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" })
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

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = {}, except = { class = "league of legends.exe" },
        properties = { border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen + awful.placement.centered,
        }
    },
    { rule_any = { class = { "qutebrowser" } }, properties = { tag = root.tags()[1] } },
    { rule_any = { class = { "discord" } }, properties = { tag = root.tags()[2] } },

    { rule_any = { class = { "FLOATING" } },
        properties = {
            focus     = awful.client.focus.filter,
            screen    = mouse.screen.preferred,
            placement = awful.placement.centered,
            floating  = true
        }
    },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

client.connect_signal("manage", function(c)
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


client.connect_signal("manage", function (c)
    c.shape = gears.shape.rounded_rect
end)

client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.shape = gears.shape.rect
    else
    c.shape = gears.shape.rounded_rect
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- set wallpaper
awful.spawn.with_shell("~/.fehbg")
