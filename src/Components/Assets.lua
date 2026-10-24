-- Bloomware UI, based on Fluent by dawid (MIT).
local Assets = {
    Close = "rbxassetid://9886659671", Min = "rbxassetid://9886659276",
    Max = "rbxassetid://9886659406", Restore = "rbxassetid://9886659001",
}

-- ImageLabel needs an asset URI. Raw PNGs require a supported local-asset bridge.
-- Native Roblox clients can supply CreateWindow({ Logo = "rbxassetid://..." }).
function Assets.ResolveLogo(source)
    if source == nil or source == false then return nil end
    if type(source) == "number" then return "rbxassetid://" .. tostring(source) end
    if type(source) ~= "string" then return nil end
    if not source:match("^https?://") or source:find("roblox.com/asset", 1, true) then return source end
    -- Custom logos use the same per-URL cache as backgrounds.
    -- Loading a library never downloads a project-specific default logo.
    return Assets.ResolveImage(source)
end

local imageCache = {}
local imageCacheOrder = {}
local maxImageBytes = 12 * 1024 * 1024

function Assets.NormalizeImageSource(source)
    if type(source) == "number" and source > 0 and source % 1 == 0 and source < math.huge then
        source = string.format("%.0f", source)
    end
    if type(source) ~= "string" then return nil, "Enter a direct PNG/JPG URL or a Roblox asset ID." end
    source = source:match("^%s*(.-)%s*$")
    if source == "" then return "" end
    if #source > 4096 or source:find("[%c]") then return nil, "The URL is too long or contains invalid characters." end
    local id = source:match("^rbxassetid://(%d+)$") or source:match("^(%d+)$")
    if id then
        if #id > 20 or not id:find("[1-9]") then return nil, "Invalid Roblox asset ID." end
        return "rbxassetid://" .. id
    end
    if source:match("^https?://[^/%s?#]+[^%s]*$") then return source end
    return nil, "Use a direct http/https image URL or a Roblox asset ID."
end

local function cacheName(source, extension)
    local a, b = 5381, 2166136261
    for i = 1, #source do
        local byte = source:byte(i)
        a = (a * 33 + byte) % 4294967296
        b = (b * 65599 + byte) % 4294967296
    end
    return string.format("bloomware-ui-background-%08x%08x.%s", a, b, extension)
end

-- Check downloaded bytes and register a local image URI before changing the background.
function Assets.ResolveImage(source)
    local normalized, message = Assets.NormalizeImageSource(source)
    if not normalized then return nil, message end
    if normalized == "" then return nil, "No image URL was provided." end
    if normalized:match("^rbxassetid://") then return normalized end
    if imageCache[normalized] then return imageCache[normalized] end
    local registerAsset = getcustomasset or getsynasset
    if type(registerAsset) ~= "function" or type(writefile) ~= "function" then
        return nil, "Image URLs are unavailable in this environment. Use rbxassetid://ID."
    end
    local downloaded, bytes = pcall(function() return game:HttpGet(normalized) end)
    if not downloaded or type(bytes) ~= "string" or #bytes == 0 then
        return nil, "Could not download the image. Check the URL and your connection."
    end
    if #bytes > maxImageBytes then return nil, "The image exceeds 12 MB. Choose a smaller file." end
    local extension
    if bytes:sub(1, 8) == "\137PNG\13\10\26\10" then extension = "png"
    elseif bytes:sub(1, 3) == "\255\216\255" then extension = "jpg"
    else return nil, "The URL must point directly to a PNG or JPG image file." end
    local ok, uri = pcall(function()
        local fileName = cacheName(normalized, extension)
        writefile(fileName, bytes)
        return registerAsset(fileName)
    end)
    if not ok or type(uri) ~= "string" or uri == "" then
        return nil, "Could not open the downloaded image. Try a Roblox asset ID."
    end
    imageCache[normalized] = uri
    table.insert(imageCacheOrder, normalized)
    if #imageCacheOrder > 16 then imageCache[table.remove(imageCacheOrder, 1)] = nil end
    return uri
end

return Assets
