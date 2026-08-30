-- POPHUB TROLL - SCRIPT HUB
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa UI cũ nếu có tránh bị trùng lặp
if CoreGui:FindFirstChild("PopHubTroll") then
    CoreGui.PopHubTroll:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PopHubTroll"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- === INTRO CUTSCENE (HIỆU ỨNG MỞ ĐẦU) ===
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.ZIndex = 10

local LogoText = Instance.new("TextLabel", IntroFrame)
LogoText.Size = UDim2.new(0, 300, 0, 100)
LogoText.Position = UDim2.new(0.5, -150, 0.4, -50)
LogoText.BackgroundTransparency = 1
LogoText.Text = "💩 PopHub Troll 💩"
LogoText.TextColor3 = Color3.fromRGB(255, 215, 0)
LogoText.TextSize = 28
LogoText.Font = Enum.Font.SourceSansBold
LogoText.TextTransparency = 1

local IntroTweenIn = TweenService:Create(LogoText, TweenInfo.new(1), {TextTransparency = 0})
IntroTweenIn:Play()
IntroTweenIn.Completed:Wait()
task.wait(1.5)
local IntroTweenOut = TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 1})
local TextTweenOut = TweenService:Create(LogoText, TweenInfo.new(1), {TextTransparency = 1})
IntroTweenOut:Play()
TextTweenOut:Play()
IntroTweenOut.Completed:Wait()
IntroFrame:Destroy()

-- === GIAO DIỆN CHÍNH (MAIN UI) ===
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 360)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

-- Thanh tiêu đề
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "💩 PopHub Troll - Menu Chính"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Nút đóng Hub
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Thanh chuyển Tab (Mục 1, 2, 3)
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, -20, 0, 35)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1

local function createTabButton(name, positionX)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0.32, 0, 1, 0)
    btn.Position = UDim2.new(positionX, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    return btn
end

local Tab1Btn = createTabButton("1. Troll", 0)
local Tab2Btn = createTabButton("2. Aura", 0.34)
local Tab3Btn = createTabButton("3. Hỗ Trợ", 0.68)

-- Khung chứa nội dung các Tab
local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -20, 1, -100)
ContentContainer.Position = UDim2.new(0, 10, 0, 95)
ContentContainer.BackgroundTransparency = 1

local function createScrollingFrame()
    local sf = Instance.new("ScrollingFrame", ContentContainer)
    sf.Size = UDim2.new(1, 0, 1, 0)
    sf.BackgroundTransparency = 1
    sf.ScrollBarThickness = 6
    sf.Visible = false
    local layout = Instance.new("UIListLayout", sf)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    return sf
end

local Tab1Scroll = createScrollingFrame()
local Tab2Scroll = createScrollingFrame()
local Tab3Scroll = createScrollingFrame()
Tab1Scroll.Visible = true -- Mặc định mở tab 1

Tab1Btn.MouseButton1Click:Connect(function()
    Tab1Scroll.Visible = true; Tab2Scroll.Visible = false; Tab3Scroll.Visible = false
end)
Tab2Btn.MouseButton1Click:Connect(function()
    Tab1Scroll.Visible = false; Tab2Scroll.Visible = true; Tab3Scroll.Visible = false
end)
Tab3Btn.MouseButton1Click:Connect(function()
    Tab1Scroll.Visible = false; Tab2Scroll.Visible = false; Tab3Scroll.Visible = true
end)

-- Hàm tạo hàng tùy chọn chức năng (Có nút Bật/Tắt bên cạnh)
local function addToggleFeature(parent, text, callbackOn, callbackOff)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -10, 0, 35)
    row.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton", row)
    toggleBtn.Size = UDim2.new(0, 80, 0, 25)
    toggleBtn.Position = UDim2.new(1, -90, 0.5, -12.5)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.SourceSansBold
    toggleBtn.TextSize = 14
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 4)

    local active = false
    toggleBtn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
            toggleBtn.Text = "ON"
            if callbackOn then callbackOn() end
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            toggleBtn.Text = "OFF"
            if callbackOff then callbackOff() end
        end
    end)
end

