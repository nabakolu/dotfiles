local iconhelper = {}
local icon = {
    high = "墳",
    medium = "奔",
    low = "奄",
    muted = "婢",
    bt = "",
    bt_muted = ""
}

function iconhelper.get_icon(state)
    if state.name ~= nil then
        if state.name:find("bluez", 1, true) then
            if state.muted then return icon.bt_muted end
            return icon.bt
        end
    end
    if state.muted then return icon.muted end
    if state.volume <= 33 then return icon.low end
    if state.volume <= 66 then return icon.medium end
    return icon.high
end

return iconhelper
