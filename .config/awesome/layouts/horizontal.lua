local pairs = pairs

local horiz_tile = {}

horiz_tile.name = "horizontal"
function horiz_tile.arrange(p)
    local area
    area = p.workarea
    local i = 0
    for _, c in pairs(p.clients) do
            local g = {
                    y = area.y,
                    x = area.x + i * (area.width / #p.clients),
                    height = area.height,
                    width = area.width / #p.clients,
            }
            p.geometries[c] = g
            i = i + 1
    end
end

return horiz_tile
