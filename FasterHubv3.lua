local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa Hub cũ nếu chạy lại script
if CoreGui:FindFirstChild("FasterHub") then
    CoreGui:FindFirstChild("FasterHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FasterHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Hàm gửi thông báo game
local function SendNotification(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Faster Hub",
            Text = text,
            Duration = 3
        })
    end)
end

-- ==========================================
-- 1. CUTSCENE & HỆ THỐNG NHẬP KEY
-- ==========================================
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.ZIndex = 100
IntroFrame.Parent = ScreenGui

local AuthorText = Instance.new("TextLabel")
AuthorText.Size = UDim2.new(0.6, 0, 0.1, 0)
AuthorText.Position = UDim2.new(0.2, 0, 0.35, 0)
AuthorText.BackgroundTransparency = 1
AuthorText.Font = Enum.Font.GothamBold
AuthorText.Text = "Faster Hub by @Hacker_loso1vietnam"
AuthorText.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthorText.TextScaled = true
AuthorText.ZIndex = 101
AuthorText.Parent = IntroFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.3, 0, 0.08, 0)
KeyInput.Position = UDim2.new(0.35, 0, 0.5, 0)
KeyInput.PlaceholderText = "Nhập Key ở đây..."
KeyInput.Text = ""
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextScaled = true
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.ZIndex = 101
KeyInput.Parent = IntroFrame
Instance.new("UICorner", KeyInput)

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.15, 0, 0.08, 0)
SubmitBtn.Position = UDim2.new(0.425, 0, 0.6, 0)
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextScaled = true
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.ZIndex = 101
SubmitBtn.Parent = IntroFrame
Instance.new("UICorner", SubmitBtn)

-- Thanh Loading (Ẩn lúc đầu)
local LoadBarBG = Instance.new("Frame")
LoadBarBG.Size = UDim2.new(0.4, 0, 0.03, 0)
LoadBarBG.Position = UDim2.new(0.3, 0, 0.55, 0)
LoadBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadBarBG.Visible = false
LoadBarBG.ZIndex = 101
LoadBarBG.Parent = IntroFrame
Instance.new("UICorner", LoadBarBG)

local LoadBarFill = Instance.new("Frame")
LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
LoadBarFill.ZIndex = 102
LoadBarFill.Parent = LoadBarBG
Instance.new("UICorner", LoadBarFill)

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(1, 0, 1.5, 0)
PercentText.Position = UDim2.new(0, 0, -1.5, 0)
PercentText.BackgroundTransparency = 1
PercentText.Font = Enum.Font.GothamBold
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentText.TextScaled = true
PercentText.ZIndex = 102
PercentText.Visible = false
PercentText.Parent = LoadBarBG

-- ==========================================
-- 2. NÚT FHUB (HÌNH VUÔNG - VIỀN CẦU VỒNG)
-- ==========================================
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleButton.Text = "Fhub"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextScaled = true
ToggleButton.Visible = false -- Sẽ hiện sau khi load xong
ToggleButton.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.Parent = ToggleButton
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 0, 255))
}
UIGradient.Parent = UIStroke

RunService.RenderStepped:Connect(function()
    UIGradient.Rotation = (UIGradient.Rotation + 2) % 360
end)

-- ==========================================
-- XỬ LÝ NHẬP KEY & LOADING
-- ==========================================
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "FasterHub123" then
        SendNotification("Đang kích hoạt key✅")
        
        -- Ẩn UI nhập key
        KeyInput.Visible = false
        SubmitBtn.Visible = false
        
        -- Hiện thanh Loading
        LoadBarBG.Visible = true
        PercentText.Visible = true
        
        -- Hiệu ứng Loading (Chạy vài giây)
        for i = 0, 100 do
            PercentText.Text = tostring(i) .. "%"
            LoadBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
            task.wait(0.02)
        end
        task.wait(0.5)
        
        IntroFrame:Destroy()
        ToggleButton.Visible = true
        SendNotification("Đã kích hoạt scirpt thành công ✅")
    else
        SendNotification("Bạn đã nhập sai key, vui lòng thử lại ❌")
    end
end)


-- ==========================================
-- 3. BẢNG HUB & TABS (GIỮ NGUYÊN TỪ V2)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "FASTER HUB V3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

