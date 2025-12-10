local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"

local wifi = wibox.widget.textbox()
local tooltip = awful.tooltip { objects = { wifi }, mode = "inside", gaps = 5 }

wifi:connect_signal("mouse::enter", function()
  awful.spawn.easy_async_with_shell(
    [[nmcli con show --active | tail -n +2]],
    function(stdout)
      tooltip.text = stdout:gsub("\n[^\n]*$", "")
    end
  )
end)

local active_interface = nil

local function detect_interface(cb)
  awful.spawn.easy_async_with_shell(
    [[ip route | grep default | awk '{print $5}' | head -n1]],
    function(stdout)
      active_interface = stdout:match("(%S+)")
      if cb then cb() end
    end
  )
end

local last_down, last_up = 0, 0
local last_time = os.time()

local function get_net_speed(cb)
  if not active_interface then
    detect_interface(function() get_net_speed(cb) end)
    return
  end

  local f = io.open("/proc/net/dev", "r")
  if not f then return end

  for line in f:lines() do
    if line:match(active_interface .. ":") then
      local down, up = line:match(active_interface .. ":%s*(%d+).+%s(%d+)")
      down, up = tonumber(down), tonumber(up)

      local now = os.time()
      local dt = now - last_time
      if dt == 0 then dt = 1 end

      local ds, us = 0, 0
      if last_down ~= 0 then
        ds = (down - last_down) / 1024 / 1024 / dt
        us = (up - last_up)   / 1024 / 1024 / dt
      end

      last_down, last_up, last_time = down, up, now
      if cb then cb(ds, us) end
    end
  end

  f:close()
end

local function connection_icon(cb)
  awful.spawn.easy_async_with_shell(
    [[nmcli -t -f TYPE,STATE connection show --active]],
    function(stdout)
      -- Default icon
      local icon = "󰌙"

      for line in stdout:gmatch("[^\n]+") do
        local type = line:match("^(%S+):")
        if type == "ethernet" then icon = "󰌘"
        elseif type == "wifi"  then icon = "󰖩"
        elseif type == "vpn"   then icon = ""
        end
      end

      cb(icon)
    end
  )
end

local function update_widget()
  detect_interface(function()
    connection_icon(function(icon)
      get_net_speed(function(down, up)
        wifi.markup = string.format(
          "%s ↓%.1f ↑%.1f",
          icon,
          down,
          up
        )
      end)
    end)
  end)
end

gears.timer {
  timeout = 5,
  call_now = true,
  autostart = true,
  callback = update_widget
}

wifi:buttons(gears.table.join(
  awful.button({}, 1, function() awful.spawn("networkmanager_dmenu") end),
  awful.button({}, 3, function() awful.spawn("networkmanager_dmenu") end)
))

return wifi
