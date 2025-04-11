local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"

-- datetime
local datetime = wibox.widget.textclock('󰃶 %a %d %b  %H:%M')
datetime.refresh = 15
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


datetime:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.spawn(terminal .. " -e ikhal"); end),
    awful.button({ }, 3, function () awful.spawn(terminal .. " -e ikhal"); end)
    ))

return datetime
