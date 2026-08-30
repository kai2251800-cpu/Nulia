local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("FasterHubV4") then
    CoreGui:FindFirstChild("FasterHubV4"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FasterHubV4"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local function SendNotification(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = "Faster Hub V4", Text = text, Duration = 3})
    end)
end

-- ==========================================
-- 1. CUTSCENE & KEY
-- ==========================================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.ZIndex = 100

local AuthorText = Instance.new("TextLabel", IntroFrame)
AuthorText.Size = UDim2.new(0.6, 0, 0.1, 0)
AuthorText.Position = UDim2.new(0.2, 0, 0.35, 0)
AuthorText.BackgroundTransparency = 1
AuthorText.Font = Enum.Font.GothamBold
AuthorText.Text = "Faster Hub V4 by @Hacker_loso1vietnam"
AuthorText.TextColor3 = Color3.fromRGB(255, 255, 255)
AuthorText.TextScaled = true
AuthorText.ZIndex = 101

local KeyInput = Instance.new("TextBox", IntroFrame)
KeyInput.Size = UDim2.new(0.3, 0, 0.08, 0)
KeyInput.Position = UDim2.new(0.35, 0, 0.5, 0)
KeyInput.PlaceholderText = "Nhập Key ở đây..."
KeyInput.Text = ""
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextScaled = true
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.ZIndex = 101
Instance.new("UICorner", KeyInput)

local SubmitBtn = Instance.new("TextButton", IntroFrame)
SubmitBtn.Size = UDim2.new(0.15, 0, 0.08, 0)
SubmitBtn.Position = UDim2.new(0.425, 0, 0.6, 0)
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextScaled = true
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.ZIndex = 101
Instance.new("UICorner", SubmitBtn)

local LoadBarBG = Instance.new("Frame", IntroFrame)
LoadBarBG.Size = UDim2.new(0.4, 0, 0.03, 0)
LoadBarBG.Position = UDim2.new(0.3, 0, 0.55, 0)
LoadBarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadBarBG.Visible = false
LoadBarBG.ZIndex = 101
Instance.new("UICorner", LoadBarBG)

local LoadBarFill = Instance.new("Frame", LoadBarBG)
LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
LoadBarFill.ZIndex = 102
Instance.new("UICorner", LoadBarFill)

local PercentText = Instance.new("TextLabel", LoadBarBG)
PercentText.Size = UDim2.new(1, 0, 1.5, 0)
PercentText.Position = UDim2.new(0, 0, -1.5, 0)
PercentText.BackgroundTransparency = 1
PercentText.Font = Enum.Font.GothamBold
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentText.TextScaled = true
PercentText.ZIndex = 102
PercentText.Visible = false

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleButton.Text = "Fhub"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextScaled = true
ToggleButton.Visible = false 
Instance.new("UICorner", ToggleButton)
local UIStroke = Instance.new("UIStroke", ToggleButton)
UIStroke.Thickness = 3
local UIGradient = Instance.new("UIGradient", UIStroke)
UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.new(1,0,0)), ColorSequenceKeypoint.new(0.5, Color3.new(0,1,0)), ColorSequenceKeypoint.new(1, Color3.new(0,0,1))}
RunService.RenderStepped:Connect(function() UIGradient.Rotation = (UIGradient.Rotation + 2) % 360 end)

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "FasterHub123" then
        SendNotification("Đang kích hoạt key✅")
        KeyInput.Visible = false
        SubmitBtn.Visible = false
        AuthorText.Visible = false
        LoadBarBG.Visible = true
        PercentText.Visible = true
        for i = 0, 100 do
            PercentText.Text = tostring(i) .. "%"
            LoadBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
            task.wait(0.015)
        end
        IntroFrame:Destroy()
        ToggleButton.Visible = true
        SendNotification("Đã kích hoạt script thành công ✅")
    else
        SendNotification("Bạn đã nhập sai key, vui lòng thử lại ❌")
    end
end)

