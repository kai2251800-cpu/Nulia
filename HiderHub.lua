-- ==========================================
-- HIDER HUB - ADVANCED SCRIPT
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- TẠO MÔI TRƯỜNG GUI (HỖ TRỢ CẢ PC & MOBILE EXECUTOR)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HiderHub"
ScreenGui.ResetOnSpawn = false
local success = pcall(function() ScreenGui.Parent = CoreGui end)
if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- ==========================================
-- 1. CUTSCENE MỞ ĐẦU
-- ==========================================
local CutsceneFrame = Instance.new("Frame", ScreenGui)
CutsceneFrame.Size = UDim2.new(1, 0, 1, 0)
CutsceneFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
CutsceneFrame.ZIndex = 100

local CutTitle = Instance.new("TextLabel", CutsceneFrame)
CutTitle.Size = UDim2.new(1, 0, 0, 100)
CutTitle.Position = UDim2.new(0, 0, 0.4, -50)
CutTitle.BackgroundTransparency = 1
CutTitle.Text = "Hider Hub"
CutTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
CutTitle.Font = Enum.Font.GothamBlack
CutTitle.TextSize = 50
CutTitle.ZIndex = 101

local CutSub = Instance.new("TextLabel", CutsceneFrame)
CutSub.Size = UDim2.new(1, 0, 0, 50)
CutSub.Position = UDim2.new(0, 0, 0.5, 0)
CutSub.BackgroundTransparency = 1
CutSub.Text = ""
CutSub.TextColor3 = Color3.fromRGB(180, 180, 180)
CutSub.Font = Enum.Font.GothamMedium
CutSub.TextSize = 25
CutSub.ZIndex = 101

local CutPercent = Instance.new("TextLabel", CutsceneFrame)
CutPercent.Size = UDim2.new(1, 0, 0, 50)
CutPercent.Position = UDim2.new(0, 0, 0.6, 0)
CutPercent.BackgroundTransparency = 1
CutPercent.Text = "0%"
CutPercent.TextColor3 = Color3.fromRGB(0, 255, 100)
CutPercent.Font = Enum.Font.GothamBold
CutPercent.TextSize = 30
CutPercent.ZIndex = 101

