local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"

-- Pulse
local pulse = wibox.widget.textbox()
local volume
local icon

local tooltip = awful.tooltip { }
tooltip:add_to_object(pulse)
tooltip.mode = "inside"
tooltip.gaps = 5


local function get_default_sink_description()
    local def_handle = io.popen("pactl get-default-sink")
    if not def_handle then return "unknown" end
    local default_sink = def_handle:read("*a"):gsub("%s+", "")
    def_handle:close()

    local handle = io.popen("pactl list sinks")
    if not handle then return "unknown" end
    local sinks_output = handle:read("*a")
    handle:close()

    local current_name = nil
    for line in sinks_output:gmatch("[^\r\n]+") do
        local name = line:match("^%s*Name:%s*(.+)$")
        if name then
            current_name = name:gsub("%s+", "")
        end

        local desc = line:match("^%s*Description:%s*(.+)$")
        if desc and current_name == default_sink then
            return desc
        end
    end

    return "unknown"
end

pulse:connect_signal("mouse::enter", function()
    tooltip.text = get_default_sink_description()
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
            icon = "󰂰"
        else
            icon = "󰕾"
        end
    else
        if bt then
            icon = "󰂲"
        else
            icon = "󰖁"
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
    awful.button({ }, 1, function () awful.spawn("pamixer -t"); update_icon(); pulse.markup = icon..volume end),
    awful.button({ }, 3, function () awful.spawn(terminal .. " -e pulsemixer"); update_icon(); pulse.markup = icon..volume end)
    ))
return pulse
