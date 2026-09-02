-- [[ LUNASPACE HUB V2 - FULL UPDATE ]] --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

local guiName = "LunaSpaceHub_V2"
local parentGui = RunService:IsStudio() and player.PlayerGui or (CoreGui:FindFirstChild("RobloxGui") or player:WaitForChild("PlayerGui"))
if parentGui:FindFirstChild(guiName) then
    parentGui[guiName]:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = guiName
screenGui.ResetOnSpawn = false
screenGui.Parent = parentGui

-- ==========================================
-- 1. HỆ THỐNG MÀU SẮC & CẦU VỒNG ĐỘNG
-- ==========================================
local rainbowGradients = {}
local function addRainbow(guiObject)
    local grad = Instance.new("UIGradient")
    grad.Parent = guiObject
    table.insert(rainbowGradients, grad)
    return grad
end

RunService.RenderStepped:Connect(function()
    local t = tick() * 1.5
    local seq = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHSV((t) % 1, 1, 1)),
        ColorSequenceKeypoint.new(0.25, Color3.fromHSV((t + 0.25) % 1, 1, 1)),
        ColorSequenceKeypoint.new(0.5, Color3.fromHSV((t + 0.5) % 1, 1, 1)),
        ColorSequenceKeypoint.new(0.75, Color3.fromHSV((t + 0.75) % 1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 1) % 1, 1, 1)),
    })
    for _, grad in ipairs(rainbowGradients) do
        if grad and grad.Parent and grad.Color ~= seq then
            grad.Color = seq
        end
    end
end)

-- ==========================================
-- 2. CUTSCENE INTRO LOADING
-- ==========================================
local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.new(1, 0, 1, 0)
introFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
introFrame.ZIndex = 100
introFrame.Parent = screenGui

local bgReflect = Instance.new("Frame")
bgReflect.Size = UDim2.new(1, 0, 1, 0)
bgReflect.BackgroundTransparency = 0.85
bgReflect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bgReflect.ZIndex = 101
bgReflect.Parent = introFrame
addRainbow(bgReflect)

local introText = Instance.new("TextLabel")
introText.Size = UDim2.new(1, 0, 0, 80)
introText.Position = UDim2.new(0, 0, 0.35, -40)
introText.BackgroundTransparency = 1
introText.Font = Enum.Font.Arcade
introText.TextSize = 44
introText.Text = "LunaSpace Hub"
introText.TextColor3 = Color3.fromRGB(255, 255, 255)
introText.ZIndex = 102
introText.Parent = introFrame
addRainbow(introText)

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0, 40)
loadingText.Position = UDim2.new(0, 0, 0.5, 0)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.SourceSansBold
loadingText.TextSize = 22
loadingText.TextColor3 = Color3.fromRGB(200, 200, 200)
loadingText.Text = "Đang chuẩn bị..."
loadingText.ZIndex = 102
loadingText.Parent = introFrame

local loadBarBg = Instance.new("Frame")
loadBarBg.Size = UDim2.new(0, 300, 0, 12)
loadBarBg.Position = UDim2.new(0.5, -150, 0.6, 0)
loadBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
loadBarBg.ZIndex = 102
loadBarBg.Parent = introFrame
local lbgc = Instance.new("UICorner") lbgc.CornerRadius = UDim.new(1, 0) lbgc.Parent = loadBarBg

local loadBarFill = Instance.new("Frame")
loadBarFill.Size = UDim2.new(0, 0, 1, 0)
loadBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
loadBarFill.ZIndex = 103
loadBarFill.Parent = loadBarBg
local lbfc = Instance.new("UICorner") lbfc.CornerRadius = UDim.new(1, 0) lbfc.Parent = loadBarFill
addRainbow(loadBarFill)

