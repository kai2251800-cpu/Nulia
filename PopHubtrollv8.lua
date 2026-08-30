-- POPHUB TROLL - V8 (FINAL FIXED MOBILE EDITION)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- THÔNG BÁO HOÀN TẤT
task.spawn(function()
    task.wait(0.5)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "💩 PopHub Troll",
            Text = "Đã loading thành công ✅",
            Duration = 3
        })
    end)
end)

-- TẠO GUI AN TOÀN TRÊN PLAYERGUI CHO MOBILE
local success, guiParent = pcall(function()
    return LocalPlayer:WaitForChild("PlayerGui")
end)

if not success or not guiParent then
    guiParent = game:GetService("CoreGui")
end

if guiParent:FindFirstChild("PopHubTroll") then
    guiParent.PopHubTroll:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PopHubTroll"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = guiParent

-- === NÚT TOGGLE CỤC 💩 ===
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0.15, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleBtn.Text = "💩"
ToggleBtn.TextSize = 25
ToggleBtn.Active = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(255, 215, 0)
ToggleStroke.Thickness = 2

-- === GIAO DIỆN CHÍNH ===
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 460, 0, 320)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(60, 60, 60)
MainStroke.Thickness = 1.5

ToggleBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
end)

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

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = false 
end)

-- Thanh Tabs
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, -20, 0, 35)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

local function createTabButton(name)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0.235, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Tab1Btn = createTabButton("1. Troll")
local Tab2Btn = createTabButton("2. Aura")
local Tab3Btn = createTabButton("3. Hỗ Trợ")
local Tab4Btn = createTabButton("4. Anim")

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -20, 1, -100)
ContentContainer.Position = UDim2.new(0, 10, 0, 95)
ContentContainer.BackgroundTransparency = 1

local function createScrollingFrame()
    local sf = Instance.new("ScrollingFrame", ContentContainer)
    sf.Size = UDim2.new(1, 0, 1, 0)
    sf.BackgroundTransparency = 1
    sf.ScrollBarThickness = 4
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.CanvasSize = UDim2.new(0, 0, 0, 0)
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
Tab1Btn.BackgroundColor3 = Color3.fromRGB(60,60,60)

local function switchTab(showScroll, activeBtn)
    Tab1Scroll.Visible = false
    Tab2Scroll.Visible = false
    Tab3Scroll.Visible = false
    Tab4Scroll.Visible = false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Tab4Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    showScroll.Visible = true 
    activeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
end

Tab1Btn.MouseButton1Click:Connect(function() switchTab(Tab1Scroll, Tab1Btn) end)
Tab2Btn.MouseButton1Click:Connect(function() switchTab(Tab2Scroll, Tab2Btn) end)
Tab3Btn.MouseButton1Click:Connect(function() switchTab(Tab3Scroll, Tab3Btn) end)
Tab4Btn.MouseButton1Click:Connect(function() switchTab(Tab4Scroll, Tab4Btn) end)

local function addToggleFeature(parent, text, callbackOn, callbackOff)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -8, 0, 32)
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
    
    local tBtn = Instance.new("TextButton", row)
    tBtn.Size = UDim2.new(0, 65, 0, 20) 
    tBtn.Position = UDim2.new(1, -75, 0.5, -10)
    tBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) 
    tBtn.Text = "OFF"
    tBtn.TextColor3 = Color3.fromRGB(255, 255, 255) 
    tBtn.Font = Enum.Font.SourceSansBold 
    tBtn.TextSize = 12
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 4)
    
    local active = false
    tBtn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            tBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
            tBtn.Text = "ON"
            if callbackOn then pcall(callbackOn) end
        else
            tBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            tBtn.Text = "OFF"
            if callbackOff then pcall(callbackOff) end
        end
    end)
end

local function addInputFeature(parent, text, defaultVal, callback)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -8, 0, 32)
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
    box.Size = UDim2.new(0, 65, 0, 20) 
    box.Position = UDim2.new(1, -75, 0.5, -10)
    box.BackgroundColor3 = Color3.fromRGB(45, 45, 45) 
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255) 
    box.Font = Enum.Font.SourceSansBold 
    box.TextSize = 12
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val and callback then pcall(function() callback(val) end) end
    end)
