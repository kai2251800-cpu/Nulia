-- SELECT ALPHAHUB - V4 (ADDED TELE, SHADER, DARKMIGHT, FASTMODE)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SelectAlphaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- ==========================================
-- CUTSCENE MỞ ĐẦU
-- ==========================================
local CutsceneFrame = Instance.new("Frame", ScreenGui)
CutsceneFrame.Size = UDim2.new(1, 0, 1, 0)
CutsceneFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
CutsceneFrame.ZIndex = 20

local PixelTitle = Instance.new("TextLabel", CutsceneFrame)
PixelTitle.AnchorPoint = Vector2.new(0.5, 0.5)
PixelTitle.Position = UDim2.new(0.5, 0, 0.42, 0)
PixelTitle.Size = UDim2.new(0, 400, 0, 80)
PixelTitle.BackgroundTransparency = 1
PixelTitle.Text = "Select AlphaHub"
PixelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PixelTitle.TextSize = 32
PixelTitle.Font = Enum.Font.Arcade
PixelTitle.ZIndex = 21

local LoadingText = Instance.new("TextLabel", CutsceneFrame)
LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingText.Position = UDim2.new(0.5, 0, 0.52, 0)
LoadingText.Size = UDim2.new(0, 200, 0, 30)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading: 0%"
LoadingText.TextColor3 = Color3.fromRGB(200, 200, 200)
LoadingText.TextSize = 16
LoadingText.Font = Enum.Font.Arcade
LoadingText.ZIndex = 21

local BarBg = Instance.new("Frame", CutsceneFrame)
BarBg.AnchorPoint = Vector2.new(0.5, 0.5)
BarBg.Position = UDim2.new(0.5, 0, 0.6, 0)
BarBg.Size = UDim2.new(0, 250, 0, 10)
BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BarBg.BorderSizePixel = 0
BarBg.ZIndex = 21
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame", BarBg)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BarFill.BorderSizePixel = 0
BarFill.ZIndex = 22
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    while CutsceneFrame and CutsceneFrame.Parent do
        for i = 0, 1, 0.01 do
            if not PixelTitle or not PixelTitle.Parent then break end
            PixelTitle.TextColor3 = Color3.fromHSV(i, 1, 1)
            BarFill.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
            task.wait(0.03)
        end
    end
end)

task.spawn(function()
    for i = 1, 100 do
        LoadingText.Text = "Loading: " .. i .. "%"
        BarFill.Size = UDim2.new(i / 100, 0, 1, 0)
        task.wait(0.015)
    end
    TweenService:Create(CutsceneFrame, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TweenService:Create(PixelTitle, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(BarBg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TweenService:Create(BarFill, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    task.wait(0.6)
    CutsceneFrame:Destroy()
end)

-- ==========================================
-- NÚT TOGGLE (SHub⚡ chữ pixel, cầu vồng động)
-- ==========================================
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 110, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0.15, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = "SHub⚡"
ToggleBtn.TextSize = 16
ToggleBtn.Font = Enum.Font.Arcade
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)
local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Thickness = 2

task.spawn(function()
    while ToggleBtn and ToggleBtn.Parent do
        for i = 0, 1, 0.01 do
            if not ToggleBtn or not ToggleBtn.Parent then break end
            ToggleBtn.TextColor3 = Color3.fromHSV(i, 1, 1)
            BtnStroke.Color = Color3.fromHSV(i, 1, 1)
            task.wait(0.04)
        end
    end
end)

-- ==========================================
-- GIAO DIỆN CHÍNH
-- ==========================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 360, 0, 340)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(50, 50, 50)
MainStroke.Thickness = 1.5

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local TitleLabel = Instance.new("TextLabel", MainFrame)
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Select AlphaHub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 15

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -45)
Container.Position = UDim2.new(0, 10, 0, 40)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 3
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
Container.CanvasSize = UDim2.new(0, 0, 0, 0)

local UIList = Instance.new("UIListLayout", Container)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)

-- ==========================================
-- HÀM HỖ TRỢ GIAO DIỆN
-- ==========================================
local function createSectionHeader(text)
    local lbl = Instance.new("TextLabel", Container)
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 15
    lbl.Font = Enum.Font.Arcade
    lbl.Rotation = -2 -- Chữ pixel nghiêng
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Hiệu ứng màu trắng động cho tiêu đề mục mới
    task.spawn(function()
        local v = 255
        local increasing = false
        while lbl and lbl.Parent do
            if increasing then
                v = v + 5
                if v >= 255 then increasing = false end
            else
                v = v - 5
                if v <= 150 then increasing = true end
            end
            lbl.TextColor3 = Color3.fromRGB(v, v, v)
            task.wait(0.05)
        end
    end)
end

