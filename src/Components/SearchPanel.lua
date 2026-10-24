-- Bloomware UI: global settings search and navigation.
local Creator = require(script.Parent.Parent.Creator)
local UserInputService = game:GetService("UserInputService")
local New = Creator.New
return function(window, library)
    local panel = { Results={}, Rows={}, Selected=1, Generation=0 }
    panel.Frame = New("Frame", { Name="SearchPanel",BackgroundTransparency=1,Visible=false,Parent=window.Root })
    local field = require(script.Parent.Textbox)(panel.Frame,true)
    panel.Input = field.Input
    field.Frame.Position=UDim2.fromOffset(0,0);field.Frame.Size=UDim2.new(1,-56,0,44)
    field.Input.PlaceholderText="Search settings, descriptions or tabs..."
    local close=New("TextButton",{
        Text="×",TextSize=22,Size=UDim2.fromOffset(44,44),Position=UDim2.new(1,-44,0,0),
        BackgroundTransparency=0.85,Parent=panel.Frame,
        ThemeTag={BackgroundColor3="Tab",TextColor3="Text"},
    },{New("UICorner",{CornerRadius=UDim.new(0,9)})})
    panel.Status=New("TextLabel",{
        Text="Type a setting name, description or tab.",TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,
        TextWrapped=true,Size=UDim2.new(1,0,0,34),Position=UDim2.fromOffset(0,50),Parent=panel.Frame,
        FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json"),ThemeTag={TextColor3="SubText"},
    })
    panel.List=New("ScrollingFrame",{
        Size=UDim2.new(1,0,1,-90),Position=UDim2.fromOffset(0,90),BackgroundTransparency=1,
        CanvasSize=UDim2.fromOffset(0,0),ScrollBarThickness=3,ScrollingDirection=Enum.ScrollingDirection.Y,
        Parent=panel.Frame,ThemeTag={ScrollBarImageColor3="SubText"},
    },{New("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder}),New("UIPadding",{PaddingRight=UDim.new(0,6),PaddingLeft=UDim.new(0,1),PaddingTop=UDim.new(0,1)})})
    function panel:Select(index)
        self.Selected=math.clamp(index,1,math.max(1,#self.Results))
        for i,row in ipairs(self.Rows)do
            Creator.OverrideTag(row.Title,{TextColor3=i==self.Selected and "Accent" or "Text"})
            row.Frame.BackgroundTransparency=i==self.Selected and 0 or Creator.GetThemeProperty("ElementTransparency")
        end
    end
    function panel:Choose(index)
        local result=self.Results[index or self.Selected]
        if result then return window:Reveal(result.Entry) end
        return false
    end
    function panel:Layout()
        local height=window.Size.Y.Offset*self.Frame.Size.Y.Scale+self.Frame.Size.Y.Offset
        local compact=window.Mobile and height<190
        local changed=self.Compact~=compact
        self.Compact=compact
        self.Status.Visible=not compact
        local top=compact and 52 or 90
        self.List.Position=UDim2.fromOffset(0,top)
        self.List.Size=UDim2.new(1,0,1,-top)
        if changed and self.Frame.Visible then self:Refresh()end
    end
    function panel:Refresh()
        if window.Destroyed or not self.Frame.Visible then return end
        for _,row in ipairs(self.Rows)do row.Frame:Destroy()end
        table.clear(self.Rows)
        local results,total=library.Search:Search(self.Input.Text,100)
        self.Results=results
        local query=library.Search.Fold(self.Input.Text)
        self.Status.Text=query=="" and "Type a setting name, description or tab." or (total==0 and "No settings found. Try another word." or (tostring(total).." settings found"..(total>#results and " · showing the first 100" or "")))
        local rowHeight=self.Compact and 56 or 70
        for index,result in ipairs(results)do
            local row=New("TextButton",{
                Text="",Size=UDim2.new(1,0,0,rowHeight),LayoutOrder=index,Parent=self.List,
                ThemeTag={BackgroundColor3="Element",BackgroundTransparency="ElementTransparency"},
            },{New("UICorner",{CornerRadius=UDim.new(0,10)}),New("UIStroke",{Transparency=0.6,ThemeTag={Color="ElementBorder"}})})
            local title=New("TextLabel",{
                Text=result.Title,TextSize=13,TextTruncate=Enum.TextTruncate.AtEnd,TextXAlignment=Enum.TextXAlignment.Left,
                Size=UDim2.new(1,-28,0,22),Position=UDim2.fromOffset(14,self.Compact and 6 or 10),Parent=row,
                FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Medium),ThemeTag={TextColor3="Text"},
            })
            New("TextLabel",{
                Text=result.Path,TextSize=11,TextTruncate=Enum.TextTruncate.AtEnd,TextXAlignment=Enum.TextXAlignment.Left,
                Size=UDim2.new(1,-28,0,20),Position=UDim2.fromOffset(14,self.Compact and 29 or 36),Parent=row,
                FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json"),ThemeTag={TextColor3="SubText"},
            })
            Creator.AddSignal(row.Activated,function()self:Choose(index)end,row)
            self.Rows[index]={Frame=row,Title=title}
        end
        self.List.CanvasSize=UDim2.fromOffset(0,#results*(rowHeight+8))
        self:Select(1)
    end
    function panel:Open(query)
        self.Frame.Visible=true
        if query~=nil then self.Input.Text=query end
        self:Refresh()
        self.Input:CaptureFocus()
    end
    function panel:Close()
        self.Generation=self.Generation+1
        self.Frame.Visible=false
        self.Input:ReleaseFocus()
    end
    Creator.AddSignal(close.Activated,function()window:CloseTools()end)
    Creator.AddSignal(panel.Input:GetPropertyChangedSignal("Text"),function()
        panel.Generation=panel.Generation+1
        local generation=panel.Generation
        task.delay(0.08,function()if generation==panel.Generation and not window.Destroyed then panel:Refresh()end end)
    end,panel.Frame)
    Creator.AddSignal(panel.Input.FocusLost,function(entered)if entered and panel.Frame.Visible then panel:Choose()end end,panel.Frame)
    Creator.AddSignal(UserInputService.InputBegan,function(input)
        if not panel.Frame.Visible or UserInputService:GetFocusedTextBox()~=panel.Input then return end
        if input.KeyCode==Enum.KeyCode.Down then panel:Select(panel.Selected+1)
        elseif input.KeyCode==Enum.KeyCode.Up then panel:Select(panel.Selected-1)end
    end,panel.Frame)
    library.Search.Changed=function()if panel.Frame.Visible then panel:Refresh()end end
    return panel
end
