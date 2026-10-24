-- Bloomware UI, based on Fluent by dawid (MIT).
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Acrylic = {
    AcrylicBlur = require(script.AcrylicBlur),
    CreateAcrylic = require(script.CreateAcrylic),
    AcrylicPaint = require(script.AcrylicPaint),
}
local effect, enabled = nil, false
local previous = {}
local connections = {}

local function capture(object)
    if object ~= effect and object:IsA("DepthOfFieldEffect") and previous[object] == nil then
        previous[object] = object.Enabled
        if enabled then object.Enabled = false end
    end
end

local function watch(parent)
    if not parent then return end
    for _, object in ipairs(parent:GetChildren()) do capture(object) end
    table.insert(connections, parent.ChildAdded:Connect(capture))
end

function Acrylic.Enable()
    if not effect then return end
    enabled = true
    for object in pairs(previous) do
        if object.Parent then object.Enabled = false end
    end
    effect.Parent = Lighting
end

function Acrylic.Disable()
    enabled = false
    for object, wasEnabled in pairs(previous) do
        if object.Parent then object.Enabled = wasEnabled end
    end
    if effect then effect.Parent = nil end
end

function Acrylic.Destroy()
    Acrylic.Disable()
    for _, connection in ipairs(connections) do connection:Disconnect() end
    table.clear(connections)
    table.clear(previous)
    if effect then effect:Destroy(); effect = nil end
end

function Acrylic.init()
    if effect then Acrylic.Enable(); return end
    effect = Instance.new("DepthOfFieldEffect")
    effect.Name = "BloomwareAcrylic"
    effect.FarIntensity = 0
    effect.InFocusRadius = 0.1
    effect.NearIntensity = 1
    watch(Lighting)
    watch(Workspace.CurrentCamera)
    table.insert(connections, Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() watch(Workspace.CurrentCamera) end))
    Acrylic.Enable()
end

return Acrylic
