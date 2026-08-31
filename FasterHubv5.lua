local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("FasterHubV5") then
    CoreGui:FindFirstChild("FasterHubV5"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FasterHubV5"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local function SendNotification(title, text)
    pcall(function() StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = 3}) end)
end

local function SetClipboardStr(str)
    if setclipboard then setclipboard(str)
    elseif toclipboard then toclipboard(str)
    else SendNotification("Lỗi", "Executor của bạn không hỗ trợ copy link!") end
end

-- ==========================================
-- 1. HỆ THỐNG KHỞI ĐỘNG (THÔNG BÁO & KEY)
-- ==========================================
local BlockScreen = Instance.new("Frame", ScreenGui)
BlockScreen.Size = UDim2.new(1, 0, 1, 0)
BlockScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
BlockScreen.Visible = false
BlockScreen.ZIndex = 999

-- Spinner kiểu Windows
local Spinner = Instance.new("ImageLabel", BlockScreen)
Spinner.Size = UDim2.new(0, 80, 0, 80)
Spinner.Position = UDim2.new(0.5, -40, 0.4, -40)
Spinner.BackgroundTransparency = 1
Spinner.Image = "rbxassetid://3587322965" -- Icon vòng tròn
Spinner.Visible = false
Spinner.ZIndex = 1000

-- Bảng nhập Key
local KeyFrame = Instance.new("Frame", BlockScreen)
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.Visible = false
KeyFrame.ZIndex = 1001
Instance.new("UICorner", KeyFrame)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "Vui lòng nhập key:"
KeyTitle.TextColor3 = Color3.new(1,1,1)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "Nhập key tại đây..."
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.TextColor3 = Color3.new(1,1,1)
KeyInput.Font = Enum.Font.Gotham
Instance.new("UICorner", KeyInput)

local CancelBtn = Instance.new("TextButton", KeyFrame)
CancelBtn.Size = UDim2.new(0.35, 0, 0, 35)
CancelBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
CancelBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CancelBtn.Text = "Hủy ❌"
CancelBtn.TextColor3 = Color3.new(1,1,1)
CancelBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CancelBtn)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.35, 0, 0, 35)
GetKeyBtn.Position = UDim2.new(0.55, 0, 0.65, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
GetKeyBtn.Text = "Lấy link 🔑"
GetKeyBtn.TextColor3 = Color3.new(1,1,1)
GetKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GetKeyBtn)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 25)
CheckBtn.Position = UDim2.new(0.1, 0, 0.95, 0)
CheckBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
CheckBtn.Text = "Kiểm tra Key"
CheckBtn.TextColor3 = Color3.new(1,1,1)
CheckBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CheckBtn)

-- Bảng Loading Check Key
local LoadFrame = Instance.new("Frame", BlockScreen)
LoadFrame.Size = UDim2.new(0, 300, 0, 100)
LoadFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
LoadFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LoadFrame.Visible = false
LoadFrame.ZIndex = 1001
Instance.new("UICorner", LoadFrame)

local LoadTxt = Instance.new("TextLabel", LoadFrame)
LoadTxt.Size = UDim2.new(1, 0, 0, 40)
LoadTxt.BackgroundTransparency = 1
LoadTxt.Text = "Đang kiểm tra Key🔑"
LoadTxt.TextColor3 = Color3.new(1,1,1)
LoadTxt.Font = Enum.Font.GothamBold
LoadTxt.TextSize = 16

local LoadBarBG = Instance.new("Frame", LoadFrame)
LoadBarBG.Size = UDim2.new(0.8, 0, 0, 15)
LoadBarBG.Position = UDim2.new(0.1, 0, 0.5, 0)
LoadBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", LoadBarBG)

local LoadBarFill = Instance.new("Frame", LoadBarBG)
LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
Instance.new("UICorner", LoadBarFill)

local LoadPercent = Instance.new("TextLabel", LoadFrame)
LoadPercent.Size = UDim2.new(1, 0, 0, 30)
LoadPercent.Position = UDim2.new(0, 0, 0.7, 0)
LoadPercent.BackgroundTransparency = 1
LoadPercent.Text = "0%"
LoadPercent.TextColor3 = Color3.new(1,1,1)
LoadPercent.Font = Enum.Font.GothamBold

