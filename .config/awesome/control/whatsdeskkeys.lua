local gears = require('gears')
local awful = require('awful')

local whatsdeskkeys = gears.table.join(
    awful.key({ "Control" }, "j",
        function (c)
            -- awful.spawn.with_shell("sleep 0.1; xdotool key --clearmodifiers F")
            root.fake_input("key_release", "j")
            root.fake_input("key_release", "Control_L")
            root.fake_input("key_press"  , "Return")
            root.fake_input("key_release", "Return")
            root.fake_input("key_press"  , "Control_L")
        end
    ),
    awful.key({ "Control" }, "h",
        function (c)
            -- awful.spawn.with_shell("sleep 0.1; xdotool key --clearmodifiers F")
            root.fake_input("key_release", "h")
            root.fake_input("key_release", "Control_L")
            root.fake_input("key_press"  , "BackSpace")
            root.fake_input("key_release", "BackSpace")
            root.fake_input("key_press"  , "Control_L")
        end
    ),
    awful.key({ "Control" }, "n",
        function (c)
            -- awful.spawn.with_shell("sleep 0.1; xdotool key --clearmodifiers F")
            root.fake_input("key_release", "n")
            root.fake_input("key_release", "Control_L")
            root.fake_input("key_press"  , "Down")
            root.fake_input("key_release", "Down")
            root.fake_input("key_press"  , "Control_L")
        end
    ),
    awful.key({ "Control" }, "p",
        function (c)
            -- awful.spawn.with_shell("sleep 0.1; xdotool key --clearmodifiers F")
            root.fake_input("key_release", "p")
            root.fake_input("key_release", "Control_L")
            root.fake_input("key_press"  , "Up")
            root.fake_input("key_release", "Up")
            root.fake_input("key_press"  , "Control_L")
        end
    ),
    awful.key({ "Control" }, "k",
        function (c)
            -- awful.spawn.with_shell("sleep 0.1; xdotool key --clearmodifiers F")
            root.fake_input("key_release", "k")
            root.fake_input("key_release", "Control_L")
            root.fake_input("key_press"  , "Alt_L")
            root.fake_input("key_press"  , "k")
            root.fake_input("key_release", "k")
            root.fake_input("key_release", "Alt_L")
            root.fake_input("key_press"  , "Control_L")
        end
    )
)

return whatsdeskkeys