local percentLbl = Instance.new("TextLabel")
percentLbl.Size = UDim2.new(1, 0, 0, 30)
percentLbl.Position = UDim2.new(0, 0, 0.65, 0)
percentLbl.BackgroundTransparency = 1
percentLbl.Font = Enum.Font.SourceSansBold
percentLbl.TextSize = 18
percentLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLbl.Text = "0%"
percentLbl.ZIndex = 102
percentLbl.Parent = introFrame

-- ==========================================
-- 3. GIAO DIỆN CHÍNH & ICON LUNA
-- ==========================================
local lunaIcon = Instance.new("TextButton")
lunaIcon.Size = UDim2.new(0, 60, 0, 60)
lunaIcon.Position = UDim2.new(0.02, 0, 0.3, 0)
lunaIcon.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
lunaIcon.Font = Enum.Font.Arcade
lunaIcon.TextSize = 18
lunaIcon.Text = "Luna"
lunaIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
lunaIcon.Visible = false
lunaIcon.Active = true
lunaIcon.Draggable = true
lunaIcon.Parent = screenGui
local iconCorner = Instance.new("UICorner") iconCorner.CornerRadius = UDim.new(0, 14) iconCorner.Parent = lunaIcon
addRainbow(lunaIcon)

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 460)
mainFrame.Position = UDim2.new(0.12, 0, 0.18, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
local mainCorner = Instance.new("UICorner") mainCorner.CornerRadius = UDim.new(0, 10) mainCorner.Parent = mainFrame

lunaIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Hệ thống Tabs (4 Tabs: Chức năng, Teleplayer, Setting, Discord)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 0, 40)
tabContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
tabContainer.Parent = mainFrame
local tcCorner = Instance.new("UICorner") tcCorner.CornerRadius = UDim.new(0, 10) tcCorner.Parent = tabContainer

local function createTabBtn(name, posX, sizeX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(sizeX, 0, 1, 0)
    btn.Position = UDim2.new(posX, 0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = tabContainer
    return btn
end

local tab1Btn = createTabBtn("Chức năng", 0, 0.28)
local tab2Btn = createTabBtn("Teleplayer", 0.28, 0.25)
local tab3Btn = createTabBtn("Setting", 0.53, 0.22)
local tab4Btn = createTabBtn("Discord", 0.75, 0.25)

local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, 0, 1, -40)
contentContainer.Position = UDim2.new(0, 0, 0, 40)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    
    local pad = Instance.new("UIPadding", page)
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingLeft = UDim.new(0, 12)
    page.Parent = contentContainer
    return page
end

local page1 = createPage() page1.Visible = true
local page2 = createPage()
local page3 = createPage()
local page4 = createPage()

tab1Btn.MouseButton1Click:Connect(function() page1.Visible = true; page2.Visible = false; page3.Visible = false; page4.Visible = false end)
tab2Btn.MouseButton1Click:Connect(function() page1.Visible = false; page2.Visible = true; page3.Visible = false; page4.Visible = false end)
tab3Btn.MouseButton1Click:Connect(function() page1.Visible = false; page2.Visible = false; page3.Visible = true; page4.Visible = false end)
tab4Btn.MouseButton1Click:Connect(function() page1.Visible = false; page2.Visible = false; page3.Visible = false; page4.Visible = true end)

local function sendNotify(msg)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {Title = "LunaSpace Hub", Text = msg, Duration = 3})
    end)
end

-- ==========================================
-- 4. GIAO DIỆN HỖ TRỢ (UI HELPERS)
-- ==========================================
local function createInputToggle(parent, text, defaultVal, toggleCallback, valCallback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 330, 0, 36)
    f.BackgroundTransparency = 1
    f.Parent = parent
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 230, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = text .. ": OFF"
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Parent = f
    local c1 = Instance.new("UICorner") c1.CornerRadius = UDim.new(0, 6) c1.Parent = btn

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 90, 1, 0)
    box.Position = UDim2.new(0, 240, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Text = tostring(defaultVal)
    box.Font = Enum.Font.SourceSansBold
    box.TextSize = 14
    box.Parent = f
    local c2 = Instance.new("UICorner") c2.CornerRadius = UDim.new(0, 6) c2.Parent = box

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and ": ON" or ": OFF")
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(30, 30, 40)
        toggleCallback(active, tonumber(box.Text) or defaultVal)
    end)
    box.FocusLost:Connect(function() valCallback(tonumber(box.Text) or defaultVal) end)
    return btn
