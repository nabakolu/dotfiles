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
    local script = [[ khal --color list -f "{start-time-full}-{end-time-full} {title}"  today $(date +%a) | sed -e 's/\x1b\[0m//' -e 's/\x1b\[0m/<\/b>/' -e 's/\x1b\[1m/<b>/' ]]
    awful.spawn.easy_async_with_shell(script, function(stdout)
        tooltip.markup = stdout:gsub("\n[^\n]*$", "")
    end)
end)


return datetime
