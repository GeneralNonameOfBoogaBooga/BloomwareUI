-- The bundle uses the same script.Parent-style imports as the source modules.
-- Each load gets its own module cache and UI state.
local environmentRequire = require
local nodes, cached, loading = {}, {}, {}
local Node = {}
Node.__index = function(self, key)
    return Node[key] or self._ChildrenByName[key]
end
Node.__tostring = function(self) return self:GetFullName() end

function Node:GetChildren()
    return table.clone(self._Children)
end

function Node:FindFirstChild(name)
    return self._ChildrenByName[name]
end

function Node:GetFullName()
    return self._Path:gsub("/", ".")
end

function Node:IsA(className)
    return className == self.ClassName or className == "Instance"
end

local function getNode(path)
    if nodes[path] then return nodes[path] end
    local parentPath, name = path:match("^(.*)/([^/]+)$")
    local parent = parentPath and getNode(parentPath) or nil
    local node = setmetatable({
        Name = name or path,
        ClassName = moduleFactories[path] and "ModuleScript" or "Folder",
        Parent = parent,
        _Path = path,
        _Children = {},
        _ChildrenByName = {},
    }, Node)
    nodes[path] = node
    if parent then
        table.insert(parent._Children, node)
        parent._ChildrenByName[node.Name] = node
    end
    return node
end

local paths = {}
for path in pairs(moduleFactories) do table.insert(paths, path) end
table.sort(paths)
for _, path in ipairs(paths) do getNode(path) end

local function requireModule(target)
    if type(target) ~= "table" or nodes[target._Path] ~= target then
        return environmentRequire(target)
    end
    local path = target._Path
    if cached[path] then return table.unpack(cached[path], 1, cached[path].n) end
    local factory = moduleFactories[path]
    assert(factory, "Cannot require a folder: " .. path)
    assert(not loading[path], "Circular dependency: " .. path)
    loading[path] = true
    local result = table.pack(pcall(factory, target, requireModule))
    loading[path] = nil
    if not result[1] then error(result[2], 0) end
    local values = { n = result.n - 1 }
    for i = 2, result.n do values[i - 1] = result[i] end
    cached[path] = values
    return table.unpack(values, 1, values.n)
end

return requireModule(nodes.BloomwareUI)
