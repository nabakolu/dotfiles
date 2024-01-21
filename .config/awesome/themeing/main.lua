local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local hotkeys_popup = require("awful.hotkeys_popup")


beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/nabakolu/theme.lua")

hotkeys_popup.widget.labels = {
    XF86AudioMute = "婢",
    XF86AudioLowerVolume = "",
    XF86AudioRaiseVolume = "墳",
    Return = "Enter",
    BackSpace = "Backspace",
    Delete = "Delete",
    XF86AudioPrev = "玲",
    XF86AudioNext = "怜",
    XF86AudioStop = "栗",
    XF86AudioPlay = "契",
    space = "Space",
    Up = "",
    Down = "",
    Left = "",
    Right = "",
    Control = "Ctrl",
    Mod4 = "",
    Shift = "ﰵ",
}

-- set wallpaper
awful.spawn.with_shell("~/.fehbg")