end

local function createToggle(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 330, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = text .. ": OFF"
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Parent = parent
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and ": ON" or ": OFF")
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(30, 30, 40)
        callback(active)
    end)
    return btn
end

-- ==========================================
-- 5. CÁC TÍNH NĂNG CŨ & MỚI
-- ==========================================

-- 1. Tốc độ
createInputToggle(page1, "Tốc độ", 16,
    function(state, val)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = state and val or 16
        end
    end,
    function(val)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = val
        end
    end
)

-- 2. Jump power
createInputToggle(page1, "Jump power", 50,
    function(state, val)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.UseJumpPower = true
            player.Character.Humanoid.JumpPower = state and val or 50
        end
    end,
    function(val)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = val
        end
    end
)

-- 3. Đi xuyên tường (NoClip V1)
local noclipConnection
createToggle(page1, "Đi xuyên tường", function(state)
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
    end
end)

-- 4. X-Ray
createToggle(page1, "X-Ray (Nhìn xuyên tường)", function(state)
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(player.Character) then
            part.LocalTransparencyModifier = state and 0.6 or 0
        end
    end
end)

-- 5. Định vị (ESP Xanh lá mặc định, đổi màu theo setting)
local espHighlights = {}
local currentEspColor = Color3.fromRGB(0, 255, 0)
createToggle(page1, "Định vị (ESP)", function(state)
    if state then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local hl = Instance.new("Highlight")
                hl.FillColor = currentEspColor
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.Parent = p.Character
                espHighlights[p] = hl
            end
        end
    else
        for _, hl in pairs(espHighlights) do hl:Destroy() end
        espHighlights = {}
    end
end)

-- 6. Fly V1
local flySpeed = 16
local flyConn, upConn, downConn
local flyControlGui = nil

local function toggleFlyV1(state)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")

    if state then
        humanoid.PlatformStand = true
        local bv = Instance.new("BodyVelocity")
        bv.Name = "LunaFlyVelocity"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = rootPart

        local bg = Instance.new("BodyGyro")
        bg.Name = "LunaFlyGyro"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = workspace.CurrentCamera.CFrame
        bg.Parent = rootPart

        flyConn = RunService.RenderStepped:Connect(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
            bv.Velocity = moveDir * flySpeed
            bg.CFrame = cam.CFrame
        end)

        flyControlGui = Instance.new("Frame")
        flyControlGui.Size = UDim2.new(0, 110, 0, 110)
        flyControlGui.Position = UDim2.new(0.8, 0, 0.4, 0)
        flyControlGui.BackgroundTransparency = 0.5
        flyControlGui.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        flyControlGui.Active = true
        flyControlGui.Draggable = true
        flyControlGui.Parent = screenGui
        local fcCorner = Instance.new("UICorner") fcCorner.CornerRadius = UDim.new(1, 0) fcCorner.Parent = flyControlGui

        local btnUp = Instance.new("TextButton") btnUp.Size = UDim2.new(0, 50, 0, 50) btnUp.Position = UDim2.new(0.5, -25, 0, 5) btnUp.Text = "⬆️" btnUp.TextSize = 22 btnUp.BackgroundColor3 = Color3.fromRGB(0, 170, 127) btnUp.Parent = flyControlGui
        local buc = Instance.new("UICorner") buc.CornerRadius = UDim.new(1, 0) buc.Parent = btnUp
        local btnDown = Instance.new("TextButton") btnDown.Size = UDim2.new(0, 50, 0, 50) btnDown.Position = UDim2.new(0.5, -25, 0, 55) btnDown.Text = "⬇️" btnDown.TextSize = 22 btnDown.BackgroundColor3 = Color3.fromRGB(200, 50, 50) btnDown.Parent = flyControlGui
        local bdc = Instance.new("UICorner") bdc.CornerRadius = UDim.new(1, 0) bdc.Parent = btnDown

        local isUp, isDown = false, false
        btnUp.MouseButton1Down:Connect(function() isUp = true end) btnUp.MouseButton1Up:Connect(function() isUp = false end)
        btnDown.MouseButton1Down:Connect(function() isDown = true end) btnDown.MouseButton1Up:Connect(function() isDown = false end)

        upConn = RunService.RenderStepped:Connect(function()
            if rootPart and rootPart:FindFirstChild("LunaFlyVelocity") then
                if isUp then rootPart.Velocity = Vector3.new(0, flySpeed, 0) end
                if isDown then rootPart.Velocity = Vector3.new(0, -flySpeed, 0) end
            end
        end)
    else
        if flyConn then flyConn:Disconnect() end
        if upConn then upConn:Disconnect() end
        if flyControlGui then flyControlGui:Destroy() end
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(char.HumanoidRootPart:GetChildren()) do
                if v.Name == "LunaFlyVelocity" or v.Name == "LunaFlyGyro" then v:Destroy() end
            end
            if humanoid then humanoid.PlatformStand = false end
        end
    end
