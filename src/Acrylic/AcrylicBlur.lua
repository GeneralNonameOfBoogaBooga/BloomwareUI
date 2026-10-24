-- Bloomware UI, based on Fluent by dawid (MIT).
local Workspace = game:GetService("Workspace")
local Creator = require(script.Parent.Parent.Creator)
local CreateAcrylic = require(script.Parent.CreateAcrylic)
local project, inset = unpack(require(script.Parent.Utils))
return function(distance)
    distance = distance or 0.001
    local frame = Creator.New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
    local model = CreateAcrylic()
    model.Parent = Workspace
    local blur = { Frame = frame, Model = model }
    local parent, cameraConnections, destroyed = nil, {}, false
    local function update()
        local camera = Workspace.CurrentCamera
        if destroyed or not camera or not frame.Parent then return end
        local margin = inset()
        local position = frame.AbsolutePosition + Vector2.new(margin / 2, margin / 2)
        local size = frame.AbsoluteSize - Vector2.new(margin, margin)
        local a = project(position, distance)
        local b = project(position + Vector2.new(size.X, 0), distance)
        local c = project(position + size, distance)
        local cf = camera.CFrame
        model.CFrame = CFrame.fromMatrix((a + c) / 2, cf.XVector, cf.YVector, cf.ZVector)
        model.Mesh.Scale = Vector3.new((b - a).Magnitude, (b - c).Magnitude, 0)
    end
    local function bindCamera()
        for _, connection in ipairs(cameraConnections) do connection:Disconnect() end
        table.clear(cameraConnections)
        local camera = Workspace.CurrentCamera
        if camera then
            for _, property in ipairs({ "CFrame", "ViewportSize", "FieldOfView" }) do
                table.insert(cameraConnections, camera:GetPropertyChangedSignal(property):Connect(update))
            end
        end
        update()
    end
    function blur.SetVisibility(visible)
        if destroyed then return end
        local Library = require(script.Parent.Parent)
        model.Transparency = visible and Library.Acrylic and (not parent or parent.Visible) and 0.98 or 1
    end
    function blur.AddParent(object)
        parent = object
        Creator.AddSignal(object:GetPropertyChangedSignal("Visible"), function() blur.SetVisibility(object.Visible) end, frame)
        blur.SetVisibility(object.Visible)
    end
    local function cleanup()
        if destroyed then return end
        destroyed = true
        for _, connection in ipairs(cameraConnections) do connection:Disconnect() end
        table.clear(cameraConnections)
        model:Destroy()
    end
    Creator.AddSignal(frame.Destroying, cleanup)
    Creator.AddSignal(frame:GetPropertyChangedSignal("AbsolutePosition"), update, frame)
    Creator.AddSignal(frame:GetPropertyChangedSignal("AbsoluteSize"), update, frame)
    Creator.AddSignal(Workspace:GetPropertyChangedSignal("CurrentCamera"), bindCamera, frame)
    bindCamera()
    return blur
end