-- Hàm tạo hàng nhập số lượng tùy chỉnh (Cho phần hỗ trợ tốc độ, nhảy, fly...)
local function addInputFeature(parent, text, defaultVal, callback)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -10, 0, 35)
    row.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0, 90, 0, 25)
    box.Position = UDim2.new(1, -100, 0.5, -12.5)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.SourceSansBold
    box.TextSize = 14
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)

    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val and callback then
            callback(val)
        end
    end)
end


-- ================= CHỨC NĂNG MỤC 1: TROLL =================
addToggleFeature(Tab1Scroll, "1. Fake Crash Game", function()
    game:GetService("CoreGui"):SetCore("SendNotification", {
        Title = "Roblox Crash Error",
        Text = "An unexpected error occurred. (Error Code: 277)",
        Duration = 5
    })
end)

addToggleFeature(Tab1Scroll, "2. Jumpscare Audio", function()
    local sound = Instance.new("Sound", workspace)
    sound.SoundId = "rbxassetid://9061376381"
    sound.Volume = 10
    sound.PlayOnRemove = true
    sound:Destroy()
end)

local flashGui
addToggleFeature(Tab1Scroll, "3. Flashbang Screen", function()
    flashGui = Instance.new("ScreenGui", CoreGui)
    local f = Instance.new("Frame", flashGui)
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundColor3 = Color3.new(1, 1, 1)
end, function()
    if flashGui then flashGui:Destroy() end
end)

local bJumpConn
addToggleFeature(Tab1Scroll, "4. Bouncy Mode (Nhảy liên tục)", function()
    bJumpConn = game:GetService("RunService").RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Jump = true
        end
    end)
end, function()
    if bJumpConn then bJumpConn:Disconnect() end
end)

local rgbConn
addToggleFeature(Tab1Scroll, "5. RGB Skin (Đổi màu cơ thể)", function()
    rgbConn = task.spawn(function()
        while task.wait(0.2) do
            local char = LocalPlayer.Character
            if char then
                for _, p in ipairs(char:GetChildren()) do
                    if p:IsA("BasePart") then p.Color = Color3.fromHSV(math.random(), 1, 1) end
                end
            end
        end
    end)
end, function()
    if rgbConn then task.cancel(rgbConn) end
end)

addToggleFeature(Tab1Scroll, "6. Fake Admin Chat Notification", function()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "[SYSTEM]: Bạn đã bị khóa tài khoản vĩnh viễn!",
        Color = Color3.fromRGB(255, 0, 0),
        Font = Enum.Font.SourceSansBold,
        TextSize = 20
    })
end)

local camConn
addToggleFeature(Tab1Scroll, "7. Lag Camera Shake", function()
    camConn = game:GetService("RunService").RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera
        cam.CFrame = cam.CFrame * CFrame.Angles(math.rad(math.random(-2,2)), math.rad(math.random(-2,2)), 0)
    end)
end, function()
    if camConn then camConn:Disconnect() end
end)

addToggleFeature(Tab1Scroll, "8. Freeze Character (Đứng hình 3s)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Anchored = true
        task.wait(3)
        char.HumanoidRootPart.Anchored = false
    end
end)

local spinConn
addToggleFeature(Tab1Scroll, "9. Spinbot Fun (Xoay tít mù)", function()
    spinConn = game:GetService("RunService").RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)
        end
    end)
end, function()
    if spinConn then spinConn:Disconnect() end
end)

local fireObj
addToggleFeature(Tab1Scroll, "10. Fake Fire Aura (Lửa cháy người)", function()
    local char = LocalPlayer.Character
    local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
    if torso then
        fireObj = Instance.new("Fire", torso)
        fireObj.Size = 15
    end
end, function()
    if fireObj then fireObj:Destroy() end
end)


-- ================= CHỨC NĂNG MỤC 2: AURA =================
local smokeObj
addToggleFeature(Tab2Scroll, "1. Smoke Aura (Khói mịt mù)", function()
    local char = LocalPlayer.Character
    local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
    if torso then smokeObj = Instance.new("Smoke", torso); smokeObj.Size = 10 end
end, function() if smokeObj then smokeObj:Destroy() end end)

