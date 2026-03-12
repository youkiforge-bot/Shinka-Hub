-- Shinka Hub – Versão Final Simplificada (Tudo Funcional + Discord)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinkaHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Janela principal (começa com altura 0 para animação)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 0)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 150, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Shinka Hub"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Botão minimizar
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0, 2.5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TitleBar
MinimizeButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Botão fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 2.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Parent = TitleBar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Botão flutuante para reabrir (SH)
local ReopenButton = Instance.new("TextButton")
ReopenButton.Size = UDim2.new(0, 50, 0, 50)
ReopenButton.Position = UDim2.new(0, 10, 0.5, -25)
ReopenButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
ReopenButton.Text = "SH"
ReopenButton.TextColor3 = Color3.new(1, 1, 1)
ReopenButton.Font = Enum.Font.GothamBold
ReopenButton.TextSize = 20
ReopenButton.Parent = ScreenGui
ReopenButton.Visible = false
ReopenButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = true
    MainFrame.Size = UDim2.new(0, 300, 0, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 400)}):Play()
    ReopenButton.Visible = false
end)

MinimizeButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
    ReopenButton.Visible = true
end)

-- Animação de abertura inicial
TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 400)}):Play()

-- Abas
local Tabs = {"Movement", "Visuals", "ESP", "Aimbot", "Discord"}
local TabButtons = {}
for i = 1, 5 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 55, 0, 30)
    btn.Position = UDim2.new(0, 5 + (i - 1) * 58, 0, 35)
    btn.Text = Tabs[i]
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.Parent = MainFrame
    TabButtons[i] = btn
end

-- Área de conteúdo
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -20, 0, 300)
ContentArea.Position = UDim2.new(0, 10, 0, 70)
ContentArea.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ContentArea.Parent = MainFrame
Instance.new("UICorner", ContentArea).CornerRadius = UDim.new(0, 8)

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -20, 1, -20)
ContentContainer.Position = UDim2.new(0, 10, 0, 10)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = ContentArea

-- Função auxiliar para criar botões dentro das abas
local function CreateButton(parent, yPos, text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 70)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    return btn
end

-- ===== ABA MOVEMENT =====
local MovementFrame = Instance.new("Frame")
MovementFrame.Size = UDim2.new(1, 0, 1, 0)
MovementFrame.BackgroundTransparency = 1
MovementFrame.Parent = ContentContainer

-- Slider de velocidade
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0.05, 0, 0, 10)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Walkspeed: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.Parent = MovementFrame

local SpeedSlider = Instance.new("Frame")
SpeedSlider.Size = UDim2.new(0.9, 0, 0, 5)
SpeedSlider.Position = UDim2.new(0.05, 0, 0, 35)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
SpeedSlider.Parent = MovementFrame

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0, 20, 0, 20)
SpeedButton.Position = UDim2.new(0.5, -10, 0, -7.5)
SpeedButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
SpeedButton.Text = ""
SpeedButton.Parent = SpeedSlider

local speed = 16
local speedDragging = false
SpeedButton.MouseButton1Down:Connect(function()
    speedDragging = true
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        speedDragging = false
    end
end)
RunService.RenderStepped:Connect(function()
    if speedDragging then
        local mouseX = UserInputService:GetMouseLocation().X
        local sliderX = SpeedSlider.AbsolutePosition.X
        local sliderW = SpeedSlider.AbsoluteSize.X
        local relative = math.clamp(mouseX - sliderX, 0, sliderW)
        local percent = relative / sliderW
        speed = 16 + math.floor(percent * 100)
        SpeedButton.Position = UDim2.new(percent, -10, 0, -7.5)
        SpeedLabel.Text = "Walkspeed: " .. speed
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

-- Fly
local flyEnabled = false
local flyConnection = nil
local FlyButton = CreateButton(MovementFrame, 70, "Fly: OFF", nil, function()
    flyEnabled = not flyEnabled
    FlyButton.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    FlyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if flyEnabled then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoid and rootPart then
                humanoid.PlatformStand = true
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.P = 9e4
                bodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
                bodyGyro.CFrame = rootPart.CFrame
                bodyGyro.Parent = rootPart

                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
                bodyVelocity.Parent = rootPart

                flyConnection = RunService.RenderStepped:Connect(function()
                    if not flyEnabled then
                        bodyGyro:Destroy()
                        bodyVelocity:Destroy()
                        humanoid.PlatformStand = false
                        flyConnection:Disconnect()
                        return
                    end
                    local move = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
                    bodyVelocity.Velocity = move * 50
                    bodyGyro.CFrame = Camera.CFrame
                end)
            end
        end
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local bodyGyro = rootPart:FindFirstChildOfClass("BodyGyro")
                if bodyGyro then bodyGyro:Destroy() end
                local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
                if bodyVelocity then bodyVelocity:Destroy() end
            end
        end
    end
end)

-- Noclip
local noclipEnabled = false
local noclipConnection = nil
local NoclipButton = CreateButton(MovementFrame, 110, "Noclip: OFF", nil, function()
    noclipEnabled = not noclipEnabled
    NoclipButton.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    NoclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end)

-- ===== ABA VISUALS =====
local VisualsFrame = Instance.new("Frame")
VisualsFrame.Size = UDim2.new(1, 0, 1, 0)
VisualsFrame.BackgroundTransparency = 1
VisualsFrame.Parent = ContentContainer
VisualsFrame.Visible = false

local originalBrightness = Lighting.Brightness
local originalFogEnd = Lighting.FogEnd
local originalShadows = Lighting.GlobalShadows

local fullbrightEnabled = false
local FullbrightButton = CreateButton(VisualsFrame, 10, "Fullbright: OFF", nil, function()
    fullbrightEnabled = not fullbrightEnabled
    FullbrightButton.Text = "Fullbright: " .. (fullbrightEnabled and "ON" or "OFF")
    FullbrightButton.BackgroundColor3 = fullbrightEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if fullbrightEnabled then
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.new(1, 1, 1)
    else
        Lighting.Brightness = originalBrightness
        Lighting.GlobalShadows = originalShadows
        Lighting.Ambient = Color3.new(0, 0, 0)
    end
end)

local noFogEnabled = false
local NoFogButton = CreateButton(VisualsFrame, 60, "No Fog: OFF", nil, function()
    noFogEnabled = not noFogEnabled
    NoFogButton.Text = "No Fog: " .. (noFogEnabled and "ON" or "OFF")
    NoFogButton.BackgroundColor3 = noFogEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if noFogEnabled then
        Lighting.FogEnd = 1e5
    else
        Lighting.FogEnd = originalFogEnd
    end
end)

-- ===== ABA ESP =====
local ESPFrame = Instance.new("Frame")
ESPFrame.Size = UDim2.new(1, 0, 1, 0)
ESPFrame.BackgroundTransparency = 1
ESPFrame.Parent = ContentContainer
ESPFrame.Visible = false

local ESPInfo = Instance.new("TextLabel")
ESPInfo.Size = UDim2.new(0.9, 0, 0, 60)
ESPInfo.Position = UDim2.new(0.05, 0, 0, 10)
ESPInfo.BackgroundTransparency = 1
ESPInfo.Text = "ESP ativo automaticamente.\nContorno colorido por vida e etiqueta com distância."
ESPInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
ESPInfo.TextWrapped = true
ESPInfo.Parent = ESPFrame

-- Código ESP (funcional)
local ESPObjects = {}
local function CreateESP(player)
    if player == LocalPlayer or not player.Character then return end
    local character = player.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    if not rootPart then return end

    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            pcall(function() obj:Destroy() end)
        end
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ShinkaESP"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ShinkaESP_Text"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = rootPart

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboard

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.4, 0)
    distLabel.Position = UDim2.new(0, 0, 0.6, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "0m"
    distLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.Parent = billboard

    ESPObjects[player] = {highlight, billboard}
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        CreateESP(player)
    end)
    if player.Character then
        task.wait(1)
        CreateESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            pcall(function() obj:Destroy() end)
        end
        ESPObjects[player] = nil
    end