-- ==========================================
-- 2. KHUNG HUB & CHUYỂN TAB 
-- ==========================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 480)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "FASTER HUB V4 [VIP PRO]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local TabScroll = Instance.new("ScrollingFrame", MainFrame)
TabScroll.Size = UDim2.new(1, 0, 0, 35)
TabScroll.Position = UDim2.new(0, 0, 0, 30)
TabScroll.BackgroundTransparency = 1
TabScroll.CanvasSize = UDim2.new(1.5, 0, 0, 0)
TabScroll.ScrollBarThickness = 0
local TabListLayout = Instance.new("UIListLayout", TabScroll)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)

local function CreateTabBtn(name)
    local btn = Instance.new("TextButton", TabScroll)
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    return btn
end

local Tabs = {
    Home = CreateTabBtn("CHỨC NĂNG"),
    Troll = CreateTabBtn("TROLL & BẢO VỆ"),
    Aura = CreateTabBtn("AURA & SIZE"),
    Shader = CreateTabBtn("SHADER"),
    Set = CreateTabBtn("CÀI ĐẶT")
}

local Pages = {}
for k, _ in pairs(Tabs) do
    local page = Instance.new("ScrollingFrame", MainFrame)
    page.Size = UDim2.new(1, -20, 1, -80)
    page.Position = UDim2.new(0, 10, 0, 70)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.Visible = false
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 8)
    Pages[k] = page
end
Pages.Home.Visible = true
Tabs.Home.TextColor3 = Color3.fromRGB(255, 255, 255)

for k, btn in pairs(Tabs) do
    btn.MouseButton1Click:Connect(function()
        for pk, page in pairs(Pages) do page.Visible = (pk == k) end
        for tbk, tbb in pairs(Tabs) do tbb.TextColor3 = (tbk == k) and Color3.new(1,1,1) or Color3.fromRGB(150,150,150) end
    end)
end