-- Toggle Button (Biểu tượng 🎱, di chuyển được)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.Text = "🎱"
ToggleButton.TextSize = 25
ToggleButton.Visible = false
ToggleButton.Active = true
ToggleButton.Draggable = true
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

-- Logic Khởi Động
local bindable = Instance.new("BindableFunction")
bindable.OnInvoke = function(response)
    if response == "Có✅" then
        BlockScreen.Visible = true
        Spinner.Visible = true
        local spinAnim = RunService.RenderStepped:Connect(function() Spinner.Rotation = Spinner.Rotation + 5 end)
        task.wait(2)
        spinAnim:Disconnect()
        Spinner.Visible = false
        KeyFrame.Visible = true
    end
end

task.spawn(function()
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Faster Hub V5",
            Text = "Bạn có muốn kích hoạt scirpt không?",
            Duration = 10,
            Button1 = "Có✅",
            Button2 = "Không ❌",
            Callback = bindable
        })
    end)
end)

CancelBtn.MouseButton1Click:Connect(function() BlockScreen.Visible = false end)
GetKeyBtn.MouseButton1Click:Connect(function() 
    SetClipboardStr("https://sites.google.com/view/faterhub-key/trang-ch%E1%BB%A7")
    SendNotification("Thành công", "Đã copy link lấy Key!")
end)

CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "FasterHub_SuperVip" then
        KeyFrame.Visible = false
        LoadFrame.Visible = true
        for i = 0, 100 do
            LoadPercent.Text = i .. "%"
            LoadBarFill.Size = UDim2.new(i/100, 0, 1, 0)
            task.wait(0.02)
        end
        SendNotification("Faster Hub", "Đã thành công kích hoạt key🔑✅")
        BlockScreen:Destroy()
        ToggleButton.Visible = true
    else
        SendNotification("Thất bại", "Key sai hoặc đã cũ!")
    end
end)

-- ==========================================
-- 2. GIAO DIỆN HUB CHÍNH V5
-- ==========================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 420, 0, 480)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "FASTER HUB V5"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local TabScroll = Instance.new("ScrollingFrame", MainFrame)
TabScroll.Size = UDim2.new(1, 0, 0, 35)
TabScroll.Position = UDim2.new(0, 0, 0, 30)
TabScroll.BackgroundTransparency = 1
TabScroll.CanvasSize = UDim2.new(2, 0, 0, 0)
TabScroll.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabScroll)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)

local function CreateTabBtn(name)
    local btn = Instance.new("TextButton", TabScroll)
    btn.Size = UDim2.new(0, 95, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    return btn
end

local Tabs = {
    Home = CreateTabBtn("CHỨC NĂNG"),
    ESP_Fly = CreateTabBtn("ĐỊNH VỊ & BAY"),
    Troll = CreateTabBtn("TROLL & BẢO VỆ"),
    Aura = CreateTabBtn("AURA & FX"),
    Anim = CreateTabBtn("ANIM & ĐỘI HÌNH"),
    Shader = CreateTabBtn("SHADER"),
    Set = CreateTabBtn("CÀI ĐẶT")
}

local Pages = {}
for k, _ in pairs(Tabs) do
    local page = Instance.new("ScrollingFrame", MainFrame)
    page.Size = UDim2.new(1, -20, 1, -80)
    page.Position = UDim2.new(0, 10, 0, 70)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.Visible = false
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 8)
    Pages[k] = page
end
Pages.Home.Visible = true
Tabs.Home.TextColor3 = Color3.new(1,1,1)

for k, btn in pairs(Tabs) do
    btn.MouseButton1Click:Connect(function()
        for pk, page in pairs(Pages) do page.Visible = (pk == k) end
        for tbk, tbb in pairs(Tabs) do tbb.TextColor3 = (tbk == k) and Color3.new(1,1,1) or Color3.fromRGB(150,150,150) end
    end)
end

