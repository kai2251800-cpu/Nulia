local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("FasterHubV8") then
    CoreGui:FindFirstChild("FasterHubV8"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FasterHubV8"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local function SendNotification(title, text)
    pcall(function() StarterGui:SetCore("SendNotification", { Title = title, Text = text, Duration = 3 }) end)
end

local function SetClipboardStr(str)
    if setclipboard then setclipboard(str) elseif toclipboard then toclipboard(str)
    else SendNotification("Lỗi", "Executor không hỗ trợ copy!") end
end

-- ==========================================
-- 1. GIAO DIỆN KHỞI ĐỘNG (MOBILE OPTIMIZED)
-- ==========================================
local BlockScreen = Instance.new("Frame", ScreenGui)
BlockScreen.Size = UDim2.new(1, 0, 1, 0)
BlockScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
BlockScreen.Visible = false
BlockScreen.ZIndex = 999

local KeyFrame = Instance.new("Frame", BlockScreen)
KeyFrame.Size = UDim2.new(0, 320, 0, 190)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -95)
KeyFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyFrame.Visible = false
KeyFrame.ZIndex = 1000
Instance.new("UICorner", KeyFrame)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "VUI LÒNG NHẬP KEY V8:"
KeyTitle.TextColor3 = Color3.new(1,1,1)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0.3, 0)
KeyInput.PlaceholderText = "Nhập key tại đây..."
KeyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyInput.TextColor3 = Color3.new(1,1,1)
KeyInput.Font = Enum.Font.Gotham
Instance.new("UICorner", KeyInput)

local CancelBtn = Instance.new("TextButton", KeyFrame)
CancelBtn.Size = UDim2.new(0.4, 0, 0, 35)
CancelBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
CancelBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CancelBtn.Text = "Hủy ❌"
CancelBtn.TextColor3 = Color3.new(1,1,1)
CancelBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CancelBtn)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.4, 0, 0, 35)
GetKeyBtn.Position = UDim2.new(0.525, 0, 0.65, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
GetKeyBtn.Text = "Lấy link 🔑"
GetKeyBtn.TextColor3 = Color3.new(1,1,1)
GetKeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GetKeyBtn)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.85, 0, 0, 30)
CheckBtn.Position = UDim2.new(0.075, 0, 0.84, 0)
CheckBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
CheckBtn.Text = "Kiểm tra Key"
CheckBtn.TextColor3 = Color3.new(1,1,1)
CheckBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CheckBtn)

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Text = "🎱"
ToggleButton.TextSize = 25
ToggleButton.Visible = false
ToggleButton.Active = true
ToggleButton.Draggable = true
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local bindable = Instance.new("BindableFunction")
bindable.OnInvoke = function(res)
    if res == "Có✅" then 
        BlockScreen.Visible = true
        KeyFrame.Visible = true
    end
end

task.spawn(function()
    pcall(function() StarterGui:SetCore("SendNotification", { Title = "Faster Hub V8", Text = "Kích hoạt script V8 FINAL?", Duration = 5, Button1 = "Có✅", Button2 = "Không ❌", Callback = bindable }) end)
end)

CancelBtn.MouseButton1Click:Connect(function() BlockScreen:Destroy() end)
GetKeyBtn.MouseButton1Click:Connect(function() SetClipboardStr("https://sites.google.com/view/faterhub-key/trang-ch%E1%BB%A7") SendNotification("Thành công", "Đã copy link lấy Key!") end)
CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "FasterHub_SuperVip" then
        SendNotification("Faster Hub", "Đã kích hoạt bản V8 FINAL 🔑✅")
        BlockScreen:Destroy()
        ToggleButton.Visible = true
    else
        SendNotification("Thất bại", "Key sai! Vui lòng thử lại.")
    end
end)

-- ==========================================
-- HỆ THỐNG XYZ REAL-TIME THEO YÊU CẦU
-- ==========================================
local XYZLabel = Instance.new("TextLabel", ScreenGui)
XYZLabel.Size = UDim2.new(0, 200, 0, 30)
XYZLabel.Position = UDim2.new(1, -210, 0, 10)
XYZLabel.BackgroundTransparency = 0.5
XYZLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
XYZLabel.TextColor3 = Color3.new(0, 1, 0)
XYZLabel.Font = Enum.Font.GothamBold
XYZLabel.TextSize = 12
XYZLabel.Visible = false
Instance.new("UICorner", XYZLabel)

-- ==========================================
-- 2. KHUNG HUB CHÍNH
-- ==========================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 420, 0, 450)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "FASTER HUB V8 [FINAL UPDATE]"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local TabScroll = Instance.new("ScrollingFrame", MainFrame)
TabScroll.Size = UDim2.new(1, 0, 0, 35)
TabScroll.Position = UDim2.new(0, 0, 0, 35)
TabScroll.BackgroundTransparency = 1
TabScroll.CanvasSize = UDim2.new(4.5, 0, 0, 0)
TabScroll.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabScroll)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)

local function CreateTabBtn(name)
    local btn = Instance.new("TextButton", TabScroll)
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    return btn
end

local Tabs = {
    Info = CreateTabBtn("THÔNG TIN"),
    Home = CreateTabBtn("CHỨC NĂNG"),
    ESP_Fly = CreateTabBtn("ĐỊNH VỊ & BAY"),
    TP = CreateTabBtn("DỊCH CHUYỂN"),
    Troll = CreateTabBtn("TROLL & BẢO VỆ"),
    Aura = CreateTabBtn("AURA & FX"),
    Skybox = CreateTabBtn("SKYBOX"),
    Anim = CreateTabBtn("ANIM & SHADER"),
    MM2 = CreateTabBtn("MM2 HACK"),
    WithGame = CreateTabBtn("WITH GAME?"),
    Set = CreateTabBtn("CÀI ĐẶT")
}

-- Tạo UIGradient cầu vồng cho tab WithGame
local rainbowGrad = Instance.new("UIGradient", Tabs.WithGame)
rainbowGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.new(1,0,0)), ColorSequenceKeypoint.new(0.5, Color3.new(0,1,0)), ColorSequenceKeypoint.new(1, Color3.new(0,0,1))}
RunService.RenderStepped:Connect(function() rainbowGrad.Rotation = (rainbowGrad.Rotation + 2) % 360 end)
Tabs.WithGame.TextColor3 = Color3.new(1,1,1)

