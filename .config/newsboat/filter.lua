Link_COUNT = 0

local maxCharsPerLine = 60
local function insertLineBreaks(inputString)
    local lines = {}
    local currentLine = ""
    for word in inputString:gmatch("%S+") do
        if #currentLine + #word + 1 > maxCharsPerLine then
            table.insert(lines, currentLine)
            currentLine = ""
        end
        if currentLine == "" then
            currentLine = word
        else
            currentLine = currentLine .. " " .. word
        end
    end
    if currentLine ~= "" then
        table.insert(lines, currentLine)
    end
    return table.concat(lines, "\n")
end

function Image(elem)
    Link_COUNT = Link_COUNT +1
    return { "![" .. tostring(Link_COUNT) .. "](" .. elem.src ..")", "\n",  insertLineBreaks(tostring(elem.title)) }
end

function Link(elem)
    Link_COUNT = Link_COUNT +1
    return pandoc.utils.stringify(elem.content) .. " [" .. tostring(Link_COUNT) .. "]"
end
