-- JDHub v2.0 for Delta Executor
-- Cập nhật toàn diện: Sửa lỗi tắt tính năng vẫn chạy, fix lỗi đứng hình khi Fly, thêm tính năng Skin Rainbow, Đường mòn, Bám tường, Teleport Player và Cài đặt màu sắc.

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Xóa Hub cũ nếu có
if CoreGui:FindFirstChild("JDHub_GUI") then
    CoreGui.JDHub_GUI:Destroy()
end

-- Bảng màu cho Settings
local UIColors = {
    Color3.fromRGB(20, 20, 20),   -- Đen tối (Mặc định)
    Color3.fromRGB(30, 0, 60),   -- Tím đậm
    Color3.fromRGB(0, 30, 60),   -- Xanh dương đậm
    Color3.fromRGB(0, 50, 30),   -- Xanh lá đậm
    Color3.fromRGB(60, 0, 0),    -- Đỏ đậm
    Color3.fromRGB(60, 40, 0),    -- Cam đậm
    Color3.fromRGB(50, 0, 50),   -- Hồng đậm
    Color3.fromRGB(20, 40, 40),   -- Xanh mòng két
    Color3.fromRGB(40, 40, 40),   -- Xám
    Color3.fromRGB(70, 70, 70)    -- Xám sáng
}
local currentUIColorIdx = 1

local TrailColors = {
    Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 128, 0), Color3.fromRGB(128, 0, 255),
    Color3.fromRGB(255, 192, 203), Color3.fromRGB(165, 42, 42), Color3.fromRGB(128, 128, 128),
    Color3.fromRGB(0, 100, 0), Color3.fromRGB(0, 0, 139), "Rainbow"
}
local currentTrailColorIdx = 1

local ESPColors = {
    Color3.fromRGB(0, 255, 0),    -- Xanh lá (Mặc định)
    Color3.fromRGB(255, 0, 0),    -- Đỏ
    Color3.fromRGB(0, 0, 255),    -- Xanh dương
    Color3.fromRGB(255, 255, 0),  -- Vàng
    Color3.fromRGB(255, 0, 255),  -- Hồng tím
    Color3.fromRGB(0, 255, 255),  -- Xanh ngọc
    Color3.fromRGB(255, 128, 0),  -- Cam
    Color3.fromRGB(255, 255, 255),-- Trắng
    Color3.fromRGB(128, 0, 128),  -- Tím
    Color3.fromRGB(139, 69, 19)   -- Nâu
}
local currentESPColorIdx = 1

-- Tạo GUI chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JDHub_GUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Nút mở/đóng Hub (JHub)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "JHubButton"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.Position = UDim2.new(0, 20, 0.4, 0)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "JHub"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
ToggleBtn.TextSize = 18
ToggleBtn.Draggable = true
ToggleBtn.Active = true

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 12)
UICornerBtn.Parent = ToggleBtn

-- Khung Menu chính
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = UIColors[currentUIColorIdx]
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -220)
MainFrame.Size = UDim2.new(0, 360, 0, 440)
MainFrame.Visible = false
MainFrame.Draggable = true
MainFrame.Active = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

-- Tiêu đề Hub
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "JDHub v2.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

-- Thanh chuyển Tab (Main, TP Player, Settings)
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0, 10, 0, 45)
TabBar.Size = UDim2.new(1, -20, 0, 30)

local TabMainBtn = Instance.new("TextButton")
TabMainBtn.Parent = TabBar
TabMainBtn.Size = UDim2.new(0.32, 0, 1, 0)
TabMainBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabMainBtn.Font = Enum.Font.SourceSansBold
TabMainBtn.Text = "Tính năng"
TabMainBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
TabMainBtn.TextSize = 13
Instance.new("UICorner", TabMainBtn).CornerRadius = UDim.new(0, 6)

