-- JDHub Script for Delta Executor
-- Giao diện được thiết kế tối ưu, chống kẹt khi Fly và đầy đủ tính năng.

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Xóa Hub cũ nếu có để tránh trùng lặp
if CoreGui:FindFirstChild("JDHub_GUI") then
    CoreGui.JDHub_GUI:Destroy()
end

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
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
MainFrame.Size = UDim2.new(0, 320, 0, 400)
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
Title.Text = "JDHub v1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

-- Khu vực chứa các chức năng (ScrollingFrame)
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 550)
ScrollingFrame.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- Hàm hiển thị thông báo góc màn hình
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
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = Notif
    
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

-- Chạy Cutscene mờ dần
task.spawn(function()
    task.wait(1)
    CutsceneText.Text = "Đang khởi tạo hệ thống..."
    task.wait(1)
    
    -- Xóa hiệu ứng cắt cảnh
    local tweenService = game:GetService("TweenService")
    local info = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = tweenService:Create(CutsceneFrame, info, {BackgroundTransparency = 1})
    local tweenText = tweenService:Create(CutsceneText, info, {TextTransparency = 1})
    
    tween:Play()
    tweenText:Play()
    
    task.wait(0.8)
    CutsceneFrame:Destroy()
    showNotification("Kích hoạt thành công JVHub ✅")
end)

-- Nút mở/đóng menu chính
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Biến lưu trạng thái các tính năng
local speedEnabled = false
local speedValue = 16
local jumpEnabled = false
local jumpValue = 50
local noclipEnabled = false
local xrayEnabled = false
local espEnabled = false
local flyEnabled = false
local flySpeed = 16

-- Hàm tạo các thành phần giao diện (Toggle + Input)
local function createFeatureRow(name, defaultVal, onToggle, onValChanged)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 45)
    row.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    row.Parent = ScrollingFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = row
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 160, 1, 0)
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
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = inputBox
    
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
    
    inputBox.FocusLost:Connect(function(enterPressed)
        local num = tonumber(inputBox.Text)
        if num then
            onValChanged(num)
        else
            inputBox.Text = tostring(defaultVal)
            onValChanged(defaultVal)
        end
    end)
end

-- 1. Tốc độ (WalkSpeed)
createFeatureRow("Tốc độ", 16, function(state)
    speedEnabled = state
end, function(val)
    speedValue = val
end)

RunService.RenderStepped:Connect(function()
    if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
    end
end)

-- 2. Jump Power
createFeatureRow("Jump Power", 50, function(state)
    jumpEnabled = state
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
createFeatureRow("Đi xuyên tường", "Off", function(state)
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
    end
end, function(val) end)

-- 4. X-Ray (Nhìn xuyên vật thể)
createFeatureRow("X-Ray", "Off", function(state)
    xrayEnabled = state
    for _, part in pairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then
            part.LocalTransparencyModifier = xrayEnabled and 0.5 or 0
        end
    end
end, function(val) end)

-- 5. Định vị (ESP Player màu xanh lá)
local espConnections = {}
createFeatureRow("Định vị (ESP)", "Off", function(state)
    espEnabled = state
    if espEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local function addHighlight(char)
                    if not char:FindFirstChild("JD_Highlight") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "JD_Highlight"
                        hl.Adornee = char
                        hl.FillColor = Color3.fromRGB(0, 255, 0)
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

-- 6. Fly (Cải tiến mượt mà, chống đứng hình)
createFeatureRow("Fly", 16, function(state)
    flyEnabled = state
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = char.HumanoidRootPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    if flyEnabled then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "JDFlyVelocity"
        bv.Parent = hrp
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "JDFlyGyro"
        bg.Parent = hrp
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = hrp.CFrame
        
        if humanoid then humanoid.PlatformStand = true end
        
        -- Vòng lặp điều khiển hướng bay theo Camera tránh bị đứng cứng ngắc
        task.spawn(function()
            while flyEnabled and char and hrp.Parent do
                local cam = Workspace.CurrentCamera
                local moveDir = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + cam.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - cam.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - cam.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + cam.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDir = moveDir - Vector3.new(0, 1, 0)
                end
                
                bv.Velocity = moveDir * flySpeed
                bg.CFrame = cam.CFrame
                RunService.RenderStepped:Wait()
            end
            
            -- Dọn dẹp khi tắt Fly
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
            if humanoid then humanoid.PlatformStand = false end
        end)
    else
        if hrp:FindFirstChild("JDFlyVelocity") then hrp.JDFlyVelocity:Destroy() end
        if hrp:FindFirstChild("JDFlyGyro") then hrp.JDFlyGyro:Destroy() end
        if humanoid then humanoid.PlatformStand = false end
    end
end, function(val)
    flySpeed = val
end)