-- Logic Cutscene
task.spawn(function()
    task.wait(1)
    CutSub.Text = "Đang kích hoạt"
    task.wait(0.5)
    
    for i = 0, 100, 2 do
        CutPercent.Text = i .. "%"
        task.wait(0.01) -- Load nhanh
    end
    
    CutPercent.Text = "100%"
    StarterGui:SetCore("SendNotification", {
        Title = "Hider Hub",
        Text = "Kích hoạt thành công Hider Hub ✅",
        Duration = 5
    })
    
    TweenService:Create(CutsceneFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(CutTitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(CutSub, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(CutPercent, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    
    task.wait(0.5)
    CutsceneFrame:Destroy()
end)

-- ==========================================
-- 2. NÚT TOGGLE (MỞ/ĐÓNG MENU)
-- ==========================================
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 70, 0, 70)
ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ToggleBtn.Text = "Hider"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 18
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Thickness = 2
ToggleStroke.Color = Color3.fromRGB(255, 255, 255)

-- Hiệu ứng chữ cầu vồng
task.spawn(function()
    local hue = 0
    while ToggleBtn.Parent do
        hue = hue + 0.01
        if hue >= 1 then hue = 0 end
        local color = Color3.fromHSV(hue, 1, 1)
        ToggleBtn.TextColor3 = color
        ToggleStroke.Color = color
        task.wait(0.05)
    end
end)

-- ==========================================
-- 3. GIAO DIỆN CHÍNH (MAIN UI)
-- ==========================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local TitleBar = Instance.new("TextLabel", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundTransparency = 1
TitleBar.Text = "HIDER HUB"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.Font = Enum.Font.GothamBlack
TitleBar.TextSize = 20

local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.Size = UDim2.new(0, 120, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local TabList = Instance.new("UIListLayout", TabContainer)
TabList.SortOrder = Enum.SortOrder.LayoutOrder

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -120, 1, -40)
ContentContainer.Position = UDim2.new(0, 120, 0, 40)
ContentContainer.BackgroundTransparency = 1

local Tabs = {}
local Pages = {}

local function CreateTab(name)
    local btn = Instance.new("TextButton", TabContainer)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    
    local page = Instance.new("ScrollingFrame", ContentContainer)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ScrollBarThickness = 4
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    
    Instance.new("UIPadding", page).PaddingTop = UDim.new(0, 5)
    Instance.new("UIPadding", page).PaddingLeft = UDim.new(0, 5)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(Tabs) do b.TextColor3 = Color3.fromRGB(200, 200, 200) end
        page.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    table.insert(Tabs, btn)
    table.insert(Pages, page)
    
    if #Tabs == 1 then
        page.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    return page
end

-- ==========================================
-- HÀM HỖ TRỢ TẠO NÚT
-- ==========================================
local function CreateToggleWithInput(page, name, defaultVal, callbackOn, callbackOff, callbackInput)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 5)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.5, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0, 40, 0, 26)
    box.Position = UDim2.new(1, -110, 0.5, -13)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Text = tostring(defaultVal)
    box.Font = Enum.Font.Gotham
    Instance.new("UICorner", box)
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 50, 0, 26)
    btn.Position = UDim2.new(1, -60, 0.5, -13)
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    
    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            btn.Text = "ON"
            if callbackOn then callbackOn(tonumber(box.Text) or defaultVal) end
        else
            btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            btn.Text = "OFF"
            if callbackOff then callbackOff() end
        end
    end)
    
    box.FocusLost:Connect(function()
        if toggled and callbackInput then
            callbackInput(tonumber(box.Text) or defaultVal)
        end
    end)
end

local function CreateToggle(page, name, callbackOn, callbackOff)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 5)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 50, 0, 26)
    btn.Position = UDim2.new(1, -60, 0.5, -13)
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    
    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            btn.Text = "ON"
            if callbackOn then pcall(callbackOn) end
        else
            btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            btn.Text = "OFF"
            if callbackOff then pcall(callbackOff) end
        end
    end)
end

-- ==========================================
-- 4. LOGIC CÁC TAB
-- ==========================================
local Page1 = CreateTab("Chức năng")
local Page2 = CreateTab("Thông tin")
local Page3 = CreateTab("Hiệu ứng")
local Page4 = CreateTab("Người chơi")

-- ================= MỤC 1: CHỨC NĂNG =================
-- Tốc độ
local walkSpeedLoop, targetSpeed
CreateToggleWithInput(Page1, "Tốc độ", 16, 
    function(val) targetSpeed = val; walkSpeedLoop = RunService.RenderStepped:Connect(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = targetSpeed end end) end,
    function() if walkSpeedLoop then walkSpeedLoop:Disconnect() end; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end end,
    function(val) targetSpeed = val end
)

-- Nhảy
local jumpPowerLoop, targetJump
CreateToggleWithInput(Page1, "Jump power", 50, 
    function(val) targetJump = val; jumpPowerLoop = RunService.RenderStepped:Connect(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.UseJumpPower = true; LocalPlayer.Character.Humanoid.JumpPower = targetJump end end) end,
    function() if jumpPowerLoop then jumpPowerLoop:Disconnect() end; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 50 end end,
    function(val) targetJump = val end
)

-- Xuyên tường (Noclip)
local noclipLoop
CreateToggle(Page1, "Đi xuyên tường", 
    function() noclipLoop = RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end end) end,
    function() if noclipLoop then noclipLoop:Disconnect() end end
)

-- X-Ray (Nhìn xuyên tường)
local XRayData = {}
CreateToggle(Page1, "X-Ray", 
    function() 
        for _, part in pairs(workspace:GetDescendants()) do 
            if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) and part.Transparency < 1 then 
                XRayData[part] = part.Transparency
                part.Transparency = 0.5 
            end 
        end 
    end,
    function() 
        for part, trans in pairs(XRayData) do if part and part.Parent then part.Transparency = trans end end 
        XRayData = {} 
    end
)