local function CreateToggle(parent, name, defaultInput)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", Frame)

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local ToggleBtn = Instance.new("TextButton", Frame)
    ToggleBtn.Size = UDim2.new(0, 50, 0, 25)
    ToggleBtn.Position = UDim2.new(0.85, -10, 0.5, -12.5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.new(1,1,1)
    ToggleBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", ToggleBtn)

    local InputBox = nil
    if defaultInput then
        InputBox = Instance.new("TextBox", Frame)
        InputBox.Size = UDim2.new(0, 40, 0, 25)
        InputBox.Position = UDim2.new(0.7, -15, 0.5, -12.5)
        InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        InputBox.TextColor3 = Color3.new(1,1,1)
        InputBox.Text = tostring(defaultInput)
        Instance.new("UICorner", InputBox)
    end
    return ToggleBtn, InputBox
end

local function CreateButton(parent, name, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local states = {}
local function RegisterToggle(btn, stateKey, callback)
    states[stateKey] = false
    btn.MouseButton1Click:Connect(function()
        states[stateKey] = not states[stateKey]
        btn.BackgroundColor3 = states[stateKey] and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        btn.Text = states[stateKey] and "ON" or "OFF"
        if callback then callback(states[stateKey]) end
    end)
end

-- ==========================================
-- 3. CÁC TÍNH NĂNG VÀ LOGIC
-- ==========================================

-- TAB HOME
local wsBtn, wsBox = CreateToggle(Pages.Home, "Tốc Độ", 16)
local jpBtn, jpBox = CreateToggle(Pages.Home, "Nhảy (Jump)", 50)
local ncBtn, _ = CreateToggle(Pages.Home, "Xuyên Tường")
local acBtn, _ = CreateToggle(Pages.Home, "Auto Clicker")
local climbBtn, _ = CreateToggle(Pages.Home, "Bám Tường (Giữ Nhảy)")

RegisterToggle(wsBtn, "WS", function(v) if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end end)
RegisterToggle(jpBtn, "JP", function(v) if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 50 end end)
RegisterToggle(ncBtn, "NC")
RegisterToggle(climbBtn, "WallClimb")

local AutoClickCircle = Instance.new("TextButton", ScreenGui)
AutoClickCircle.Size = UDim2.new(0, 50, 0, 50)
AutoClickCircle.BackgroundColor3 = Color3.new(1,1,1)
AutoClickCircle.Text = "🖱️"
AutoClickCircle.Visible = false
AutoClickCircle.Draggable = true
AutoClickCircle.Active = true
Instance.new("UICorner", AutoClickCircle).CornerRadius = UDim.new(1,0)

RegisterToggle(acBtn, "AutoClick", function(v) AutoClickCircle.Visible = v end)

-- TAB ĐỊNH VỊ & BAY (Khôi phục ESP & Fly Mobile)
local espBtn, _ = CreateToggle(Pages.ESP_Fly, "Định Vị (ESP)")
local currentESPColor = Color3.new(0,1,0)
local function UpdateESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = plr.Character:FindFirstChild("ESP_HL")
            if states.ESP then
                if not hl then hl = Instance.new("Highlight", plr.Character) hl.Name = "ESP_HL" hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop end
                hl.FillColor = currentESPColor
            else
                if hl then hl:Destroy() end
            end
        end
    end
end
RegisterToggle(espBtn, "ESP", function() UpdateESP() end)
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() task.wait(1) UpdateESP() end) end)

local flyBtn, flyBox = CreateToggle(Pages.ESP_Fly, "Fly (Bay Điện Thoại)", 16)
local FlyControlFrame = Instance.new("Frame", ScreenGui)
FlyControlFrame.Size = UDim2.new(0, 120, 0, 60)
FlyControlFrame.Position = UDim2.new(1, -140, 0.45, 0) 
FlyControlFrame.BackgroundTransparency = 1
FlyControlFrame.Visible = false
local UpBtn = Instance.new("TextButton", FlyControlFrame) UpBtn.Size = UDim2.new(0, 50, 0, 50) UpBtn.Position = UDim2.new(0, 0, 0, 0) UpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255) UpBtn.Text = "⬆️" Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0.5, 0)
local DownBtn = Instance.new("TextButton", FlyControlFrame) DownBtn.Size = UDim2.new(0, 50, 0, 50) DownBtn.Position = UDim2.new(0, 60, 0, 0) DownBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0) DownBtn.Text = "⬇️" Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0.5, 0)