-- TAB BUTTONS
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, 0, 0, 30)
TabContainer.Position = UDim2.new(0, 0, 0, 30)
TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabContainer.Parent = MainFrame
Instance.new("UIListLayout", TabContainer).FillDirection = Enum.FillDirection.Horizontal

local function CreateTabBtn(name, sizeScale)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(sizeScale, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = TabContainer
    return btn
end

local TabHomeBtn = CreateTabBtn("CHỨC NĂNG", 0.4)
local TabTPBtn = CreateTabBtn("TP PLAYER", 0.3)
local TabSetBtn = CreateTabBtn("CÀI ĐẶT", 0.3)

local function CreatePage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -70)
    page.Position = UDim2.new(0, 10, 0, 65)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.Visible = false
    page.Parent = MainFrame
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 8)
    return page, layout
end

local PageHome, HomeLayout = CreatePage()
local PageTP, TPLayout = CreatePage()
local PageSet, SetLayout = CreatePage()

PageHome.Visible = true
TabHomeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local function SwitchTab(activePage, activeBtn)
    PageHome.Visible = (activePage == PageHome)
    PageTP.Visible = (activePage == PageTP)
    PageSet.Visible = (activePage == PageSet)
    
    TabHomeBtn.TextColor3 = (activeBtn == TabHomeBtn) and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)
    TabTPBtn.TextColor3 = (activeBtn == TabTPBtn) and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)
    TabSetBtn.TextColor3 = (activeBtn == TabSetBtn) and Color3.new(1,1,1) or Color3.fromRGB(150,150,150)
end

TabHomeBtn.MouseButton1Click:Connect(function() SwitchTab(PageHome, TabHomeBtn) end)
TabTPBtn.MouseButton1Click:Connect(function() SwitchTab(PageTP, TabTPBtn) end)
TabSetBtn.MouseButton1Click:Connect(function() SwitchTab(PageSet, TabSetBtn) end)

-- ==========================================
-- 4. HÀM TẠO GIAO DIỆN CON
-- ==========================================
local function CreateFeature(parent, name, defaultVal)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Frame.Parent = parent
    Instance.new("UICorner", Frame)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 50, 0, 25)
    ToggleBtn.Position = UDim2.new(0.82, -10, 0.5, -12.5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", ToggleBtn)
    ToggleBtn.Parent = Frame

    local InputBox = nil
    if defaultVal then
        InputBox = Instance.new("TextBox")
        InputBox.Size = UDim2.new(0, 40, 0, 25)
        InputBox.Position = UDim2.new(0.65, -15, 0.5, -12.5)
        InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        InputBox.TextColor3 = Color3.fromRGB(255,255,255)
        InputBox.Text = tostring(defaultVal)
        InputBox.TextSize = 12
        Instance.new("UICorner", InputBox)
        InputBox.Parent = Frame
    end
    return ToggleBtn, InputBox
end

local function CreateSelector(parent, name, options, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Frame.Parent = parent
    Instance.new("UICorner", Frame)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local currentIndex = 1
    local LeftBtn = Instance.new("TextButton")
    LeftBtn.Size = UDim2.new(0, 25, 0, 25)
    LeftBtn.Position = UDim2.new(0.45, 0, 0.5, -12.5)
    LeftBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    LeftBtn.Text = "<"
    LeftBtn.TextColor3 = Color3.new(1,1,1)
    LeftBtn.Parent = Frame
    Instance.new("UICorner", LeftBtn)

    local ValueTxt = Instance.new("TextLabel")
    ValueTxt.Size = UDim2.new(0, 70, 0, 25)
    ValueTxt.Position = UDim2.new(0.45, 30, 0.5, -12.5)
    ValueTxt.BackgroundTransparency = 1
    ValueTxt.Text = options[1].name
    ValueTxt.TextColor3 = Color3.new(1,1,1)
    ValueTxt.Font = Enum.Font.Gotham
    ValueTxt.TextSize = 12
    ValueTxt.Parent = Frame

    local RightBtn = Instance.new("TextButton")
    RightBtn.Size = UDim2.new(0, 25, 0, 25)
    RightBtn.Position = UDim2.new(0.45, 105, 0.5, -12.5)
    RightBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    RightBtn.Text = ">"
    RightBtn.TextColor3 = Color3.new(1,1,1)
    RightBtn.Parent = Frame
    Instance.new("UICorner", RightBtn)

    local function Update()
        ValueTxt.Text = options[currentIndex].name
        callback(options[currentIndex].val, currentIndex)
    end

    LeftBtn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex - 1
        if currentIndex < 1 then currentIndex = #options end
        Update()
    end)
    RightBtn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then currentIndex = 1 end
        Update()
    end)