-- ==========================================
-- 3. HÀM TẠO UI COMPONENT
-- ==========================================
local function CreateToggle(parent, name, defaultInput)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", Frame)

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local ToggleBtn = Instance.new("TextButton", Frame)
    ToggleBtn.Size = UDim2.new(0, 50, 0, 25)
    ToggleBtn.Position = UDim2.new(0.85, -10, 0.5, -12.5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.new(1,1,1)
    ToggleBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", ToggleBtn)

    local InputBox = nil
    if defaultInput then
        InputBox = Instance.new("TextBox", Frame)
        InputBox.Size = UDim2.new(0, 40, 0, 25)
        InputBox.Position = UDim2.new(0.7, -15, 0.5, -12.5)
        InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        InputBox.TextColor3 = Color3.new(1,1,1)
        InputBox.Text = tostring(defaultInput)
        Instance.new("UICorner", InputBox)
    end
    return ToggleBtn, InputBox
end

local function CreateButton(parent, name, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function CreateSlider(parent, name, min, max, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 50)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", Frame)

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0.5, 0, 0.5, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local ValueTxt = Instance.new("TextLabel", Frame)
    ValueTxt.Size = UDim2.new(0.3, 0, 0.5, 0)
    ValueTxt.Position = UDim2.new(0.65, 0, 0, 0)
    ValueTxt.BackgroundTransparency = 1
    ValueTxt.Text = tostring(default)
    ValueTxt.TextColor3 = Color3.new(1,1,1)
    ValueTxt.Font = Enum.Font.GothamBold
    ValueTxt.TextXAlignment = Enum.TextXAlignment.Right

    local SliderBg = Instance.new("TextButton", Frame)
    SliderBg.Size = UDim2.new(0.9, 0, 0, 10)
    SliderBg.Position = UDim2.new(0.05, 0, 0.65, 0)
    SliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    SliderBg.Text = ""
    Instance.new("UICorner", SliderBg)

    local SliderFill = Instance.new("Frame", SliderBg)
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    Instance.new("UICorner", SliderFill)

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(min + (max - min) * pos)
        ValueTxt.Text = tostring(val)
        callback(val)
    end
    SliderBg.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = true Update(inp) end end)
    UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    UserInputService.InputChanged:Connect(function(inp) if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then Update(inp) end end)
end

-- Dialog Cảnh Báo
local function ShowDialog(title, desc, confirmTxt, cancelTxt, confirmCallback)
    local BlockFrame = Instance.new("Frame", ScreenGui)
    BlockFrame.Size = UDim2.new(1, 0, 1, 0)
    BlockFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BlockFrame.BackgroundTransparency = 0.5
    BlockFrame.ZIndex = 200

    local Dlg = Instance.new("Frame", BlockFrame)
    Dlg.Size = UDim2.new(0, 300, 0, 150)
    Dlg.Position = UDim2.new(0.5, -150, 0.5, -75)
    Dlg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Dlg.ZIndex = 201
    Instance.new("UICorner", Dlg)

    local Ttl = Instance.new("TextLabel", Dlg)
    Ttl.Size = UDim2.new(1, 0, 0, 30)
    Ttl.BackgroundTransparency = 1
    Ttl.Text = title
    Ttl.TextColor3 = Color3.new(1,0,0)
    Ttl.Font = Enum.Font.GothamBold
    Ttl.TextSize = 16
    Ttl.ZIndex = 202

    local Txt = Instance.new("TextLabel", Dlg)
    Txt.Size = UDim2.new(0.9, 0, 0, 60)
    Txt.Position = UDim2.new(0.05, 0, 0, 30)
    Txt.BackgroundTransparency = 1
    Txt.Text = desc
    Txt.TextColor3 = Color3.new(1,1,1)
    Txt.Font = Enum.Font.Gotham
    Txt.TextSize = 13
    Txt.TextWrapped = true
    Txt.ZIndex = 202

    local YesBtn = Instance.new("TextButton", Dlg)
    YesBtn.Size = UDim2.new(0.4, 0, 0, 30)
    YesBtn.Position = UDim2.new(0.05, 0, 1, -40)
    YesBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    YesBtn.Text = confirmTxt
    YesBtn.Font = Enum.Font.GothamBold
    YesBtn.ZIndex = 202
    Instance.new("UICorner", YesBtn)

    local NoBtn = Instance.new("TextButton", Dlg)
    NoBtn.Size = UDim2.new(0.4, 0, 0, 30)
    NoBtn.Position = UDim2.new(0.55, 0, 1, -40)
    NoBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    NoBtn.Text = cancelTxt
    NoBtn.Font = Enum.Font.GothamBold
    NoBtn.ZIndex = 202
    Instance.new("UICorner", NoBtn)

    YesBtn.MouseButton1Click:Connect(function() BlockFrame:Destroy() confirmCallback(true) end)
    NoBtn.MouseButton1Click:Connect(function() BlockFrame:Destroy() confirmCallback(false) end)
end

local states = {}
local function RegisterToggle(btn, stateKey, callback)
    states[stateKey] = false
    btn.MouseButton1Click:Connect(function()
        states[stateKey] = not states[stateKey]
        btn.BackgroundColor3 = states[stateKey] and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        btn.Text = states[stateKey] and "ON" or "OFF"
        if callback then callback(states[stateKey]) end
    end)
end

-- ==========================================
-- 4. TAB 1: CHỨC NĂNG (HOME)
-- ==========================================
local wsBtn, wsBox = CreateToggle(Pages.Home, "Tốc Độ", 16)
local jpBtn, jpBox = CreateToggle(Pages.Home, "Nhảy (Jump)", 50)
local ncBtn, _ = CreateToggle(Pages.Home, "Xuyên Tường")

RegisterToggle(wsBtn, "WS", function(v) if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end end)
RegisterToggle(jpBtn, "JP", function(v) if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = 50 end end)
RegisterToggle(ncBtn, "NC")

-- Auto-Clicker Thông Minh
local acBtn, _ = CreateToggle(Pages.Home, "Auto-Clicker Thông Minh")
local AutoClickCircle = Instance.new("TextButton", ScreenGui)
AutoClickCircle.Size = UDim2.new(0, 50, 0, 50)
AutoClickCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AutoClickCircle.Text = "🖱️"
AutoClickCircle.Visible = false
AutoClickCircle.Draggable = true
AutoClickCircle.Active = true
Instance.new("UICorner", AutoClickCircle).CornerRadius = UDim.new(1, 0)

RegisterToggle(acBtn, "AutoClick", function(v)
    if v then
        acBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        acBtn.Text = "OFF"
        states.AutoClick = false
        ShowDialog("Cảnh Báo Auto-Click", "Nếu game bạn đang chơi là game hỗ trợ auto click thì hãy dùng ✅", "Đúng", "Không", function(agreed)
            if agreed then
                states.AutoClick = true
                acBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
                acBtn.Text = "ON"
                AutoClickCircle.Visible = true
            end
        end)
    else
        AutoClickCircle.Visible = false
    end
end)
RunService.RenderStepped:Connect(function()
    if states.AutoClick and AutoClickCircle.Visible then
        VirtualUser:ClickButton1(Vector2.new(0,0))
    end
end)

-- Fullbright
local fbBtn, _ = CreateToggle(Pages.Home, "Fullbright")
local oldAmbient = Lighting.Ambient
RegisterToggle(fbBtn, "Fullbright", function(v)
    if v then
        fbBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        fbBtn.Text = "OFF"
        states.Fullbright = false
        ShowDialog("Lưu ý⚠️", "Nếu game bạn là game có nhiều bóng tối thì hãy dùng, nếu không phải thì sẽ ảnh hưởng đến mắt.", "Tôi chấp nhận rủi ro ✅", "Từ chối ❌", function(agreed)
            if agreed then
                states.Fullbright = true
                fbBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
                fbBtn.Text = "ON"
                Lighting.Ambient = Color3.new(1, 1, 1)
                Lighting.Brightness = 2
                Lighting.GlobalShadows = false
            end
        end)
    else
        Lighting.Ambient = oldAmbient
        Lighting.GlobalShadows = true
    end
end)

-- Infinite Zoom
local ZoomFrame = Instance.new("Frame", Pages.Home)
ZoomFrame.Size = UDim2.new(1, 0, 0, 40)
ZoomFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", ZoomFrame)
local ZLbl = Instance.new("TextLabel", ZoomFrame)
ZLbl.Size = UDim2.new(0.5, 0, 1, 0)
ZLbl.Position = UDim2.new(0.05, 0, 0, 0)
ZLbl.BackgroundTransparency = 1
ZLbl.Text = "Infinite Zoom (FOVs)"
ZLbl.TextColor3 = Color3.new(1,1,1)
ZLbl.Font = Enum.Font.Gotham
ZLbl.TextSize = 13
local btnMin = Instance.new("TextButton", ZoomFrame)
btnMin.Size = UDim2.new(0, 30, 0, 30)
btnMin.Position = UDim2.new(0.65, 0, 0.5, -15)
btnMin.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnMin.Text = "-"
btnMin.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btnMin)
local btnPls = Instance.new("TextButton", ZoomFrame)
btnPls.Size = UDim2.new(0, 30, 0, 30)
btnPls.Position = UDim2.new(0.85, 0, 0.5, -15)
btnPls.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnPls.Text = "+"
btnPls.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btnPls)

