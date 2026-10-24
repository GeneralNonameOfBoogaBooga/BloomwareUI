-- Small Roblox API substitute. Exercises the actual bundled library, not a copy.
local Mock = {Files = {}, Http = {}, Calls = {}, Notices = {}, Preload = {}, PreloadCalls = {}}
local Scheduler = {Ready = {}, Timers = {}, Now = 0, Gates = {}}
function Scheduler.flush()
    local steps = 0
    while #Scheduler.Ready > 0 do
        steps = steps + 1
        assert(steps < 20000, "scheduler did not settle")
        local item = table.remove(Scheduler.Ready, 1)
        if not item.Cancelled then
            local ok, message = coroutine.resume(item.Thread, table.unpack(item.Args or {}))
            assert(ok, tostring(message) .. "\n" .. debug.traceback(item.Thread))
        end
    end
end
function Scheduler.advance(seconds)
    Scheduler.Now = Scheduler.Now + seconds
    for _, item in ipairs(Scheduler.Timers) do
        if not item.Cancelled and not item.Started and item.At <= Scheduler.Now then
            item.Started = true; table.insert(Scheduler.Ready, item)
        end
    end
    Scheduler.flush()
end
function Scheduler.gate(key)
    local thread = coroutine.running()
    Scheduler.Gates[key] = thread
    return coroutine.yield()
end
function Scheduler.release(key, ...)
    local thread = Scheduler.Gates[key]
    assert(thread, "missing gate " .. key)
    Scheduler.Gates[key] = nil
    table.insert(Scheduler.Ready, {Thread = thread, Args = {...}})
    Scheduler.flush()
end
local task = {}
function task.defer(fn, ...)
    local item = {Thread = type(fn)=="thread"and fn or coroutine.create(fn), Args = {...}}
    table.insert(Scheduler.Ready, item)
    return item
end
task.spawn = task.defer
function task.delay(seconds, fn, ...)
    local item = {Thread = coroutine.create(fn), Args = {...}, At = Scheduler.Now + seconds}
    table.insert(Scheduler.Timers, item)
    return item
end
function task.cancel(item) item.Cancelled = true end
function task.wait(seconds) return Scheduler.gate("wait:" .. tostring(seconds)) end

local function signal()
    local event = {Listeners = {}}
    function event:Connect(fn)
        local connection = {Connected = true, Callback = fn}
        function connection:Disconnect() self.Connected = false end
        table.insert(self.Listeners, connection)
        return connection
    end
    function event:Fire(...)
        for _, connection in ipairs(table.clone(self.Listeners)) do
            if connection.Connected then connection.Callback(...) end
        end
    end
    function event:Wait()
        local thread = coroutine.running()
        local connection
        connection = self:Connect(function(...)
            connection:Disconnect()
            table.insert(Scheduler.Ready,{Thread=thread,Args=table.pack(...)})
        end)
        return coroutine.yield()
    end
    return event
end

local Enum = setmetatable({}, {__index = function(self, name)
    local enumType = setmetatable({}, {__index = function(items, key)
        local item = setmetatable({Name = key, EnumType = name}, {__tostring = function() return "Enum." .. name .. "." .. key end})
        rawset(items, key, item); return item
    end})
    rawset(self, name, enumType); return enumType
end})
local Vector2 = {}
local vectorMT = {}
function Vector2.new(x, y) return setmetatable({X = x, Y = y}, vectorMT) end
vectorMT.__add = function(a, b) return Vector2.new(a.X + b.X, a.Y + b.Y) end
vectorMT.__sub = function(a, b) return Vector2.new(a.X - b.X, a.Y - b.Y) end
local Vector3 = {new = function(x,y,z) return {X=x,Y=y,Z=z} end}
local UDim = {new = function(scale, offset) return {Scale = scale, Offset = offset} end}
local UDim2 = {}
function UDim2.new(xs, xo, ys, yo) return {X = UDim.new(xs,xo), Y = UDim.new(ys,yo)} end
function UDim2.fromOffset(x, y) return UDim2.new(0,x,0,y) end
function UDim2.fromScale(x, y) return UDim2.new(x,0,y,0) end
local Color3 = {}
local colorMT = {}
colorMT.__index = function(self,key)
    if key=="r"or key=="g"or key=="b"then return self[key:upper()]end
    if key=="ToHex"then return function(value)return string.format("%02x%02x%02x",math.floor(value.R*255+0.5),math.floor(value.G*255+0.5),math.floor(value.B*255+0.5))end end