end

-- ==========================================
-- 5. CÁC MÀU SẮC CHO SETTINGS
-- ==========================================
local BgColors = {
    {name = "Đen nhạt", val = Color3.fromRGB(25,25,25)}, {name = "Đỏ thẫm", val = Color3.fromRGB(40,15,15)},
    {name = "Xanh đen", val = Color3.fromRGB(15,20,40)}, {name = "Tím than", val = Color3.fromRGB(30,15,40)},
    {name = "Xanh lá đậm", val = Color3.fromRGB(15,35,15)}, {name = "Xám tro", val = Color3.fromRGB(50,50,50)},
    {name = "Nâu sẫm", val = Color3.fromRGB(40,25,15)}, {name = "Hồng đen", val = Color3.fromRGB(40,15,25)},
    {name = "Cam đất", val = Color3.fromRGB(40,30,10)}, {name = "Xanh rêu", val = Color3.fromRGB(25,35,25)}
}
local TrailColors = {
    {name = "Đỏ", val = Color3.fromRGB(255,0,0)}, {name = "Cam", val = Color3.fromRGB(255,128,0)},
    {name = "Vàng", val = Color3.fromRGB(255,255,0)}, {name = "Lục", val = Color3.fromRGB(0,255,0)},
    {name = "Lam", val = Color3.fromRGB(0,0,255)}, {name = "Chàm", val = Color3.fromRGB(75,0,130)},
    {name = "Tím", val = Color3.fromRGB(238,130,238)}, {name = "Hồng", val = Color3.fromRGB(255,192,203)},
    {name = "Trắng", val = Color3.fromRGB(255,255,255)}, {name = "Đen", val = Color3.fromRGB(0,0,0)},
    {name = "Nâu", val = Color3.fromRGB(165,42,42)}, {name = "Xanh dương", val = Color3.fromRGB(0,255,255)},
    {name = "Xanh ngọc", val = Color3.fromRGB(64,224,208)}, {name = "Bạc", val = Color3.fromRGB(192,192,192)},
    {name = "Vàng kim", val = Color3.fromRGB(255,215,0)}, {name = "CẦU VỒNG", val = "Rainbow"}
}
local ESPColors = {
    {name = "Xanh lá", val = Color3.fromRGB(0,255,0)}, {name = "Đỏ", val = Color3.fromRGB(255,0,0)},
    {name = "Xanh biển", val = Color3.fromRGB(0,150,255)}, {name = "Vàng", val = Color3.fromRGB(255,255,0)},
    {name = "Cam", val = Color3.fromRGB(255,150,0)}, {name = "Hồng", val = Color3.fromRGB(255,100,255)},
    {name = "Tím", val = Color3.fromRGB(150,0,255)}, {name = "Trắng", val = Color3.fromRGB(255,255,255)},
    {name = "Cyan", val = Color3.fromRGB(0,255,255)}, {name = "Đen", val = Color3.fromRGB(0,0,0)}
}

local currentTrailColor = TrailColors[1].val
local currentESPColor = ESPColors[1].val
local trailAttachment0, trailAttachment1, trailObject

-- ==========================================
-- 6. LOGIC CHỨC NĂNG (TAB HOME)
-- ==========================================
local states = { WS=false, JP=false, NC=false, XRay=false, ESP=false, Fly=false, RainbowSkin=false, Trail=false, WallClimb=false }

local function SetupToggle(btn, stateKey, callback)
    btn.MouseButton1Click:Connect(function()
        states[stateKey] = not states[stateKey]
        if states[stateKey] then
            btn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
            btn.Text = "ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            btn.Text = "OFF"
        end
        if callback then callback(states[stateKey]) end
    end)
end