btnMin.MouseButton1Click:Connect(function() Camera.FieldOfView = math.max(10, Camera.FieldOfView - 10) LocalPlayer.CameraMaxZoomDistance = math.huge end)
btnPls.MouseButton1Click:Connect(function() Camera.FieldOfView = math.min(120, Camera.FieldOfView + 10) LocalPlayer.CameraMaxZoomDistance = math.huge end)

Pages.Home.CanvasSize = UDim2.new(0, 0, 0, 350)

-- ==========================================
-- 5. TAB 2: TROLL & BẢO VỆ
-- ==========================================
local spinBtn, _ = CreateToggle(Pages.Troll, "Spin Bot")
local flingBtn, flingBox = CreateToggle(Pages.Troll, "Fling Aura (Power)", 50)
local antikickBtn, _ = CreateToggle(Pages.Troll, "Anti-Kick (Yêu cầu hook)")
local antiflingBtn, _ = CreateToggle(Pages.Troll, "Anti-Fling")
local antivoidBtn, _ = CreateToggle(Pages.Troll, "Anti-Void")
local safeZoneBtn, _ = CreateToggle(Pages.Troll, "Safe Zone Teleport")

local SafeBtnUI = Instance.new("TextButton", ScreenGui)
SafeBtnUI.Size = UDim2.new(0, 50, 0, 50)
SafeBtnUI.Position = UDim2.new(1, -70, 0.5, 0)
SafeBtnUI.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SafeBtnUI.Text = "🟩"
SafeBtnUI.TextSize = 25
SafeBtnUI.Visible = false
Instance.new("UICorner", SafeBtnUI)

