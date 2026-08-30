-- POPHUB TROLL - FULL UPDATE V2
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Xóa UI cũ nếu có
if CoreGui:FindFirstChild("PopHubTroll") then
    CoreGui.PopHubTroll:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PopHubTroll"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- === INTRO CUTSCENE (CHỈ CÓ CHỮ ĐỘNG, KHÔNG NỀN ĐEN) ===
local IntroText = Instance.new("TextLabel", ScreenGui)
IntroText.Size = UDim2.new(0, 500, 0, 100)
IntroText.Position = UDim2.new(0.5, -250, 0.35, -50)
IntroText.BackgroundTransparency = 1
IntroText.Text = "PopHub Troll 💩"
IntroText.TextColor3 = Color3.fromRGB(255, 215, 0)
IntroText.TextSize = 38
IntroText.Font = Enum.Font.SourceSansBold
IntroText.TextTransparency = 1
IntroText.ZIndex = 999

-- Hiệu ứng hiện chữ
local introIn = TweenService:Create(IntroText, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextTransparency = 0, TextSize = 46})
introIn:Play()
introIn.Completed:Wait()
task.wait(1.2)
-- Hiệu ứng biến mất chữ
local introOut = TweenService:Create(IntroText, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1, TextSize = 20})
introOut:Play()
introOut.Completed:Wait()
IntroText:Destroy()


-- === NÚT TOGGLE NỔI (ĐỂ ẨN/HIỆN MENU & KÉO THẢ ĐƯỢC) ===
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 50, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleBtn.Text = "💩"
ToggleBtn.TextSize = 26
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(255, 215, 0)
ToggleStroke.Thickness = 2


-- === GIAO DIỆN CHÍNH (MAIN UI) ===
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 380)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(60, 60, 60)
MainStroke.Thickness = 1.5

-- Ẩn/Hiện Menu khi bấm nút Toggle
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Thanh tiêu đề
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "💩 PopHub Troll - Menu Chính"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Nút đóng Hub
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Thanh chuyển Tab (4 Mục)
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, -20, 0, 35)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1

local function createTabButton(name, positionX, widthRatio)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(widthRatio, -4, 1, 0)
    btn.Position = UDim2.new(positionX, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Tab1Btn = createTabButton("1. Troll", 0, 0.24)
local Tab2Btn = createTabButton("2. Aura", 0.25, 0.24)
local Tab3Btn = createTabButton("3. Hỗ Trợ", 0.50, 0.24)
local Tab4Btn = createTabButton("4. Anim", 0.75, 0.24)

-- Khung chứa nội dung các Tab
local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -20, 1, -100)
ContentContainer.Position = UDim2.new(0, 10, 0, 95)
ContentContainer.BackgroundTransparency = 1

local function createScrollingFrame()
    local sf = Instance.new("ScrollingFrame", ContentContainer)
    sf.Size = UDim2.new(1, 0, 1, 0)
    sf.BackgroundTransparency = 1
    sf.ScrollBarThickness = 5
    sf.Visible = false
    local layout = Instance.new("UIListLayout", sf)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    return sf
end

local Tab1Scroll = createScrollingFrame()
local Tab2Scroll = createScrollingFrame()
local Tab3Scroll = createScrollingFrame()
local Tab4Scroll = createScrollingFrame()
Tab1Scroll.Visible = true

Tab1Btn.MouseButton1Click:Connect(function()
    Tab1Scroll.Visible=true; Tab2Scroll.Visible=false; Tab3Scroll.Visible=false; Tab4Scroll.Visible=false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(60,60,60); Tab2Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab3Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab4Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
end)
Tab2Btn.MouseButton1Click:Connect(function()
    Tab1Scroll.Visible=false; Tab2Scroll.Visible=true; Tab3Scroll.Visible=false; Tab4Scroll.Visible=false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab2Btn.BackgroundColor3 = Color3.fromRGB(60,60,60); Tab3Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab4Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
end)
Tab3Btn.MouseButton1Click:Connect(function()
    Tab1Scroll.Visible=false; Tab2Scroll.Visible=false; Tab3Scroll.Visible=true; Tab4Scroll.Visible=false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab2Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab3Btn.BackgroundColor3 = Color3.fromRGB(60,60,60); Tab4Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
end)
Tab4Btn.MouseButton1Click:Connect(function()
    Tab1Scroll.Visible=false; Tab2Scroll.Visible=false; Tab3Scroll.Visible=false; Tab4Scroll.Visible=true
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab2Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab3Btn.BackgroundColor3 = Color3.fromRGB(40,40,40); Tab4Btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
end)