end
createInputToggle(page1, "Fly v1", 16, function(state, val) flySpeed = val toggleFlyV1(state) end, function(val) flySpeed = val end)

-- 6.1 Fly V2 (Bay xuyên tường)
local flyV2Conn, flyV2UpConn, flyV2Gui
local function toggleFlyV2(state)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")

    if state then
        humanoid.PlatformStand = true
        local bv = Instance.new("BodyVelocity")
        bv.Name = "LunaFlyV2Vel"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = rootPart

        local bg = Instance.new("BodyGyro")
        bg.Name = "LunaFlyV2Gyro"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = workspace.CurrentCamera.CFrame
        bg.Parent = rootPart

        -- Kết hợp xuyên tường khi bay V2
        flyV2Conn = RunService.RenderStepped:Connect(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            for _, p in pairs(player.Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
            bv.Velocity = moveDir * flySpeed
            bg.CFrame = cam.CFrame
        end)

        flyV2Gui = Instance.new("Frame")
        flyV2Gui.Size = UDim2.new(0, 110, 0, 110)
        flyV2Gui.Position = UDim2.new(0.8, 0, 0.55, 0)
        flyV2Gui.BackgroundTransparency = 0.5
        flyV2Gui.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        flyV2Gui.Active = true
        flyV2Gui.Draggable = true
        flyV2Gui.Parent = screenGui
        local fcCorner = Instance.new("UICorner") fcCorner.CornerRadius = UDim.new(1, 0) fcCorner.Parent = flyV2Gui

        local btnUp = Instance.new("TextButton") btnUp.Size = UDim2.new(0, 50, 0, 50) btnUp.Position = UDim2.new(0.5, -25, 0, 5) btnUp.Text = "⬆️" btnUp.TextSize = 22 btnUp.BackgroundColor3 = Color3.fromRGB(0, 170, 127) btnUp.Parent = flyV2Gui
        local buc = Instance.new("UICorner") buc.CornerRadius = UDim.new(1, 0) buc.Parent = btnUp
        local btnDown = Instance.new("TextButton") btnDown.Size = UDim2.new(0, 50, 0, 50) btnDown.Position = UDim2.new(0.5, -25, 0, 55) btnDown.Text = "⬇️" btnDown.TextSize = 22 btnDown.BackgroundColor3 = Color3.fromRGB(200, 50, 50) btnDown.Parent = flyV2Gui
        local bdc = Instance.new("UICorner") bdc.CornerRadius = UDim.new(1, 0) bdc.Parent = btnDown

        local isUp, isDown = false, false
        btnUp.MouseButton1Down:Connect(function() isUp = true end) btnUp.MouseButton1Up:Connect(function() isUp = false end)
        btnDown.MouseButton1Down:Connect(function() isDown = true end) btnDown.MouseButton1Up:Connect(function() isDown = false end)

        flyV2UpConn = RunService.RenderStepped:Connect(function()
            if rootPart and rootPart:FindFirstChild("LunaFlyV2Vel") then
                if isUp then rootPart.Velocity = Vector3.new(0, flySpeed, 0) end
                if isDown then rootPart.Velocity = Vector3.new(0, -flySpeed, 0) end
            end
        end)
    else
        if flyV2Conn then flyV2Conn:Disconnect() end
        if flyV2UpConn then flyV2UpConn:Disconnect() end
        if flyV2Gui then flyV2Gui::Destroy() end
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(char.HumanoidRootPart:GetChildren()) do
                if v.Name == "LunaFlyV2Vel" or v.Name == "LunaFlyV2Gyro" then v:Destroy() end
            end
            if humanoid then humanoid.PlatformStand = false end
        end
    end
end
createInputToggle(page1, "Fly v2 (Xuyên tường)", 16, function(state, val) flySpeed = val toggleFlyV2(state) end, function(val) flySpeed = val val = flySpeed end)

-- 6.2 ZoomPov (- & +)
local povFrame = Instance.new("Frame")
povFrame.Size = UDim2.new(0, 330, 0, 40)
povFrame.BackgroundTransparency = 1
povFrame.Parent = page1

local povLabel = Instance.new("TextLabel")
povLabel.Size = UDim2.new(0, 150, 1, 0)
povLabel.BackgroundTransparency = 1
povLabel.Text = "ZoomPov (Góc nhìn)"
povLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
povLabel.Font = Enum.Font.SourceSansBold
povLabel.TextSize = 14
povLabel.Parent = povFrame

local zoomMinus = Instance.new("TextButton")
zoomMinus.Size = UDim2.new(0, 85, 1, 0)
zoomMinus.Position = UDim2.new(0, 155, 0, 0)
zoomMinus.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
zoomMinus.Text = "- Thu Nhỏ"
zoomMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
zoomMinus.Font = Enum.Font.SourceSansBold
zoomMinus.TextSize = 13
zoomMinus.Parent = povFrame
local zmC = Instance.new("UICorner") zmC.CornerRadius = UDim.new(0, 6) zmC.Parent = zoomMinus

local zoomPlus = Instance.new("TextButton")
zoomPlus.Size = UDim2.new(0, 85, 1, 0)
zoomPlus.Position = UDim2.new(0, 245, 0, 0)
zoomPlus.BackgroundColor3 = Color3.fromRGB(30, 40, 30)
zoomPlus.Text = "+ Mở Rộng"
zoomPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
zoomPlus.Font = Enum.Font.SourceSansBold
zoomPlus.TextSize = 13
zoomPlus.Parent = povFrame
local zpC = Instance.new("UICorner") zpC.CornerRadius = UDim.new(0, 6) zpC.Parent = zoomPlus

zoomMinus.MouseButton1Click:Connect(function()
    workspace.CurrentCamera.FieldOfView = math.clamp(workspace.CurrentCamera.FieldOfView - 10, 20, 120)
end)
zoomPlus.MouseButton1Click:Connect(function()
    workspace.CurrentCamera.FieldOfView = math.clamp(workspace.CurrentCamera.FieldOfView + 10, 20, 120)
end)
-- 6.3 Đường mòn (Trail)
local activeTrail = nil
createToggle(page1, "Đường mòn (Trail)", function(state)
    if state then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local att0 = Instance.new("Attachment", hrp) att0.Position = Vector3.new(0, -1, 0)
            local att1 = Instance.new("Attachment", hrp) att1.Position = Vector3.new(0, 1, 0)
            local trail = Instance.new("Trail")
            trail.Attachment0 = att0
            trail.Attachment1 = att1
            trail.Lifetime = 0.5
            trail.MinLength = 0
            trail.Parent = hrp
            activeTrail = trail
        end
    else
        if activeTrail then
            local parentPart = activeTrail.Parent
            if parentPart then
                for _, att in pairs(parentPart:GetChildren()) do
                    if att:IsA("Attachment") then att:Destroy() end
                end
            end
            activeTrail:Destroy()
            activeTrail = nil
        end
    end
end)

-- 7. Khoảng cách & Hiển thị tên cũ
createToggle(page1, "Khoảng cách (Hiện số M)", function(state)
    if state then
        RunService.RenderStepped:Connect(function()
            if not state then return end
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head
                    local bg = head:FindFirstChild("LunaDistTag")
                    if not bg then
                        bg = Instance.new("BillboardGui")
                        bg.Name = "LunaDistTag"
                        bg.Size = UDim2.new(0, 100, 0, 30)
                        bg.StudsOffset = Vector3.new(0, 2.5, 0)
                        bg.AlwaysOnTop = true
                        bg.Parent = head

                        local lbl = Instance.new("TextLabel")
                        lbl.Name = "Text"
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 1
                        lbl.TextColor3 = Color3.fromRGB(255, 255, 0)
                        lbl.TextStrokeTransparency = 0
                        lbl.Font = Enum.Font.SourceSansBold
                        lbl.TextSize = 14
                        lbl.Parent = bg
                    end
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((player.Character.HumanoidRootPart.Position - head.Position).Magnitude)
                        bg.Text.Text = dist .. "M"
                    end
                end
            end
        end)
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") then
                local tag = p.Character.Head:FindFirstChild("LunaDistTag")
                if tag then tag:Destroy() end
            end
        end
    end
end)

createToggle(page1, "Hiển thị tên người chơi", function(state)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.DisplayDistanceType = state and Enum.HumanoidDisplayDistanceType.Viewer or Enum.HumanoidDisplayDistanceType.None
        end
    end
end)

-- ==========================================
-- 6. MỤC 2: TELEPORT PLAYER
-- ==========================================
local teleTitle = Instance.new("TextLabel")
teleTitle.Size = UDim2.new(0, 330, 0, 30)
teleTitle.BackgroundTransparency = 1
teleTitle.Font = Enum.Font.SourceSansBold
teleTitle.TextSize = 16
teleTitle.Text = "DANH SÁCH NGƯỜI CHƠI TRONG SERVER"
teleTitle.Parent = page2
addRainbow(teleTitle)

local playerListContainer = Instance.new("Frame")
playerListContainer.Size = UDim2.new(0, 330, 0, 320)
playerListContainer.BackgroundTransparency = 1
playerListContainer.Parent = page2

local playerListLayout = Instance.new("UIListLayout", playerListContainer)
playerListLayout.Padding = UDim.new(0, 6)

local function updatePlayerList()
    for _, child in pairs(playerListContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, 0, 0, 35)
            pBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.Font = Enum.Font.SourceSansBold
            pBtn.TextSize = 15
            pBtn.Text = "📍 Teleport đến: " .. p.Name
            pBtn.Parent = playerListContainer
            local pbc = Instance.new("UICorner") pbc.CornerRadius = UDim.new(0, 6) pbc.Parent = pBtn
            
            pBtn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    sendNotify("Đã dịch chuyển đến: " .. p.Name)
                else
                    sendNotify("Không thể dịch chuyển tới người chơi này!")
                end
            end)
        end
    end
