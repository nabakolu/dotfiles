---------------------------------------------
-- Awesome theme which follows xrdb config --
--   by Yauhen Kirylau                     --
--   modified by nabakolu                  --
---------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local naughty = require("naughty")
local gears = require("gears")
local rnotification = require("ruled.notification")

-- inherit default theme
local theme = dofile(themes_path.."default/theme.lua")
-- load vector assets' generators for this theme

theme.font          = "nabakolu 11"

theme.bg_normal     = xrdb.color0
theme.bg_focus      = xrdb.color12
theme.bg_urgent     = xrdb.color9
theme.bg_minimize   = xrdb.color8

theme.fg_normal     = xrdb.foreground
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.bg_normal

theme.taglist_font = "nabakolu 13"
theme.taglist_fg_focus    = xrdb.color1
theme.taglist_bg_focus    = xrdb.color0
theme.taglist_fg_occupied    = xrdb.color0
theme.taglist_fg_empty    = xrdb.color0
theme.taglist_fg_urgent  = xrdb.color0
theme.taglist_bg_urgent  = xrdb.color2
theme.taglist_bg = xrdb.color1
theme.taglist_spacing = 3

theme.tasklist_bg_focus = xrdb.color2
theme.tasklist_bg_normal = xrdb.color8
theme.tasklist_disable_icon = false
theme.tasklist_plain_task_name=true

theme.bg_systray = xrdb.color6


theme.bg_audio = xrdb.color3
theme.fg_audio = xrdb.color0

theme.bg_textclock = xrdb.color5
theme.fg_textclock = xrdb.color0

theme.bg_wifi = xrdb.color4
theme.fg_wifi = xrdb.color0

theme.bg_battery = xrdb.color7
theme.fg_battery = xrdb.color0

theme.bg_bar = xrdb.color0

theme.useless_gap   = 3 -- dpi(3)
theme.border_width  = dpi(2)
theme.border_normal = xrdb.color8
theme.border_focus  = theme.bg_focus
theme.border_marked = xrdb.color10


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.notification_icon_size = 32
theme.notification_shape = gears.shape.rect
theme.notification_max_width = 400
theme.notification_max_height = 200

rnotification.connect_signal('request::rules', function()
      -- Critical notifs
      rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = {
          bg                  = xrdb.background,
          fg                  = xrdb.color4,
          border_color        = xrdb.color4,
          implicit_timeout    = 0,
        }
      }

      -- Normal notifs
      rnotification.append_rule {
        rule       = { urgency = 'normal' },
        properties = {
          bg                  = xrdb.background,
          fg                  = xrdb.foreground,
          border_color        = xrdb.foreground,
          implicit_timeout    = 10,
        }
      }

      -- Low notifs
      rnotification.append_rule {
        rule       = { urgency = 'low' },
        properties = {
          bg                  = xrdb.background,
          fg                  = xrdb.foreground,
          border_color        = xrdb.foreground,
          implicit_timeout    = 10,
        }
      }
  end
  )



theme.tooltip_fg = xrdb.foreground
theme.tooltip_bg = xrdb.background
theme.tooltip_border_width = 1
theme.tooltip_border_color = xrdb.foreground

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.taglist_fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.taglist_fg_empty
)


return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