end

-- ================== TAB 1: TROLL ==================
addToggleFeature(Tab1Scroll, "1. Fake Crash Game", function() 
    StarterGui:SetCore("SendNotification", {Title="Roblox Error", Text="Error Code: 277", Duration=5}) 
end)

addToggleFeature(Tab1Scroll, "2. Jumpscare Audio", function() 
    local s = Instance.new("Sound", workspace) 
    s.SoundId = "rbxassetid://9061376381" 
    s.Volume = 10 
    s.PlayOnRemove = true 
    s:Destroy() 
end)

local flFrame
addToggleFeature(Tab1Scroll, "3. Flashbang Screen", function() 
    flFrame = Instance.new("Frame", ScreenGui) 
    flFrame.Size = UDim2.new(10,0,10,0) 
    flFrame.Position = UDim2.new(-5,0,-5,0) 
    flFrame.BackgroundColor3 = Color3.new(1,1,1) 
    flFrame.ZIndex = 1000 
end, function() 
    if flFrame then flFrame:Destroy() end 
end)

local bJumpConn
addToggleFeature(Tab1Scroll, "4. Bouncy Mode", function() 
    bJumpConn = RunService.RenderStepped:Connect(function() 
        local c = LocalPlayer.Character 
        if c and c:FindFirstChild("Humanoid") then 
            c.Humanoid.Jump = true 
        end 
    end) 
end, function() 
    if bJumpConn then bJumpConn:Disconnect() end 
end)

local rgbConn
addToggleFeature(Tab1Scroll, "5. RGB Skin", function() 
    rgbConn = task.spawn(function() 
        while task.wait(0.2) do 
            local c = LocalPlayer.Character 
            if c then 
                for _,p in ipairs(c:GetChildren()) do 
                    if p:IsA("BasePart") then 
                        p.Color = Color3.fromHSV(math.random(),1,1) 
                    end 
                end 
            end 
        end 
    end) 
end, function() 
    if rgbConn then task.cancel(rgbConn) end 
end)

addToggleFeature(Tab1Scroll, "6. Fake Admin Chat", function() 
    StarterGui:SetCore("ChatMakeSystemMessage", {Text="[SYSTEM]: Bạn đã bị khóa tài khoản!", Color=Color3.fromRGB(255,0,0), Font=Enum.Font.SourceSansBold, TextSize=18}) 
end)

local camConn
addToggleFeature(Tab1Scroll, "7. Lag Camera Shake", function() 
    camConn = RunService.RenderStepped:Connect(function() 
        local cam = workspace.CurrentCamera 
        cam.CFrame = cam.CFrame * CFrame.Angles(math.rad(math.random(-2,2)), math.rad(math.random(-2,2)), 0) 
    end) 
end, function() 
    if camConn then camConn:Disconnect() end 
end)

addToggleFeature(Tab1Scroll, "8. Freeze Character", function() 
    local c = LocalPlayer.Character 
    if c and c:FindFirstChild("HumanoidRootPart") then 
        c.HumanoidRootPart.Anchored = true 
        task.wait(3) 
        c.HumanoidRootPart.Anchored = false 
    end 
end)

local spinConn
addToggleFeature(Tab1Scroll, "9. Spinbot Fun", function() 
    spinConn = RunService.RenderStepped:Connect(function() 
        local c = LocalPlayer.Character 
        if c and c:FindFirstChild("HumanoidRootPart") then 
            c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(60), 0) 
        end 
    end) 
end, function() 
    if spinConn then spinConn:Disconnect() end 
end)

local fireTroll
addToggleFeature(Tab1Scroll, "10. Fake Fire Aura", function() 
    local c = LocalPlayer.Character 
    local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")) 
    if t then 
        fireTroll = Instance.new("Fire", t) 
        fireTroll.Size = 15 
    end 
end, function() 
    if fireTroll then fireTroll:Destroy() end 
end)

