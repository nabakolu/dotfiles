local gears = require('gears')
local beautiful = require('beautiful')
local hotkeys_popup = require("awful.hotkeys_popup")
local set_wallpaper = require('themeing.set_wallpaper')


beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/nabakolu/theme.lua")

-- set wallpaper
set_wallpaper()
