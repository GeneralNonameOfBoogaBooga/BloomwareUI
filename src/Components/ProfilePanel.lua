-- Bloomware UI: profile browser, save/load and JSON import/export.
local Creator = require(script.Parent.Parent.Creator)
local New = Creator.New
return function(window,library)
    local manager=library.Profiles
    local panel={Selected=nil,Rows={}}
    local layout=New("UIListLayout",{Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder})
    panel.Frame=New("ScrollingFrame",{
        Name="ProfilePanel",Visible=false,BackgroundTransparency=1,CanvasSize=UDim2.fromOffset(0,0),ScrollBarThickness=3,
        ScrollingDirection=Enum.ScrollingDirection.Y,Parent=window.Root,ThemeTag={ScrollBarImageColor3="SubText"},
    },{layout,New("UIPadding",{PaddingLeft=UDim.new(0,1),PaddingRight=UDim.new(0,7),PaddingBottom=UDim.new(0,12)})})
    local function label(text,order,height)
        return New("TextLabel",{Text=text,TextSize=12,TextWrapped=true,AutomaticSize=Enum.AutomaticSize.Y,
            Size=UDim2.new(1,0,0,height or 20),LayoutOrder=order,Parent=panel.Frame,TextXAlignment=Enum.TextXAlignment.Left,
            FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json"),ThemeTag={TextColor3="SubText"}})
    end
    local back=New("TextButton",{
        Text="‹  Back to settings",TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(1,0,0,44),LayoutOrder=1,
        BackgroundTransparency=1,Parent=panel.Frame,ThemeTag={TextColor3="Accent"},
    })
    panel.Storage=label("",2,30)
    panel.Active=label("No active profile",3)
    local field=require(script.Parent.Textbox)(panel.Frame,true)
    field.Frame.Size=UDim2.new(1,0,0,44);field.Frame.LayoutOrder=4
    field.Input.PlaceholderText="Profile name";panel.NameInput=field.Input
    panel.List=New("ScrollingFrame",{
        Name="SavedProfiles",Size=UDim2.new(1,0,0,140),LayoutOrder=5,BackgroundTransparency=0.35,
        CanvasSize=UDim2.fromOffset(0,0),ScrollBarThickness=3,ScrollingDirection=Enum.ScrollingDirection.Y,Parent=panel.Frame,
        ThemeTag={BackgroundColor3="DropdownHolder",ScrollBarImageColor3="SubText"},
    },{New("UICorner",{CornerRadius=UDim.new(0,9)}),New("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder}),New("UIPadding",{PaddingLeft=UDim.new(0,5),PaddingRight=UDim.new(0,5),PaddingTop=UDim.new(0,5)})})
    local grid=New("UIGridLayout",{CellPadding=UDim2.fromOffset(8,8),CellSize=UDim2.new(1/3,-6,0,44),SortOrder=Enum.SortOrder.LayoutOrder})
    local actions=New("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,96),LayoutOrder=6,Parent=panel.Frame},{grid})
    label("JSON import / export",7)
    local jsonScroll=New("ScrollingFrame",{
        Size=UDim2.new(1,0,0,160),LayoutOrder=8,CanvasSize=UDim2.fromOffset(0,0),ScrollBarThickness=3,
        ScrollingDirection=Enum.ScrollingDirection.Y,Parent=panel.Frame,
        ThemeTag={BackgroundColor3="Input",ScrollBarImageColor3="SubText"},
    },{New("UICorner",{CornerRadius=UDim.new(0,9)}),New("UIStroke",{Transparency=0.6,ThemeTag={Color="InElementBorder"}})})
    panel.JSON=New("TextBox",{
        Name="ProfileJSON",Text="",PlaceholderText="Export a profile or paste JSON here, then press Import.",TextSize=12,
        FontFace=Font.new("rbxasset://fonts/families/RobotoMono.json"),BackgroundTransparency=1,ClearTextOnFocus=false,
        MultiLine=true,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,
        AutomaticSize=Enum.AutomaticSize.Y,Size=UDim2.new(1,-24,0,140),Position=UDim2.fromOffset(12,10),Parent=jsonScroll,
        ThemeTag={TextColor3="Text",PlaceholderColor3="SubText"},
    })
    panel.Status=label("Save your current settings, or select a profile to load.",9,30)
    function panel:SetStatus(message,success)
        self.Status.Text=message or ""
        Creator.OverrideTag(self.Status,{TextColor3=success==false and "Error" or "SubText"})
    end
    function panel:Refresh()
        if window.Destroyed then return end
        self.Storage.Text=manager.StorageError or (manager.Mode=="session" and "Session storage · export JSON to keep profiles after closing." or "Profile storage is available. Press Save to keep changes.")
        self.Active.Text=manager.Active and ("Active: "..manager.Active..(manager.Dirty and " · unsaved changes" or "")) or "No active profile"
        for _,row in ipairs(self.Rows)do row:Destroy()end
        table.clear(self.Rows)
        local names=manager:List()
        if self.Selected and not manager.Data[self.Selected]then self.Selected=nil end
        for index,name in ipairs(names)do
            local row=New("TextButton",{
                Text="  "..name,TextSize=13,TextTruncate=Enum.TextTruncate.AtEnd,TextXAlignment=Enum.TextXAlignment.Left,
                Size=UDim2.new(1,-3,0,44),LayoutOrder=index,BackgroundTransparency=self.Selected==name and 0.86 or 1,Parent=self.List,
                FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Medium),
                ThemeTag={BackgroundColor3="Tab",TextColor3=self.Selected==name and "Accent" or "Text"},
            },{New("UICorner",{CornerRadius=UDim.new(0,7)})})
            Creator.AddSignal(row.Activated,function()self.Selected=name;self.NameInput.Text=name;self:Refresh()end,row)
            self.Rows[#self.Rows+1]=row
        end
        if #names==0 then
            local empty=New("TextLabel",{Text="No saved profiles yet",TextSize=12,Size=UDim2.new(1,0,0,44),Parent=self.List,ThemeTag={TextColor3="SubText"}})
            self.Rows[1]=empty
        end
        self.List.CanvasSize=UDim2.fromOffset(0,math.max(1,#names)*48+10)
    end
    local function confirm(title,content,callback)
        window:Dialog({Title=title,Content=content,Buttons={{Title="Cancel"},{Title="Continue",Callback=callback}}})
    end
    local function action(text,order,callback)
        local button=New("TextButton",{
            Text=text,TextSize=13,LayoutOrder=order,Parent=actions,BackgroundTransparency=0.3,
            FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Medium),
            ThemeTag={TextColor3="Text",BackgroundColor3="DialogButton"},
        },{New("UICorner",{CornerRadius=UDim.new(0,8)}),New("UIStroke",{Transparency=0.6,ThemeTag={Color="DialogButtonBorder"}})})
        Creator.AddSignal(button.Activated,callback)
        return button
    end
    panel.SaveButton=action("Save",1,function()
        local name=panel.NameInput.Text:match("^%s*(.-)%s*$")
        local function save(overwrite)
            local ok,message=manager:Save(name,overwrite);panel:SetStatus(message,ok)
            if ok then panel.Selected=name;panel:Refresh()end
        end
        if manager.Data[name]then confirm("Overwrite profile",'Replace "'..name..'" with the current settings?',function()save(true)end)else save(false)end
    end)
    panel.LoadButton=action("Load",2,function()
        local ok,message=manager:Load(panel.Selected);panel:SetStatus(message,ok)
    end)
    panel.DeleteButton=action("Delete",3,function()
        local name=panel.Selected
        if not name then panel:SetStatus("Choose an existing profile.",false);return end
        confirm("Delete profile",'Delete "'..name..'"?',function()local ok,message=manager:Delete(name);panel:SetStatus(message,ok)end)
    end)
    panel.ExportButton=action("Export JSON",4,function()
        local text,message=manager:Export(panel.Selected)
        if text then panel.JSON.Text=text;panel:SetStatus("JSON is ready. Select the text to copy it.",true)else panel:SetStatus(message,false)end
    end)
    panel.ImportButton=action("Import JSON",5,function()
        local name=panel.NameInput.Text:match("^%s*(.-)%s*$")
        local function import(overwrite)local ok,message=manager:Import(panel.JSON.Text,name,overwrite);panel:SetStatus(message,ok);if ok then panel:Refresh()end end
        if name~="" and manager.Data[name]then confirm("Overwrite profile",'Replace "'..name..'" with imported JSON?',function()import(true)end)else import(false)end
    end)
    panel.CopyButton=action(type(setclipboard)=="function" and "Copy JSON" or "Select JSON",6,function()
        if type(setclipboard)=="function" then
            local ok=pcall(setclipboard,panel.JSON.Text);panel:SetStatus(ok and "JSON copied." or "Could not copy. Select the JSON text manually.",ok)
        else panel.JSON:CaptureFocus();panel.JSON.CursorPosition=#panel.JSON.Text+1;panel.JSON.SelectionStart=1 end
    end)
    function panel:Layout(mobile)
        local columns=mobile and 2 or 3
        grid.CellSize=UDim2.new(1/columns,-(columns-1)*8/columns,0,44)
        grid.FillDirectionMaxCells=columns
        actions.Size=UDim2.new(1,0,0,math.ceil(6/columns)*52-8)
    end
    function panel:Open()self.Frame.Visible=true;self:Refresh()end
    function panel:Close()self.Frame.Visible=false;self.NameInput:ReleaseFocus();self.JSON:ReleaseFocus()end
    Creator.AddSignal(back.Activated,function()window:CloseTools()end)
    Creator.AddSignal(layout:GetPropertyChangedSignal("AbsoluteContentSize"),function()
        panel.Frame.CanvasSize=UDim2.fromOffset(0,layout.AbsoluteContentSize.Y/Creator.GetScale(panel.Frame)+12)
    end,panel.Frame)
    Creator.AddSignal(panel.JSON:GetPropertyChangedSignal("AbsoluteSize"),function()
        jsonScroll.CanvasSize=UDim2.fromOffset(0,panel.JSON.AbsoluteSize.Y/Creator.GetScale(panel.JSON)+20)
    end,panel.Frame)
    manager.Changed=function()if panel.Frame.Visible then panel:Refresh()end end
    panel:Layout(window.Mobile)
    return panel
end