end
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
task.spawn(updatePlayerList)

-- ==========================================
-- 7. MỤC SETTING (MÀU NỀN, ĐƯỜNG MÒN, ĐỊNH VỊ)
-- ==========================================
local settingTitle = Instance.new("TextLabel")
settingTitle.Size = UDim2.new(0, 330, 0, 30)
settingTitle.BackgroundTransparency = 1
settingTitle.Font = Enum.Font.SourceSansBold
settingTitle.TextSize = 16
settingTitle.Text = "CÀI ĐẶT MÀU SẮC GIAO DIỆN"
settingTitle.Parent = page3
addRainbow(settingTitle)

-- Danh sách màu sắc
local bgColors = {
    {name = "Đen Tối (Mặc định)", color = Color3.fromRGB(16, 16, 22)},
    {name = "Xanh Đậm", color = Color3.fromRGB(10, 20, 40)},
    {name = "Đỏ Đậm", color = Color3.fromRGB(40, 10, 10)},
    {name = "Tím Mộng Mơ", color = Color3.fromRGB(30, 10, 40)},
    {name = "Xanh Ngọc", color = Color3.fromRGB(10, 40, 30)},
    {name = "Vàng Đồng", color = Color3.fromRGB(40, 35, 10)},
    {name = "Hồng Pastel", color = Color3.fromRGB(40, 20, 35)},
    {name = "Xám Bạc", color = Color3.fromRGB(40, 40, 45)},
    {name = "Xanh Dương Sáng", color = Color3.fromRGB(20, 30, 50)},
    {name = "Cam Đất", color = Color3.fromRGB(45, 25, 10)},
    {name = "Xanh Lá Cây", color = Color3.fromRGB(15, 35, 15)},
    {name = "Trắng Sữa", color = Color3.fromRGB(240, 240, 245)},
}