local flyForce, flyGyro, flyConn, flyUpState, flyDownState
UpBtn.MouseButton1Down:Connect(function() flyUpState = true end) UpBtn.MouseButton1Up:Connect(function() flyUpState = false end)
DownBtn.MouseButton1Down:Connect(function() flyDownState = true end) DownBtn.MouseButton1Up:Connect(function() flyDownState = false end)

RegisterToggle(flyBtn, "Fly", function(v)
    local char = LocalPlayer.Character
    FlyControlFrame.Visible = v
    if v and char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        flyForce = Instance.new("BodyVelocity", hrp) flyForce.MaxForce = Vector3.new(9e9, 9e9, 9e9) flyForce.Velocity = Vector3.zero
        flyGyro = Instance.new("BodyGyro", hrp) flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9) flyGyro.P = 10000
        char.Humanoid.PlatformStand = true
        flyConn = RunService.RenderStepped:Connect(function()
            flyGyro.CFrame = Camera.CFrame
            local speed = tonumber(flyBox.Text) or 16
            local moveDir = char.Humanoid.MoveDirection 
            local ySpeed = 0
            if flyUpState then ySpeed = speed end
            if flyDownState then ySpeed = -speed end
            flyForce.Velocity = (moveDir * speed) + Vector3.new(0, ySpeed, 0)
        end)
    else
        if flyForce then flyForce:Destroy() end if flyGyro then flyGyro:Destroy() end if flyConn then flyConn:Disconnect() end
        if char then char.Humanoid.PlatformStand = false end
    end
end)

-- TAB TROLL & BẢO VỆ
local flingBtn, flingBox = CreateToggle(Pages.Troll, "Fling Aura (Lực quay)", 50)
local antikickBtn, _ = CreateToggle(Pages.Troll, "Anti-Kick")
local antiflingBtn, _ = CreateToggle(Pages.Troll, "Anti-Fling")
local antivoidBtn, _ = CreateToggle(Pages.Troll, "Anti-Void")
RegisterToggle(flingBtn, "Fling")
RegisterToggle(antikickBtn, "AntiKick")
RegisterToggle(antiflingBtn, "AntiFling")
local spawnPoint = Vector3.new(0, 50, 0)
RegisterToggle(antivoidBtn, "AntiVoid", function(v) if v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then spawnPoint = LocalPlayer.Character.HumanoidRootPart.Position end end)

-- TAB AURA & FX
local rainbowSkinBtn, _ = CreateToggle(Pages.Aura, "Rainbow Skin (Toàn Nhân Vật)")
local fireBtn, _ = CreateToggle(Pages.Aura, "Fire Aura")
local smokeBtn, _ = CreateToggle(Pages.Aura, "Smoke Aura")
local lightBtn, _ = CreateToggle(Pages.Aura, "Lighting Aura")
local trailBtn, _ = CreateToggle(Pages.Aura, "Đường Mòn (Trail)")

RegisterToggle(rainbowSkinBtn, "RainbowSkin")
RegisterToggle(fireBtn, "Fire", function(v)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if v and hrp then local f = Instance.new("Fire", hrp) f.Name = "FAura" f.Size = 10 else if hrp and hrp:FindFirstChild("FAura") then hrp.FAura:Destroy() end end
end)
RegisterToggle(smokeBtn, "Smoke", function(v)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if v and hrp then local s = Instance.new("Smoke", hrp) s.Name = "SAura" s.Size = 8 else if hrp and hrp:FindFirstChild("SAura") then hrp.SAura:Destroy() end end
end)
RegisterToggle(lightBtn, "Lighting", function(v)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if v and hrp then local l = Instance.new("Sparkles", hrp) l.Name = "LAura" else if hrp and hrp:FindFirstChild("LAura") then hrp.LAura:Destroy() end end
end)

