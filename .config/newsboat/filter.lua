Link_COUNT = 0

function Image(elem)
    Link_COUNT = Link_COUNT +1
    return "![" .. tostring(Link_COUNT) .. "](" .. elem.src ..")"
end

function Link(elem)
    Link_COUNT = Link_COUNT +1
    return "[" .. tostring(Link_COUNT) .. "]"
end