local elementColors = {
    {name = "Xanh Lá (Mặc định)", color = Color3.fromRGB(0, 255, 0)},
    {name = "Đỏ Rực", color = Color3.fromRGB(255, 0, 0)},
    {name = "Xanh Dương", color = Color3.fromRGB(0, 100, 255)},
    {name = "Vàng Chanh", color = Color3.fromRGB(255, 255, 0)},
    {name = "Hồng Neon", color = Color3.fromRGB(255, 0, 128)},
    {name = "Cam Sáng", color = Color3.fromRGB(255, 128, 0)},
    {name = "Tím Sáng", color = Color3.fromRGB(128, 0, 255)},
    {name = "Xanh Ngọc Bích", color = Color3.fromRGB(0, 255, 128)},
    {name = "Trắng Tinh", color = Color3.fromRGB(255, 255, 255)},
    {name = "Xám Đen", color = Color3.fromRGB(100, 100, 100)},
    {name = "Xanh Navy", color = Color3.fromRGB(0, 0, 128)},
    {name = "Đỏ Đun", color = Color3.fromRGB(128, 0, 0)},
    {name = "Xanh Rêu", color = Color3.fromRGB(64, 128, 64)},
    {name = "Vàng Gold", color = Color3.fromRGB(218, 165, 32)},
    {name = "Cầu Vồng Động 1", color = "Rainbow1"},
    {name = "Cầu Vồng Động 2", color = "Rainbow2"}
}

