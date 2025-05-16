local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Wifi
local wifi = wibox.widget.textbox()
local tooltip = awful.tooltip {}
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
  nmcli connection show --active | awk -F'  +' 'NR>1 {print $3}'
  ]]

  awful.spawn.easy_async_with_shell(script, function(stdout)
    local status = tostring(stdout)
    wifi.markup = " "
    for line in status:gmatch("[^\r\n]+") do
      if line == "ethernet" then
        wifi.markup = wifi.markup .. "󰌘 "
      elseif line == "wifi" then
        wifi.markup = wifi.markup .. "󰖩 "
      elseif line == "vpn" then
        wifi.markup = wifi.markup .. " "
      end
    end
    if wifi.markup == " " then
        wifi.markup = " 󰌙 "
    end
  end)
end

gears.timer {
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function() get_wifi() end
}

wifi:buttons(gears.table.join(
  awful.button({}, 1, function() awful.spawn("networkmanager_dmenu"); end),
  awful.button({}, 3, function() awful.spawn("networkmanager_dmenu"); end)
))

return wifi