RegisterToggle(safeZoneBtn, "SafeZone", function(v) SafeBtnUI.Visible = v end)
SafeBtnUI.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local spawnLoc = workspace:FindFirstChildOfClass("SpawnLocation")
    if char and char:FindFirstChild("HumanoidRootPart") and spawnLoc then
        char.HumanoidRootPart.CFrame = spawnLoc.CFrame + Vector3.new(0, 5, 0)
    end
end)

RegisterToggle(spinBtn, "SpinBot")
RegisterToggle(flingBtn, "Fling")
RegisterToggle(antiflingBtn, "AntiFling")

-- Anti-Kick (Hook)
RegisterToggle(antikickBtn, "AntiKick", function(v)
    if v then
        pcall(function()
            local oldNM
            oldNM = hookmetamethod(game, "__namecall", function(self, ...)
                if states.AntiKick and self == LocalPlayer and getnamecallmethod() == "Kick" then return end
                return oldNM(self, ...)
            end)
        end)
    end
end)

local spawnPoint = Vector3.new(0, 50, 0)
RegisterToggle(antivoidBtn, "AntiVoid", function(v)
    if v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        spawnPoint = LocalPlayer.Character.HumanoidRootPart.Position
    end
end)

Pages.Troll.CanvasSize = UDim2.new(0, 0, 0, 400)

-- ==========================================
-- LOOP XỬ LÝ CHÍNH
-- ==========================================
local SpinForce
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if states.WS and hum then hum.WalkSpeed = tonumber(wsBox.Text) or 16 end
    if states.JP and hum then hum.JumpPower = tonumber(jpBox.Text) or 50 hum.UseJumpPower = true end
    if states.NC then for _, part in pairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
    
    if states.SpinBot and hrp then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(50), 0)
    end

    if states.Fling and hrp then
        if not SpinForce then
            SpinForce = Instance.new("BodyAngularVelocity", hrp)
            SpinForce.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        end
        SpinForce.AngularVelocity = Vector3.new(0, tonumber(flingBox.Text) or 50, 0)
    else
        if SpinForce then SpinForce:Destroy() SpinForce = nil end
    end

    if states.AntiFling then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local otherHRP = plr.Character.HumanoidRootPart
                if (otherHRP.Position - hrp.Position).Magnitude < 10 and otherHRP.Velocity.Magnitude > 50 then
                    for _, p in pairs(plr.Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end
            end
        end
    end

    if states.AntiVoid and hrp then
        if hrp.Position.Y < (workspace.FallenPartsDestroyHeight + 20) then
            hrp.CFrame = CFrame.new(spawnPoint)
            hrp.Velocity = Vector3.new(0,0,0)
        end
    end
end)
-- ==========================================
-- 6. TAB 3: AURA & SIZE
-- ==========================================
local haloBtn, _ = CreateToggle(Pages.Aura, "Halo Aura")
local fireBtn, _ = CreateToggle(Pages.Aura, "Fire Aura")
local smokeBtn, _ = CreateToggle(Pages.Aura, "Smoke Aura")
local hitBtn, _ = CreateToggle(Pages.Aura, "Hit Effect")

