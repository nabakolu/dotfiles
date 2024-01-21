local gears = require('gears')
local awful = require('awful')

local clientkeys = gears.table.join(
    awful.key({ modkey, "Shift"}, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift" }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "space", function(c) c.ontop = not c.ontop end,
        { description = "toggle always on top", group = "client" }),
    awful.key({ modkey, "Shift"}, "r",
        function (c)
            c.maximized_vertical   = false
            c.maximized_horizontal = false
            c.maximized = false
        end,
        {description = "toggle weird", group = "client"}),

    awful.key({modkey, "Shift"}, "k",
        function (c)
            c:move_to_screen(c.screen.index+1)
        end, {description = "move to next screen", group = "client"}),
    awful.key({modkey, "Shift"}, "j",
        function (c)
            c:move_to_screen(c.screen.index-1)
        end, {description = "move to previous screen", group = "client"})

)

return clientkeys