local function createColorPickerSetting(parent, labelText, colorList, onSelect)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 330, 0, 60)
    f.BackgroundTransparency = 1
    f.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 25)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Text = labelText
    lbl.Parent = f

    local btnLeft = Instance.new("TextButton")
    btnLeft.Size = UDim2.new(0, 40, 0, 30)
    btnLeft.Position = UDim2.new(0, 0, 0, 25)
    btnLeft.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btnLeft.Text = "<-"
    btnLeft.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnLeft.Font = Enum.Font.SourceSansBold
    btnLeft.Parent = f
    local lc = Instance.new("UICorner") lc.CornerRadius = UDim.new(0, 6) lc.Parent = btnLeft

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 240, 0, 30)
    valLbl.Position = UDim2.new(0, 45, 0, 25)
    valLbl.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    valLbl.Font = Enum.Font.SourceSansBold
    valLbl.TextSize = 13
    valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    valLbl.Parent = f
    local vc = Instance.new("UICorner") vc.CornerRadius = UDim.new(0, 6) vc.Parent = valLbl

    local btnRight = Instance.new("TextButton")
    btnRight.Size = UDim2.new(0, 40, 0, 30)
    btnRight.Position = UDim2.new(0, 290, 0, 25)
    btnRight.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btnRight.Text = "->"
    btnRight.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnRight.Font = Enum.Font.SourceSansBold
    btnRight.Parent = f
    local rc = Instance.new("UICorner") rc.CornerRadius = UDim.new(0, 6) rc.Parent = btnRight

    local idx = 1
    local function updateDisplay()
        local item = colorList[idx]
        valLbl.Text = item.name
        onSelect(item.color)
    end
    updateDisplay()

    btnLeft.MouseButton1Click:Connect(function()
        idx = idx - 1
        if idx < 1 then idx = #colorList end
        updateDisplay()
    end)

    btnRight.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #colorList then idx = 1 end
        updateDisplay()
    end)
