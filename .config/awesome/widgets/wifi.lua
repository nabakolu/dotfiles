local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Wifi
local wifi = wibox.widget.textbox()
local tooltip = awful.tooltip { }
tooltip:add_to_object(wifi)
tooltip.mode = "inside"
tooltip.gaps = 5

wifi:connect_signal("mouse::enter", function()
    local script = [[ nmcli con show --active | tail -n +2 ]]
    awful.spawn.easy_async_with_shell(script, function(stdout)
        tooltip.text = tostring(stdout:gsub("\n[^\n]*$", ""))
    end)
end)

local function get_wifi()
    local script = [[
	nmcli g | tail -1 | awk '{printf $1}'
	]]

    awful.spawn.easy_async_with_shell(script, function(stdout)
        local status = tostring(stdout)
        if not status:match("disconnected") then
            wifi.markup = " 󰖩 "
        else
            wifi.markup = " 󰖪 "
        end
    end)
end

gears.timer {
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = function() get_wifi() end
}

return wifi
