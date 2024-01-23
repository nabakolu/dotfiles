local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local clientbuttons = require('control.clientbuttons')
local clientkeys = require('control.clientkeys')
local whatsdeskkeys = require('control.whatsdeskkeys')
local discordkeys = require('control.discordkeys')
local keepassxckeys = require('control.keepassxckeys')


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
            maximized_vertical   = false,
            maximized_horizontal = false,
            titlebars_enabled = true
        }
    },
    { rule_any = { class = { "qutebrowser" } }, properties = { tag = root.tags()[1] } },
    { rule_any = { class = { "discord" } }, properties = { keys = gears.table.join(clientkeys, discordkeys),  tag = root.tags()[2] } },
    { rule_any = { class = { "whatsdesk" } }, properties = { keys = gears.table.join(clientkeys, whatsdeskkeys),  tag = root.tags()[2] } },
    { rule_any = { name = { "Auto-Type - KeePassXC" } }, properties = { keys = gears.table.join(clientkeys, keepassxckeys) } },


    { rule_any = { class = { "FLOATING" } },
        properties = {
            focus     = awful.client.focus.filter,
            screen    = mouse.screen.preferred,
            placement = awful.placement.centered,
            floating  = true
        }
    },
}