end)

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character then
        task.spawn(function()
            task.wait(1)
            CreateESP(player)
        end)
    end
end

RunService.RenderStepped:Connect(function()
    for player, objects in pairs(ESPObjects) do
        if player and player.Character and player.Character.Parent then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if rootPart and humanoid and humanoid.Health > 0 then
                local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                objects[1].FillColor = Color3.new(1 - healthPercent, healthPercent, 0)

                if objects[2] then
                    objects[2].Enabled = true
                    for _, label in pairs(objects[2]:GetChildren()) do
                        if label:IsA("TextLabel") and label.Text:match("%.1fm") then
                            label.Text = string.format("%.1fm", dist)
                        end
                    end
                end
            else
                if objects[2] then
                    objects[2].Enabled = false
                end
            end
        end
    end
end)

-- ===== ABA AIMBOT =====
local AimbotFrame = Instance.new("Frame")
AimbotFrame.Size = UDim2.new(1, 0, 1, 0)
AimbotFrame.BackgroundTransparency = 1
AimbotFrame.Parent = ContentContainer
AimbotFrame.Visible = false

local aimbotEnabled = false
local AimbotButton = CreateButton(AimbotFrame, 10, "Aimbot: OFF", nil, function()
    aimbotEnabled = not aimbotEnabled
    AimbotButton.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
    AimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)
end)

local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(0.9, 0, 0, 20)
FOVLabel.Position = UDim2.new(0.05, 0, 0, 60)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "FOV: 90"
FOVLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
FOVLabel.Parent = AimbotFrame

local FOVSlider = Instance.new("Frame")
FOVSlider.Size = UDim2.new(0.9, 0, 0, 5)
FOVSlider.Position = UDim2.new(0.05, 0, 0, 85)
FOVSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
FOVSlider.Parent = AimbotFrame

local FOVButton = Instance.new("TextButton")
FOVButton.Size = UDim2.new(0, 20, 0, 20)
FOVButton.Position = UDim2.new(0.5, -10, 0, -7.5)
FOVButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
FOVButton.Text = ""
FOVButton.Parent = FOVSlider

local fov = 90
local fovDragging = false
FOVButton.MouseButton1Down:Connect(function()
    fovDragging = true
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        fovDragging = false
    end
end)
RunService.RenderStepped:Connect(function()
    if fovDragging then
        local mouseX = UserInputService:GetMouseLocation().X
        local sliderX = FOVSlider.AbsolutePosition.X
        local sliderW = FOVSlider.AbsoluteSize.X
        local relative = math.clamp(mouseX - sliderX, 0, sliderW)
        local percent = relative / sliderW
        fov = 30 + math.floor(percent * 270)
        FOVButton.Position = UDim2.new(percent, -10, 0, -7.5)
        FOVLabel.Text = "FOV: " .. fov
    end
end)

local function IsEnemy(player)
    if not LocalPlayer.Team or not player.Team then return true end
    return LocalPlayer.Team ~= player.Team
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestTarget = nil
        local closestDistance = fov
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and IsEnemy(player) then
                local head = player.Character:FindFirstChild("Head")
      
