local passed = 0
local function check(name, callback)
    callback();passed+=1;print("PASS public: "..name)
end

check("default window uses PlayerGui and makes no project HTTP request",function()
    local library=loadLibrary()
    local window=library:CreateWindow({AppId="default-test"})
    window:AddTab({Title="Main"});Scheduler.flush()
    assert(library.GUI.Parent==Mock.Services.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui"))
    assert(window.TitleBar.Title.Text=="Bloomware UI")
    assert(next(Mock.Calls)==nil)
    for path in pairs(Mock.Files)do assert(not path:find("logo",1,true))end
    library:Destroy()
end)

check("separate AppId values get separate profile files",function()
    local profileFiles={}
    -- A native file adapter is optional, but when present it must be scoped.
    local originalRead,originalIsFile=readfile,isfile
    readfile=function(path)return Mock.Files[path]end
    isfile=function(path)return Mock.Files[path]~=nil end
    for _,id in ipairs({"app-one","app-two"})do
        local library=loadLibrary()
        library:CreateWindow({Title="Same title",AppId=id,Appearance=false})
        profileFiles[id]=library.Profiles.File
        assert(library.Profiles:Save("test"))
        library:Destroy()
    end
    assert(profileFiles["app-one"]~=profileFiles["app-two"])
    assert(Mock.Files[profileFiles["app-one"]]and Mock.Files[profileFiles["app-two"]])
    readfile,isfile=originalRead,originalIsFile
end)

check("the example loads as a LocalScript beside a ModuleScript",function()
    local folder=Instance.new("Folder")
    local module=Instance.new("ModuleScript");module.Name="BloomwareUI";module.Parent=folder
    local localScript=Instance.new("LocalScript");localScript.Parent=folder
    local library,window=runExample(localScript,function(target)
        assert(target==module);return loadLibrary()
    end,nil,nil,nil)
    Scheduler.flush()
    assert(window:SelectTab(1,true)and window:SelectTab(2,true)and window:SelectTab(3,true))
    assert(not window:SelectTab(4,true))
    local options=library.Options
    assert(options.Enabled and options.ProjectName and options.PreviewColor and options.NotifyKey)
    options.ProjectName:SetValue("Different project")
    options.Amount:SetValue(72)
    assert(library.Options.Preview.Value:find("Different project",1,true))
    assert(library.Options.Preview.Value:find("72",1,true))
    assert(library.Profiles:Save("example"))
    options.Amount:SetValue(5)
    assert(library.Profiles:Load("example"));assert(options.Amount.Value==72)
    library:Destroy()
end)

check("the example supports a local file without a hosted URL",function()
    local seen=false
    local library,window=runExample(nil,nil,function(path)
        assert(path=="BloomwareUI.lua");return "local source"
    end,function(path)return path=="BloomwareUI.lua"end,function(source)
        assert(source=="local source");seen=true;return loadLibrary
    end)
    Scheduler.flush();assert(seen and window and library.Loaded)
    assert(next(Mock.Calls)==nil)
    library:Destroy()
end)

check("missing example installation gives a useful message",function()
    local ok,message=pcall(runExample,nil,nil,nil,nil,nil)
    assert(not ok and tostring(message):find("BloomwareUI ModuleScript",1,true))
end)

print("All "..passed.." public checks passed (Roblox APIs mocked).")
