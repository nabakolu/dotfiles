local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- datetime
local datetime = wibox.widget.textclock(' %a %d %b  %H:%M')
local tooltip = awful.tooltip {
    objects        = { datetime },
    timer_function = function()
        local script = [[ khal list ]]
        awful.spawn.easy_async_with_shell(script, function(stdout)
            res = tostring(stdout)
        end)
        return res
    end,
}

return datetime
