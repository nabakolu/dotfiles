local utils = require 'mp.utils'

local function get_clipboard()
    local platform = mp.get_property("platform")
    local command

    if platform == "windows" then
        command = {"powershell", "-NoProfile", "-Command", "Get-Clipboard"}
    elseif platform == "linux" then
        command = {"xclip", "-selection", "clipboard", "-o"}
    elseif platform == "macOS" then
        command = {"pbpaste"}
    else
        mp.osd_message("Unsupported platform")
        return nil
    end

    local result = utils.subprocess({ args = command })
    if result.status == 0 then
        return result.stdout
    else
        mp.osd_message("Failed to get clipboard")
        return nil
    end
end

local function load_clipboard_url()
    local url = get_clipboard()
    if url then
        mp.commandv("loadfile", url, "append")
        mp.osd_message("Added to playlist: " .. url)
    end
end

mp.register_script_message("load-clipboard-url", load_clipboard_url)
