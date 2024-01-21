local gears = require('gears')
local awful = require('awful')

discordkeys = gears.table.join(
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
    awful.key({ "Control" }, "d",
        function (c)
            -- awful.spawn.with_shell("sleep 0.1; xdotool key --clearmodifiers F")
            root.fake_input("key_release", "d")
            root.fake_input("key_release", "Control_L")
            root.fake_input("key_press"  , "Next")
            root.fake_input("key_release", "Next")
            root.fake_input("key_press"  , "Control_L")
        end
    ),
    awful.key({ "Control" }, "u",
        function (c)
            -- awful.spawn.with_shell("sleep 0.1; xdotool key --clearmodifiers F")
            root.fake_input("key_release", "u")
            root.fake_input("key_release", "Control_L")
            root.fake_input("key_press"  , "Prior")
            root.fake_input("key_release", "Prior")
            root.fake_input("key_press"  , "Control_L")
        end
    )
)

return discordkeys