-- ESP (Định vị xanh lá)
local espLoop, espActive
CreateToggle(Page1, "Định vị", 
    function()
        espActive = true
        espLoop = task.spawn(function()
            while espActive do
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        if not player.Character:FindFirstChild("HiderESP") then
                            local hl = Instance.new("Highlight", player.Character)
                            hl.Name = "HiderESP"
                            hl.FillColor = Color3.fromRGB(0, 255, 0)
                            hl.OutlineColor = Color3.fromRGB(0, 100, 0)
                            hl.FillTransparency = 0.5
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end,
    function()
        espActive = false
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HiderESP") then
                player.Character.HiderESP:Destroy()
            end
        end
    end
)

-- HỆ THỐNG FLY NÂNG CAO (Có nút ⬆️ ⬇️)
local flyLoop, flying, flySpeedVal = nil, false, 16
local FlyUI = Instance.new("Frame", ScreenGui)
FlyUI.Size = UDim2.new(0, 60, 0, 130)
FlyUI.Position = UDim2.new(1, -80, 0.5, -65)
FlyUI.BackgroundTransparency = 1
FlyUI.Visible = false

local btnUp = Instance.new("TextButton", FlyUI)
btnUp.Size = UDim2.new(1, 0, 0, 60)
btnUp.Text = "⬆️"
btnUp.TextSize = 30
btnUp.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnUp.BackgroundTransparency = 0.5
Instance.new("UICorner", btnUp)

local btnDown = Instance.new("TextButton", FlyUI)
btnDown.Size = UDim2.new(1, 0, 0, 60)
btnDown.Position = UDim2.new(0, 0, 0, 70)
btnDown.Text = "⬇️"
btnDown.TextSize = 30
btnDown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnDown.BackgroundTransparency = 0.5
Instance.new("UICorner", btnDown)

local flyUpPressed, flyDownPressed = false, false
btnUp.MouseButton1Down:Connect(function() flyUpPressed = true end)
btnUp.MouseButton1Up:Connect(function() flyUpPressed = false end)
btnDown.MouseButton1Down:Connect(function() flyDownPressed = true end)
btnDown.MouseButton1Up:Connect(function() flyDownPressed = false end)

local bodyGyro, bodyVelocity
CreateToggleWithInput(Page1, "Fly", 16, 
    function(val) 
        flying = true
        flySpeedVal = val
        FlyUI.Visible = true
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            bodyGyro = Instance.new("BodyGyro", hrp)
            bodyGyro.P = 9e4
            bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bodyGyro.cframe = hrp.CFrame
            
            bodyVelocity = Instance.new("BodyVelocity", hrp)
            bodyVelocity.velocity = Vector3.new(0, 0.1, 0)
            bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            flyLoop = RunService.RenderStepped:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then return end
                local human = LocalPlayer.Character.Humanoid
                local camCFrame = Camera.CFrame
                
                local moveDir = human.MoveDirection
                local flyDir = Vector3.zero
                if moveDir.Magnitude > 0 then
                    flyDir = (camCFrame.RightVector * (camCFrame:VectorToObjectSpace(moveDir).X) + camCFrame.LookVector * (camCFrame:VectorToObjectSpace(moveDir).Z)).Unit
                end
                
                local yVelocity = 0
                if flyUpPressed then yVelocity = flySpeedVal end
                if flyDownPressed then yVelocity = -flySpeedVal end
                
                bodyVelocity.velocity = (camCFrame.LookVector * moveDir.Z * -flySpeedVal) + (camCFrame.RightVector * moveDir.X * flySpeedVal) + Vector3.new(0, yVelocity, 0)
                bodyGyro.cframe = camCFrame
            end)
        end
    end,
    function() 
        flying = false
        FlyUI.Visible = false
        if flyLoop then flyLoop:Disconnect() end
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end,
    function(val) flySpeedVal = val end
)