-- Hàm tạo UI Toggle hàng ngang
local function addToggleFeature(parent, text, callbackOn, callbackOff)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -6, 0, 34)
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton", row)
    toggleBtn.Size = UDim2.new(0, 70, 0, 22)
    toggleBtn.Position = UDim2.new(1, -78, 0.5, -11)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.SourceSansBold
    toggleBtn.TextSize = 12
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

-- Hàm tạo UI Input điền số
local function addInputFeature(parent, text, defaultVal, callback)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -6, 0, 34)
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0, 80, 0, 22)
    box.Position = UDim2.new(1, -88, 0.5, -11)
    box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.SourceSansBold
    box.TextSize = 13
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)

    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val and callback then callback(val) end
    end)
end


-- ==========================================================
-- MỤC 1: TROLL (10 Script cũ + 5 Script mới = 15 Script)
-- ==========================================================
addToggleFeature(Tab1Scroll, "1. Fake Crash Game", function()
    game:GetService("CoreGui"):SetCore("SendNotification", {Title="Roblox Crash", Text="Error Code: 277", Duration=5})
end)

addToggleFeature(Tab1Scroll, "2. Jumpscare Audio", function()
    local s = Instance.new("Sound", workspace)
    s.SoundId = "rbxassetid://9061376381"
    s.Volume = 10 s.PlayOnRemove = true s:Destroy()
end)

local flashGui
addToggleFeature(Tab1Scroll, "3. Flashbang Screen", function()
    flashGui = Instance.new("ScreenGui", CoreGui)
    local f = Instance.new("Frame", flashGui) f.Size = UDim2.new(1,0,1,0) f.BackgroundColor3 = Color3.new(1,1,1)
end, function() if flashGui then flashGui:Destroy() end end)

local bJumpConn
addToggleFeature(Tab1Scroll, "4. Bouncy Mode (Nhảy liên tục)", function()
    bJumpConn = RunService.RenderStepped:Connect(function()
        local c = LocalPlayer.Character if c and c:FindFirstChild("Humanoid") then c.Humanoid.Jump = true end
    end)
end, function() if bJumpConn then bJumpConn:Disconnect() end end)

local rgbConn
addToggleFeature(Tab1Scroll, "5. RGB Skin (Đổi màu cơ thể)", function()
    rgbConn = task.spawn(function()
        while task.wait(0.2) do
            local c = LocalPlayer.Character
            if c then for _,p in ipairs(c:GetChildren()) do if p:IsA("BasePart") then p.Color = Color3.fromHSV(math.random(),1,1) end end end
        end
    end)
end, function() if rgbConn then task.cancel(rgbConn) end end)

addToggleFeature(Tab1Scroll, "6. Fake Admin Chat Notification", function()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {Text="[SYSTEM]: Bạn đã bị khóa tài khoản!", Color=Color3.fromRGB(255,0,0), Font=Enum.Font.SourceSansBold, TextSize=18})
end)

local camConn
addToggleFeature(Tab1Scroll, "7. Lag Camera Shake", function()
    camConn = RunService.RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera
        cam.CFrame = cam.CFrame * CFrame.Angles(math.rad(math.random(-2,2)), math.rad(math.random(-2,2)), 0)
    end)
end, function() if camConn then camConn:Disconnect() end end)

addToggleFeature(Tab1Scroll, "8. Freeze Character (Đứng hình 3s)", function()
    local c = LocalPlayer.Character if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.Anchored = true task.wait(3) c.HumanoidRootPart.Anchored = false
    end
end)