local Pages = {}
for k, _ in pairs(Tabs) do
    local page = Instance.new("ScrollingFrame", MainFrame)
    page.Size = UDim2.new(1, -20, 1, -85)
    page.Position = UDim2.new(0, 10, 0, 75)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.Visible = false
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 8)
    Pages[k] = page
end
Pages.Info.Visible = true
Tabs.Info.TextColor3 = Color3.new(1,1,1)

for k, btn in pairs(Tabs) do
    btn.MouseButton1Click:Connect(function()
        for pk, page in pairs(Pages) do page.Visible = (pk == k) end
        for tbk, tbb in pairs(Tabs) do if tbk ~= "WithGame" then tbb.TextColor3 = (tbk == k) and Color3.new(1,1,1) or Color3.fromRGB(150,150,150) end end
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
    Label.TextSize = 12
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
        InputBox.Position = UDim2.new(0.68, -15, 0.5, -12.5)
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
    btn.TextSize = 13
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function CreateLabel(parent, text)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
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
-- THÔNG TIN (INFO TAB)
-- ==========================================
local PlayTimeLabel = CreateLabel(Pages.Info, "Số phút chơi game: 00:00:00")
CreateLabel(Pages.Info, "Id người chơi: " .. LocalPlayer.UserId)
CreateLabel(Pages.Info, "Tên biệt danh: " .. LocalPlayer.DisplayName)
CreateLabel(Pages.Info, "Tên chính: " .. LocalPlayer.Name)

local OutfitLabel = CreateLabel(Pages.Info, "Trang phục đang mặc: Đang tải...")
task.spawn(function()
    pcall(function()
        local desc = Players:GetCharacterAppearanceAsync(LocalPlayer.UserId)
        local count = 0
        for _,v in pairs(desc:GetChildren()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then count = count + 1 end end
        OutfitLabel.Text = "Trang phục đang mặc: " .. count .. " items (Tải qua CharacterAppearance)"
    end)
end)

local startTime = tick()
RunService.RenderStepped:Connect(function()
    local elapsed = tick() - startTime
    local h = math.floor(elapsed / 3600)
    local m = math.floor((elapsed % 3600) / 60)
    local s = math.floor(elapsed % 60)
    PlayTimeLabel.Text = string.format("Số phút chơi game: %02d:%02d:%02d", h, m, s)
end)

-- ==========================================
-- CHỨC NĂNG (HOME TAB)
-- ==========================================
local wsBtn, wsBox = CreateToggle(Pages.Home, "Tốc Độ", 16)
local jpBtn, jpBox = CreateToggle(Pages.Home, "Nhảy (Jump)", 50)
local ncBtn, _ = CreateToggle(Pages.Home, "Xuyên Tường")
local acBtn, _ = CreateToggle(Pages.Home, "Auto Clicker")
local climbBtn, _ = CreateToggle(Pages.Home, "Bám Tường")
local infJumpBtn, _ = CreateToggle(Pages.Home, "Infi Jump")
local godBtn, _ = CreateToggle(Pages.Home, "Godmode (Bất Tử)")
local aJumpBtn, _ = CreateToggle(Pages.Home, "Auto Jumpwall")

local xyzBtn, _ = CreateToggle(Pages.Home, "Xem Tọa Độ Thời Gian Thực (XYZ)")
RegisterToggle(xyzBtn, "XYZ", function(v) XYZLabel.Visible = v end)

local glowBtn, _ = CreateToggle(Pages.Home, "Hiệu Ứng Phát Sáng Toàn Thân")
RegisterToggle(glowBtn, "FullBodyGlow", function(v)
    local char = LocalPlayer.Character
    if char then
        if v then
            local hl = Instance.new("Highlight", char) hl.Name = "SelfGlow" hl.FillColor = Color3.new(1,1,1) hl.OutlineColor = Color3.new(0,1,1) hl.FillTransparency = 0.5
        else
            if char:FindFirstChild("SelfGlow") then char.SelfGlow:Destroy() end
        end
    end
end)

CreateButton(Pages.Home, "🎁 Lấy Tool Ẩn (Clone Item)", function()
    local targetFolder = game:GetService("ReplicatedStorage")
    local foundTool = targetFolder:FindFirstChild("SpeedCoil", true) or targetFolder:FindFirstChild("Coil", true) or targetFolder:FindFirstChild("Sword", true)
    if foundTool then local cloned = foundTool:Clone() cloned.Parent = LocalPlayer.Backpack SendNotification("Thành công", "Đã lấy vật phẩm vào balo!")
    else SendNotification("Thất bại", "Không tìm thấy Tool ẩn ở ReplicatedStorage.") end
end)

local ZoomFrame = Instance.new("Frame", Pages.Home) ZoomFrame.Size = UDim2.new(1, 0, 0, 40) ZoomFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45) Instance.new("UICorner", ZoomFrame)
local ZLbl = Instance.new("TextLabel", ZoomFrame) ZLbl.Size = UDim2.new(0.5, 0, 1, 0) ZLbl.Position = UDim2.new(0.05, 0, 0, 0) ZLbl.BackgroundTransparency = 1 ZLbl.Text = "Povzoom (Góc nhìn)" ZLbl.TextColor3 = Color3.new(1,1,1) ZLbl.Font = Enum.Font.Gotham ZLbl.TextSize = 13
local btnMin = Instance.new("TextButton", ZoomFrame) btnMin.Size = UDim2.new(0, 35, 0, 30) btnMin.Position = UDim2.new(0.68, 0, 0.5, -15) btnMin.BackgroundColor3 = Color3.fromRGB(30,30,30) btnMin.Text = "-" btnMin.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", btnMin)
local btnPls = Instance.new("TextButton", ZoomFrame) btnPls.Size = UDim2.new(0, 35, 0, 30) btnPls.Position = UDim2.new(0.83, 0, 0.5, -15) btnPls.BackgroundColor3 = Color3.fromRGB(30,30,30) btnPls.Text = "+" btnPls.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", btnPls)
btnMin.MouseButton1Click:Connect(function() LocalPlayer.CameraMaxZoomDistance = math.huge LocalPlayer.CameraMinZoomDistance = 0 Camera.FieldOfView = math.clamp(Camera.FieldOfView - 5, 1, 120) end)
btnPls.MouseButton1Click:Connect(function() LocalPlayer.CameraMaxZoomDistance = math.huge LocalPlayer.CameraMinZoomDistance = 0 Camera.FieldOfView = math.clamp(Camera.FieldOfView + 5, 1, 120) end)

RegisterToggle(wsBtn, "WS", function(v) if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end end)
RegisterToggle(jpBtn, "JP", function(v) if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 50 end end)
RegisterToggle(ncBtn, "NC") RegisterToggle(climbBtn, "WallClimb") RegisterToggle(infJumpBtn, "InfJump") RegisterToggle(godBtn, "Godmode") RegisterToggle(aJumpBtn, "AutoJumpwall")

local AutoClickCircle = Instance.new("TextButton", ScreenGui) AutoClickCircle.Size = UDim2.new(0, 50, 0, 50) AutoClickCircle.BackgroundColor3 = Color3.new(1,1,1) AutoClickCircle.Text = "🖱️" AutoClickCircle.Visible = false AutoClickCircle.Draggable = true AutoClickCircle.Active = true Instance.new("UICorner", AutoClickCircle).CornerRadius = UDim.new(1,0)
RegisterToggle(acBtn, "AutoClick", function(v) AutoClickCircle.Visible = v end)

-- ESP & FLY
local espBtn, _ = CreateToggle(Pages.ESP_Fly, "Định Vị (ESP)")
local healthEspBtn, _ = CreateToggle(Pages.ESP_Fly, "Bảng Điều Máu (Health Bar ESP)")
local nameBtn, _ = CreateToggle(Pages.ESP_Fly, "Tên Hiển Thị")
local distBtn, _ = CreateToggle(Pages.ESP_Fly, "Khoảng Cách")
local currentESPColor, currentNameColor = Color3.new(0,1,0), Color3.new(1,1,1)
RegisterToggle(espBtn, "ESP") RegisterToggle(healthEspBtn, "HealthESP") RegisterToggle(nameBtn, "NameESP") RegisterToggle(distBtn, "Distance")

local flyBtn, flyBox = CreateToggle(Pages.ESP_Fly, "Fly V1 (Cơ Bản)", 16)
local fly2Btn, fly2Box = CreateToggle(Pages.ESP_Fly, "Fly V2 (Xuyên Tường)", 16)
local FlyControlFrame = Instance.new("Frame", ScreenGui) FlyControlFrame.Size = UDim2.new(0, 120, 0, 60) FlyControlFrame.Position = UDim2.new(1, -140, 0.45, 0) FlyControlFrame.BackgroundTransparency = 1 FlyControlFrame.Visible = false
local UpBtn = Instance.new("TextButton", FlyControlFrame) UpBtn.Size = UDim2.new(0, 50, 0, 50) UpBtn.Position = UDim2.new(0, 0, 0, 0) UpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255) UpBtn.Text = "⬆️" Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(0.5, 0)
local DownBtn = Instance.new("TextButton", FlyControlFrame) DownBtn.Size = UDim2.new(0, 50, 0, 50) DownBtn.Position = UDim2.new(0, 60, 0, 0) DownBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0) DownBtn.Text = "⬇️" Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(0.5, 0)