-- ================= MỤC 2: BẢNG THÔNG TIN =================
local lblDisplay = Instance.new("TextLabel", Page2)
lblDisplay.Size = UDim2.new(1, -10, 0, 30)
lblDisplay.BackgroundTransparency = 1
lblDisplay.Text = "Tên biệt danh: " .. LocalPlayer.DisplayName
lblDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
lblDisplay.Font = Enum.Font.GothamMedium
lblDisplay.TextSize = 16
lblDisplay.TextXAlignment = Enum.TextXAlignment.Left

local lblName = Instance.new("TextLabel", Page2)
lblName.Size = UDim2.new(1, -10, 0, 30)
lblName.BackgroundTransparency = 1
lblName.Text = "Tên chính: " .. LocalPlayer.Name
lblName.TextColor3 = Color3.fromRGB(200, 200, 200)
lblName.Font = Enum.Font.GothamMedium
lblName.TextSize = 16
lblName.TextXAlignment = Enum.TextXAlignment.Left

local lblTime = Instance.new("TextLabel", Page2)
lblTime.Size = UDim2.new(1, -10, 0, 30)
lblTime.BackgroundTransparency = 1
lblTime.Text = "Thời gian chơi game: 00:00:00"
lblTime.TextColor3 = Color3.fromRGB(0, 255, 255)
lblTime.Font = Enum.Font.GothamMedium
lblTime.TextSize = 16
lblTime.TextXAlignment = Enum.TextXAlignment.Left

local playSeconds = 0
task.spawn(function()
    while true do
        task.wait(1)
        playSeconds = playSeconds + 1
        local h = math.floor(playSeconds / 3600)
        local m = math.floor((playSeconds % 3600) / 60)
        local s = playSeconds % 60
        lblTime.Text = string.format("Thời gian chơi game: %02d:%02d:%02d", h, m, s)
    end
end)

-- ================= MỤC 3: HIỆU ỨNG =================
-- Skin Rainbow
local rainbowLoop, rainbowActive
CreateToggle(Page3, "Skin rainbow", 
    function()
        rainbowActive = true
        rainbowLoop = task.spawn(function()
            local hue = 0
            while rainbowActive do
                hue = hue + 0.05
                if hue >= 1 then hue = 0 end
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") then part.Color = Color3.fromHSV(hue, 1, 1) end
                    end
                end
                task.wait(0.1)
            end
        end)
    end,
    function()
        rainbowActive = false
        -- Tự reset khi chết
    end
)

-- Aura Flame
CreateToggle(Page3, "Aura flame", 
    function() 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local f = Instance.new("Fire", LocalPlayer.Character.HumanoidRootPart)
            f.Name = "HiderFlame"
            f.Size = 8
        end
    end,
    function() 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local f = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("HiderFlame")
            if f then f:Destroy() end
        end
    end
)

-- Smoke
CreateToggle(Page3, "Smoke", 
    function() 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local s = Instance.new("Smoke", LocalPlayer.Character.HumanoidRootPart)
            s.Name = "HiderSmoke"
            s.Size = 5
        end
    end,
    function() 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local s = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("HiderSmoke")
            if s then s:Destroy() end
        end
    end
)

-- Invisible
local invisData = {}
CreateToggle(Page3, "Invisible", 
    function() 
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    invisData[part] = part.Transparency
                    part.Transparency = 1
                end
            end
        end
    end,
    function() 
        for part, trans in pairs(invisData) do
            if part and part.Parent then part.Transparency = trans end
        end
        invisData = {}
    end
)

-- ================= MỤC 4: NGƯỜI CHƠI (TELEPORT) =================
local function UpdatePlayerList()
    for _, child in pairs(Page4:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton", Page4)
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.Text = "Teleport: " .. player.DisplayName .. " (@" .. player.Name .. ")"
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 13
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
            
            btn.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                end
            end)
        end
    end
end

Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)
task.spawn(UpdatePlayerList)