local wsBtn, wsBox = CreateFeature(PageHome, "Tốc Độ", 16)
local jpBtn, jpBox = CreateFeature(PageHome, "Nhảy (Jump)", 50)
local ncBtn, _ = CreateFeature(PageHome, "Xuyên Tường", nil)
local xrayBtn, _ = CreateFeature(PageHome, "X-Ray", nil)
local espBtn, _ = CreateFeature(PageHome, "Định Vị (ESP)", nil)
local flyBtn, flyBox = CreateFeature(PageHome, "Fly (Bay)", 16)
local rSkinBtn, _ = CreateFeature(PageHome, "Skin Cầu Vồng", nil)
local trailBtn, _ = CreateFeature(PageHome, "Đường Mòn", nil)
local climbBtn, _ = CreateFeature(PageHome, "Bám/Leo Tường", nil)

SetupToggle(wsBtn, "WS", function(v)
    if not v then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
end)
SetupToggle(jpBtn, "JP", function(v)
    if not v then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = 50 end
    end
end)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if states.WS and hum then hum.WalkSpeed = tonumber(wsBox.Text) or 16 end
    if states.JP and hum then
        hum.UseJumpPower = true
        hum.JumpPower = tonumber(jpBox.Text) or 50
    end
    if states.NC then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

SetupToggle(ncBtn, "NC")

SetupToggle(xrayBtn, "XRay", function(v)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            if v then
                if not obj:GetAttribute("OrigTrans") then obj:SetAttribute("OrigTrans", obj.Transparency) end
                obj.Transparency = 0.5
            else
                if obj:GetAttribute("OrigTrans") then obj.Transparency = obj:GetAttribute("OrigTrans") end
            end
        end
    end
end)

local function UpdateESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = plr.Character:FindFirstChild("ESP_Highlight")
            if states.ESP then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "ESP_Highlight"
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = plr.Character
                end
                hl.FillColor = currentESPColor
            else
                if hl then hl:Destroy() end
            end
        end
    end
end
SetupToggle(espBtn, "ESP", function(v) UpdateESP() end)

local hue = 0
RunService.RenderStepped:Connect(function(dt)
    hue = (hue + dt * 0.3) % 1
    local rainbowColor = Color3.fromHSV(hue, 1, 1)

    if states.RainbowSkin and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then part.Color = rainbowColor end
        end
    end

    if states.Trail and currentTrailColor == "Rainbow" and trailObject then
        trailObject.Color = ColorSequence.new(rainbowColor)
    end
end)
SetupToggle(rSkinBtn, "RainbowSkin")

SetupToggle(trailBtn, "Trail", function(v)
    local char = LocalPlayer.Character
    if v and char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        trailAttachment0 = Instance.new("Attachment", hrp)
        trailAttachment0.Position = Vector3.new(0, 1, 0)
        trailAttachment1 = Instance.new("Attachment", hrp)
        trailAttachment1.Position = Vector3.new(0, -1, 0)
        
        trailObject = Instance.new("Trail", hrp)
        trailObject.Attachment0 = trailAttachment0
        trailObject.Attachment1 = trailAttachment1
        trailObject.Lifetime = 0.5
        if currentTrailColor ~= "Rainbow" then
            trailObject.Color = ColorSequence.new(currentTrailColor)
        end
    else
        if trailObject then trailObject:Destroy() end
        if trailAttachment0 then trailAttachment0:Destroy() end
        if trailAttachment1 then trailAttachment1:Destroy() end
    end
end)

SetupToggle(climbBtn, "WallClimb")
UserInputService.JumpRequest:Connect(function()
    if states.WallClimb then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local ray = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 2.5)
            if ray and not ray.Instance:IsDescendantOf(char) then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 40, hrp.Velocity.Z) 
            end
        end
    end
end)

-- ==========================================
-- 7. FLY CHO ĐIỆN THOẠI
-- ==========================================
local flyForce, flyGyro, flyConn
local flyUpState, flyDownState = false, false

local FlyControlFrame = Instance.new("Frame")
FlyControlFrame.Size = UDim2.new(0, 120, 0, 60)
FlyControlFrame.Position = UDim2.new(1, -140, 0.45, 0) 
FlyControlFrame.BackgroundTransparency = 1
FlyControlFrame.Visible = false
FlyControlFrame.Parent = ScreenGui