local szFrame, szConn
addToggleFeature(Tab1Scroll, "11. Screen Seizure", function() 
    szFrame = Instance.new("Frame", ScreenGui) 
    szFrame.Size = UDim2.new(10,0,10,0) 
    szFrame.Position = UDim2.new(-5,0,-5,0) 
    szFrame.ZIndex = 998 
    szConn = RunService.RenderStepped:Connect(function() 
        szFrame.BackgroundColor3 = Color3.fromHSV(math.random(),1,1) 
        szFrame.BackgroundTransparency = 0.5 
    end) 
end, function() 
    if szConn then szConn:Disconnect() end 
    if szFrame then szFrame:Destroy() end 
end)

addToggleFeature(Tab1Scroll, "12. Fake Ban Menu", function() 
    StarterGui:SetCore("SendNotification", {Title="BANNED", Text="You have been banned.", Duration=6}) 
end)

local ghConn
addToggleFeature(Tab1Scroll, "13. Upside Down Tumble", function() 
    ghConn = RunService.RenderStepped:Connect(function() 
        local c = LocalPlayer.Character 
        if c and c:FindFirstChild("HumanoidRootPart") then 
            c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(2),0,math.rad(180)) 
        end 
    end) 
end, function() 
    if ghConn then ghConn:Disconnect() end 
end)

addToggleFeature(Tab1Scroll, "14. Spam Laugh", function() 
    task.spawn(function() 
        for i=1,3 do 
            local s = Instance.new("Sound", workspace) 
            s.SoundId = "rbxassetid://9061376381" 
            s.Volume = 5 
            s.PlayOnRemove = true 
            s:Destroy() 
            task.wait(1) 
        end 
    end) 
end)

local jtConn
addToggleFeature(Tab1Scroll, "15. Micro-Jitter", function() 
    jtConn = RunService.RenderStepped:Connect(function() 
        local c = LocalPlayer.Character 
        if c and c:FindFirstChild("HumanoidRootPart") then 
            c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame + Vector3.new(math.random(-1,1)*0.2,0,math.random(-1,1)*0.2) 
        end 
    end) 
end, function() 
    if jtConn then jtConn:Disconnect() end 
end)

-- ================== TAB 2: AURA ==================
local smokeA, sparkA
addToggleFeature(Tab2Scroll, "1. Smoke Aura", function() 
    local t = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Torso") or LocalPlayer.Character:FindFirstChild("UpperTorso")) 
    if t then smokeA = Instance.new("Smoke", t) smokeA.Size = 10 end 
end, function() 
    if smokeA then smokeA:Destroy() end 
end)

addToggleFeature(Tab2Scroll, "2. Sparkles Aura", function() 
    local t = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Torso") or LocalPlayer.Character:FindFirstChild("UpperTorso")) 
    if t then sparkA = Instance.new("Sparkles", t) end 
end, function() 
    if sparkA then sparkA:Destroy() end 
end)

addToggleFeature(Tab2Scroll, "3. Big Head", function() 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") 
    if h then 
        h.Size = Vector3.new(4,4,4) 
        if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(4,4,4) end 
    end 
end, function() 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") 
    if h then 
        h.Size = Vector3.new(2,1,1) 
        if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(1,1,1) end 
    end 
end)

addToggleFeature(Tab2Scroll, "4. Speed (100)", function() 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") 
    if h then h.WalkSpeed = 100 end 
end, function() 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") 
    if h then h.WalkSpeed = 16 end 
end)

local flObj
addToggleFeature(Tab2Scroll, "5. Float Mode", function() 
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
    if hrp then 
        flObj = Instance.new("BodyVelocity", hrp) 
        flObj.Velocity = Vector3.new(0,1,0) 
        flObj.MaxForce = Vector3.new(0,40000,0) 
    end 
end, function() 
    if flObj then flObj:Destroy() end 
end)

