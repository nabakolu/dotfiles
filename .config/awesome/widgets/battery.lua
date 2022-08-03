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
    local scriptBattery = [[
    cat /sys/class/power_supply/BAT0/capacity
    ]]
    local handle = io.popen(scriptBattery)
    local percent = string.gsub(handle:read("*a"),"\n","")
    percent = tonumber(percent)
    local icon
    if percent == 100 then
        icon = ""
    elseif percent > 90 then
        icon = ""
    elseif percent > 80 then
        icon = ""
    elseif percent > 70 then
        icon = ""
    elseif percent > 60 then
        icon = ""
    elseif percent > 50 then
        icon = ""
    elseif percent > 40 then
        icon = ""
    elseif percent > 30 then
        icon = ""
    elseif percent > 20 then
        icon = ""
    elseif percent > 10 then
        icon = ""
    else
        icon = ""
    end
    battery.markup = icon..percent.."%"
    handle:close()
end

gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = function() update_battery() end
}


return battery