end
-- 2. Màu đường mòn (14 màu + 2 động)
createColorPickerSetting(page3, "Màu đường mòn (Trail):", elementColors, function(col)
    if activeTrail then
        if col == "Rainbow1" or col == "Rainbow2" then
            activeTrail.Color = ColorSequence.new(Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0))
        elseif typeof(col) == "Color3" then
            activeTrail.Color = ColorSequence.new(col)
        end
    end
end)

-- 3. Màu định vị ESP (14 màu)
createColorPickerSetting(page3, "Màu định vị (ESP):", elementColors, function(col)
    if typeof(col) == "Color3" then
        currentEspColor = col
        for _, hl in pairs(espHighlights) do
            if hl and hl.Parent then hl.FillColor = col end
        end
    end
end)

-- ==========================================
-- 8. MỤC DISCORD
-- ==========================================
local discTitle = Instance.new("TextLabel")
discTitle.Size = UDim2.new(0, 330, 0, 30)
discTitle.BackgroundTransparency = 1
discTitle.Font = Enum.Font.SourceSansBold
discTitle.TextSize = 16
discTitle.Text = "CỘNG ĐỒNG LUNAHUB"
discTitle.Parent = page4
addRainbow(discTitle)

local discDesc = Instance.new("TextLabel")
discDesc.Size = UDim2.new(0, 330, 0, 60)
discDesc.BackgroundTransparency = 1
discDesc.Font = Enum.Font.SourceSans
discDesc.TextSize = 14
discDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
discDesc.TextWrapped = true
discDesc.Text = "Nhấn vào nút bên dưới để tham gia Discord chính thức của LunaHub cập nhật script mới nhất!"
discDesc.Parent = page4

local discBtn = Instance.new("TextButton")
discBtn.Size = UDim2.new(0, 330, 0, 45)
discBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
discBtn.Font = Enum.Font.SourceSansBold
discBtn.TextSize = 15
discBtn.Text = "🔗 Tham gia Discord: https://discord.gg/Gj4pE2zjJ"
discBtn.Parent = page4
local dbc = Instance.new("UICorner") dbc.CornerRadius = UDim.new(0, 8) dbc.Parent = discBtn

discBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/Gj4pE2zjJ")
            sendNotify("Đã copy link Discord vào clipboard!")
        end
    end)
end)

-- ==========================================
-- 9. CHẠY LUỒNG INTRO CUTSCENE
-- ==========================================
task.spawn(function()
    task.wait(1)
    loadingText.Text = "Đang kích hoạt V2..."
    for i = 0, 100, 2 do
        loadBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
        percentLbl.Text = i .. "%"
        task.wait(0.025)
    end
    task.wait(0.4)
    introFrame.Visible = false
    lunaIcon.Visible = true
    mainFrame.Visible = true
    sendNotify("Kích hoạt LunaSpace Hub V2 thành công! 🌙")
end)