local flyForce, flyGyro, flyConn, flyUpState, flyDownState
UpBtn.MouseButton1Down:Connect(function() flyUpState = true end) UpBtn.MouseButton1Up:Connect(function() flyUpState = false end)
DownBtn.MouseButton1Down:Connect(function() flyDownState = true end) DownBtn.MouseButton1Up:Connect(function() flyDownState = false end)
local function HandleFly(v, isV2, box)
    local char = LocalPlayer.Character FlyControlFrame.Visible = v
    if v and char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        flyForce = Instance.new("BodyVelocity", hrp) flyForce.MaxForce = Vector3.new(9e9, 9e9, 9e9) flyForce.Velocity = Vector3.zero
        flyGyro = Instance.new("BodyGyro", hrp) flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9) flyGyro.P = 10000
        char.Humanoid.PlatformStand = true
        flyConn = RunService.RenderStepped:Connect(function()
            flyGyro.CFrame = Camera.CFrame local speed = tonumber(box.Text) or 16 local moveDir = char.Humanoid.MoveDirection local ySpeed = 0
            if flyUpState then ySpeed = speed end if flyDownState then ySpeed = -speed end
            flyForce.Velocity = (moveDir * speed) + Vector3.new(0, ySpeed, 0)
            if isV2 then for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        end)
    else
        if flyForce then flyForce:Destroy() end if flyGyro then flyGyro:Destroy() end if flyConn then flyConn:Disconnect() end
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
    end
end
RegisterToggle(flyBtn, "Fly", function(v) HandleFly(v, false, flyBox) end) RegisterToggle(fly2Btn, "FlyV2", function(v) HandleFly(v, true, fly2Box) end)

-- TP TAB & THEO DÕI
local teleOldBtn, _ = CreateToggle(Pages.TP, "TeleOld (Nút ❗)")
local TeleOldIcon = Instance.new("TextButton", ScreenGui) TeleOldIcon.Size = UDim2.new(0, 50, 0, 50) TeleOldIcon.Position = UDim2.new(1, -70, 0.3, 0) TeleOldIcon.BackgroundColor3 = Color3.fromRGB(255, 50, 50) TeleOldIcon.Text = "❗" TeleOldIcon.TextSize = 25 TeleOldIcon.Visible = false Instance.new("UICorner", TeleOldIcon).CornerRadius = UDim.new(1,0)
RegisterToggle(teleOldBtn, "TeleOld", function(v) TeleOldIcon.Visible = v end)
local initialSpawnCFrame = nil task.spawn(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then initialSpawnCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame end end)
TeleOldIcon.MouseButton1Click:Connect(function() local char = LocalPlayer.Character if char and char:FindFirstChild("HumanoidRootPart") then local spawnLoc = workspace:FindFirstChildOfClass("SpawnLocation") if spawnLoc then char.HumanoidRootPart.CFrame = spawnLoc.CFrame + Vector3.new(0, 5, 0) elseif initialSpawnCFrame then char.HumanoidRootPart.CFrame = initialSpawnCFrame end end end)

