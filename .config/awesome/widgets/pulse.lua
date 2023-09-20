local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Pulse
local pulse = wibox.widget.textbox()
local volume
local icon

local tooltip = awful.tooltip { }
tooltip:add_to_object(pulse)
tooltip.mode = "inside"
tooltip.gaps = 5

pulse:connect_signal("mouse::enter", function()
    local script = [[ pactl get-default-sink ]]
    awful.spawn.easy_async_with_shell(script, function(stdout)
        tooltip.text = tostring(stdout)
    end)
end)

local function update_volume()
    local scriptVolume = [[
    pamixer --get-volume
    ]]
    local handle = io.popen(scriptVolume)
    volume = string.gsub(handle:read("*a"),"\n","%%")
    handle:close()
end

local function update_icon()
    local bt = false
    local scriptMute = [[
    pamixer --get-mute
    ]]
    local scriptSink = [[
    pamixer --get-default-sink
    ]]
    local handle = io.popen(scriptSink)
    if handle:read("*a"):find("bluez",1,true) then
        bt = true
    end
    local handle = io.popen(scriptMute)
    if handle:read("*a"):find("false",1,true) then
        if bt then
            icon = ""
        else
            icon = "墳"
        end
    else
        if bt then
            icon = ""
        else
            icon = "婢"
        end
    end
    handle:close()
end

local function update_all()
    update_volume()
    update_icon()
    pulse.markup = icon..volume
end

gears.timer {
    timeout = 10,
    autostart = true,
    call_now = true,
    callback = function() update_all() end
}


awesome.connect_signal('update-pulse-volume', function()
    update_volume()
    pulse.markup = icon..volume
end)

awesome.connect_signal('update-pulse-icon', function()
    update_icon()
    pulse.markup = icon..volume
end)

pulse:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.spawn("pamixer -t"); update_icon(); pulse.markup = icon..volume end)))
return pulse