local sparkleObj
addToggleFeature(Tab2Scroll, "2. Sparkles Aura (Lấp lánh)", function()
    local char = LocalPlayer.Character
    local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
    if torso then sparkleObj = Instance.new("Sparkles", torso) end
end, function() if sparkleObj then sparkleObj:Destroy() end end)

addToggleFeature(Tab2Scroll, "3. Big Head Mode (Đầu to)", function()
    local char = LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    if head then head.Size = Vector3.new(5,5,5) end
end, function()
    local char = LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    if head then head.Size = Vector3.new(2,1,1) end
end)

addToggleFeature(Tab2Scroll, "4. Invisible Accessories (Ẩn phụ kiện)", function()
    local char = LocalPlayer.Character
    if char then
        for _, c in ipairs(char:GetChildren()) do if c:IsA("Accessory") then c:Destroy() end end
    end
end)

local speedConn
addToggleFeature(Tab2Scroll, "5. Speed Boost (Chạy nhanh 100)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = 100 end
end, function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = 16 end
end)

local floatObj
addToggleFeature(Tab2Scroll, "6. Float Mode (Lơ lửng nhẹ)", function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        floatObj = Instance.new("BodyVelocity", hrp)
        floatObj.Velocity = Vector3.new(0, 1, 0)
        floatObj.MaxForce = Vector3.new(0, 40000, 0)
    end
end, function() if floatObj then floatObj:Destroy() end end)

addToggleFeature(Tab2Scroll, "7. Rainbow Sparkles (Hạt cầu vồng)", function()
    local char = LocalPlayer.Character
    local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
    if torso then
        sparkleObj = Instance.new("Sparkles", torso)
        sparkleObj.SparkleColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
    end
end, function() if sparkleObj then sparkleObj:Destroy() end end)

addToggleFeature(Tab2Scroll, "8. Super High Jump (Nhảy cao gấp đôi)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = 100 end
end, function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = 50 end
end)

addToggleFeature(Tab2Scroll, "9. Tiny Character (Người tí hon)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        for _, v in ipairs(char:GetChildren()) do
            if v:IsA("NumberValue") or v:IsA("Folder") then v:Destroy() end
        end
    end
end)

addToggleFeature(Tab2Scroll, "10. Glow Aura (Hào quang sáng)", function()
    local char = LocalPlayer.Character
    local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
    if torso then
        local pointLight = Instance.new("PointLight", torso)
        pointLight.Range = 15
        pointLight.Brightness = 5
    end
end, function()
    local char = LocalPlayer.Character
    local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
    if torso and torso:FindFirstChild("PointLight") then torso.PointLight:Destroy() end
end)


-- ================= CHỨC NĂNG MỤC 3: HỖ TRỢ =================
local noclipConn
addToggleFeature(Tab3Scroll, "1. Đi xuyên tường (Noclip)", function()
    noclipConn = game:GetService("RunService").Stepped:Connect(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end, function()
    if noclipConn then noclipConn:Disconnect() end
end)

addInputFeature(Tab3Scroll, "2. Chỉnh Tốc Độ (WalkSpeed)", 16, function(val)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = val end
end)

addInputFeature(Tab3Scroll, "3. Chỉnh Sức Nhảy (JumpPower)", 50, function(val)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = val end
end)

addToggleFeature(Tab3Scroll, "4. X-Ray (Nhìn xuyên vật thể)", function()
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") and not p:IsDescendantOf(LocalPlayer.Character) then
            p.Transparency = 0.5
        end
    end
end, function()
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") and not p:IsDescendantOf(LocalPlayer.Character) then
            p.Transparency = 0
        end
    end
end)

addToggleFeature(Tab3Scroll, "5. Đi trên không trung", function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local p = Instance.new("Part", workspace)
        p.Size = Vector3.new(5, 1, 5)
        p.Position = hrp.Position - Vector3.new(0, 3, 0)
        p.Anchored = true
        p.Transparency = 1
        p.Name = "AirPlatform"
    end
end, function()
    local plat = workspace:FindFirstChild("AirPlatform")
    if plat then plat:Destroy() end
end)

local flyConn
addInputFeature(Tab3Scroll, "6. Fly Speed (Tốc độ Bay)", 50, function(val)
    -- Tùy chỉnh tốc độ bay nếu cần
end)