local followBtn, _ = CreateToggle(Pages.TP, "Theo Dõi Mục Tiêu (Bám theo)")
local followTarget, followIndex = nil, 1
local followTargetBtn = CreateButton(Pages.TP, "Mục Tiêu: Chưa Chọn", function()
    local plrs = Players:GetPlayers() followIndex = followIndex + 1 if followIndex > #plrs then followIndex = 1 end followTarget = plrs[followIndex]
    if followTarget == LocalPlayer then followIndex = followIndex + 1 if followIndex > #plrs then followIndex = 1 end followTarget = plrs[followIndex] end
    script.Parent.Text = "Mục Tiêu: " .. (followTarget and followTarget.Name or "Chưa Chọn")
end)
RegisterToggle(followBtn, "Follow")

local function RefreshTPList()
    for _, c in pairs(Pages.TP:GetChildren()) do if c:IsA("TextButton") and c.Name ~= "RefreshBtn" and c ~= followTargetBtn then c:Destroy() end end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then CreateButton(Pages.TP, "👤 TP: " .. plr.Name, function() if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame end end) end
    end
    Pages.TP.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 45 + 200)
end
local RefreshBtn = CreateButton(Pages.TP, "🔄 Làm Mới Danh Sách TP", function() RefreshTPList() end) RefreshBtn.Name = "RefreshBtn" RefreshTPList()

-- TROLL & ORBIT
local orbitBtn, _ = CreateToggle(Pages.Troll, "Xoay Quanh Người Chơi")
local orbitTarget, orbitIndex = nil, 1
local orbitTargetBtn = CreateButton(Pages.Troll, "Mục Tiêu Xoay: Chưa Chọn", function()
    local plrs = Players:GetPlayers() orbitIndex = orbitIndex + 1 if orbitIndex > #plrs then orbitIndex = 1 end orbitTarget = plrs[orbitIndex]
    if orbitTarget == LocalPlayer then orbitIndex = orbitIndex + 1 if orbitIndex > #plrs then orbitIndex = 1 end orbitTarget = plrs[orbitIndex] end
    script.Parent.Text = "Mục Tiêu Xoay: " .. (orbitTarget and orbitTarget.Name or "Chưa Chọn")
end)
local flingBtn, flingBox = CreateToggle(Pages.Troll, "Fling Aura", 50)
local antikickBtn, _ = CreateToggle(Pages.Troll, "Anti-Kick")
local antiflingBtn, _ = CreateToggle(Pages.Troll, "Anti-Fling")
local antivoidBtn, _ = CreateToggle(Pages.Troll, "Anti-Void")
RegisterToggle(orbitBtn, "Orbit") RegisterToggle(flingBtn, "Fling") RegisterToggle(antikickBtn, "AntiKick") RegisterToggle(antiflingBtn, "AntiFling")
local spawnPoint = Vector3.new(0, 50, 0)
RegisterToggle(antivoidBtn, "AntiVoid", function(v) if v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then spawnPoint = LocalPlayer.Character.HumanoidRootPart.Position end end)

-- AURA & FX
local rainbowSkinBtn, _ = CreateToggle(Pages.Aura, "Rainbow Skin") local fireBtn, _ = CreateToggle(Pages.Aura, "Fire Aura") local smokeBtn, _ = CreateToggle(Pages.Aura, "Smoke Aura") local lightBtn, _ = CreateToggle(Pages.Aura, "Lighting Aura") local trailBtn, _ = CreateToggle(Pages.Aura, "Đường Mòn (Trail)")
RegisterToggle(rainbowSkinBtn, "RainbowSkin")
RegisterToggle(fireBtn, "Fire", function(v) local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if v and hrp then local f = Instance.new("Fire", hrp) f.Name = "FAura" f.Size = 10 else if hrp and hrp:FindFirstChild("FAura") then hrp.FAura:Destroy() end end end)
RegisterToggle(smokeBtn, "Smoke", function(v) local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if v and hrp then local s = Instance.new("Smoke", hrp) s.Name = "SAura" s.Size = 8 else if hrp and hrp:FindFirstChild("SAura") then hrp.SAura:Destroy() end end end)
RegisterToggle(lightBtn, "Lighting", function(v) local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if v and hrp then local l = Instance.new("Sparkles", hrp) l.Name = "LAura" else if hrp and hrp:FindFirstChild("LAura") then hrp.LAura:Destroy() end end end)
local currentTrailColor, trailObj = Color3.new(1,0,0), nil
RegisterToggle(trailBtn, "Trail", function(v)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if v and hrp then local a0 = Instance.new("Attachment", hrp) a0.Position = Vector3.new(0, 1, 0) local a1 = Instance.new("Attachment", hrp) a1.Position = Vector3.new(0, -1, 0) trailObj = Instance.new("Trail", hrp) trailObj.Attachment0 = a0 trailObj.Attachment1 = a1 trailObj.Lifetime = 0.5
    else if hrp then for _, c in pairs(hrp:GetChildren()) do if c:IsA("Trail") or c:IsA("Attachment") then c:Destroy() end end end end
end)

