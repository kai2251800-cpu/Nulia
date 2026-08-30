-- POPHUB TROLL - V18 (FULL FEATURES + NEW TROLL, SUPPORT, AURA & SHADERS)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

task.spawn(function()
    task.wait(0.5)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "💩 PopHub Troll V18",
            Text = "Đã cập nhật đầy đủ tính năng mới! ✅",
            Duration = 3
        })
    end)
end)

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

-- NÚT TOGGLE 💩
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

-- GIAO DIỆN CHÍNH
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 540, 0, 360)
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
Title.Text = "💩 PopHub Troll V18 - Ultimate Edition"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
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

-- THANH TABS (5 Tabs)
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
    btn.Size = UDim2.new(0.19, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Tab1Btn = createTabButton("1. Troll")
local Tab2Btn = createTabButton("2. Aura")
local Tab3Btn = createTabButton("3. Hỗ Trợ")
local Tab4Btn = createTabButton("4. Anim")
local Tab5Btn = createTabButton("5. Shader")

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
local Tab5Scroll = createScrollingFrame()

Tab1Scroll.Visible = true 
Tab1Btn.BackgroundColor3 = Color3.fromRGB(60,60,60)

local function switchTab(showScroll, activeBtn)
    Tab1Scroll.Visible = false
    Tab2Scroll.Visible = false
    Tab3Scroll.Visible = false
    Tab4Scroll.Visible = false
    Tab5Scroll.Visible = false
    Tab1Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Tab2Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Tab3Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Tab4Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Tab5Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    showScroll.Visible = true 
    activeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
end

Tab1Btn.MouseButton1Click:Connect(function() switchTab(Tab1Scroll, Tab1Btn) end)
Tab2Btn.MouseButton1Click:Connect(function() switchTab(Tab2Scroll, Tab2Btn) end)
Tab3Btn.MouseButton1Click:Connect(function() switchTab(Tab3Scroll, Tab3Btn) end)
Tab4Btn.MouseButton1Click:Connect(function() switchTab(Tab4Scroll, Tab4Btn) end)
Tab5Btn.MouseButton1Click:Connect(function() switchTab(Tab5Scroll, Tab5Btn) end)

local function addToggleFeature(parent, text, callbackOn, callbackOff)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, -8, 0, 32)
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.65, 0, 1, 0) 
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1 
    lbl.Text = text 
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.SourceSans 
    lbl.TextSize = 12 
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
            pcall(function() if callbackOn then callbackOn() end end)
        else
            tBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            tBtn.Text = "OFF"
            pcall(function() if callbackOff then callbackOff() end end)
        end
    end)
end

-- TAB 1: TROLL
addToggleFeature(Tab1Scroll, "1. Fake Crash Game", function() 
    StarterGui:SetCore("SendNotification", {Title="Roblox Error", Text="Error Code: 277", Duration=5}) 
end)
addToggleFeature(Tab1Scroll, "2. Jumpscare Audio", function() 
    local s = Instance.new("Sound", workspace) s.SoundId = "rbxassetid://9061376381" s.Volume = 10 s.PlayOnRemove = true s:Destroy() 
end)
local flFrame
addToggleFeature(Tab1Scroll, "3. Flashbang Screen", function() 
    flFrame = Instance.new("Frame", ScreenGui) flFrame.Size = UDim2.new(10,0,10,0) flFrame.Position = UDim2.new(-5,0,-5,0) flFrame.BackgroundColor3 = Color3.new(1,1,1) flFrame.ZIndex = 1000 
end, function() 
    if flFrame then flFrame:Destroy() end 
end)
local bJumpConn
addToggleFeature(Tab1Scroll, "4. Bouncy Mode", function() 
    bJumpConn = RunService.RenderStepped:Connect(function() 
        local c = LocalPlayer.Character if c and c:FindFirstChild("Humanoid") then c.Humanoid.Jump = true end 
    end) 
end, function() 
    if bJumpConn then bJumpConn:Disconnect() end 
end)