local function createInputToggleRow(name, defaultVal, callbackOn, callbackOff)
    local row = Instance.new("Frame", Container)
    row.Size = UDim2.new(1, 0, 0, 35)
    row.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.4, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local box = Instance.new("TextBox", row)
    box.Size = UDim2.new(0, 45, 0, 22)
    box.Position = UDim2.new(1, -120, 0.5, -11)
    box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    box.Text = tostring(defaultVal)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.SourceSansBold
    box.TextSize = 12
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(0, 60, 0, 22)
    btn.Position = UDim2.new(1, -65, 0.5, -11)
    btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    local active = false
    local function update()
        if active then callbackOn(tonumber(box.Text) or defaultVal) end
    end

    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
            btn.Text = "ON"
            update()
        else
            btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            btn.Text = "OFF"
            if callbackOff then callbackOff() end
        end
    end)
    box.FocusLost:Connect(update)
    return box
end

local function createToggleRow(name, callbackOn, callbackOff)
    local row = Instance.new("Frame", Container)
    row.Size = UDim2.new(1, 0, 0, 35)
    row.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(0, 60, 0, 22)
    btn.Position = UDim2.new(1, -65, 0.5, -11)
    btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
            btn.Text = "ON"
            pcall(callbackOn)
        else
            btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            btn.Text = "OFF"
            pcall(callbackOff)
        end
    end)
end

-- ==========================================
-- CÁC TÍNH NĂNG CHÍNH (CŨ)
-- ==========================================
_G.TargetSpeed = 16
_G.ToggleSpeed = false
createInputToggleRow("Chỉnh tốc độ:", 16, function(val) _G.ToggleSpeed = true; _G.TargetSpeed = val end, function() _G.ToggleSpeed = false; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end end)
RunService.Stepped:Connect(function() if _G.ToggleSpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = _G.TargetSpeed end end)

_G.TargetJump = 50
_G.ToggleJump = false
createInputToggleRow("Jump:", 50, function(val) _G.ToggleJump = true; _G.TargetJump = val end, function() _G.ToggleJump = false; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 50 end end)
RunService.Stepped:Connect(function() if _G.ToggleJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.UseJumpPower = true; LocalPlayer.Character.Humanoid.JumpPower = _G.TargetJump end end)

local noclipConn
createToggleRow("Xuyên tường", function() noclipConn = RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end) end, function() if noclipConn then noclipConn:Disconnect() end end)

local espLoop
createToggleRow("Định vị", function() _G.ESPActive = true; espLoop = task.spawn(function() while _G.ESPActive do for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("AlphaESP") then local hl = Instance.new("Highlight") hl.Name = "AlphaESP"; hl.FillColor = Color3.fromRGB(0, 255, 0); hl.OutlineColor = Color3.fromRGB(0, 100, 0); hl.FillTransparency = 0.5; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = p.Character end end task.wait(1) end end) end, function() _G.ESPActive = false; for _, p in ipairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("AlphaESP") then p.Character.AlphaESP:Destroy() end end end)

local OriginalTransparencies = {}
createToggleRow("Nhìn xuyên tường", function() for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then local isP = false; for _, p in ipairs(Players:GetPlayers()) do if p.Character and obj:IsDescendantOf(p.Character) then isP = true end end; if not isP then OriginalTransparencies[obj] = obj.Transparency; obj.Transparency = 0.5 end end end, function() for obj, trans in pairs(OriginalTransparencies) do if obj and obj.Parent then obj.Transparency = trans end end; OriginalTransparencies = {} end)

_G.NameESP = false; _G.DistanceESP = false
createToggleRow("Tên hiển thị", function() _G.NameESP = true end, function() _G.NameESP = false end)
createToggleRow("Số M (Khoảng cách)", function() _G.DistanceESP = true end, function() _G.DistanceESP = false end)

RunService.RenderStepped:Connect(function()
    if not _G.NameESP and not _G.DistanceESP then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("HumanoidRootPart") then
            local head = p.Character.Head
            local espGui = head:FindFirstChild("AlphaHubTextESP")
            if not espGui then
                espGui = Instance.new("BillboardGui", head)
                espGui.Name = "AlphaHubTextESP"
                espGui.Size = UDim2.new(0, 200, 0, 60)
                espGui.StudsOffset = Vector3.new(0, 3, 0)
                espGui.AlwaysOnTop = true
                local nLbl = Instance.new("TextLabel", espGui)
                nLbl.Name = "NL"
                nLbl.Size = UDim2.new(1, 0, 0.5, 0)
                nLbl.BackgroundTransparency = 1
                nLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                nLbl.TextStrokeTransparency = 0
                nLbl.Font = Enum.Font.SourceSansBold
                nLbl.TextSize = 14
                local dLbl = Instance.new("TextLabel", espGui)
                dLbl.Name = "DL"
                dLbl.Size = UDim2.new(1, 0, 0.5, 0)
                dLbl.Position = UDim2.new(0, 0, 0.5, 0)
                dLbl.BackgroundTransparency = 1
                dLbl.TextColor3 = Color3.fromRGB(0, 255, 150)
                dLbl.TextStrokeTransparency = 0
                dLbl.Font = Enum.Font.SourceSansBold
                dLbl.TextSize = 18
            end
            espGui.NL.Text = _G.NameESP and p.DisplayName or ""
            espGui.NL.Visible = _G.NameESP
            if _G.DistanceESP and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude)
                espGui.DL.Text = dist .. " M"
                espGui.DL.Visible = true
            else
                espGui.DL.Visible = false
            end
        end
    end