-- SKYBOX
CreateButton(Pages.Skybox, "🌌 Không Gian Vũ Trụ", function() local s = Instance.new("Sky", Lighting) s.SkyboxBk = "rbxassetid://153696504" s.SkyboxDn = "rbxassetid://153696504" s.SkyboxFt = "rbxassetid://153696504" s.SkyboxLf = "rbxassetid://153696504" s.SkyboxRt = "rbxassetid://153696504" s.SkyboxUp = "rbxassetid://153696504" end)
CreateButton(Pages.Skybox, "✨ Hoàng Đạo (Zodiac)", function() local s = Instance.new("Sky", Lighting) s.SkyboxBk = "rbxassetid://160248248" s.SkyboxDn = "rbxassetid://160248248" s.SkyboxFt = "rbxassetid://160248248" s.SkyboxLf = "rbxassetid://160248248" s.SkyboxRt = "rbxassetid://160248248" s.SkyboxUp = "rbxassetid://160248248" end)
CreateButton(Pages.Skybox, "🌙 Màn Đêm Tĩnh Lặng", function() local s = Instance.new("Sky", Lighting) s.SkyboxBk = "rbxassetid://143921677" s.SkyboxDn = "rbxassetid://143921677" s.SkyboxFt = "rbxassetid://143921677" s.SkyboxLf = "rbxassetid://143921677" s.SkyboxRt = "rbxassetid://143921677" s.SkyboxUp = "rbxassetid://143921677" end)
CreateButton(Pages.Skybox, "🔄 Khôi Phục Skybox", function() for _, v in pairs(Lighting:GetChildren()) do if v:IsA("Sky") then v:Destroy() end end end)
-- ANIM & SHADER
local zombiBtn, _ = CreateToggle(Pages.Anim, "Zombie Animation") local ninjaBtn, _ = CreateToggle(Pages.Anim, "Ninja Animation") local ragdollBtn, _ = CreateToggle(Pages.Anim, "Ragdoll On Demand") local bigHeadBtn, _ = CreateToggle(Pages.Anim, "Big Head") local noHeadFootBtn, _ = CreateToggle(Pages.Anim, "No Head & Foot") local povBtn, _ = CreateToggle(Pages.Anim, "POV (Góc Nhìn 1)") local rnNameBtn, _ = CreateToggle(Pages.Anim, "Rainbow Name")
local function SetAnim(p) local c = LocalPlayer.Character if not c or not c:FindFirstChild("Animate") then return end local a = c.Animate if p == "Zombie" then if a:FindFirstChild("idle") then a.idle.Animation1.AnimationId = "rbxassetid://313026115" end if a:FindFirstChild("walk") then a.walk.WalkAnim.AnimationId = "rbxassetid://313032534" end elseif p == "Ninja" then if a:FindFirstChild("idle") then a.idle.Animation1.AnimationId = "rbxassetid://656117400" end if a:FindFirstChild("walk") then a.walk.WalkAnim.AnimationId = "rbxassetid://656121766" end end end
RegisterToggle(zombiBtn, "Zombie", function(v) if v then SetAnim("Zombie") end end) RegisterToggle(ninjaBtn, "Ninja", function(v) if v then SetAnim("Ninja") end end) RegisterToggle(ragdollBtn, "Ragdoll", function(v) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.PlatformStand = v end end) RegisterToggle(povBtn, "POV", function(v) LocalPlayer.CameraMode = v and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic end)
RegisterToggle(bigHeadBtn, "BigHead", function(v) local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if hum and hum:FindFirstChild("HeadScale") then hum.HeadScale.Value = v and 4 or 1 end end) RegisterToggle(noHeadFootBtn, "NoHeadFoot", function(v) local char = LocalPlayer.Character if char then for _, p in pairs({"Head", "RightFoot", "RightLowerLeg", "RightUpperLeg"}) do if char:FindFirstChild(p) then char[p].Transparency = v and 1 or 0 end end if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then char.Head.face.Transparency = v and 1 or 0 end end end)
RegisterToggle(rnNameBtn, "RainbowName") -- Đã fix lỗi bằng cách đưa vào vòng lặp RunService

local function ClearShaders() for _, v in pairs(Lighting:GetChildren()) do if v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end end end
CreateButton(Pages.Anim, "🌑 Dark Shader", function() ClearShaders() Lighting.Ambient = Color3.new(0,0,0) Lighting.OutdoorAmbient = Color3.new(0,0,0) Lighting.GlobalShadows = true end)
CreateButton(Pages.Anim, "🌅 Bình Minh", function() ClearShaders() Lighting.ClockTime = 6.5 Lighting.GlobalShadows = true Lighting.OutdoorAmbient = Color3.fromRGB(150, 100, 50) Instance.new("SunRaysEffect", Lighting).Intensity = 0.3 Instance.new("BloomEffect", Lighting).Intensity = 0.8 end)
CreateButton(Pages.Anim, "⚡ Super Fast (Xóa Đổ Bóng)", function() ClearShaders() Lighting.GlobalShadows = false pcall(function() sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility) end) for _, p in pairs(workspace:GetDescendants()) do if p:IsA("BasePart") then p.CastShadow = false p.Material = Enum.Material.SmoothPlastic end end end)

-- MM2 HACK
local mm2ESPBtn, _ = CreateToggle(Pages.MM2, "Xác định Role (ESP)")
local mm2AimBtn, _ = CreateToggle(Pages.MM2, "Aimbot (Diệt Sát Nhân)")
local mm2AutoCoinBtn, _ = CreateToggle(Pages.MM2, "Tự Động Nhặt Xu")
local mm2GunNotifBtn, _ = CreateToggle(Pages.MM2, "Gun Drop Notifier")
local mm2GunTPBtn, _ = CreateToggle(Pages.MM2, "Teleport Đến Súng Rơi")

RegisterToggle(mm2ESPBtn, "MM2_ESP", function(v) if not v then for _, plr in pairs(Players:GetPlayers()) do if plr.Character and plr.Character:FindFirstChild("MM2_HL") then plr.Character.MM2_HL:Destroy() end end end end)
RegisterToggle(mm2AimBtn, "MM2_Aim") RegisterToggle(mm2AutoCoinBtn, "MM2_Coin") RegisterToggle(mm2GunNotifBtn, "MM2_GunNotif") RegisterToggle(mm2GunTPBtn, "MM2_GunTP")

