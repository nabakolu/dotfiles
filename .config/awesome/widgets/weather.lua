local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"

-- Weather
local weather = wibox.widget.textbox()
local tooltip = awful.tooltip { }
tooltip:add_to_object(weather)
tooltip.mode = "inside"
tooltip.gaps = 5

weather:connect_signal("mouse::enter", function()
    local script = [[
	if [ -f ~/.config/location ]; then     curl wttr.in/$(cat ~/.config/location)?0qT || echo "connection failed"; else     echo "please set a location"; fi
	]]
    awful.spawn.easy_async_with_shell(script, function(stdout)
        tooltip.text = tostring(stdout:gsub("\n[^\n]*$", ""))
    end)
    local script2 = [[
	if [ -f ~/.config/location ]; then     curl wttr.in/$(cat ~/.config/location)?format="+%t+%c" || echo "failed"; else     echo "no location"; fi
	]]

    awful.spawn.easy_async_with_shell(script2, function(stdout)
        weather.markup = tostring(stdout:gsub("%s+$", ""))
    end)
end)

weather:connect_signal("button::press", function()
    local script = [[ 
        location=$(echo "" | dmenu -p "Enter location") && echo $location > ~/.config/location
    ]]
    awful.spawn.easy_async_with_shell(script, function(stdout)
    end)
end)

local function get_weather()
    local script = [[
	if [ -f ~/.config/location ]; then     curl wttr.in/$(cat ~/.config/location)?format="+%t+%c" || echo "failed"; else     echo "no location"; fi
	]]

    awful.spawn.easy_async_with_shell(script, function(stdout)
        weather.markup = tostring(stdout:gsub("%s+$", ""))
    end)
end

gears.timer {
    timeout = 3600,
    autostart = true,
    call_now = true,
    callback = function() get_weather() end
}

return weather
