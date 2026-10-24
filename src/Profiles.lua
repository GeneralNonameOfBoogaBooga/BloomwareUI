-- Bloomware UI: typed JSON profiles. No code is executed from profile data.
local HttpService = game:GetService("HttpService")
local Appearance = require(script.Parent.Appearance)
local Compatibility = require(script.Parent.Compatibility)
local Profiles = {}
Profiles.__index = Profiles
local supported = { Toggle=true, Slider=true, Input=true, Dropdown=true, Keybind=true, Colorpicker=true }
local modes = { Toggle=true, Hold=true, Always=true }
local function finite(n) return type(n) == "number" and n == n and math.abs(n) < math.huge end
local function clone(value)
    if type(value) ~= "table" then return value end
    local result = {}; for key, item in pairs(value) do result[key] = clone(item) end; return result
end
local function validName(name)
    if type(name) ~= "string" then return nil, "Enter a profile name." end
    name = name:match("^%s*(.-)%s*$")
    local length = utf8.len(name)
    if not length or length < 1 or length > 40 or name:find("[%c]") then return nil, "Use a name of 1–40 characters without control characters." end
    return name
end
local function validData(data)
    if type(data) ~= "table" or data.Format ~= "BloomwareProfile" or data.Version ~= 1 or type(data.Options) ~= "table" then return false, "Unsupported profile format or version." end
    local count = 0
    for id, entry in pairs(data.Options) do
        count = count + 1
        if count > 2000 or type(id) ~= "string" or #id > 256 or type(entry) ~= "table" or not supported[entry.Type] then return false, "Invalid profile options." end
        if entry.Type == "Toggle" and type(entry.Value) ~= "boolean" then return false, "Invalid toggle value: " .. id end
        if entry.Type == "Slider" and not finite(entry.Value) then return false, "Invalid slider value: " .. id end
        if entry.Type == "Input" and (type(entry.Value) ~= "string" or #entry.Value > 16384) then return false, "Invalid input value: " .. id end
        if entry.Type == "Keybind" and (type(entry.Value) ~= "string" or #entry.Value > 64 or not modes[entry.Mode]) then return false, "Invalid key binding: " .. id end
        if entry.Type == "Dropdown" then
            if type(entry.Multi) ~= "boolean" then return false, "Invalid dropdown mode: " .. id end
            if entry.Multi then
                if type(entry.Value) ~= "table" or #entry.Value > 2000 then return false, "Invalid dropdown selection: " .. id end
                local n = 0
                for key, value in pairs(entry.Value) do
                    n = n + 1
                    if type(key) ~= "number" or key < 1 or key % 1 ~= 0 or key > #entry.Value or type(value) ~= "string" and not finite(value) then return false, "Invalid dropdown selection: " .. id end
                end
                if n ~= #entry.Value then return false, "Invalid dropdown selection: " .. id end
            elseif entry.Value ~= nil and type(entry.Value) ~= "string" and not finite(entry.Value) then return false, "Invalid dropdown value: " .. id end
        end
        if entry.Type == "Colorpicker" then
            if type(entry.Value) ~= "table" then return false, "Invalid color: " .. id end
            for _, key in ipairs({"R","G","B","Transparency"}) do
                local value = entry.Value[key]
                if not finite(value) or value < 0 or value > 1 then return false, "Invalid color: " .. id end
            end
        end
    end
    if data.UI ~= nil then
        if type(data.UI) ~= "table" or data.UI.Theme ~= nil and type(data.UI.Theme) ~= "string" or data.UI.Transparency ~= nil and type(data.UI.Transparency) ~= "boolean" then return false, "Invalid interface settings." end
        if data.UI.Background ~= nil and not Appearance.ValidateState(data.UI.Background) then return false, "Invalid background settings." end
    end
    return true
end

function Profiles.new(library, config)
    config = config or {}
    local self = setmetatable({ Library=library, Entries={}, Data={}, Active=nil, Dirty=false, Applying=false, Changed=nil, Mode="session" }, Profiles)
    local adapter = config.ProfileStorage
    if type(adapter) == "table" and type(adapter.Read) == "function" and type(adapter.Write) == "function" then
        self.Mode, self.Read, self.Write = "custom", adapter.Read, adapter.Write
    elseif type(readfile) == "function" and type(writefile) == "function" and type(isfile) == "function" then
        local namespace = tostring(game.GameId or game.PlaceId or "default"):gsub("[^%w_-]", "_")
        local appId = tostring(config.AppId or config.Title or "default"):gsub("[^%w_-]", "_")
        if appId == "" then appId = "default" end
        appId = appId:sub(1,80)
        self.File = config.ProfileFile or ("bloomware-ui-profiles-" .. namespace .. "-" .. appId .. ".json")
        self.Mode = "file"
        self.Read = function() if isfile(self.File) then return readfile(self.File) end; return nil end
        self.Write = function(text) return writefile(self.File, text) end
    end
    if self.Read then
        local ok, text = pcall(self.Read)
        if ok and text ~= nil then
            if type(text) ~= "string" or #text > 524288 then self.StorageError = "Saved profiles are too large or unreadable."
            else
                local decoded, document = pcall(HttpService.JSONDecode, HttpService, text)
                if not decoded or type(document) ~= "table" or document.Format ~= "BloomwareProfiles" or document.Version ~= 1 or type(document.Profiles) ~= "table" then
                    self.StorageError = "Saved profiles could not be read. The file has been preserved."
                else
                    local count = 0
                    for name, profile in pairs(document.Profiles) do
                        count = count + 1
                        if count > 64 or not validName(name) or not validData(profile) then self.StorageError = "Saved profiles contain invalid data. The file has been preserved."; break end
                    end
                    if not self.StorageError then self.Data = document.Profiles end
                end
            end
        elseif not ok then self.StorageError = "Profile storage could not be read: " .. tostring(text) end
    end
    return self
end
function Profiles:NotifyChanged() if self.Changed then self.Changed() end end
function Profiles:MarkDirty()
    if self.Active and not self.Applying then self.Dirty = true; self:NotifyChanged() end
end
function Profiles:Register(id, option, config)
    if id == nil or not supported[option.Type] or config.IgnoreProfile == true then return end
    local key = tostring(id)
    self.Entries[key] = { Option=option, Id=id, Config=config }
    local function state(target)
        if target.Type == "Colorpicker" then return {target.Value.R,target.Value.G,target.Value.B,target.Transparency or 0} end
        if target.Type == "Keybind" then return {target.Value,target.Mode} end
        return {clone(target.Value)}
    end
    local function equal(a,b)
        if type(a) ~= type(b) then return false end
        if type(a) ~= "table" then return a == b end
        for k,v in pairs(a) do if not equal(v,b[k]) then return false end end
        for k in pairs(b) do if a[k] == nil then return false end end
        return true
    end
    local function wrap(original)
        return function(target, ...)
            local before = self.Active and not self.Applying and state(target) or nil
            local result = table.pack(original(target, ...))
            if before and self.Entries[key] and self.Entries[key].Option == target and not equal(before,state(target)) then self:MarkDirty() end
            return table.unpack(result, 1, result.n)
        end
    end
    option.SetValue = wrap(option.SetValue)
    if option.Type == "Colorpicker" then option.SetValueRGB = wrap(option.SetValueRGB) end
end
function Profiles:Unregister(id, option)
    local entry = self.Entries[tostring(id)]
    if entry and entry.Option == option then self.Entries[tostring(id)] = nil end
end
function Profiles:Capture(name)
    local data = { Format="BloomwareProfile", Version=1, Name=name or self.Active or "Profile", Options={}, UI={Theme=self.Library.Theme, Transparency=self.Library.Transparency} }
    if self.Library.Appearance then data.UI.Background = self.Library.Appearance:Snapshot() end
    for id, entry in pairs(self.Entries) do
        local option = entry.Option
        if not option.IgnoreProfile and self.Library.Options[entry.Id] == option then
            local item = { Type=option.Type, Value=option.Value }
            if option.Type == "Dropdown" then
                item.Multi = option.Multi
                if option.Multi then item.Value = clone(option:GetActiveValues()) end
            elseif option.Type == "Keybind" then item.Mode = option.Mode
            elseif option.Type == "Colorpicker" then item.Value = { R=option.Value.R,G=option.Value.G,B=option.Value.B,Transparency=option.Transparency or 0 } end
            data.Options[id] = item
        end
    end
    return data
end
function Profiles:List()
    local names = {};for name in pairs(self.Data) do names[#names+1]=name end
    table.sort(names, function(a,b) return a:lower()<b:lower() end)
    return names
end
function Profiles:Commit(nextData)
    if self.StorageError then return false, self.StorageError end
    if self.Write then
        local encoded, text = pcall(HttpService.JSONEncode, HttpService, {Format="BloomwareProfiles",Version=1,Profiles=nextData})
        if not encoded or #text > 524288 then return false, "Profiles could not be encoded or exceed 512 KB." end
        local ok, result = pcall(self.Write, text)
        if not ok or result == false then return false, "Profiles could not be saved: " .. tostring(result) end
    end
    self.Data = nextData
    self:NotifyChanged()
    return true
end
function Profiles:Save(name, overwrite)
    if self.Library.Appearance and self.Library.Appearance.Loading then return false, "Wait for the background to load before saving a profile." end
    local normalized, message = validName(name); if not normalized then return false, message end
    name = normalized
    if self.Data[name] and not overwrite then return false, "A profile with this name already exists." end
    if not self.Data[name] and #self:List() >= 64 then return false, "The limit is 64 profiles." end
    local data = self:Capture(name)
    local valid, errorMessage = validData(data);if not valid then return false,errorMessage end
    local nextData = clone(self.Data);nextData[name]=data
    local ok, errorText = self:Commit(nextData)
    if ok then self.Active=name;self.Dirty=false;self:NotifyChanged() end
    return ok, ok and (self.Mode=="session" and "Saved for this session. Export JSON to keep a copy." or "Profile saved.") or errorText
end
local function validateForOption(entry, registered)
    local option,config = registered.Option,registered.Config
    if entry.Type ~= option.Type then return false, "Option type changed." end
    if option.Type == "Slider" and (entry.Value < option.Min or entry.Value > option.Max) then return false,"Slider value is outside its current range." end
    if option.Type == "Input" then
        if option.Numeric and entry.Value ~= "" and not tonumber(entry.Value) then return false,"Expected a numeric input." end
        if config.MaxLength and (not utf8.len(entry.Value) or utf8.len(entry.Value)>config.MaxLength) then return false,"Input exceeds its maximum length." end
    end
    if option.Type == "Dropdown" then
        if option.Multi ~= entry.Multi then return false,"Dropdown mode changed." end
        local values = entry.Multi and entry.Value or (entry.Value~=nil and {entry.Value} or {})
        for _,value in ipairs(values) do if not table.find(option.Values,value) then return false,"Dropdown option is no longer available." end end
    end
    local keyName = option.Type == "Keybind" and Compatibility.InputName(entry.Value) or nil
    if keyName and keyName ~= "None" and keyName ~= "MouseLeft" and keyName ~= "MouseRight" and keyName ~= "MouseMiddle" then
        local valid,key = pcall(function()return Enum.KeyCode[keyName]end)
        if not valid or not key then return false,"Unknown key binding." end
    end
    return true
end
local function applyEntry(option, entry)
    if entry.Type == "Colorpicker" then option:SetValueRGB(Color3.new(entry.Value.R,entry.Value.G,entry.Value.B),entry.Value.Transparency)
    elseif entry.Type == "Keybind" then option:SetValue(entry.Value,entry.Mode)
    else option:SetValue(clone(entry.Value)) end
end
function Profiles:Load(name)
    if self.Applying then return false,"Another profile is being applied." end
    local data = self.Data[name];if not data then return false,"Choose an existing profile." end
    local valid,message = validData(data);if not valid then return false,message end
    local changes, skipped = {},0
    for id,entry in pairs(data.Options) do
        local registered = self.Entries[id]
        if registered and not registered.Option.IgnoreProfile and self.Library.Options[registered.Id]==registered.Option then
            local good,reason=validateForOption(entry,registered)
            if not good then return false,id .. ": " .. reason end
            changes[#changes+1]={Id=id,Option=registered.Option,Value=entry}
        else skipped=skipped+1 end
    end
    table.sort(changes,function(a,b)return a.Id<b.Id end)
    if data.UI and data.UI.Theme and not table.find(self.Library.Themes,data.UI.Theme) then return false,"The profile theme is unavailable." end
    local library,before=self.Library,self:Capture()
    self.Applying=true;library._CallbackQueue={}
    local applied,reason=pcall(function()
        for _,change in ipairs(changes)do applyEntry(change.Option,change.Value)end
        if data.UI then
            if data.UI.Theme then library:SetTheme(data.UI.Theme) end
            if data.UI.Transparency~=nil then library:ToggleTransparency(data.UI.Transparency) end
        end
    end)
    local queue=library._CallbackQueue
    if not applied then
        for _,change in ipairs(changes)do if before.Options[change.Id] then pcall(applyEntry,change.Option,before.Options[change.Id])end end
        pcall(library.SetTheme,library,before.UI.Theme);pcall(library.ToggleTransparency,library,before.UI.Transparency)
    end
    library._CallbackQueue=nil;self.Applying=false
    if not applied then return false,"Profile was not applied: " .. tostring(reason) end
    self.Active=name;self.Dirty=false
    -- Restore after the callback queue closes so internal control syncing stays silent.
    -- Old version-1 profiles without Background preserve the current wallpaper.
    if data.UI and data.UI.Background and library.Appearance then library.Appearance:Restore(data.UI.Background) end
    local errors=0
    for _,call in ipairs(queue)do
        if library.Unloaded then break end
        if library:SafeCallback(call.Callback,table.unpack(call.Args,1,call.Args.n))==false then errors=errors+1 end
    end
    self:NotifyChanged()
    return true,"Profile loaded." .. (skipped>0 and (" Skipped unavailable options: "..skipped..".")or"") .. (errors>0 and (" Callback errors: "..errors..".")or"")
end
function Profiles:Delete(name)
    if not self.Data[name] then return false,"Choose an existing profile." end
    local nextData=clone(self.Data);nextData[name]=nil
    local ok,message=self:Commit(nextData)
    if ok and self.Active==name then self.Active=nil;self.Dirty=false;self:NotifyChanged()end
    return ok,ok and "Profile deleted." or message
end
function Profiles:Export(name)
    if not name and self.Library.Appearance and self.Library.Appearance.Loading then return nil, "Wait for the background to load before exporting a profile." end
    local data = name and self.Data[name] or self:Capture()
    if not data then return nil,"Choose an existing profile." end
    local ok,text=pcall(HttpService.JSONEncode,HttpService,data)
    return ok and text or nil,not ok and tostring(text) or nil
end
function Profiles:Import(text,name,overwrite)
    if type(text)~="string" or #text>524288 then return false,"Paste a JSON profile smaller than 512 KB." end
    local decoded,data=pcall(HttpService.JSONDecode,HttpService,text)
    if not decoded then return false,"Invalid JSON." end
    local valid,message=validData(data);if not valid then return false,message end
    local normalized,errorText=validName(name~="" and name or data.Name)
    if not normalized then return false,errorText end
    if self.Data[normalized] and not overwrite then return false,"A profile with this name already exists." end
    if not self.Data[normalized] and #self:List()>=64 then return false,"The limit is 64 profiles." end
    local nextData=clone(self.Data);data.Name=normalized;nextData[normalized]=clone(data)
    local ok,reason=self:Commit(nextData)
    return ok,ok and "Profile imported. Select it and press Load to apply it." or reason
end
function Profiles:Destroy() self.Changed=nil;table.clear(self.Entries);table.clear(self.Data)end
return Profiles
