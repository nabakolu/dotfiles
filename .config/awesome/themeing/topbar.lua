local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

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
    end),
    awful.button({}, 3, function(c)
        c.minimized = not c.minimized
    end)
)


awful.screen.connect_for_each_screen(function(s)
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
        shape      = gears.shape.rect,
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
            shape        = gears.shape.rect,
        },
        layout          = {
            spacing = 5,
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
    local datetime = require("widgets.datetime")
    s.mydatetime_widget = wibox.widget {
        {
            datetime,
            left   = 10,
            top    = 0,
            bottom = 0,
            right  = 10,
            widget = wibox.container.margin,

        },

        bg         = beautiful.bg_textclock,
        fg         = beautiful.fg_textclock,
        shape      = gears.shape.rect,
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
        shape      = gears.shape.rect,
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
        shape      = gears.shape.rect,
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
        shape      = gears.shape.rect,
        shape_clip = true,
        widget     = wibox.container.background,
    }

    -- local weather = require("widgets.weather")
    -- s.myweather = wibox.widget {
    --     {
    --         weather,
    --         left   = 3,
    --         top    = 0,
    --         bottom = 0,
    --         right  = 5,
    --         widget = wibox.container.margin,
    --     },
    --     bg         = beautiful.bg_wifi,
    --     fg         = beautiful.fg_wifi,
    --     shape      = gears.shape.rect,
    --     shape_clip = true,
    --     widget     = wibox.container.background,
    -- }

    local battery = require("widgets.battery")
    if battery_check_available() then
        s.mybattery = wibox.widget {
            {
                battery,
                left   = 3,
                top    = 0,
                bottom = 0,
                right  = 5,
                widget = wibox.container.margin,
            },
            bg         = beautiful.bg_battery,
            fg         = beautiful.fg_battery,
            shape      = gears.shape.rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
    end
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
    s.mywibar = awful.wibar({
        position = "top",
        screen = s,
        visible = true,
        fg = beautiful.bg_bar .. "0",
        bg = beautiful
            .bg_bar .. "0",
        height = 16,
        margins = 5
    })

    -- Add widgets to the wibox
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.myspacing,
        },
        s.mytasklist, -- Middle widget
        {             -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 4,
            s.myspacing,
            s.mywifi,
            s.myweather,
            s.myaudio_widget,
            s.mybattery,
            s.mysystray,
            s.mydatetime_widget,
        },
    }
end)