end)

-- ==========================================
-- MỤC MỚI: TELE (Xếp hàng ngang 4 tên 1 hàng)
-- ==========================================
createSectionHeader("Tele")

local TeleContainer = Instance.new("Frame", Container)
TeleContainer.Size = UDim2.new(1, 0, 0, 0)
TeleContainer.BackgroundTransparency = 1
local TeleGrid = Instance.new("UIGridLayout", TeleContainer)
TeleGrid.CellSize = UDim2.new(0, 75, 0, 30) -- 4 tên một hàng (340px / 4 ~= 75-80px)
TeleGrid.CellPadding = UDim2.new(0, 5, 0, 5)
TeleGrid.SortOrder = Enum.SortOrder.LayoutOrder

local function updatePlayerList()
    for _, child in ipairs(TeleContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local btn = Instance.new("TextButton", TeleContainer)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.Text = p.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 11
            btn.Font = Enum.Font.SourceSansBold
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            
            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end
            end)
        end
    end
    local rows = math.ceil((#Players:GetPlayers() - 1) / 4)
    TeleContainer.Size = UDim2.new(1, 0, 0, math.max(0, rows * 35))
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
task.spawn(updatePlayerList)

-- ==========================================
-- MỤC MỚI: SHADER & ĐỒ HỌA (Không chèn lên nhau)
-- ==========================================
createSectionHeader("Shader & Đồ Họa")

-- Biến lưu trạng thái độc quyền của đồ họa (Tránh chèn lên nhau)
local currentActiveGraphics = nil

local function clearActiveGraphics()
    if currentActiveGraphics == "darkmight" then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("Sky") or obj:IsA("Atmosphere") or obj:IsA("PostEffect") then obj:Destroy() end
        end
    elseif currentActiveGraphics == "fastmode" then
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then part.Material = Enum.Material.Plastic end
        end
    end
    currentActiveGraphics = nil
end

-- 1. Daytime Shader
createToggleRow("Shader: Daytime", function()
    clearActiveGraphics()
    currentActiveGraphics = "shader_day"
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150)
end, function()
    if currentActiveGraphics == "shader_day" then clearActiveGraphics() end
end)

-- 2. Sunset Shader
createToggleRow("Shader: Sunset", function()
    clearActiveGraphics()
    currentActiveGraphics = "shader_sunset"
    Lighting.Brightness = 2.5
    Lighting.ClockTime = 18
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 120, 80)
end, function()
    if currentActiveGraphics == "shader_sunset" then clearActiveGraphics() end
end)

-- 3. Night Shader
createToggleRow("Shader: Night", function()
    clearActiveGraphics()
    currentActiveGraphics = "shader_night"
    Lighting.Brightness = 0.2
    Lighting.ClockTime = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(20, 20, 40)
end, function()
    if currentActiveGraphics == "shader_night" then clearActiveGraphics() end
end)

-- 4. Cloudy Shader
createToggleRow("Shader: Cloudy", function()
    clearActiveGraphics()
    currentActiveGraphics = "shader_cloudy"
    Lighting.Brightness = 1
    Lighting.ClockTime = 12
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
    Lighting.FogEnd = 3000
end, function()
    if currentActiveGraphics == "shader_cloudy" then clearActiveGraphics(); Lighting.FogEnd = 100000 end
end)

-- 5. Darkmight (Xung quanh tối om, chỉ có vùng sáng nhỏ quanh người chơi)
createToggleRow("Darkmight", function()
    clearActiveGraphics()
    currentActiveGraphics = "darkmight"
    Lighting.Brightness = 0
    Lighting.ClockTime = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    Lighting.FogEnd = 50
    Lighting.FogStart = 0
    Lighting.FogColor = Color3.fromRGB(0, 0, 0)
end, function()
    if currentActiveGraphics == "darkmight" then clearActiveGraphics() end
end)

-- 6. Fastmode (Xóa đổ bóng, chi tiết đồ họa tối ưu FPS)
createToggleRow("Fastmode", function()
    clearActiveGraphics()
    currentActiveGraphics = "fastmode"
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1
        end
    end
end, function()
    if currentActiveGraphics == "fastmode" then clearActiveGraphics() end
end)

-- 7. Tắt hết đồ họa và về lại bình thường
createToggleRow("Reset Đồ Họa Gốc", function()
    clearActiveGraphics()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.FogEnd = 100000
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") then p.Material = Enum.Material.Plastic end
    end
end, function()
    -- Không cần xử lý gì khi tắt nút reset này
end)
