-- Function to remove the currently playing file
local function remove_current_file()
    local current_index = mp.get_property_number("playlist-pos", 0)
    local playlist_count = mp.get_property_number("playlist-count", 0)

    -- Check if there is more than one file in the playlist
    if playlist_count > 1 then
        -- Ensure the current file isn't the last one in the playlist
        if current_index >= 0 and current_index < playlist_count - 1 then
            mp.commandv("playlist-remove", current_index)
            mp.osd_message("Removed current file from playlist")
        else
            mp.osd_message("Cannot remove the last file")
        end
    else
        mp.osd_message("Cannot remove the only file in the playlist")
    end
end

-- Register the function to be called via script-message
mp.register_script_message("remove-current", remove_current_file)