local currentTrailColor = Color3.new(1,0,0)
local trailObj
RegisterToggle(trailBtn, "Trail", function(v)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if v and hrp then
        local a0 = Instance.new("Attachment", hrp) a0.Position = Vector3.new(0, 1, 0)
        local a1 = Instance.new("Attachment", hrp) a1.Position = Vector3.new(0, -1, 0)
        trailObj = Instance.new("Trail", hrp) trailObj.Attachment0 = a0 trailObj.Attachment1 = a1 trailObj.Lifetime = 0.5 trailObj.Color = ColorSequence.new(currentTrailColor)
    else
        if hrp then for _, c in pairs(hrp:GetChildren()) do if c:IsA("Trail") or c:IsA("Attachment") then c:Destroy() end end end
    end
end)

-- TAB ANIM & ĐỘI HÌNH
local zombiBtn, _ = CreateToggle(Pages.Anim, "Zombie Animation")
local ninjaBtn, _ = CreateToggle(Pages.Anim, "Ninja Animation")
local ragdollBtn, _ = CreateToggle(Pages.Anim, "Ragdoll On Demand")
local bigHeadBtn, _ = CreateToggle(Pages.Anim, "Big Head")
local noHeadFootBtn, _ = CreateToggle(Pages.Anim, "No Head & Foot")
local povBtn, _ = CreateToggle(Pages.Anim, "POV (Góc Nhìn Thứ 1)")
local rnNameBtn, _ = CreateToggle(Pages.Anim, "Rainbow Name")

local function SetAnim(pack)
    local char = LocalPlayer.Character if not char or not char:FindFirstChild("Animate") then return end
    local anim = char.Animate
    if pack == "Zombie" then
        if anim:FindFirstChild("idle") then anim.idle.Animation1.AnimationId = "rbxassetid://313026115" end
        if anim:FindFirstChild("walk") then anim.walk.WalkAnim.AnimationId = "rbxassetid://313032534" end
     if anim:FindFirstChild("run") then anim.run.RunAnim.AnimationId = "rbxassetid://313029472" end
        if anim:FindFirstChild("jump") then anim.jump.JumpAnim.AnimationId = "rbxassetid://313028739" end
    elseif pack == "Ninja" then
        if anim:FindFirstChild("idle") then anim.idle.Animation1.AnimationId = "rbxassetid://656117400" end
        if anim:FindFirstChild("walk") then anim.walk.WalkAnim.AnimationId = "rbxassetid://656121766" end
        if anim:FindFirstChild("run") then anim.run.RunAnim.AnimationId = "rbxassetid://656118852" end
        if anim:FindFirstChild("jump") then anim.jump.JumpAnim.AnimationId = "rbxassetid://656117878" end
    end
end
RegisterToggle(zombiBtn, "Zombie", function(v) if v then SetAnim("Zombie") end end)
RegisterToggle(ninjaBtn, "Ninja", function(v) if v then SetAnim("Ninja") end end)

RegisterToggle(ragdollBtn, "Ragdoll", function(v)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = v
    end
end)
RegisterToggle(bigHeadBtn, "BigHead", function(v)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum:FindFirstChild("HeadScale") then hum.HeadScale.Value = v and 4 or 1 end
end)
RegisterToggle(noHeadFootBtn, "NoHeadFoot", function(v)
    local char = LocalPlayer.Character
    if char then
        local parts = {"Head", "RightFoot", "RightLowerLeg", "RightUpperLeg"}
        for _, p in pairs(parts) do
            if char:FindFirstChild(p) then char[p].Transparency = v and 1 or 0 end
        end
        if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then char.Head.face.Transparency = v and 1 or 0 end
    end
end)
RegisterToggle(povBtn, "POV", function(v) LocalPlayer.CameraMode = v and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic end)

local NameTag
RegisterToggle(rnNameBtn, "RainbowName", function(v)
    if v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
        NameTag = Instance.new("BillboardGui", LocalPlayer.Character.Head)
        NameTag.Size = UDim2.new(0, 200, 0, 50) NameTag.StudsOffset = Vector3.new(0, 2, 0)
        local txt = Instance.new("TextLabel", NameTag) txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.Text = LocalPlayer.Name txt.Font = Enum.Font.GothamBold txt.TextScaled = true
    else
        if NameTag then NameTag:Destroy() NameTag = nil end
    end
end)