addToggleFeature(Tab2Scroll, "6. Super Jump", function() 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") 
    if h then h.UseJumpPower=true h.JumpPower = 100 end 
end, function() 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") 
    if h then h.JumpPower = 50 end 
end)

local glow
addToggleFeature(Tab2Scroll, "7. Glow Aura", function() 
    local t = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Torso") or LocalPlayer.Character:FindFirstChild("UpperTorso")) 
    if t then 
        glow = Instance.new("PointLight", t) 
        glow.Range = 20 
        glow.Brightness = 8 
    end 
end, function() 
    if glow then glow:Destroy() end 
end)

addToggleFeature(Tab2Scroll, "8. Tiny Head", function() 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") 
    if h then 
        h.Size = Vector3.new(0.8,0.8,0.8) 
        if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(0.5,0.5,0.5) end 
    end 
end, function() 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") 
    if h then 
        h.Size = Vector3.new(2,1,1) 
        if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(1,1,1) end 
    end 
end)

local rgbF, rgbT
addToggleFeature(Tab2Scroll, "9. RGB Fire Aura", function() 
    local t = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Torso") or LocalPlayer.Character:FindFirstChild("UpperTorso")) 
    if t then 
        rgbF = Instance.new("Fire", t) 
        rgbF.Size = 12 
        rgbT = task.spawn(function() 
            while task.wait(0.3) do rgbF.Color = Color3.fromHSV(math.random(),1,1) end 
        end) 
    end 
end, function() 
    if rgbT then task.cancel(rgbT) end 
    if rgbF then rgbF:Destroy() end 
end)

local trail
addToggleFeature(Tab2Scroll, "10. Neon Trail", function() 
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
    if hrp then 
        local a0 = Instance.new("Attachment", hrp) a0.Position = Vector3.new(0,-1,0) 
        local a1 = Instance.new("Attachment", hrp) a1.Position = Vector3.new(0,1,0) 
        trail = Instance.new("Trail", hrp) 
        trail.Attachment0 = a0 
        trail.Attachment1 = a1 
        trail.Color = ColorSequence.new(Color3.fromRGB(0,255,255)) 
    end 
end, function() 
    if trail then trail:Destroy() end 
end)

local prt
addToggleFeature(Tab2Scroll, "11. Magic Glitter", function() 
    local t = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("Torso") or LocalPlayer.Character:FindFirstChild("UpperTorso")) 
    if t then 
        prt = Instance.new("ParticleEmitter", t) 
        prt.Texture = "rbxassetid://258124463" 
        prt.Rate = 20 
    end 
end, function() 
    if prt then prt:Destroy() end 
end)

-- ================== TAB 3: HỖ TRỢ ==================
local ncConn
addToggleFeature(Tab3Scroll, "1. Noclip (Xuyên tường)", function() 
    ncConn = RunService.Stepped:Connect(function() 
        local c = LocalPlayer.Character 
        if c then 
            for _,p in ipairs(c:GetDescendants()) do 
                if p:IsA("BasePart") then p.CanCollide = false end 
            end 
        end 
    end) 
end, function() 
    if ncConn then ncConn:Disconnect() end 
end)

addInputFeature(Tab3Scroll, "2. Chỉnh Tốc Độ", 16, function(v) 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") 
    if h then h.WalkSpeed = v end 
end)

addInputFeature(Tab3Scroll, "3. Chỉnh Sức Nhảy", 50, function(v) 
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") 
    if h then h.UseJumpPower = true h.JumpPower = v end 
end)

addToggleFeature(Tab3Scroll, "4. Air Platform", function() 
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
    if hrp then 
        local p = Instance.new("Part", workspace) 
        p.Size = Vector3.new(5,1,5) 
        p.Position = hrp.Position - Vector3.new(0,3,0) 
        p.Anchore = true 
        p.Transparency = 1 
        p.Name = "AirPlatform" 
    end 
end, function() 
    local p = workspace:FindFirstChild("AirPlatform") 
    if p then p:Destroy() end 
end)

