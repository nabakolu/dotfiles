local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi


client.connect_signal("request::titlebars", function(c)
    local buttons = awful.util.table.join(
        awful.button({}, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    local top_titlebar = awful.titlebar(c, {
        position = "top",
        size = beautiful.titlebar_size,
        font = beautiful.titlebar_font,
        bg = beautiful.border_normal
    })
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )
    top_titlebar:setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            {
                align  = 'center',
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            { awful.titlebar.widget.floatingbutton(c), widget = wibox.container.margin, margins = { right = dpi(2) } },
            { awful.titlebar.widget.closebutton(c),    widget = wibox.container.margin, margins = { right = dpi(2) } },
            layout = wibox.layout.align.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