-- TAB SHADER
local function ClearShaders()
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end
    end
end
CreateButton(Pages.Shader, "🌑 Dark Shader (Kinh Dị)", function()
    ClearShaders()
    Lighting.Ambient = Color3.new(0,0,0) Lighting.OutdoorAmbient = Color3.new(0,0,0) Lighting.GlobalShadows = true Lighting.FogEnd = 20 Lighting.FogColor = Color3.new(0,0,0)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local pl = Instance.new("PointLight", LocalPlayer.Character.HumanoidRootPart) pl.Range = 15 pl.Brightness = 2 pl.Name = "DarkLight"
    end
end)
CreateButton(Pages.Shader, "🌅 Bình Minh Rực Rỡ", function()
    ClearShaders()
    Lighting.ClockTime = 6.5 Lighting.GlobalShadows = true Lighting.OutdoorAmbient = Color3.fromRGB(150, 100, 50)
    local sun = Instance.new("SunRaysEffect", Lighting) sun.Intensity = 0.3
    local bloom = Instance.new("BloomEffect", Lighting) bloom.Intensity = 0.8
    local cc = Instance.new("ColorCorrectionEffect", Lighting) cc.Saturation = 0.5 cc.Contrast = 0.3 cc.TintColor = Color3.fromRGB(255, 200, 150)
end)
CreateButton(Pages.Shader, "📽️ Đổ Bóng (4K Cinematic)", function()
    ClearShaders()
    Lighting.GlobalShadows = true Lighting.Brightness = 3 Lighting.ClockTime = 14
    local cc = Instance.new("ColorCorrectionEffect", Lighting) cc.Saturation = 0.2 cc.Contrast = 0.4
end)
CreateButton(Pages.Shader, "⚡ Đồ Hoạ Nhanh (Mượt Cực Độ)", function()
    ClearShaders()
    Lighting.GlobalShadows = false
    for _, p in pairs(workspace:GetDescendants()) do if p:IsA("BasePart") then p.CastShadow = false end end
end)
CreateButton(Pages.Shader, "🔄 Tắt Hết Đồ Hoạ (Mặc Định)", function()
    ClearShaders() Lighting.ClockTime = 14 Lighting.Ambient = Color3.fromRGB(127,127,127) Lighting.OutdoorAmbient = Color3.fromRGB(127,127,127) Lighting.GlobalShadows = true Lighting.FogEnd = 100000
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("DarkLight") then LocalPlayer.Character.HumanoidRootPart.DarkLight:Destroy() end
end)

