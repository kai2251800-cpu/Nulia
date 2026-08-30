-- [[ ANIMATION HUB LAINJE - ANTI CACHE & FULL MENU ]] --
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa GUI cũ để chống lag/trùng lặp
if playerGui:FindFirstChild("LainjeAnimHub") then
    playerGui.LainjeAnimHub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LainjeAnimHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- === INTRO CUTSCENE ===
local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.new(1, 0, 1, 0)
introFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
introFrame.BackgroundTransparency = 1
introFrame.ZIndex = 10
introFrame.Parent = screenGui

local introText = Instance.new("TextLabel")
introText.Size = UDim2.new(1, 0, 0, 100)
introText.Position = UDim2.new(0, 0, 0.45, -50)
introText.BackgroundTransparency = 1
introText.TextColor3 = Color3.fromRGB(255, 255, 255)
introText.TextSize = 28
introText.Font = Enum.Font.SourceSansBold
introText.Text = "Animation Hub Lainje"
introText.TextTransparency = 1
introText.ZIndex = 11
introText.Parent = introFrame

task.spawn(function()
    TweenService:Create(introFrame, TweenInfo.new(0.6), {BackgroundTransparency = 0.2}):Play()
    TweenService:Create(introText, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
    task.wait(2)
    TweenService:Create(introFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(introText, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    task.wait(0.8)
    introFrame:Destroy()
end)

-- === NÚT BIỂU TƯỢNG (ANI) ===
local iconBtn = Instance.new("TextButton")
iconBtn.Size = UDim2.new(0, 50, 0, 50)
iconBtn.Position = UDim2.new(0.02, 0, 0.35, 0)
iconBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
iconBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
iconBtn.TextSize = 16
iconBtn.Font = Enum.Font.SourceSansBold
iconBtn.Text = "ANI"
iconBtn.Active = true
iconBtn.Draggable = true
iconBtn.Parent = screenGui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 12)
iconCorner.Parent = iconBtn

-- === BẢNG MENU CHÍNH ===
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 240, 0, 335)
mainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "LANJIE ANIM HUB"
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

iconBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- === HỆ THỐNG LƯU TRỮ VÀ XỬ LÝ ANIMATION ===

-- Lưu lại bộ hoạt ảnh gốc của người chơi lúc mới vào
local defaultAnims = {}
task.spawn(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local animScript = char:WaitForChild("Animate", 5)
    if animScript then
        for _, state in ipairs({"idle", "walk", "run", "jump", "fall", "climb", "swim"}) do
            local folder = animScript:FindFirstChild(state)
            if folder then
                local a = folder:FindFirstChildOfClass("Animation")
                if a then
                    defaultAnims[state] = a.AnimationId
                end
            end
        end
    end
end)

-- Các bộ Animation dữ liệu
local ninjaAnims = {
    idle = 656117412, walk = 656121766, run = 656118852,
    jump = 656115606, fall = 656115606, climb = 656114359, swim = 656121766
}

local customAnims = {
    idle = 130957634981411, walk = 128494300834784, run = 78528647678239,
    jump = 84377083621312, fall = 118855365966201, climb = 80376862285946, swim = 119301986028045
}

local sukunaAnims = {
    idle = 132011159676461, walk = 116562432475955, run = 85988010084587,
    jump = 109764146230261, fall = 109764146230261, climb = 93756360672538, swim = 96253251952462
}

local zombieAnims = {
    idle = 616158929, walk = 616168032, run = 616163682,
    jump = 616161748, fall = 616157476, climb = 616156119, swim = 616165109
}

-- Hàm ép buộc thay đổi hoạt ảnh (Xóa Cache)
local function applyAnims(animTable)
    local character = player.Character
    if not character then return end
    
    local animateScript = character:FindFirstChild("Animate")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not animateScript or not humanoid then return end

    -- B1: Thay đổi ID trong thư mục
    for stateName, animId in pairs(animTable) do
        local stateObj = animateScript:FindFirstChild(stateName)
        if stateObj then
            for _, child in ipairs(stateObj:GetChildren()) do
                if child:IsA("Animation") then
                    if tostring(animId):match("rbxassetid") then
                        child.AnimationId = animId
                    else
                        child.AnimationId = "rbxassetid://" .. tostring(animId)
                    end
                end
            end
        end
    end

    -- B2: Dừng tất cả hoạt ảnh cũ đang chạy để tránh kẹt
    local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        track:Stop(0)
    end

    -- B3: BÍ QUYẾT CHỐNG LỖI - Clone và thay thế script Animate để reset Cache
    local newAnimate = animateScript:Clone()
    animateScript:Destroy()
    newAnimate.Parent = character
    newAnimate.Enabled = true
end

-- === HÀM TẠO NÚT MENU (CÓ CHỨC NĂNG BẬT/TẮT) ===
local function createButton(name, posY, targetAnims)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 220, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name .. ": OFF"
    btn.Parent = mainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local isActive = false
    btn.MouseButton1Click:Connect(function()
        isActive = not isActive
        if isActive then
            btn.Text = name .. ": ON"
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
            applyAnims(targetAnims)
        else
            btn.Text = name .. ": OFF"
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            applyAnims(defaultAnims) -- Trở về hoạt ảnh mặc định
        end
    end)
    return btn
end

-- Mục 1: Animation
createButton("Ninja Anims", 45, ninjaAnims)
createButton("Sukuna Anims", 85, sukunaAnims)
createButton("Custom Anims Hub", 125, customAnims)
createButton("Zombie Anims", 165, zombieAnims)

-- Các mục COMING SOON
local function createMockButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 220, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name .. ": COMING SOON"
    btn.Parent = mainFrame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
end

createMockButton("Trang phục", 205)
createMockButton("Hiệu ứng", 245)
createMockButton("Hành động", 285)
