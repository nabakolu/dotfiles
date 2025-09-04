local mp = require 'mp'

local input_conf_path = mp.command_native({"expand-path", "~~/input.conf"})

function show_input_conf()
    local file = io.open(input_conf_path, "r")
    if not file then
        mp.osd_message("Could not open input.conf", 5)
        return
    end

    local content = file:read("*a")
    file:close()

    if #content > 4000 then
        content = content:sub(1, 4000) .. "\n... (truncated)"
    end

    mp.osd_message(content, 3)
end

mp.register_script_message("show-input-conf", show_input_conf)