local TabTPBtn = Instance.new("TextButton")
TabTPBtn.Parent = TabBar
TabTPBtn.Size = UDim2.new(0.32, 0, 1, 0)
TabTPBtn.Position = UDim2.new(0.34, 0, 0, 0)
TabTPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabTPBtn.Font = Enum.Font.SourceSansBold
TabTPBtn.Text = "TP Player"
TabTPBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
TabTPBtn.TextSize = 13
Instance.new("UICorner", TabTPBtn).CornerRadius = UDim.new(0, 6)

local TabSettingsBtn = Instance.new("TextButton")
TabSettingsBtn.Parent = TabBar
TabSettingsBtn.Size = UDim2.new(0.32, 0, 1, 0)
TabSettingsBtn.Position = UDim2.new(0.68, 0, 0, 0)
TabSettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabSettingsBtn.Font = Enum.Font.SourceSansBold
TabSettingsBtn.Text = "Settings"
TabSettingsBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
TabSettingsBtn.TextSize = 13
Instance.new("UICorner", TabSettingsBtn).CornerRadius = UDim.new(0, 6)

-- Các Container nội dung tương ứng với Tab
local ContainerMain = Instance.new("ScrollingFrame")
ContainerMain.Parent = MainFrame
ContainerMain.BackgroundTransparency = 1
ContainerMain.Position = UDim2.new(0, 10, 0, 85)
ContainerMain.Size = UDim2.new(1, -20, 1, -95)
ContainerMain.CanvasSize = UDim2.new(0, 0, 0, 700)
ContainerMain.ScrollBarThickness = 4
ContainerMain.Visible = true

local UIListMain = Instance.new("UIListLayout")
UIListMain.Parent = ContainerMain
UIListMain.SortOrder = Enum.SortOrder.LayoutOrder
UIListMain.Padding = UDim.new(0, 8)

local ContainerTP = Instance.new("ScrollingFrame")
ContainerTP.Parent = MainFrame
ContainerTP.BackgroundTransparency = 1
ContainerTP.Position = UDim2.new(0, 10, 0, 85)
ContainerTP.Size = UDim2.new(1, -20, 1, -95)
ContainerTP.CanvasSize = UDim2.new(0, 0, 0, 0)
ContainerTP.ScrollBarThickness = 4
ContainerTP.Visible = false

local UIListTP = Instance.new("UIListLayout")
UIListTP.Parent = ContainerTP
UIListTP.SortOrder = Enum.SortOrder.LayoutOrder
UIListTP.Padding = UDim.new(0, 8)

local ContainerSettings = Instance.new("ScrollingFrame")
ContainerSettings.Parent = MainFrame
ContainerSettings.BackgroundTransparency = 1
ContainerSettings.Position = UDim2.new(0, 10, 0, 85)
ContainerSettings.Size = UDim2.new(1, -20, 1, -95)
ContainerSettings.CanvasSize = UDim2.new(0, 0, 0, 300)
ContainerSettings.ScrollBarThickness = 4
ContainerSettings.Visible = false

local UIListSettings = Instance.new("UIListLayout")
UIListSettings.Parent = ContainerSettings
UIListSettings.SortOrder = Enum.SortOrder.LayoutOrder
UIListSettings.Padding = UDim.new(0, 8)