local spinConn
addToggleFeature(Tab1Scroll, "9. Spinbot Fun (Xoay tít mù)", function()
    spinConn = RunService.RenderStepped:Connect(function()
        local c = LocalPlayer.Character if c and c:FindFirstChild("HumanoidRootPart") then
            c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(60), 0)
        end
    end)
end, function() if spinConn then spinConn:Disconnect() end end)

local fireObj
addToggleFeature(Tab1Scroll, "10. Fake Fire Aura (Lửa cháy người)", function()
    local c = LocalPlayer.Character local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
    if t then fireObj = Instance.new("Fire", t) fireObj.Size = 15 end
end, function() if fireObj then fireObj:Destroy() end end)

-- 5 Script Troll Mới Thêm
local seizureConn
addToggleFeature(Tab1Scroll, "11. Screen Color Seizure (Nháy màu màn)", function()
    local sg = Instance.new("ScreenGui", CoreGui) local fr = Instance.new("Frame", sg) fr.Size = UDim2.new(1,0,1,0)
    seizureConn = RunService.RenderStepped:Connect(function()
        fr.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1) fr.BackgroundTransparency = 0.7
    end)
end, function() if seizureConn then seizureConn:Disconnect() end end)

addToggleFeature(Tab1Scroll, "12. Fake Ban Menu Notification", function()
    game:GetService("CoreGui"):SetCore("SendNotification", {Title="BANNED", Text="You have been banned from this experience. Reason: Exploiting.", Duration=6})
end)

local ghostSpin
addToggleFeature(Tab1Scroll, "13. Upside Down Tumble (Đảo ngược đầu)", function()
    ghostSpin = RunService.RenderStepped:Connect(function()
        local c = LocalPlayer.Character if c and c:FindFirstChild("HumanoidRootPart") then
            c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(2), 0, math.rad(180))
        end
    end)
end, function() if ghostSpin then ghostSpin:Disconnect() end end)

addToggleFeature(Tab1Scroll, "14. Sound Spam Laugh (Cười lớn liên tục)", function()
    task.spawn(function()
        for i = 1, 3 do
            local s = Instance.new("Sound", workspace) s.SoundId = "rbxassetid://9061376381" s.Volume = 5 s.PlayOnRemove = true s:Destroy()
            task.wait(1)
        end
    end)
end)

local jitterConn
addToggleFeature(Tab1Scroll, "15. Micro-Jitter Movement (Rung lắc người)", function()
    jitterConn = RunService.RenderStepped:Connect(function()
        local c = LocalPlayer.Character if c and c:FindFirstChild("HumanoidRootPart") then
            c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame + Vector3.new(math.random(-1,1)*0.2, 0, math.random(-1,1)*0.2)
        end
    end)
end, function() if jitterConn then jitterConn:Disconnect() end end)


-- ==========================================================
-- MỤC 2: AURA (10 Cũ + 7 Mới Đã Sửa Lỗi Đầu To/Nhỏ = 17 Aura)
-- ==========================================================
local smokeObj
addToggleFeature(Tab2Scroll, "1. Smoke Aura", function()
    local c = LocalPlayer.Character local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
    if t then smokeObj = Instance.new("Smoke", t) smokeObj.Size = 10 end
end, function() if smokeObj then smokeObj:Destroy() end end)

local sparkleObj
addToggleFeature(Tab2Scroll, "2. Sparkles Aura", function()
    local c = LocalPlayer.Character local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
    if t then sparkleObj = Instance.new("Sparkles", t) end
end, function() if sparkleObj then sparkleObj:Destroy() end end)

-- Sửa lỗi Head Size (Đầu To) hoạt động chuẩn
addToggleFeature(Tab2Scroll, "3. Big Head Mode (Đầu To)", function()
    local c = LocalPlayer.Character local h = c and c:FindFirstChild("Head")
    if h then h.Size = Vector3.new(4, 4, 4) if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(4, 4, 4) end end
end, function()
    local c = LocalPlayer.Character local h = c and c:FindFirstChild("Head")
    if h then h.Size = Vector3.new(2, 1, 1) if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(1, 1, 1) end end
end)

