local gears = require "gears"
local wibox = require "wibox"

-- Battry
local battery = wibox.widget.textbox()

local handle = io.popen("ls /sys/class/power_supply/ | grep BAT | head -1")
if handle == nil then
    return false
end
local battery_path = handle:read("*a")
handle:close()
battery_path = battery_path:gsub("%s+", "")
if battery_path == "" then
    return false
end
battery_path = "/sys/class/power_supply/" .. battery_path

local function update_battery()
    local percent_file = io.open(battery_path .. "/capacity", "r")
    if percent_file then
        local percent = tonumber(percent_file:read("l"))
        percent_file:close()

        local status_file = io.open(battery_path .. "/status", "r")
        if status_file then
            local status = status_file:read("l")
            status_file:close()

            local icon
            if status == "Charging" then
                icon = "󰂄"
            elseif percent == 100 then
                icon = "󰁹"
            elseif percent > 90 then
                icon = "󰂂"
            elseif percent > 80 then
                icon = "󰂁"
            elseif percent > 70 then
                icon = "󰂀"
            elseif percent > 60 then
                icon = "󰁿"
            elseif percent > 50 then
                icon = "󰁾"
            elseif percent > 40 then
                icon = "󰁽"
            elseif percent > 30 then
                icon = "󰁼"
            elseif percent > 20 then
                icon = "󰁻"
            elseif percent > 10 then
                icon = "󰁺"
            else
                icon = "󰂃"
            end

            battery.markup = icon .. percent .. "%"
        end
    end
end

gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = function() update_battery() end
}


return battery