-- Chuyển Tab logic
TabMainBtn.MouseButton1Click:Connect(function()
    ContainerMain.Visible = true
    ContainerTP.Visible = false
    ContainerSettings.Visible = false
    TabMainBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabMainBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
    TabTPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabTPBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabSettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabSettingsBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

TabTPBtn.MouseButton1Click:Connect(function()
    ContainerMain.Visible = false
    ContainerTP.Visible = true
    ContainerSettings.Visible = false
    TabTPBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabTPBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
    TabMainBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabMainBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabSettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabSettingsBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

TabSettingsBtn.MouseButton1Click:Connect(function()
    ContainerMain.Visible = false
    ContainerTP.Visible = false
    ContainerSettings.Visible = true
    TabSettingsBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabSettingsBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
    TabMainBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabMainBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabTPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabTPBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

-- Hàm hiển thị thông báo
local function showNotification(text)
    local Notif = Instance.new("TextLabel")
    Notif.Parent = ScreenGui
    Notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Notif.BackgroundTransparency = 0.4
    Notif.Position = UDim2.new(0.5, -125, 0.1, 0)
    Notif.Size = UDim2.new(0, 250, 0, 40)
    Notif.Font = Enum.Font.SourceSansBold
    Notif.Text = text
    Notif.TextColor3 = Color3.fromRGB(0, 255, 128)
    Notif.TextSize = 16
    Instance.new("UICorner", Notif).CornerRadius = UDim.new(0, 8)
    
    task.delay(2, function()
        Notif:Destroy()
    end)
end

-- Hiệu ứng Cutscene khi khởi động
local CutsceneFrame = Instance.new("Frame")
CutsceneFrame.Parent = ScreenGui
CutsceneFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CutsceneFrame.Size = UDim2.new(1, 0, 1, 0)
CutsceneFrame.ZIndex = 10

local CutsceneText = Instance.new("TextLabel")
CutsceneText.Parent = CutsceneFrame
CutsceneText.BackgroundTransparency = 1
CutsceneText.Size = UDim2.new(1, 0, 1, 0)
CutsceneText.Font = Enum.Font.SourceSansBold
CutsceneText.Text = "JDHub Loading..."
CutsceneText.TextColor3 = Color3.fromRGB(255, 255, 255)
CutsceneText.TextSize = 28
CutsceneText.ZIndex = 11

task.spawn(function()
    task.wait(1)
    CutsceneText.Text = "Đang khởi tạo hệ thống v2.0..."
    task.wait(1)
    
    local info = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(CutsceneFrame, info, {BackgroundTransparency = 1})
    local tweenText = TweenService:Create(CutsceneText, info, {TextTransparency = 1})
    
    tween:Play()
    tweenText:Play()
    
    task.wait(0.8)
    CutsceneFrame:Destroy()
    showNotification("Kích hoạt thành công JVHub ✅")
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Biến trạng thái tính năng và giá trị
local speedEnabled = false
local speedValue = 16
local jumpEnabled = false
local jumpValue = 50
local noclipEnabled = false
local xrayEnabled = false
local espEnabled = false
local flyEnabled = false
local flySpeed = 16
local rainbowSkinEnabled = false
local trailEnabled = false
local wallClimbEnabled = false

-- Hàm tạo hàng tùy chỉnh tính năng
local function createFeatureRow(parent, name, defaultVal, onToggle, onValChanged)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 45)
    row.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 180, 1, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Font = Enum.Font.SourceSansBold
    toggleBtn.Text = name .. ": OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    toggleBtn.TextSize = 14
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    toggleBtn.Position = UDim2.new(0, 10, 0, 0)
    toggleBtn.Parent = row
    
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(0, 80, 0, 30)
    inputBox.Position = UDim2.new(1, -90, 0.5, -15)
    inputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    inputBox.Font = Enum.Font.SourceSansBold
    inputBox.Text = tostring(defaultVal)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextSize = 14
    inputBox.Parent = row
    Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 4)
    
    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleBtn.Text = name .. ": ON"
            toggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
        else
            toggleBtn.Text = name .. ": OFF"
            toggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        onToggle(state)
    end)
    
    inputBox.FocusLost:Connect(function()
        local num = tonumber(inputBox.Text)
        if num then
            onValChanged(num)
        else
            inputBox.Text = tostring(defaultVal)
            onValChanged(defaultVal)
        end
    end)
end

-- 1. Tốc độ
createFeatureRow(ContainerMain, "Tốc độ", 16, function(state)
    speedEnabled = state
    if not speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end, function(val)
    speedValue = val
end)

RunService.RenderStepped:Connect(function()
    if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
    end
end)

-- 2. Jump Power
createFeatureRow(ContainerMain, "Jump Power", 50, function(state)
    jumpEnabled = state
    if not jumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end, function(val)
    jumpValue = val
end)

RunService.RenderStepped:Connect(function()
    if jumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = jumpValue
    end
end)

-- 3. Đi xuyên tường (Noclip)
local noclipConnection
createFeatureRow(ContainerMain, "Đi xuyên tường", "Off", function(state)
    noclipEnabled = state
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end, function(val) end)

-- 4. X-Ray
createFeatureRow(ContainerMain, "X-Ray", "Off", function(state)
    xrayEnabled = state
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then
            part.LocalTransparencyModifier = xrayEnabled and 0.5 or 0
        end
    end
end, function(val) end)

-- 5. Định vị (ESP)
local espConnections = {}
createFeatureRow(ContainerMain, "Định vị (ESP)", "Off", function(state)
    espEnabled = state
    local colorToUse = ESPColors[currentESPColorIdx]
    if espEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local function addHighlight(char)
                    if not char:FindFirstChild("JD_Highlight") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "JD_Highlight"
                        hl.Adornee = char
                        hl.FillColor = colorToUse
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.Parent = char
                    end
                end
                if plr.Character then addHighlight(plr.Character) end
                table.insert(espConnections, plr.CharacterAdded:Connect(addHighlight))
            end
        end
    else
        for _, conn in pairs(espConnections) do conn:Disconnect() end
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("JD_Highlight") then
                plr.Character.JD_Highlight:Destroy()
            end
        end
    end
end, function(val) end)

-- 6. Skin Rainbow (Replicates to other players because client owns character parts appearance properties)
createFeatureRow(ContainerMain, "Skin Rainbow", "Off", function(state)
    rainbowSkinEnabled = state
    task.spawn(function()
        while rainbowSkinEnabled do
            local char = LocalPlayer.Character
            if char then
                local hue = (tick() % 5) / 5
                local rainbowColor = Color3.fromHSV(hue, 1, 1)
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Color = rainbowColor
                        part.Material = Enum.Material.Neon
                    end
                end
            end
            task.wait(0.1)
        end
        -- Reset khi tắt
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Plastic
                end
            end
        end
    end)
end, function(val) end)

-- 7. Đường mòn (Trail)
local currentTrailObj = nil
createFeatureRow(ContainerMain, "Đường mòn", "Off", function(state)
    trailEnabled = state
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if trailEnabled and hrp then
        local att0 = Instance.new("Attachment", hrp)
        att0.Name = "TrailAtt0"
        att0.Position = Vector3.new(0, -1, 0)
        
        local att1 = Instance.new("Attachment", hrp)
        att1.Name = "TrailAtt1"
        att1.Position = Vector3.new(0, 1, 0)
        
        local trail = Instance.new("Trail", hrp)
        trail.Name = "JD_Trail"
        trail.Attachment0 = att0
        trail.Attachment1 = att1
        trail.Lifetime = 0.5
        trail.MinLength = 0
        
        local chosenColor = TrailColors[currentTrailColorIdx]
        if chosenColor == "Rainbow" then
            task.spawn(function()
                while trail.Parent do
                    trail.Color = ColorSequence.new(Color3.fromHSV((tick() % 5) / 5, 1, 1))
                    task.wait(0.1)
                end
            end)
        else
            trail.Color = ColorSequence.new(chosenColor)
        end
        currentTrailObj = trail
    else
        if hrp then
            if hrp:FindFirstChild("TrailAtt0") then hrp.TrailAtt0:Destroy() end
            if hrp:FindFirstChild("TrailAtt1") then hrp.TrailAtt1:Destroy() end
            if hrp:FindFirstChild("JD_Trail") then hrp.JD_Trail:Destroy() end
        end
    end
end, function(val) end)

-- 8. Bám tường (Wall Climb)
createFeatureRow(ContainerMain, "Bám tường", "Off", function(state)
    wallClimbEnabled = state
    task.spawn(function()
        while wallClimbEnabled do
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if hrp and humanoid then
                local ray = Ray.new(hrp.Position, hrp.CFrame.LookVector * 3)
                local hit = Workspace:FindPartOnRay(ray, char)
                if hit and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
                    humanoid.PlatformStand = true
                else
                    if humanoid.PlatformStand and not flyEnabled then
                        humanoid.PlatformStand = false
                    end
                end
            end
            task.wait(0.1)
        end
        local char = LocalPlayer.Characte