-- TÍNH NĂNG MỚI TROLL: XOÁ VẬT THỂ (BÚA)
local hammerTool
addToggleFeature(Tab1Scroll, "5. Xoá vật thể (Búa phá huỷ)", function()
    hammerTool = Instance.new("Tool")
    hammerTool.Name = "Búa Xoá Vật Thể"
    hammerTool.RequiresHandle = false
    hammerTool.Activated:Connect(function()
        local mouse = LocalPlayer:GetMouse()
        if mouse.Target then
            mouse.Target:Destroy()
        end
    end)
    hammerTool.Parent = LocalPlayer.Backpack
end, function()
    if hammerTool then hammerTool:Destroy() hammerTool = nil end
end)

-- TÍNH NĂNG MỚI TROLL: FLING
local flingConn
addToggleFeature(Tab1Scroll, "6. Fling (Quăng quật)", function()
    flingConn = RunService.Stepped:Connect(function()
        local c = LocalPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.AssemblyAngularVelocity = Vector3.new(0, 50000, 0)
        end
    end)
end, function()
    if flingConn then flingConn:Disconnect() flingConn = nil end
end)

-- TÍNH NĂNG MỚI TROLL: BAY XUNG QUANH (ORBIT PLAYER)
local orbitTarget = nil
local orbitConn = nil
local function createDropdownUI(parent, titleText, onSelect)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -8, 0, 60)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -10, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, 5)
    lbl.BackgroundTransparency = 1
    lbl.Text = titleText
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local sf = Instance.new("ScrollingFrame", frame)
    sf.Size = UDim2.new(1, -10, 0, 30)
    sf.Position = UDim2.new(0, 5, 0, 25)
    sf.BackgroundTransparency = 1
    sf.CanvasSize = UDim2.new(0, 0, 0, 0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.X
    sf.ScrollBarThickness = 2
    
    local layout = Instance.new("UIListLayout", sf)
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    
    local function updateList()
        for _, child in ipairs(sf:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local btn = Instance.new("TextButton", sf)
                btn.Size = UDim2.new(0, 80, 1, 0)
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                btn.Text = p.Name
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 11
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
                btn.MouseButton1Click:Connect(function()
                    onSelect(p)
                end)
            end
        end
    end
    updateList()
    Players.PlayerAdded:Connect(updateList)
    Players.PlayerRemoving:Connect(updateList)
end

createDropdownUI(Tab1Scroll, "7. Bay xung quanh (Chọn mục tiêu):", function(player)
    orbitTarget = player
end)

addToggleFeature(Tab1Scroll, "Bật/Tắt Bay Xung Quanh", function()
    orbitConn = RunService.RenderStepped:Connect(function()
        if orbitTarget and orbitTarget.Character and orbitTarget.Character:FindFirstChild("HumanoidRootPart") then
            local c = LocalPlayer.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            if hrp then
                local targetHrp = orbitTarget.Character.HumanoidRootPart
                local angle = tick() * 5
                local offset = Vector3.new(math.cos(angle) * 8, 3, math.sin(angle) * 8)
                hrp.CFrame = CFrame.new(targetHrp.Position + offset, targetHrp.Position)
            end
        end
    end)
end, function()
    if orbitConn then orbitConn:Disconnect() orbitConn = nil end
end)


-- TAB 2: AURA
local smokeA, sparkA
addToggleFeature(Tab2Scroll, "1. Smoke Aura", function() 
    local c = LocalPlayer.Character
    local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")) 
    if t then smokeA = Instance.new("Smoke", t) smokeA.Size = 10 end 
end, function() 
    if smokeA then smokeA:Destroy() end 
end)
addToggleFeature(Tab2Scroll, "2. Sparkles Aura", function() 
    local c = LocalPlayer.Character
    local t = c and (c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")) 
    if t then sparkA = Instance.new("Sparkles", t) end 
end, function() 
    if sparkA then sparkA:Destroy() end 
end)
addToggleFeature(Tab2Scroll, "3. Big Head", function() 
    local c = LocalPlayer.Character
    local h = c and c:FindFirstChild("Head") 
    if h then h.Size = Vector3.new(4,4,4) if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(4,4,4) end end 
end, function() 
    local c = LocalPlayer.Character
    local h = c and c:FindFirstChild("Head") 
    if h then h.Size = Vector3.new(2,1,1) if h:FindFirstChild("Mesh") then h.Mesh.Scale = Vector3.new(1,1,1) end end 
end)

-- TÍNH NĂNG MỚI AURA
local lightningPart
addToggleFeature(Tab2Scroll, "4. Hiệu ứng sấm sét", function()
    local c = LocalPlayer.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp and not workspace:FindFirstChild("LightningAura") then
        lightningPart = Instance.new("Part", workspace)
        lightningPart.Name = "LightningAura"
        lightningPart.Transparency = 1
        lightningPart.Size = Vector3.new(1,1,1)
        lightningPart.Anchored = true
        local pe = Instance.new("ParticleEmitter", lightningPart)
        pe.Texture = "rbxassetid://1084225547"
        pe.Rate = 20
        pe.Speed = NumberRange.new(5, 10)
        task.spawn(function()
            while lightningPart and lightningPart.Parent do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then lightningPart.Position = root.Position end
                task.wait()
            end
        end)
    end
end, function()
    if lightningPart then lightningPart:Destroy() lightningPart = nil end
end)

local trailObj
addToggleFeature(Tab2Scroll, "5. Đường mòn", function()
    local c = LocalPlayer.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp and not hrp:FindFirstChild("CustomTrail") then
        local att0 = Instance.new("Attachment", hrp)
        att0.Position = Vector3.new(0, 1, 0)
        local att1 = Instance.new("Attachment", hrp)
        att1.Position = Vector3.new(0, -1, 0)
        trailObj = Instance.new("Trail", hrp)
        trailObj.Name = "CustomTrail"
        trailObj.Attachment0 = att0
        trailObj.Attachment1 = att1
        trailObj.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
        trailObj.Lifetime = 0.8
    end
end, function()
    local c = LocalPlayer.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp then
        local t = hrp:FindFirstChild("CustomTrail")
        if t then t:Destroy() end
    end
end)

local tornadoPart
addToggleFeature(Tab2Scroll, "6. Lốc xoáy nhỏ xung quanh", function()
    local c = LocalPlayer.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp and not workspace:FindFirstChild("MiniTornado") then
        tornadoPart = Instance.new("Part", workspace)
        tornadoPart.Name = "MiniTornado"
        tornadoPart.Transparency = 1
        tornadoPart.Size = Vector3.new(1,1,1)
        tornadoPart.Anchored = true
        local pe = Instance.new("ParticleEmitter", tornadoPart)
        pe.Texture = "rbxassetid://243411445"
        pe.Rate = 100
        pe.Speed = NumberRange.new(15, 20)
        pe.VelocitySpread = 30
        task.spawn(function()
            while tornadoPart and tornadoPart.Parent do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then tornadoPart.Position = root.Position end
                task.wait()
            end
        end)
    end
end, function()
    if tornadoPart then tornadoPart:Destroy() tornadoPart = nil end
end)

local shadowEffect
addToggleFeature(Tab2Scroll, "7. Bóng tối", function()
    local c = LocalPlayer.Character
    if c then
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Color = Color3.fromRGB(20, 20, 20)
            end
        end
    end
end, function()
    -- Revert handled on reset or ignored
end)

local rainbowConn
addToggleFeature(Tab2Scroll, "8. Skin cầu vồng", function()
    rainbowConn = RunService.RenderStepped:Connect(function()
        local c = LocalPlayer.Character
        if c then
            local hue = tick() % 5 / 5
            local col = Color3.fromHSV(hue, 1, 1)
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Color = col
                end
            end
        end
    end)
end, function()
    if rainbowConn then rainbowConn:Disconnect() rainbowConn = nil end
end)

local orbsPart
addToggleFeature(Tab2Scroll, "9. Quả cầu ma thuật (3 quả)", function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and not workspace:FindFirstChild("MagicOrbs") then
        orbsPart = Instance.new("Part", workspace)
        orbsPart.Name = "MagicOrbs"
        orbsPart.Transparency = 1
        orbsPart.Size = Vector3.new(1,1,1)
        orbsPart.Anchored = true
        for i = 1, 3 do
            local p = Instance.new("Part", orbsPart)
            p.Size = Vector3.new(1,1,1)
            p.Shape = Enum.PartType.Ball
            p.Material = Enum.Material.Neon
            p.Color = Color3.fromRGB(255, 0, 255)
            p.Anchored = true
            p.CanCollide = false
        end
        task.spawn(function()
            while orbsPart and orbsPart.Parent do
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    orbsPart.Position = root.Position
                    local children = orbsPart:GetChildren()
                    for index, child in ipairs(children) do
                        if child:IsA("BasePart") then
                            local angle = tick() * 3 + (index * (math.pi * 2 / 3))
                            child.Position = root.Position + Vector3.new(math.cos(angle) * 4, math.sin(tick() * 2) * 1, math.sin(angle) * 4)
                        end
                    end
                end
                task.wait()
            end
        end)
    end
end, function()
    if orbsPart then orbsPart:Destroy() orbsPart = nil end
end)


-- TAB 3: HỖ TRỢ
local ncConn
addToggleFeature(Tab3Scroll, "1. Noclip (Xuyên tường)", function() 
    ncConn = RunService.Stepped:Connect(function() 
        local c = LocalPlayer.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end 
    end) 
end, function() 
    if ncConn then ncConn:Disconnect() end 
end)

addToggleFeature(Tab3Scroll, "2. Air Platform (Tạo sàn)", function() 
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then 
        local p = Instance.new("Part", workspace) 
        p.Size = Vector3.new(5,1,5) 
        p.CFrame = hrp.CFrame - Vector3.new(0,3,0) 
        p.Anchored = true 
        p.Transparency = 0.5 
        p.Name = "AirPlatform" 
    end 
end, function() 
    local p = workspace:FindFirstChild("AirPlatform") 
    if p then p:Destroy() end 
end)

addToggleFeature(Tab3Scroll, "3. Infinite Jump", function() 
    _G.InfJ = true 
    UserInputService.JumpRequest:Connect(function() 
        if _G.InfJ then 
            local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") 
            if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end 
        end 
    end) 
end, function() 
    _G.InfJ = false 
end)

addToggleFeature(Tab3Scroll, "4. Fullbright", function() 
    Lighting.Brightness = 2 
    Lighting.ClockTime = 14 
    Lighting.FogEnd = 100000 
end)

addToggleFeature(Tab3Scroll, "5. Click TP (Ctrl+Click)", function() 
    local m = LocalPlayer:GetMouse() 
    _G.CTP = true 
    m.Button1Down:Connect(function() 
        if _G.CTP and m.Target and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then 
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
            if hrp then hrp.CFrame = CFrame.new(m.Hit.Position + Vector3.new(0,3,0)) end 
        end 
    end) 
end, function() 
    _G.CTP = false 
end)

-- TÍNH NĂNG MỚI HỖ TRỢ: ĐỊNH VỊ NGƯỜI CHƠI (ESP)
local espEnabled = false
addToggleFeature(Tab3Scroll, "6. Định vị người chơi (ESP)", function()
    espEnabled = true
    task.spawn(function()
        while espEnabled do
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    if not p.Character.Head:FindFirstChild("ESPBox") then
                        local bb = Instance.new("BillboardGui", p.Character.Head)
                        bb.Name = "ESPBox"
                        bb.Size = UDim2.new(0, 40, 0, 40)
                        bb.AlwaysOnTop = true
                        local f = Instance.new("Frame", bb)
                        f.Size = UDim2.new(1,0,1,0)
                        f.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        f.BackgroundTransparency = 0.5
                    end
                end
            end
            task.wait(1)
        end
    end)
end, function()
    espEnabled = false
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            local esp = p.Character.Head:FindFirstChild("ESPBox")
            if esp then esp:Destroy() end
        end
    end
end)

-- FLY V2
local flyV2Conn
local flySpeed = 50
addToggleFeature(Tab3Scroll, "7. Fly v2 (Có tốc độ)", function()
    local c = LocalPlayer.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyV2Conn = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            local vel = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.CFrame.RightVector end
            bv.Velocity = vel * flySpeed
        end)
    end
end, function()
    if flyV2Conn then flyV2Conn:Disconnect() flyV2Conn = nil end
    local c = LocalPlayer.Character
    local hrp = c and c:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = hrp:FindFirstChild("FlyVelocity")
        if bv then bv:Destroy() end
    end
end)

-- KHOẢNG CÁCH M & AVATAR
local distEspEnabled = false
addToggleFeature(Tab3Scroll, "8. Khoảng cách M & Avatar", function()
    distEspEnabled = true
    task.spawn(function()
        while distEspEnabled do
            local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if localHrp then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        local head = p.Character.Head
                        local bb = head:FindFirstChild("DistEspGui")
                        if not bb then
                            bb = Instance.new("BillboardGui", head)
                            bb.Name = "DistEspGui"
                            bb.Size = UDim2.new(0, 100, 0, 50)
                            bb.AlwaysOnTop = true
                            bb.StudsOffset = Vector3.new(0, 2.5, 0)
                            
                            local img = Instance.new("ImageLabel", bb)
                            img.Name = "Avatar"
                            img.Size = UDim2.new(0, 30, 0, 30)
                            img.Position = UDim2.new(0.5, -15, 0, 0)
                            img.BackgroundTransparency = 1
                            img.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size42x42)
                            
                            local lbl = Instance.new("TextLabel", bb)
                            lbl.Name = "Text"
                            lbl.Size = UDim2.new(1, 0, 0, 20)
                            lbl.Position = UDim2.new(0, 0, 0, 30)
                            lbl.BackgroundTransparency = 1
                            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                            lbl.TextSize = 12
                            lbl.Font = Enum.Font.SourceSansBold
                        end
                        local pDist = (localHrp.Position - head.Position).Magnitude
                        local bbGui = head:FindFirstChild("DistEspGui")
                        if bbGui then
                            local lbl = bbGui:FindFirstChild("Text") if lbl then lbl.Text = math.floor(pDist) .. "m" end
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end, function()
    distEspEnabled = false
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            local d = p.Character.Head:FindFirstChild("DistEspGui")
            if d then d:Destroy() end
        end
    end
end)

-- TP TO PLAYER UI
createDropdownUI(Tab3Scroll, "9. Tp đến người chơi:", function(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

-- XOÁ ĐẦU & KHÔNG CHÂN (1 BÊN CHÂN PHẢI)
addToggleFeature(Tab3Scroll, "10. Xoá đầu & không chân phải", function()
    local c = LocalPlayer.Character
    if c then
        local head = c:FindFirstChild("Head")
        if head then head:Destroy() end
        local rLeg = c:FindFirstChild("Right Leg") or c:FindFirstChild("RightLowerLeg")
        if rLeg then rLeg:Destroy() end
    end
end, function()
    -- Rejoining or respawning restores it natively
end)


-- TAB 4: ANIMATION PACK
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
                    if anim:IsA("Animation") then table.insert(DefaultAnims[name], {obj = anim, id = anim.AnimationId}) end
                end
            end
        end
    end
end

local function setAnims(animPack)
    pcall(function()
        local char = LocalPlayer.Character if not char then return end
        saveDefaultAnims(char)
        local animate = char:FindFirstChild("Animate") if not animate then return end
        
        for name, ids in pairs(animPack) do
            local folder = animate:FindFirstChild(name)
            if folder then
                local anims = folder:GetChildren()
                local idIndex = 1
                for _, anim in pairs(anims) do
                    if anim:IsA("Animation") then
                        anim.AnimationId = "rbxassetid://" .. ids[idIndex]
                        idIndex = idIndex + 1
                        if idIndex > #ids then idIndex = 1 end
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
    end)
end

local function revertAnims()
    pcall(function()
        local char = LocalPlayer.Character if not char then return end
        local animate = char:FindFirstChild("Animate") if not animate then return end
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
    end)
end

local OldschoolPack = { idle = {531982855, 531983979}, walk = {531984715}, run = {531984337}, jump = {531983578}, fall = {531982578}, climb = {531983196} }
local ZombiePack = { idle = {616158929, 616160636}, walk = {616168032}, run = {616163682}, jump = {616161748}, fall = {616157476}, climb = {616156119} }
local NinjaPack = { idle = {656117400, 656118341}, walk = {656121766}, run = {656118852}, jump = {656117878}, fall = {656117076}, climb = {656114359}, swim = {656120073} }
local VampirePack = { idle = {1083445855, 1083450166}, walk = {1083473930}, run = {1083462077}, jump = {1083455352}, fall = {1083443587}, climb = {1083439238}, swim = {1083467611} }

addToggleFeature(Tab4Scroll, "1. Oldschool Anim", function() setAnims(OldschoolPack) end, function() revertAnims() end)
addToggleFeature(Tab4Scroll, "2. Zombie Anim", function() setAnims(ZombiePack) end, function() revertAnims() end)
addToggleFeature(Tab4Scroll, "3. Ninja Anim", function() setAnims(NinjaPack) end, function() revertAnims() end)
addToggleFeature(Tab4Scroll, "4. Vampire Anim", function() setAnims(VampirePack) end, function() revertAnims() end)
-- TAB 5: SHADER & THỜI TIẾT MỚI
addToggleFeature(Tab5Scroll, "1. Nhanh (Giảm đồ họa chi tiết)", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        end
    end
end)

addToggleFeature(Tab5Scroll, "2. Đơn giản (Xoá sạch đồ họa)", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.Neon
            obj.Color = Color3.fromRGB(240, 240, 240)
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end
end)

local stormPart
addToggleFeature(Tab5Scroll, "3. Bão (Mưa, gió, nền ướt)", function()
    Lighting.ClockTime = 0
    Lighting.Brightness = 0.5
    Lighting.FogEnd = 400
    Lighting.FogColor = Color3.fromRGB(50, 50, 60)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.Glass
            obj.Reflectance = 0.3
        end
    end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and not workspace:FindFirstChild("StormPart") then
        stormPart = Instance.new("Part", workspace)
        stormPart.Name = "StormPart"
        stormPart.Size = Vector3.new(1,1,1)
        stormPart.Transparency = 1
        stormPart.Anchored = true
        local emitter = Instance.new("ParticleEmitter", stormPart)
        emitter.Texture = "rbxassetid://243411445"
        emitter.Rate = 800
        emitter.Speed = NumberRange.new(60, 80)
        emitter.VelocitySpread = 15
        task.spawn(function()
            while stormPart and stormPart.Parent do
                local c = LocalPlayer.Character
                local root = c and c:FindFirstChild("HumanoidRootPart")
                if root then stormPart.Position = root.Position + Vector3.new(0, 30, 0) end
                task.wait()
            end
        end)
    end
end, function()
    Lighting.FogEnd = 100000
    if stormPart then stormPart:Destroy() stormPart = nil end
end)

local windPart
addToggleFeature(Tab5Scroll, "4. Gió (Mây đen, hạt bụi)", function()
    Lighting.ClockTime = 12
    Lighting.Brightness = 1.2
    Lighting.FogEnd = 1000
    Lighting.FogColor = Color3.fromRGB(100, 100, 100)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and not workspace:FindFirstChild("WindPart") then
        windPart = Instance.new("Part", workspace)
        windPart.Name = "WindPart"
        windPart.Size = Vector3.new(1,1,1)
        windPart.Transparency = 1
        windPart.Anchored = true
        local emitter = Instance.new("ParticleEmitter", windPart)
        emitter.Texture = "rbxassetid://258127463"
        emitter.Rate = 150
        emitter.Speed = NumberRange.new(20, 40)
        emitter.VelocitySpread = 50
        task.spawn(function()
            while windPart and windPart.Parent do
                local c = LocalPlayer.Character
                local root = c and c:FindFirstChild("HumanoidRootPart")
                if root then windPart.Position = root.Position + Vector3.new(0, 15, 0) end
                task.wait()
            end
        end)
    end
end, function()
    Lighting.FogEnd = 100000
    if windPart then windPart:Destroy() windPart = nil end
end)

local snowPart
addToggleFeature(Tab5Scroll, "5. Mùa đông (Tuyết rơi, phủ tuyết)", function()
    Lighting.ClockTime = 14
    Lighting.Brightness = 1.5
    Lighting.FogEnd = 2000
    Lighting.FogColor = Color3.fromRGB(220, 230, 240)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Color = Color3.fromRGB(240, 245, 255)
            obj.Material = Enum.Material.SmoothPlastic
        end
    end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and not workspace:FindFirstChild("SnowPart") then
        snowPart = Instance.new("Part", workspace)
        snowPart.Name = "SnowPart"
        snowPart.Size = Vector3.new(1,1,1)
        snowPart.Transparency = 1
        snowPart.Anchored = true
        local emitter = Instance.new("ParticleEmitter", snowPart)
        emitter.Texture = "rbxassetid://258127463"
        emitter.Rate = 400
        emitter.Speed = NumberRange.new(5, 10)
        emitter.VelocitySpread = 25
        emitter.Size = NumberSequence.new(0.4)
        task.spawn(function()
            while snowPart and snowPart.Parent do
                local c = LocalPlayer.Character
                local root = c and c:FindFirstChild("HumanoidRootPart")
                if root then snowPart.Position = root.Position + Vector3.new(0, 25, 0) end
                task.wait()
            end
        end)
    end
end, function()
    Lighting.FogEnd = 100000
    if snowPart then snowPart:Destroy() snowPart = nil end
end)

-- SHADERS MỚI THEO YÊU CẦU:
addToggleFeature(Tab5Scroll, "6. Nắng lung linh", function()
    Lighting.ClockTime = 13
    Lighting.Brightness = 3.0
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 180, 120)
    Lighting.GlobalShadows = true
end, function()
    Lighting.Brightness = 2
end)

addToggleFeature(Tab5Scroll, "7. Tạnh mưa (U ám, nền ướt)", function()
    Lighting.ClockTime = 9
    Lighting.Brightness = 1.0
    Lighting.FogEnd = 600
    Lighting.FogColor = Color3.fromRGB(110, 110, 120)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0.4
        end
    end
end, function()
    Lighting.FogEnd = 100000
end)

addToggleFeature(Tab5Scroll, "8. Kinh dị (Góc nhìn 1, trăng máu)", function()
    Lighting.ClockTime = 0
    Lighting.Brightness = 0.2
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 0, 0)
    Lighting.GlobalShadows = true
    LocalPlayer.CameraMaxZoomDistance = 0.5
    LocalPlayer.CameraMinZoomDistance = 0.5
end, function()
    LocalPlayer.CameraMaxZoomDistance = 400
    LocalPlayer.CameraMinZoomDistance = 0.5
    Lighting.Brightness = 2
end)

addToggleFeature(Tab5Scroll, "9. Sáng sớm", function()
    Lighting.ClockTime = 6
    Lighting.Brightness = 2.0
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 200, 150)
    Lighting.GlobalShadows = true
end, function()
    Lighting.Brightness = 2
end)

addToggleFeature(Tab5Scroll, "10. Cyberpunk Neon (Đổ bóng)", function()
    Lighting.ClockTime = 0
    Lighting.Brightness = 2.0
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(80, 0, 120)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.Neon
            obj.Color = Color3.fromRGB(0, 255, 200)
            obj.Reflectance = 0.5
        end
    end
end, function()
    Lighting.ClockTime = 14
    Lighting.Brightness = 2
end)