addToggleFeature(Tab3Scroll, "5. Infinite Jump", function() 
    _G.InfJ = true 
    game:GetService("UserInputService").JumpRequest:Connect(function() 
        if _G.InfJ then 
            local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") 
            if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end 
        end 
    end) 
end, function() 
    _G.InfJ = false 
end)

addToggleFeature(Tab3Scroll, "6. Fullbright", function() 
    game:GetService("Lighting").Brightness = 2 
    game:GetService("Lighting").ClockTime = 14 
    game:GetService("Lighting").FogEnd = 100000 
end)

addToggleFeature(Tab3Scroll, "7. Click TP (Ctrl+Click)", function() 
    local m = LocalPlayer:GetMouse() 
    _G.CTP = true 
    m.Button1Down:Connect(function() 
        if _G.CTP and m.Target and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then 
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
            if hrp then hrp.CFrame = CFrame.new(m.Hit.Position + Vector3.new(0,3,0)) end 
        end 
    end) 
end, function() 
    _G.CTP = false 
end)

-- ================== TAB 4: ANIMATION PACK ==================
local DefaultAnims = {}

local function saveDefaultAnims(char)
    local animate = char:FindFirstChild("Animate")
    if not animate then return end
    local anims = {"idle", "walk", "run", "jump", "fall", "climb", "swim"}
    if next(DefaultAnims) == nil then
        for _, name in pairs(anims) do
            local folder = animate:FindFirstChild(name)
            if folder then
                DefaultAnims[name] = {}
                for _, anim in pairs(folder:GetChildren()) do
                    if anim:IsA("Animation") then
                        table.insert(DefaultAnims[name], {obj = anim, id = anim.AnimationId})
                    end
                end
            end
        end
    end
end

local function setAnims(animPack)
    local char = LocalPlayer.Character
    if not char then return end
    saveDefaultAnims(char)
    local animate = char:FindFirstChild("Animate")
    if not animate then return end

    for name, ids in pairs(animPack) do
        local folder = animate:FindFirstChild(name)
        if folder then
            local anims = folder:GetChildren()
            for i, anim in pairs(anims) do
                if anim:IsA("Animation") and ids[i] then
                    anim.AnimationId = "rbxassetid://" .. ids[i]
                end
            end
        end
    end
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        local current = hum:GetState()
        hum:ChangeState(Enum.HumanoidStateType.None)
        task.wait(0.05)
        hum:ChangeState(current)
    end
end

local function revertAnims()
    local char = LocalPlayer.Character
    if not char then return end
    local animate = char:FindFirstChild("Animate")
    if not animate then return end
    for name, savedList in pairs(DefaultAnims) do
        for _, saved in pairs(savedList) do
            if saved.obj and saved.obj.Parent then
                saved.obj.AnimationId = saved.id
            end
        end
    end
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        local current = hum:GetState()
        hum:ChangeState(Enum.HumanoidStateType.None)
        task.wait(0.05)
        hum:ChangeState(current)
    end
end

local ZombiePack = { idle = {616158929, 616160636}, walk = {616168032}, run = {616163682}, jump = {616161748}, fall = {616157476}, climb = {616156119} }
local NinjaPack = { idle = {656117400, 656118341}, walk = {656121766}, run = {656118852}, jump = {656117878}, fall = {656117076}, climb = {656114359}, swim = {656120073} }
local VampirePack = { idle = {1083445855, 1083450166}, walk = {1083473930}, run = {1083462077}, jump = {1083455352}, fall = {1083443587}, climb = {1083439238}, swim = {1083467611} }

addToggleFeature(Tab4Scroll, "1. Zombie Animation [On/Off]", function() setAnims(ZombiePack) end, function() revertAnims() end)
addToggleFeature(Tab4Scroll, "2. Ninja Animation [On/Off]", function() setAnims(NinjaPack) end, function() revertAnims() end)
addToggleFeature(Tab4Scroll, "3. Vampire Animation [On/Off]", function() setAnims(VampirePack) end, function() revertAnims() end)