local oldIndex oldIndex = hookmetamethod(game, "__index", function(self, key)
    if not checkcaller() and states.MM2_Aim and self == LocalPlayer:GetMouse() and (key == "Hit" or key == "Target") then
        for _, plr in pairs(Players:GetPlayers()) do
            local bp, char = plr:FindFirstChild("Backpack"), plr.Character
            if plr ~= LocalPlayer and ((bp and bp:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife"))) and char and char:FindFirstChild("HumanoidRootPart") then return key == "Hit" and char.HumanoidRootPart.CFrame or char.HumanoidRootPart end
        end
    end return oldIndex(self, key)
end)

workspace.ChildAdded:Connect(function(child)
    if child.Name == "GunDrop" then
        if states.MM2_GunNotif then SendNotification("⚠️ Cảnh Báo MM2", "Cảnh sát đã chết! Súng đã rơi xuống đất!") end
        if states.MM2_GunTP and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = child.CFrame
        end
    end
end)
-- WITH GAME? (NEW TAB)
CreateLabel(Pages.WithGame, "🎮 BLADE BALL / DEATH BALL")
local bbParryBtn, _ = CreateToggle(Pages.WithGame, "Auto Parry / Đỡ Bóng") RegisterToggle(bbParryBtn, "BB_Parry")
local bbEspBtn, _ = CreateToggle(Pages.WithGame, "Ball ESP / Xuyên Bóng") RegisterToggle(bbEspBtn, "BB_ESP")
local bbSpamBtn, _ = CreateToggle(Pages.WithGame, "Auto Spam Click") RegisterToggle(bbSpamBtn, "BB_Spam")
local bbTrailBtn, _ = CreateToggle(Pages.WithGame, "Visual Trail / Cầu Vồng Bóng") RegisterToggle(bbTrailBtn, "BB_Trail")

CreateLabel(Pages.WithGame, "👻 HORROR - PETAPETA")
local ppEspBtn, _ = CreateToggle(Pages.WithGame, "Monster ESP / Xuyên Ma") RegisterToggle(ppEspBtn, "PP_ESP")
local ppBrightBtn, _ = CreateToggle(Pages.WithGame, "Fullbright / Sáng Ngóc Ngách") RegisterToggle(ppBrightBtn, "PP_Fullbright", function(v) Lighting.Ambient = v and Color3.new(1,1,1) or Color3.fromRGB(127,127,127) end)
local ppItemBtn, _ = CreateToggle(Pages.WithGame, "Item & Key ESP") RegisterToggle(ppItemBtn, "PP_ItemESP")
local ppStaminaBtn, _ = CreateToggle(Pages.WithGame, "Infinite Stamina / Vô Hạn Thể Lực") RegisterToggle(ppStaminaBtn, "PP_Stamina")
local ppSpeedBtn, _ = CreateToggle(Pages.WithGame, "Speed Hack / Tốc Độ Bùm Chéo") RegisterToggle(ppSpeedBtn, "PP_Speed")

CreateLabel(Pages.WithGame, "🍃 LEAF BLOWER SIMULATOR")
local lbsCleanBtn, _ = CreateToggle(Pages.WithGame, "Auto Clean / Hút Lá") RegisterToggle(lbsCleanBtn, "LBS_Clean")
local lbsCapBtn, _ = CreateToggle(Pages.WithGame, "Infinite Capacity / Túi Vô Hạn") RegisterToggle(lbsCapBtn, "LBS_Cap")
local lbsSellBtn, _ = CreateToggle(Pages.WithGame, "Auto Sell / Tự Động Bán") RegisterToggle(lbsSellBtn, "LBS_Sell")
local lbsSpeedBtn, _ = CreateToggle(Pages.WithGame, "Speed Multiplier / Siêu Tốc Độ") RegisterToggle(lbsSpeedBtn, "LBS_Speed")

-- CÀI ĐẶT
local function CreateSelector(parent, name, options, callback)
    local Frame = Instance.new("Frame", parent) Frame.Size = UDim2.new(1, 0, 0, 40) Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45) Instance.new("UICorner", Frame)
    local Label = Instance.new("TextLabel", Frame) Label.Size = UDim2.new(0.4, 0, 1, 0) Label.Position = UDim2.new(0.05, 0, 0, 0) Label.BackgroundTransparency = 1 Label.Text = name Label.TextColor3 = Color3.new(1,1,1) Label.Font = Enum.Font.Gotham Label.TextXAlignment = Enum.TextXAlignment.Left
    local currentIndex = 1 local ValueTxt = Instance.new("TextLabel", Frame) ValueTxt.Size = UDim2.new(0, 100, 0, 30) ValueTxt.Position = UDim2.new(0.45, 30, 0.5, -15) ValueTxt.BackgroundTransparency = 1 ValueTxt.Text = options[1].name ValueTxt.TextColor3 = Color3.new(1,1,1) ValueTxt.Font = Enum.Font.GothamBold
    local function update() ValueTxt.Text = options[currentIndex].name callback(options[currentIndex].val) end
    local LeftBtn = Instance.new("TextButton", Frame) LeftBtn.Size = UDim2.new(0,30,0,30) LeftBtn.Position = UDim2.new(0.45,0,0.5,-15) LeftBtn.Text = "<" Instance.new("UICorner", LeftBtn) LeftBtn.MouseButton1Click:Connect(function() currentIndex = currentIndex - 1 if currentIndex < 1 then currentIndex = #options end update() end)
    local RightBtn = Instance.new("TextButton", Frame) RightBtn.Size = UDim2.new(0,30,0,30) RightBtn.Position = UDim2.new(0.45,130,0.5,-15) RightBtn.Text = ">" Instance.new("UICorner", RightBtn) RightBtn.MouseButton1Click:Connect(function() currentIndex = currentIndex + 1 if currentIndex > #options then currentIndex = 1 end update() end)
end

local ESPColors = {{name="Xanh Lá",val=Color3.new(0,1,0)}, {name="Đỏ",val=Color3.new(1,0,0)}, {name="Trắng",val=Color3.new(1,1,1)}, {name="RGB (Động)",val="Anim_RGB"}, {name="Nhịp Đỏ (Động)",val="Anim_PulseRed"}, {name="Nhịp Xanh (Động)",val="Anim_PulseBlue"}, {name="Nhịp Vàng (Động)",val="Anim_PulseYellow"}, {name="Đa Sắc (Động)",val="Anim_Flash"}}
local TrailColors = {{name="Đỏ",val=Color3.new(1,0,0)}, {name="Trắng",val=Color3.new(1,1,1)}, {name="Vàng",val=Color3.new(1,1,0)}, {name="RGB (Động)",val="Anim_RGB"}, {name="Lửa Giao Thoa",val="Anim_Fire"}, {name="Biển Xanh",val="Anim_Ocean"}, {name="Neon Nhấp Nháy",val="Anim_Neon"}}
local NameColors = {{name="Trắng",val=Color3.new(1,1,1)}, {name="Đỏ",val=Color3.new(1,0,0)}, {name="Xanh Lá",val=Color3.new(0,1,0)}, {name="Xanh Dương",val=Color3.new(0,0,1)}, {name="Vàng",val=Color3.new(1,1,0)}, {name="Hồng",val=Color3.fromRGB(255,105,180)}, {name="Cam",val=Color3.fromRGB(255,165,0)}, {name="Tím",val=Color3.fromRGB(128,0,128)}}

CreateSelector(Pages.Set, "Màu Định Vị", ESPColors, function(v) currentESPColor = v end)
CreateSelector(Pages.Set, "Màu Đường Mòn", TrailColors, function(v) currentTrailColor = v end)
CreateSelector(Pages.Set, "Màu Tên Hiển Thị", NameColors, function(v) currentNameColor = v end)

Pages.Info.CanvasSize = UDim2.new(0,0,0,200) Pages.Home.CanvasSize = UDim2.new(0,0,0,600) Pages.ESP_Fly.CanvasSize = UDim2.new(0,0,0,350) Pages.TP.CanvasSize = UDim2.new(0,0,0,300) Pages.Troll.CanvasSize = UDim2.new(0,0,0,350) Pages.Aura.CanvasSize = UDim2.new(0,0,0,350) Pages.Skybox.CanvasSize = UDim2.new(0,0,0,250) Pages.Anim.CanvasSize = UDim2.new(0,0,0,450) Pages.MM2.CanvasSize = UDim2.new(0,0,0,250) Pages.WithGame.CanvasSize = UDim2.new(0,0,0,700) Pages.Set.CanvasSize = UDim2.new(0,0,0,250)

-- ==========================================
-- VÒNG LẶP HỆ THỐNG MASTER
-- ==========================================
local SpinForce
RunService.RenderStepped:Connect(function()
    local t = tick()
    local cRGB = Color3.fromHSV((t*0.5)%1, 1, 1)
    local cPulseR = Color3.new(0.5+0.5*math.sin(t*3), 0, 0)
    local cPulseB = Color3.new(0, 0, 0.5+0.5*math.sin(t*3))
    local cPulseY = Color3.new(0.5+0.5*math.sin(t*3), 0.5+0.5*math.sin(t*3), 0)
    local cFlash = math.floor(t*5)%2==0 and Color3.new(1,1,1) or cRGB

    local realESP = type(currentESPColor)=="string" and (currentESPColor=="Anim_RGB" and cRGB or currentESPColor=="Anim_PulseRed" and cPulseR or currentESPColor=="Anim_PulseBlue" and cPulseB or currentESPColor=="Anim_PulseYellow" and cPulseY or currentESPColor=="Anim_Flash" and cFlash) or currentESPColor
    local realTrail = type(currentTrailColor)=="string" and (currentTrailColor=="Anim_RGB" and cRGB or currentTrailColor=="Anim_Fire" and Color3.fromHSV((t*0.5)%0.15, 1, 1) or currentTrailColor=="Anim_Ocean" and Color3.fromHSV(0.5+(t*0.2)%0.15, 1, 1) or currentTrailColor=="Anim_Neon" and cFlash) or currentTrailColor

    if trailObj then trailObj.Color = ColorSequence.new(realTrail) end

    local char = LocalPlayer.Character if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChildOfClass("Humanoid")
    
    if states.WS and hum then hum.WalkSpeed = tonumber(wsBox.Text) or 16 end
    if states.JP and hum then hum.JumpPower = tonumber(jpBox.Text) or 50 hum.UseJumpPower = true end
    if states.NC then for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    if states.AutoClick and AutoClickCircle.Visible then VirtualUser:ClickButton1(Vector2.new(0,0)) end
    if states.Godmode and hum then hum.MaxHealth = math.huge hum.Health = math.huge end

    if states.XYZ and hrp then XYZLabel.Text = string.format("X: %.1f | Y: %.1f | Z: %.1f", hrp.Position.X, hrp.Position.Y, hrp.Position.Z) end

    if states.Follow and followTarget and followTarget.Character and followTarget.Character:FindFirstChild("HumanoidRootPart") and hrp then
        hrp.CFrame = followTarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
    if states.Orbit and orbitTarget and orbitTarget.Character and orbitTarget.Character:FindFirstChild("HumanoidRootPart") and hrp then
        hrp.CFrame = orbitTarget.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, t * 5, 0) * CFrame.new(0, 0, 10)
    end

    if states.Fling and hrp then
        if not SpinForce then SpinForce = Instance.new("BodyAngularVelocity", hrp) SpinForce.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        SpinForce.AngularVelocity = Vector3.new(0, tonumber(flingBox.Text) or 50, 0)
    else if SpinForce then SpinForce:Destroy() SpinForce = nil end end
    
    if states.RainbowSkin then for _, p in pairs(char:GetDescendants()) do if p:IsA("BasePart") or p:IsA("MeshPart") then p.Color = cRGB end end end
    
    -- Fix Rainbow Name liên tục kiểm tra và áp dụng
    if states.RainbowName then
        if char:FindFirstChild("Head") then
            local rn = char.Head:FindFirstChild("RainbowNameTagV8")
            if not rn then
                rn = Instance.new("BillboardGui", char.Head) rn.Name = "RainbowNameTagV8" rn.Size = UDim2.new(0,200,0,50) rn.StudsOffset = Vector3.new(0,2.5,0) rn.AlwaysOnTop = true
                local rntxt = Instance.new("TextLabel", rn) rntxt.Size = UDim2.new(1,0,1,0) rntxt.BackgroundTransparency = 1 rntxt.Text = LocalPlayer.Name rntxt.Font = Enum.Font.GothamBold rntxt.TextScaled = true
            end
            rn:FindFirstChildOfClass("TextLabel").TextColor3 = cRGB
        end
    else
        if char:FindFirstChild("Head") and char.Head:FindFirstChild("RainbowNameTagV8") then char.Head.RainbowNameTagV8:Destroy() end
    end

    if states.AutoJumpwall and hrp and hum and hum.MoveDirection.Magnitude > 0 then
        local ray = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 3)
        if ray and not ray.Instance:IsDescendantOf(char) then hum.Jump = true end
    end

    -- WITH GAME Logic & ESP Tổng Hợp
    pcall(function()
        if states.MM2_Coin and hrp then for _,v in pairs(workspace:GetDescendants()) do if v.Name == "CoinContainer" and v:FindFirstChild("Coin") then hrp.CFrame = v.Coin.CFrame break end end end
        
        -- Generic Horror Logic
        if states.PP_Stamina and LocalPlayer:GetAttribute("Stamina") then LocalPlayer:SetAttribute("Stamina", 100) end
        if states.PP_Speed and hum then hum.WalkSpeed = 35 end

        -- Generic Ball Logic
        if states.BB_Parry or states.BB_ESP or states.BB_Spam or states.BB_Trail then
            local ballsFolder = workspace:FindFirstChild("Balls")
            if ballsFolder then
                for _, ball in pairs(ballsFolder:GetChildren()) do
                    if ball:IsA("BasePart") then
                        if states.BB_Trail and not ball:FindFirstChild("BBTrail") then
                            local t = Instance.new("Trail", ball) t.Name = "BBTrail" t.Color = ColorSequence.new(cRGB)
                            local a0 = Instance.new("Attachment", ball) a0.Position = Vector3.new(0,0.5,0) local a1 = Instance.new("Attachment", ball) a1.Position = Vector3.new(0,-0.5,0) t.Attachment0 = a0 t.Attachment1 = a1
                        end
                        if states.BB_ESP and not ball:FindFirstChild("BBHL") then local hl = Instance.new("Highlight", ball) hl.Name = "BBHL" hl.FillColor = Color3.new(1,0,0) end
                        if states.BB_Parry or states.BB_Spam then
                            local dist = (hrp.Position - ball.Position).Magnitude
                            if ball.Velocity.Magnitude > 5 and dist < (states.BB_Spam and 15 or 30) then VirtualUser:ClickButton1(Vector2.new(0,0)) end
                        end
                    end
                end
            end
        end

        -- Generic Leaf Blower Logic
        if (states.LBS_Clean or states.LBS_Cap or states.LBS_Sell or states.LBS_Speed) and hrp then
            if states.LBS_Speed and hum then hum.WalkSpeed = 50 end
            if states.LBS_Clean then
                for _,v in pairs(workspace:GetDescendants()) do if v.Name == "Leaf" and v:IsA("BasePart") then firetouchinterest(hrp, v, 0) firetouchinterest(hrp, v, 1) end end
            end
        end
    end)

    -- ESP Người chơi
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local pChar = plr.Character
            local hl = pChar:FindFirstChild("ESP_HL")
            if states.ESP then if not hl then hl = Instance.new("Highlight", pChar) hl.Name = "ESP_HL" hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop end hl.FillColor = realESP else if hl then hl:Destroy() end end
            
            -- Health Bar ESP
            local hpUI = pChar:FindFirstChild("HealthESPUI")
            if states.HealthESP then
                if not hpUI then
                    hpUI = Instance.new("BillboardGui", pChar) hpUI.Name = "HealthESPUI" hpUI.Size = UDim2.new(0, 50, 0, 5) hpUI.StudsOffset = Vector3.new(0, 4, 0) hpUI.AlwaysOnTop = true
                    local bg = Instance.new("Frame", hpUI) bg.Size = UDim2.new(1,0,1,0) bg.BackgroundColor3 = Color3.new(1,0,0)
                    local bar = Instance.new("Frame", bg) bar.Name = "Bar" bar.Size = UDim2.new(1,0,1,0) bar.BackgroundColor3 = Color3.new(0,1,0)
                end
                local eHum = pChar:FindFirstChildOfClass("Humanoid")
                if eHum and hpUI:FindFirstChild("Frame") and hpUI.Frame:FindFirstChild("Bar") then hpUI.Frame.Bar.Size = UDim2.new(math.clamp(eHum.Health/eHum.MaxHealth,0,1),0,1,0) end
            else if hpUI then hpUI:Destroy() end end

            -- Tên và Khoảng cách
            local nameUI = pChar:FindFirstChild("NameDistUI")
            if states.NameESP or states.Distance then
                if not nameUI then
                    nameUI = Instance.new("BillboardGui", pChar) nameUI.Name = "NameDistUI" nameUI.Size = UDim2.new(0, 200, 0, 50) nameUI.StudsOffset = Vector3.new(0, 2.5, 0) nameUI.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", nameUI) txt.Size = UDim2.new(1,0,1,0) txt.BackgroundTransparency = 1 txt.TextStrokeTransparency = 0 txt.Font = Enum.Font.GothamBold txt.TextScaled = true
                end
                local txt = nameUI:FindFirstChildOfClass("TextLabel")
                if txt then
                    local finalTxt = "" if states.NameESP then finalTxt = plr.Name end
                    if states.Distance and hrp then finalTxt = finalTxt .. (finalTxt~="" and "\n" or "") .. math.floor((hrp.Position - pChar.Head.Position).Magnitude) .. " M" end
                    txt.Text = finalTxt txt.TextColor3 = currentNameColor
                end
            else if nameUI then nameUI:Destroy() end end
            
            -- MM2 ESP Override
            if states.MM2_ESP then
                local mm2hl = pChar:FindFirstChild("MM2_HL")
                if not mm2hl then mm2hl = Instance.new("Highlight", pChar) mm2hl.Name = "MM2_HL" mm2hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop end
                local bp = plr:FindFirstChild("Backpack")
                if (bp and bp:FindFirstChild("Knife")) or pChar:FindFirstChild("Knife") then mm2hl.FillColor = Color3.fromRGB(255,0,0)
                elseif (bp and (bp:FindFirstChild("Gun") or bp:FindFirstChild("Revolver"))) or pChar:FindFirstChild("Gun") or pChar:FindFirstChild("Revolver") then mm2hl.FillColor = Color3.fromRGB(0,150,255)
                else mm2hl.FillColor = Color3.fromRGB(0,255,0) end
            else if pChar:FindFirstChild("MM2_HL") then pChar.MM2_HL:Destroy() end end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if states.WallClimb then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart local ray = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 2.5)
            if ray and not ray.Instance:IsDescendantOf(char) then hrp.Velocity = Vector3.new(hrp.Velocity.X, 40, hrp.Velocity.Z) end
        end
    end
    if states.InfJump then local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)
