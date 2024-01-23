---------------------------------------------
-- Awesome theme which follows xrdb config --
--   by Yauhen Kirylau                     --
--   modified by nabakolu                  --
---------------------------------------------

local theme_assets             = require("beautiful.theme_assets")
local xresources               = require("beautiful.xresources")
local dpi                      = xresources.apply_dpi
local xrdb                     = xresources.get_current_theme()
local gfs                      = require("gears.filesystem")
local themes_path              = gfs.get_themes_dir()
local naughty                  = require("naughty")
local gears                    = require("gears")
local rnotification            = require("ruled.notification")

-- inherit default theme
local theme                    = dofile(themes_path .. "default/theme.lua")
-- load vector assets' generators for this theme

theme.font                     = "Roboto Mono Nerd Font 11"

theme.bg_normal                = xrdb.color0
theme.bg_focus                 = xrdb.color1
theme.bg_urgent                = xrdb.color9
theme.bg_minimize              = xrdb.color8

theme.fg_normal                = xrdb.foreground
theme.fg_focus                 = theme.bg_normal
theme.fg_urgent                = theme.bg_normal
theme.fg_minimize              = theme.bg_normal

theme.taglist_font             = "Roboto Mono Nerd Font 13"
theme.taglist_bg               = xrdb.color0
theme.taglist_fg               = xrdb.color7
theme.taglist_fg_focus         = xrdb.color0
theme.taglist_bg_focus         = xrdb.color1
theme.taglist_fg_urgent        = xrdb.color0
theme.taglist_bg_urgent        = xrdb.color7
theme.taglist_fg_occupied      = theme.taglist_fg
theme.taglist_bg_occupied      = theme.taglist_bg
theme.taglist_fg_empty         = theme.taglist_fg
theme.taglist_bg_empty         = theme.taglist_bg
theme.taglist_fg_volatile         = theme.taglist_fg
theme.taglist_bg_volatile         = theme.taglist_bg
theme.taglist_spacing          = 3

theme.tasklist_bg_focus        = xrdb.color1
theme.tasklist_fg_focus        = xrdb.color0
theme.tasklist_bg_normal       = xrdb.color0
theme.tasklist_disable_icon    = false
theme.tasklist_plain_task_name = true

theme.bg_systray               = xrdb.color0


theme.bg_audio                = xrdb.color0
theme.fg_audio                = xrdb.color7

theme.bg_textclock            = xrdb.color0
theme.fg_textclock            = xrdb.color7

theme.bg_wifi                 = xrdb.color0
theme.fg_wifi                 = xrdb.color7

theme.bg_battery              = xrdb.color0
theme.fg_battery              = xrdb.color7

theme.bg_bar                  = xrdb.color0

theme.useless_gap             = 3 -- dpi(3)
theme.border_width            = dpi(2)
theme.border_normal           = xrdb.color8
theme.border_focus            = theme.bg_focus
theme.border_marked           = xrdb.color10

theme.notification_icon_size  = 32
theme.notification_shape      = gears.shape.rect
theme.notification_max_width  = 400
theme.notification_max_height = 200


rnotification.connect_signal('request::rules', function()
    -- Critical notifs
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = {
            bg               = xrdb.background,
            fg               = xrdb.color4,
            border_color     = xrdb.color4,
            implicit_timeout = 0,
        }
    }

    -- Normal notifs
    rnotification.append_rule {
        rule       = { urgency = 'normal' },
        properties = {
            bg               = xrdb.background,
            fg               = xrdb.foreground,
            border_color     = xrdb.foreground,
            implicit_timeout = 10,
        }
    }

    -- Low notifs
    rnotification.append_rule {
        rule       = { urgency = 'low' },
        properties = {
            bg               = xrdb.background,
            fg               = xrdb.foreground,
            border_color     = xrdb.foreground,
            implicit_timeout = 10,
        }
    }
end
)



theme.tooltip_fg = xrdb.foreground
theme.tooltip_bg = xrdb.background
theme.tooltip_border_width = 1
theme.tooltip_border_color = xrdb.foreground
theme.tooltip_shape = gears.shape.rectangle


theme.hotkeys_font             = "Roboto Mono Nerd Font 13"
theme.hotkeys_description_font = "Roboto Mono Nerd Font 10"
theme.hotkeys_group_margin     = 50

-- Generate taglist squares:
local taglist_square_size      = dpi(4)
theme.taglist_squares_sel      = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.taglist_fg_focus
)
theme.taglist_squares_unsel    = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.taglist_fg_empty
)


return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