end
function Color3.new(r,g,b) return setmetatable({R=r,G=g,B=b},colorMT) end
function Color3.fromRGB(r,g,b) return Color3.new(r/255,g/255,b/255) end
function Color3.fromHSV(h,s,v)
    local c=v*s;local x=c*(1-math.abs((h*6)%2-1));local m=v-c
    local colors={{c,x,0},{x,c,0},{0,c,x},{0,x,c},{x,0,c},{c,0,x}}
    local rgb=colors[math.floor(h*6)%6+1]
    return Color3.new(rgb[1]+m,rgb[2]+m,rgb[3]+m)
end
function Color3.toHSV(color)
    local r,g,b=color.R,color.G,color.B
    local max,min=math.max(r,g,b),math.min(r,g,b);local delta=max-min
    local h=0
    if delta~=0 then
        if max==r then h=((g-b)/delta)%6 elseif max==g then h=(b-r)/delta+2 else h=(r-g)/delta+4 end
    end
    return h/6,max==0 and 0 or delta/max,max
end
function Color3.fromHex(hex)
    hex=hex:gsub("^#","");assert(#hex==6,"invalid hex")
    return Color3.fromRGB(tonumber(hex:sub(1,2),16),tonumber(hex:sub(3,4),16),tonumber(hex:sub(5,6),16))
end
local ColorSequence = {new = function(...) return {...} end}
local ColorSequenceKeypoint = {new = function(...) return {...} end}
local NumberSequence = {new = function(...) return {...} end}
local NumberSequenceKeypoint = {new = function(...) return {...} end}
local Rect = {new = function(...) return {...} end}
local Font = {new = function(...) return {...} end}
local TweenInfo = {new = function(...) return {...} end}
local Instance = {}
local methods = {}
local events = {Destroying=true, AncestryChanged=true, ChildAdded=true, ChildRemoved=true, InputBegan=true, InputChanged=true,
    InputEnded=true, MouseEnter=true, MouseLeave=true, Activated=true, MouseButton1Click=true, MouseButton1Down=true, MouseButton1Up=true, FocusLost=true, Focused=true,
    Event=true, Changed=true, RenderStepped=true, Heartbeat=true, TextBoxFocused=true, TextBoxFocusReleased=true}
local nodeMT = {}
function Instance.new(class)
    local node = setmetatable({_properties = {ClassName = class, Name = class, Visible = true, Text = "", BackgroundTransparency=0,
        AbsolutePosition = Vector2.new(0,0), AbsoluteSize = Vector2.new(800,500), AbsoluteContentSize=Vector2.new(0,0),
        Size = UDim2.fromOffset(100,30), Position=UDim2.fromOffset(0,0), CanvasSize=UDim2.fromOffset(0,0),
        CanvasPosition=Vector2.new(0,0), TextBounds=Vector2.new(0,0), CursorPosition=-1,
        ScrollingEnabled=true, GroupTransparency=0, Image="", IsLoaded=false},
        _children = {}, _signals = {}}, nodeMT)
    return node
end
nodeMT.__index = function(self, key)
    if methods[key] then return methods[key] end
    local value = self._properties[key]
    if value ~= nil then return value end
    for _, child in ipairs(self._children) do if child.Name == key then return child end end
    if events[key] then
        if not self._signals[key] then self._signals[key] = signal() end
        return self._signals[key]
    end
    return nil
end
nodeMT.__newindex = function(self, key, value)
    if key:sub(1,1) == "_" then rawset(self,key,value); return end
    if key == "Parent" then
        local before = self._properties.Parent
        if before then local index = table.find(before._children,self); if index then table.remove(before._children,index) end end
        if value then table.insert(value._children,self) end
    end
    self._properties[key] = value
end
function methods:IsA(class) return self.ClassName == class or class == "GuiObject" and self.ClassName ~= "ScreenGui" end
function methods:GetChildren() return table.clone(self._children) end
function methods:GetDescendants()
    local result = {}
    for _,child in ipairs(self._children) do table.insert(result,child); for _,descendant in ipairs(child:GetDescendants()) do table.insert(result,descendant) end end
    return result
end
function methods:FindFirstChild(name)
    for _,child in ipairs(self._children) do if child.Name == name then return child end end
end
methods.WaitForChild = methods.FindFirstChild
function methods:FindFirstChildOfClass(class)
    for _,child in ipairs(self._children) do if child.ClassName == class then return child end end
end
function methods:GetPropertyChangedSignal(property)
    local key = "Property:" .. property
    if not self._signals[key] then self._signals[key] = signal() end
    return self._signals[key]
end
function methods:Destroy()
    if self._destroyed then return end
    self._destroyed = true
    self.Destroying:Fire()
    for _,child in ipairs(self:GetChildren()) do child:Destroy() end
    self.Parent = nil
end
function methods:Fire(...) self.Event:Fire(...) end
function methods:CaptureFocus() Mock.Focused = self; self.Focused:Fire() end
function methods:ReleaseFocus() Mock.Focused = nil; self.FocusLost:Fire() end
function methods:IsFocused() return Mock.Focused == self end
function methods:IsStudio() return true end
function methods:IsKeyDown() return false end
function methods:GetFocusedTextBox() return Mock.Focused end
function methods:GetMouseLocation() return Vector2.new(0,0) end
function methods:GetMouse() return {X=0,Y=0} end
function methods:GetTextSize(text, size) return Vector2.new(#text * size * 0.5,size) end
function methods:Create(object, info, properties)
    return {Play = function() for key,value in pairs(properties) do object[key] = value end end, Cancel = function() end}
end
local services = {}
for _, name in ipairs({"RunService","Players","CoreGui","Lighting","Workspace","UserInputService","TweenService","HttpService","ContentProvider","TextService"}) do
    services[name] = Instance.new(name)
end
services.Players.LocalPlayer = Instance.new("Player")
local playerGui = Instance.new("PlayerGui"); playerGui.Parent = services.Players.LocalPlayer
services.Workspace.CurrentCamera = Instance.new("Camera")
services.Workspace.CurrentCamera.ViewportSize = Vector2.new(1280,720)
services.UserInputService.TouchEnabled = false
services.UserInputService.KeyboardEnabled = true
local game = {GameId = 123, PlaceId = 456}
function game:GetService(name) assert(services[name],name); return services[name] end
function game:HttpGet(url)
    Mock.Calls[url] = (Mock.Calls[url] or 0) + 1
    local response = Mock.Http[url]
    if type(response) == "function" then return response(url) end
    assert(response, "unexpected HTTP: " .. url)
    return response
end
function methods:PreloadAsync(objects, callback)
    for _,object in ipairs(objects) do
        table.insert(Mock.PreloadCalls, object.Image)
        local handler = Mock.Preload[object.Image]
        if Mock.LocalPreloadMode and object.Image:find("rbxasset://mock/",1,true) then
            if Mock.LocalPreloadMode == "error" then error("local assets unavailable to preloader") end
            if Mock.LocalPreloadMode == "stall" then Scheduler.gate("local-preload") end
            -- A custom asset can render without the hidden probe's IsLoaded flag.
            if callback then callback(object.Image, Enum.AssetFetchStatus.Failure) end
        elseif handler then handler(object, callback)
        else
            object.IsLoaded = true
            if callback then callback(object.Image, Enum.AssetFetchStatus.Success) end
        end
    end
end
local jsonTokens, jsonIndex = {}, 0
function methods:JSONEncode(data)
    jsonIndex = jsonIndex + 1
    local text = "json:" .. jsonIndex
    jsonTokens[text] = data
    return text
end
function methods:JSONDecode(text) assert(jsonTokens[text], "bad JSON token"); return jsonTokens[text] end
local writefile = function(name, data) Mock.Files[name] = data end
local getcustomasset = function(name) assert(Mock.Files[name]); return "rbxasset://mock/" .. name end
local getsynasset, readfile, isfile = nil, nil, nil
Mock.Scheduler, Mock.Services, Mock.Instance = Scheduler, services, Instance
