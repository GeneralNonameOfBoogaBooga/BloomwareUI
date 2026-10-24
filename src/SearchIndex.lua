-- Bloomware UI: searchable settings registry, independent of the rendering layer.
local SearchIndex = {}
SearchIndex.__index = SearchIndex

local lowerExtra = { [0x401]=0x451, [0x404]=0x454, [0x406]=0x456, [0x407]=0x457, [0x490]=0x491 }
function SearchIndex.Fold(text)
    text = tostring(text or ""):gsub("<[^>]->", "")
    local output = {}
    local ok = pcall(function()
        for _, code in utf8.codes(text) do
            if code >= 0x41 and code <= 0x5A or code >= 0x410 and code <= 0x42F then code = code + 32
            elseif code >= 0xC0 and code <= 0xDE and code ~= 0xD7 then code = code + 32
            else code = lowerExtra[code] or code end
            output[#output + 1] = utf8.char(code)
        end
    end)
    return (ok and table.concat(output) or text:lower()):gsub("%s+", " "):match("^%s*(.-)%s*$")
end

function SearchIndex.new()
    return setmetatable({ Entries = {}, Sequence = 0, Changed = nil }, SearchIndex)
end
function SearchIndex:Add(card, metadata)
    self.Sequence = self.Sequence + 1
    local entry = {
        Card = card, Tab = metadata.Tab, Section = metadata.Section or "",
        Id = metadata.Id ~= nil and tostring(metadata.Id) or "", Order = self.Sequence,
    }
    self.Entries[card] = entry
    if self.Changed then self.Changed() end
    return entry
end
function SearchIndex:Remove(card)
    self.Entries[card] = nil
    if self.Changed then self.Changed() end
end
function SearchIndex:Search(query, limit)
    query = self.Fold(query)
    if query == "" then return {}, 0 end
    local tokens = {}
    for token in query:gmatch("%S+") do tokens[#tokens + 1] = token end
    local matches = {}
    for _, entry in pairs(self.Entries) do
        local card = entry.Card
        if not card.Destroyed and entry.Tab then
            local title = card.TitleLabel.Text
            local description = card.DescLabel.Text
            local path = entry.Tab.Name .. (entry.Section ~= "" and (" / " .. entry.Section) or "")
            local foldedTitle = self.Fold(title)
            local haystack = self.Fold(title .. " " .. description .. " " .. path .. " " .. entry.Id)
            local found = true
            for _, token in ipairs(tokens) do if not haystack:find(token, 1, true) then found = false; break end end
            if found then
                local score = foldedTitle == query and 100 or (foldedTitle:sub(1, #query) == query and 60 or 0)
                for _, token in ipairs(tokens) do if foldedTitle:find(token, 1, true) then score = score + 10 end end
                matches[#matches + 1] = { Entry = entry, Title = title, Description = description, Path = path, Score = score }
            end
        end
    end
    table.sort(matches, function(a, b) return a.Score == b.Score and a.Entry.Order < b.Entry.Order or a.Score > b.Score end)
    local total = #matches
    while #matches > (limit or 100) do table.remove(matches) end
    return matches, total
end
function SearchIndex:Destroy() self.Changed = nil; table.clear(self.Entries) end
return SearchIndex