addToggleFeature(Tab2Scroll, "4. Invisible Accessories", function()
    local c = LocalPlayer.Character if c then for _,v in ipairs(c:GetChildren()) do if v:IsA("Accessory") then v:Destroy() end end end
end)

local speedConn2
addToggleFeature(Tab2Scroll, "5. Speed Boost (100)", function()
    local c = LocalPlayer.Character if c and c:FindFirstChild("Humanoid") then c.Humanoid.WalkSpeed = 100 end
end, function()
    local c = LocalPlayer.Character if c and c:FindFirstChild("Humanoid") then c.Humanoid.WalkSpeed = 16 end
end)

local floatObj
addToggleFeature(Tab2Scroll, "6. Float Mode", function()
    local c = LocalPlayer.Character local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp then
        floatObj = Instance.new("BodyVelocity", hrp) floatObj.Velocity = Vector3.new(0,1,0) floatObj.MaxForce = Vector3.new(0,40000,0)
    end
end, function() if floatObj then floatObj:Destroy() end end)

addToggleFeature(Tab2Scroll, "7. Rainbow Sparkles", function()
    local c = LocalPlayer.Character local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
    if t then
        sparkleObj = Instance.new("Sparkles", t)
        sparkleObj.SparkleColor = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
    end
end, function() if sparkleObj then sparkleObj:Destroy() end end)

addToggleFeature(Tab2Scroll, "8. Super Jump (100)", function()
    local c = LocalPlayer.Character if c and c:FindFirstChild("Humanoid") then c.Humanoid.JumpPower = 100 end
end, function()
    local c = LocalPlayer.Character if c and c:FindFirstChild("Humanoid") then c.Humanoid.JumpPower = 50 end
end)

addToggleFeature(Tab2Scroll, "9. Tiny Character Fix", function()
    local c = LocalPlayer.Character if c and c:FindFirstChild("Humanoid") then
        for _,v in ipairs(c:GetChildren()) do if v:IsA("NumberValue") then v:Destroy() end end
    end
end)

local lightObj
addToggleFeature(Tab2Scroll, "10. Glow Aura", function()
    local c = LocalPlayer.Character local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
    if t then lightObj = Instance.new("PointLight", t) lightObj.Range = 20 lightObj.Brightness = 8 end
end, function() if lightObj then lightObj:Destroy() end end)

-- 7 Script Aura Mới Thêm (Bao gồm Sửa lỗi Đầu Nhỏ)
-- Sửa lỗi Head Size (Đầu Nhỏ) hoạt động chuẩn
addToggleFeature(Tab2Scroll, "11. Tiny Head Mode (Đầu Nhỏ)", function()
    local c = LocalPlayer.Character local h = c and c:FindFirstChild("Head")
    if h then h.Size = Vector3.new(0.8, 0.8, 0.8) if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(0.5, 0.5, 0.5) end end
end, function()
    local c = LocalPlayer.Character local h = c and c:FindFirstChild("Head")
    if h then h.Size = Vector3.new(2, 1, 1) if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(1, 1, 1) end end
end)

local auraColorTask
addToggleFeature(Tab2Scroll, "12. RGB Fire Aura", function()
    local c = LocalPlayer.Character local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso"))
    if t then
        local f = Instance.new("Fire", t) f.Size = 12
        auraColorTask = task.spawn(function()
            while task.wait(0.3) do f.Color = Color3.fromHSV(math.random(), 1, 1) end
        end)
    end
end, function() if auraColorTask then task.cancel(auraColorTask) end local c=LocalPlayer.Character local t=c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")) if t and t:FindFirstChild("Fire") then t.Fire:Destroy() end end)

local trailObj
addToggleFeature(Tab2Scroll, "13. Neon Trail Effect", function()
    local c = LocalPlayer.Character local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp then
        local att0 = Instance.