local function CreateParticle(name, tex, color, size)
    local p = Instance.new("ParticleEmitter")
    p.Name = name
    p.Texture = tex
    p.Color = ColorSequence.new(color)
    p.Size = NumberSequence.new(size)
    p.Rate = 20
    p.Speed = NumberRange.new(2, 4)
    p.Lifetime = NumberRange.new(1, 2)
    return p
end

RegisterToggle(haloBtn, "Halo", function(v)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        if v then
            local p = CreateParticle("HaloFX", "rbxassetid://1344840003", Color3.fromRGB(255, 255, 0), 2)
            p.Parent = char.Head
        else
            if char.Head:FindFirstChild("HaloFX") then char.Head.HaloFX:Destroy() end
        end
    end
end)

RegisterToggle(fireBtn, "Fire", function(v)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if v then
            local f = Instance.new("Fire", char.HumanoidRootPart)
            f.Name = "FireFX"
            f.Size = 8
        else
            if char.HumanoidRootPart:FindFirstChild("FireFX") then char.HumanoidRootPart.FireFX:Destroy() end
        end
    end
end)

RegisterToggle(smokeBtn, "Smoke", function(v)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if v then
            local s = Instance.new("Smoke", char.HumanoidRootPart)
            s.Name = "SmokeFX"
            s.Size = 5
        else
            if char.HumanoidRootPart:FindFirstChild("SmokeFX") then char.HumanoidRootPart.SmokeFX:Destroy() end
        end
    end
end)

RegisterToggle(hitBtn, "HitFX")
LocalPlayer:GetMouse().Button1Down:Connect(function()
    if states.HitFX and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local p = CreateParticle("HitSpark", "rbxassetid://243660364", Color3.fromRGB(255,0,0), 3)
        p.Rate = 100
        p.Parent = LocalPlayer.Character.HumanoidRootPart
        task.delay(0.2, function() p:Destroy() end)
    end
end)

CreateSlider(Pages.Aura, "Head Size", 0, 100, 50, function(val)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum:FindFirstChild("HeadScale") then hum.HeadScale.Value = val / 50 end
end)
CreateSlider(Pages.Aura, "Body Size (Width)", 0, 100, 50, function(val)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum:FindFirstChild("BodyWidthScale") then hum.BodyWidthScale.Value = val / 50 end
end)
CreateSlider(Pages.Aura, "Hand/Arm Size", 0, 100, 50, function(val)
    -- Tùy thuộc game R15, dùng ProportionScale
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum:FindFirstChild("ProportionScale") then hum.ProportionScale.Value = val / 50 end
end)
CreateSlider(Pages.Aura, "Foot/Leg Size", 0, 100, 50, function(val)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum and hum:FindFirstChild("BodyHeightScale") then hum.BodyHeightScale.Value = val / 50 end
end)

Pages.Aura.CanvasSize = UDim2.new(0, 0, 0, 500)

-- ==========================================
-- 7. TAB 4: SHADER (MÔI TRƯỜNG ĐẸP)
-- ==========================================
local function ClearShaders()
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
            v:Destroy()
        end
    end
end

CreateButton(Pages.Shader, "☀️ Daytime Shader", function()
    ClearShaders()
    Lighting.ClockTime = 14
    Lighting.Brightness = 3
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
    local bloom = Instance.new("BloomEffect", Lighting) bloom.Intensity = 0.5
    local cc = Instance.new("ColorCorrectionEffect", Lighting) cc.Saturation = 0.5 cc.Contrast = 0.2
    local sun = Instance.new("SunRaysEffect", Lighting) sun.Intensity = 0.1
    SendNotification("Đã đổi sang Daytime!")
end)