local UpBtn = Instance.new("TextButton")
UpBtn.Size = UDim2.new(0, 50, 0, 50)
UpBtn.Position = UDim2.new(0, 0, 0, 0)
UpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
UpBtn.Text = "⬆️"
UpBtn.TextSize = 22
UpBtn.Parent = FlyControlFrame
Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0.5, 0)

local DownBtn = Instance.new("TextButton")
DownBtn.Size = UDim2.new(0, 50, 0, 50)
DownBtn.Position = UDim2.new(0, 60, 0, 0)
DownBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
DownBtn.Text = "⬇️"
DownBtn.TextSize = 22
DownBtn.Parent = FlyControlFrame
Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0.5, 0)

UpBtn.MouseButton1Down:Connect(function() flyUpState = true end)
UpBtn.MouseButton1Up:Connect(function() flyUpState = false end)
DownBtn.MouseButton1Down:Connect(function() flyDownState = true end)
DownBtn.MouseButton1Up:Connect(function() flyDownState = false end)

SetupToggle(flyBtn, "Fly", function(v)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    FlyControlFrame.Visible = v
    if v then
        if hrp:FindFirstChild("FlyForce") then hrp.FlyForce:Destroy() end
        if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        
        flyForce = Instance.new("BodyVelocity")
        flyForce.Name = "FlyForce"
        flyForce.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyForce.Velocity = Vector3.new(0, 0, 0)
        flyForce.Parent = hrp

        flyGyro = Instance.new("BodyGyro")
        flyGyro.Name = "FlyGyro"
        flyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        flyGyro.D = 50
        flyGyro.P = 10000
        flyGyro.Parent = hrp

        char.Humanoid.PlatformStand = true

        flyConn = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            flyGyro.CFrame = cam.CFrame
            local speed = tonumber(flyBox.Text) or 16
            local moveDir = char.Humanoid.MoveDirection 
            local ySpeed = 0
            if flyUpState then ySpeed = speed end
            if flyDownState then ySpeed = -speed end
            flyForce.Velocity = (moveDir * speed) + Vector3.new(0, ySpeed, 0)
        end)
    else
        if flyForce then flyForce:Destroy() end
        if flyGyro then flyGyro:Destroy() end
        if flyConn then flyConn:Disconnect() end
        char.Humanoid.PlatformStand = false
        flyUpState, flyDownState = false, false
    end
end)
-- ==========================================
-- 8. TAB DỊCH CHUYỂN (TP)
-- ==========================================
local function RefreshPlayerList()
    for _, child in pairs(PageTP:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local RefreshBtn = Instance.new("TextButton")
    RefreshBtn.Size = UDim2.new(1, 0, 0, 35)
    RefreshBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    RefreshBtn.Text = "🔄 Làm mới danh sách"
    RefreshBtn.TextColor3 = Color3.new(1,1,1)
    RefreshBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", RefreshBtn)
    RefreshBtn.Parent = PageTP

    RefreshBtn.MouseButton1Click:Connect(RefreshPlayerList)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, 0, 0, 35)
            pBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            pBtn.Text = "👤 " .. plr.Name
            pBtn.TextColor3 = Color3.new(1,1,1)
            pBtn.Font = Enum.Font.Gotham
            Instance.new("UICorner", pBtn)
            pBtn.Parent = PageTP

            pBtn.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
    PageTP.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 45 + 50)
end
RefreshPlayerList()
Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(RefreshPlayerList)

-- ==========================================
-- 9. TAB CÀI ĐẶT
-- ==========================================
CreateSelector(PageSet, "Màu Nền Hub", BgColors, function(val)
    MainFrame.BackgroundColor3 = val
end)

CreateSelector(PageSet, "Màu Đường Mòn", TrailColors, function(val)
    currentTrailColor = val
    if trailObject then
        if val ~= "Rainbow" then
            trailObject.Color = ColorSequence.new(val)
        end
    end
end)

CreateSelector(PageSet, "Màu Định Vị", ESPColors, function(val)
    currentESPColor = val
    if states.ESP then UpdateESP() end
end)

PageHome.CanvasSize = UDim2.new(0, 0, 0, 450)
PageSet.CanvasSize = UDim2.new(0, 0, 0, 150)
