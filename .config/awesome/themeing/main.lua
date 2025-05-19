local gears = require('gears')
local beautiful = require('beautiful')
local hotkeys_popup = require("awful.hotkeys_popup")
local set_wallpaper = require('themeing.set_wallpaper')


beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/nabakolu/theme.lua")

hotkeys_popup.widget.labels = {
    XF86AudioMute = "󰖁",
    XF86AudioLowerVolume = "",
    XF86AudioRaiseVolume = "󰕾",
    XF86AudioMicMute = "󰍭",
    XF86MonBrightnessDown = "󰃞",
    XF86MonBrightnessUp = "󰃠",
    Return = "Enter",
    BackSpace = "Backspace",
    Delete = "Delete",
    XF86AudioPrev = "󰒮",
    XF86AudioNext = "󰒭",
    XF86AudioStop = "󰓛",
    XF86AudioPlay = "󰐊",
    space = "Space",
    Up = "",
    Down = "",
    Left = "",
    Right = "",
    Control = "Ctrl",
    Mod4 = "",
    Shift = "󰜷",
}

-- set wallpaper
set_wallpaper()