-- TAB CÀI ĐẶT
local function CreateSelector(parent, name, options, callback)
    local Frame = Instance.new("Frame", parent) Frame.Size = UDim2.new(1, 0, 0, 40) Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45) Instance.new("UICorner", Frame)
    local Label = Instance.new("TextLabel", Frame) Label.Size = UDim2.new(0.4, 0, 1, 0) Label.Position = UDim2.new(0.05, 0, 0, 0) Label.BackgroundTransparency = 1 Label.Text = name Label.TextColor3 = Color3.new(1,1,1) Label.Font = Enum.Font.Gotham Label.TextXAlignment = Enum.TextXAlignment.Left
    local currentIndex = 1
    local ValueTxt = Instance.new("TextLabel", Frame) ValueTxt.Size = UDim2.new(0, 100, 0, 30) ValueTxt.Position = UDim2.new(0.45, 30, 0.5, -15) ValueTxt.BackgroundTransparency = 1 ValueTxt.Text = options[1].name ValueTxt.TextColor3 = Color3.new(1,1,1) ValueTxt.Font = Enum.Font.GothamBold
    local function update() ValueTxt.Text = options[currentIndex].name callback(options[currentIndex].val) end
    local LeftBtn = Instance.new("TextButton", Frame) LeftBtn.Size = UDim2.new(0,30,0,30) LeftBtn.Position = UDim2.new(0.45,0,0.5,-15) LeftBtn.Text = "<" Instance.new("UICorner", LeftBtn)
    LeftBtn.MouseButton1Click:Connect(function() currentIndex = currentIndex - 1 if currentIndex < 1 then currentIndex = #options end update() end)
    local RightBtn = Instance.new("TextButton", Frame) RightBtn.Size = UDim2.new(0,30,0,30) RightBtn.Position = UDim2.new(0.45,130,0.5,-15) RightBtn.Text = ">" Instance.new("UICorner", RightBtn)
    RightBtn.MouseButton1Click:Connect(function() currentIndex = currentIndex + 1 if currentIndex > #options then currentIndex = 1 end update() end)
end

CreateSelector(Pages.Set, "Màu Nền Hub", {{name="Đen",val=Color3.fromRGB(25,25,25)}, {name="Đỏ",val=Color3.fromRGB(40,15,15)}, {name="Xanh",val=Color3.fromRGB(15,20,40)}}, function(v) MainFrame.BackgroundColor3 = v end)
CreateSelector(Pages.Set, "Màu Định Vị (ESP)", {{name="Xanh Lá",val=Color3.new(0,1,0)}, {name="Đỏ",val=Color3.new(1,0,0)}, {name="Trắng",val=Color3.new(1,1,1)}}, function(v) currentESPColor = v UpdateESP() end)
CreateSelector(Pages.Set, "Màu Đường Mòn", {{name="Đỏ",val=Color3.new(1,0,0)}, {name="Xanh Dương",val=Color3.new(0,0,1)}, {name="Vàng",val=Color3.new(1,1,0)}}, function(v) currentTrailColor = v if trailObj then trailObj.Color = ColorSequence.new(v) end end)

Pages.Home.CanvasSize = UDim2.new(0, 0, 0, 300)
Pages.ESP_Fly.CanvasSize = UDim2.new(0, 0, 0, 200)
Pages.Troll.CanvasSize = UDim2.new(0, 0, 0, 300)
Pages.Aura.CanvasSize = UDim2.new(0, 0, 0, 350)
Pages.Anim.CanvasSize = UDim2.new(0, 0, 0, 450)
Pages.Shader.CanvasSize = UDim2.new(0, 0, 0, 350)
Pages.Set.CanvasSize = UDim2.new(0, 0, 0, 250)
-- ==========================================
-- VÒNG LẶP XỬ LÝ CHUNG
-- ==========================================
local SpinForce, hue = nil, 0
RunService.Stepped:Connect(function(dt)
    hue = (hue + dt * 0.3) % 1
    local char = LocalPlayer.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if states.WS and hum then hum.WalkSpeed = tonumber(wsBox.Text) or 16 end
    if states.JP and hum then hum.JumpPower = tonumber(jpBox.Text) or 50 hum.UseJumpPower = true end
    if states.NC then for _, part in pairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
    
    if states.AutoClick and AutoClickCircle.Visible then VirtualUser:ClickButton1(Vector2.new(0,0)) end
    
    if states.Fling and hrp then
        if not SpinForce then SpinForce = Instance.new("BodyAngularVelocity", hrp) SpinForce.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        SpinForce.AngularVelocity = Vector3.new(0, tonumber(flingBox.Text) or 50, 0)
    else
        if SpinForce then SpinForce:Destroy() SpinForce = nil end
    end
    
    if states.AntiVoid and hrp and hrp.Position.Y < (workspace.FallenPartsDestroyHeight + 20) then
        hrp.CFrame = CFrame.new(spawnPoint) hrp.Velocity = Vector3.zero
    end

    if states.RainbowSkin then
        local rc = Color3.fromHSV(hue, 1, 1)
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("MeshPart") then p.Color = rc end
        end
    end

    if states.RainbowName and NameTag and NameTag:FindFirstChildOfClass("TextLabel") then
        NameTag:FindFirstChildOfClass("TextLabel").TextColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)
UserInputService.JumpRequest:Connect(function()
    if states.WallClimb then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local ray = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 2.5)
            if ray and not ray.Instance:IsDescendantOf(char) then hrp.Velocity = Vector3.new(hrp.Velocity.X, 40, hrp.Velocity.Z) end
        end
    end
end)
