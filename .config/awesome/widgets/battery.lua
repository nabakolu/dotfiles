local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Battry
local battery = wibox.widget.textbox()

function battery_check_available()
    local f=io.open("/sys/class/power_supply/BAT0/capacity","r")
    if f~=nil then io.close(f) return true else return false end
end

local function update_battery()
    local percent_file = io.open("/sys/class/power_supply/BAT0/capacity", "r")
    if percent_file then
        local percent = tonumber(percent_file:read("l"))
        percent_file:close()

        local status_file = io.open("/sys/class/power_supply/BAT0/status", "r")
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

if battery_check_available() then
    gears.timer {
        timeout = 60,
        autostart = true,
        call_now = true,
        callback = function() update_battery() end
    }
end


return battery
