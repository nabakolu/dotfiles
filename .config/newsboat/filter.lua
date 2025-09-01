Link_COUNT = 0
local links = {}

local function register_url(url)
    Link_COUNT = Link_COUNT + 1
    table.insert(links, url)
    return Link_COUNT
end

function Image(elem)
    local num = register_url(elem.src)
    return { "![" .. tostring(num) .. "](" .. elem.src .. ")", "\n", tostring(elem.title) }
end

function Link(elem)
    local num = register_url(elem.target)
    return pandoc.utils.stringify(elem.content) .. " [" .. tostring(num) .. "]"
end

function Pandoc(doc)
    if #links > 0 then
        local inlines = { pandoc.Str("Article Links:"), pandoc.LineBreak() }
        for i, url in ipairs(links) do
            table.insert(inlines, pandoc.Str("[" .. tostring(i) .. "] "))
            table.insert(inlines, pandoc.Str(url))
            if i < #links then
                table.insert(inlines, pandoc.LineBreak())
            end
        end
        table.insert(doc.blocks, pandoc.Para(inlines))
    end
    return doc
end
