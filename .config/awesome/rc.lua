pcall(require, "luarocks.loader")
local awful = require("awful")
require("awful.autofocus")
local naughty = require("naughty")


if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err) })
        in_error = false
    end)
end

terminal = "st"
floating_terminal = "st -c FLOATING"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"


awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.floating,
}


require('themeing.main')
require('themeing.topbar')
require('themeing.titlebar')
require('control.globalkeys')
require('util.rules')
require('util.signals')
