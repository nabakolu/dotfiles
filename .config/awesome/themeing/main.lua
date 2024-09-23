local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local hotkeys_popup = require("awful.hotkeys_popup")


beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/nabakolu/theme.lua")

hotkeys_popup.widget.labels = {
    XF86AudioMute = "󰖁",
    XF86AudioLowerVolume = "",
    XF86AudioRaiseVolume = "󰕾",
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
awful.spawn.with_shell("~/.fehbg")
