local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- datetime
local datetime = wibox.widget.textclock(' %a %d %b  %H:%M')
local tooltip = awful.tooltip { }
tooltip:add_to_object(datetime)
tooltip.mode = "inside"
tooltip.gaps = 5
datetime:connect_signal("mouse::enter", function()
    local script = [[ khal list | ( ! grep ^ ) && echo "No Events Today" ]]
    awful.spawn.easy_async_with_shell(script, function(stdout)
        tooltip.text = tostring(stdout)
    end)
end)


return datetime
