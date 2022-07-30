local setmetatable = setmetatable
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local iconhelper = require("widgets.awesome-pulseaudio-widget.iconhelper")
local pulseaudio = require("widgets.awesome-pulseaudio-widget.pulseaudio")

local pulseaudio_widget = { mt = {} }

local pulse_client = nil

function pulseaudio_widget:update_icon(state)
    self.iconcontainer.textbox:set_text(iconhelper.get_icon(state))
end

function pulseaudio_widget:update_text(state)
    if state.pulse == true then
        self.textbox:set_text(string.format("%02d%%", state.volume))
    else
        self.textbox:set_text("...")
    end
end

function pulseaudio_widget:update_tooltip(state)
    if state.pulse == true then
        self.tooltip:set_text(state.name)
    else
        self.tooltip:set_text("connecting to pulseaudio...")
    end
end

function pulseaudio_widget:update(state)
    self:update_icon(state)
    self:update_text(state)
    self:update_tooltip(state)
end

local function new(args)
    local w = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = 2,
        {
            layout = wibox.layout.fixed.horizontal,
            id = "iconcontainer",
            {
                id = "textbox",
                widget = wibox.widget.textbox,
            },
        },
        {
            id = "textbox",
            widget = wibox.widget.textbox,
        }
    }

    w.tooltip = awful.tooltip({ objects = { w },})

    gears.table.crush(w, pulseaudio_widget, true)

    local buttons_binding = gears.table.join(
        awful.button({ }, 1, function() pulse_client:toggle_mute() end),
        awful.button({ }, 4, function() pulse_client:update_volume(5) end),
        awful.button({ }, 5, function() pulse_client:update_volume(-5) end)
    )

    pulse_client = pulseaudio()
    pulse_client:on_pulse_connect(function() 
        w:buttons(buttons_binding) 
    end)
    pulse_client:connect(function(pulse_state) 
        w:update(pulse_state) 
    end)

    return w
end

function pulseaudio_widget.mt:__call(...)
    return new(...)
end

return setmetatable(pulseaudio_widget, pulseaudio_widget.mt)