CreateButton(Pages.Shader, "🌅 Sunset Shader", function()
    ClearShaders()
    Lighting.ClockTime = 17.8
    Lighting.Brightness = 2.5
    Lighting.OutdoorAmbient = Color3.fromRGB(150, 100, 50)
    local bloom = Instance.new("BloomEffect", Lighting) bloom.Intensity = 0.8
    local cc = Instance.new("ColorCorrectionEffect", Lighting) cc.Saturation = 0.8 cc.Contrast = 0.4 cc.TintColor = Color3.fromRGB(255, 200, 150)
    local sun = Instance.new("SunRaysEffect", Lighting) sun.Intensity = 0.25
    SendNotification("Đã đổi sang Sunset!")
end)

CreateButton(Pages.Shader, "🌙 Night Shader", function()
    ClearShaders()
    Lighting.ClockTime = 0
    Lighting.Brightness = 1
    Lighting.OutdoorAmbient = Color3.fromRGB(20, 20, 50)
    local cc = Instance.new("ColorCorrectionEffect", Lighting) cc.Saturation = 0.2 cc.Contrast = 0.1 cc.TintColor = Color3.fromRGB(180, 180, 255)
    SendNotification("Đã đổi sang Night!")
end)

CreateButton(Pages.Shader, "☁️ Cloudy Shader", function()
    ClearShaders()
    Lighting.ClockTime = 12
    Lighting.Brightness = 1.5
    Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 130)
    local atmo = Instance.new("Atmosphere", Lighting)
    atmo.Density = 0.5
    atmo.Color = Color3.fromRGB(150, 150, 150)
    local cc = Instance.new("ColorCorrectionEffect", Lighting) cc.Saturation = -0.2 cc.Contrast = -0.1
    SendNotification("Đã đổi sang Cloudy!")
end)

Pages.Shader.CanvasSize = UDim2.new(0, 0, 0, 300)

-- ==========================================
-- 8. TAB 5: CÀI ĐẶT
-- ==========================================
local function CreateSelector(parent, name, options, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", Frame)

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local currentIndex = 1
    local ValueTxt = Instance.new("TextLabel", Frame)
    ValueTxt.Size = UDim2.new(0, 100, 0, 30)
    ValueTxt.Position = UDim2.new(0.45, 30, 0.5, -15)
    ValueTxt.BackgroundTransparency = 1
    ValueTxt.Text = options[1].name
    ValueTxt.TextColor3 = Color3.new(1,1,1)
    ValueTxt.Font = Enum.Font.GothamBold

    local function update() ValueTxt.Text = options[currentIndex].name callback(options[currentIndex].val) end

    local LeftBtn = Instance.new("TextButton", Frame) LeftBtn.Size = UDim2.new(0,30,0,30) LeftBtn.Position = UDim2.new(0.45,0,0.5,-15) LeftBtn.Text = "<" Instance.new("UICorner", LeftBtn)
    LeftBtn.MouseButton1Click:Connect(function() currentIndex = currentIndex - 1 if currentIndex < 1 then currentIndex = #options end update() end)
    
    local RightBtn = Instance.new("TextButton", Frame) RightBtn.Size = UDim2.new(0,30,0,30) RightBtn.Position = UDim2.new(0.45,130,0.5,-15) RightBtn.Text = ">" Instance.new("UICorner", RightBtn)
    RightBtn.MouseButton1Click:Connect(function() currentIndex = currentIndex + 1 if currentIndex > #options then currentIndex = 1 end update() end)
end

CreateSelector(Pages.Set, "Màu Nền Hub", {{name="Đen",val=Color3.fromRGB(25,25,25)}, {name="Đỏ",val=Color3.fromRGB(40,15,15)}, {name="Xanh",val=Color3.fromRGB(15,20,40)}}, function(v) MainFrame.BackgroundColor3 = v end)

Pages.Set.CanvasSize = UDim2.new(0, 0, 0, 200)
