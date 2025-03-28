local awful = require("awful")

local function set_wallpaper(s)
    awful.spawn.with_shell("~/.fehbg")
end

return set_wallpaper
