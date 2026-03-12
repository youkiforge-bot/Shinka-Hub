-- =============================================
-- MEU SCRIPT - VELOCIDADE + FLY + NOCLIP + ESP + AIMBOT + TELEPORTE
-- =============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHub"
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Janela principal (altura aumentada para caber tudo)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 500)
frame.Position = UDim2.new(0.5, -150, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 30)
titulo.Text = "Meu Script - Completo+"
titulo.TextColor3 = Color3.new(1, 1, 1)
titulo.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
titulo.Parent = frame
Instance.new("UICorner", titulo).CornerRadius = UDim.new(0, 8)

-- Área de conteúdo (com rolagem, se necessário)
local area = Instance.new("ScrollingFrame")
area.Size = UDim2.new(1, -20, 1, -40)
area.Position = UDim2.new(0, 10, 0, 35)
area.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
area.CanvasSize = UDim2.new(0, 0, 0, 700) -- Altura maior que a área para rolagem
area.ScrollBarThickness = 6
area.Parent = frame
Instance.new("UICorner", area).CornerRadius = UDim.new(0, 6)

-- ========== VELOCIDADE ==========
local speedEnabled = true
local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0.9, 0, 0, 30)
speedButton.Position = UDim2.new(0.05, 0, 0, 10)
speedButton.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
speedButton.Text = "Speed: ON"
speedButton.TextColor3 = Color3.new(1, 1, 1)
speedButton.Font = Enum.Font.GothamSemibold
speedButton.TextSize = 16
speedButton.Parent = area
Instance.new("UICorner", speedButton).CornerRadius = UDim.new(0, 6)

local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(0.9, 0, 0, 25)
speedText.Position = UDim2.new(0.05, 0, 0, 50)
speedText.BackgroundTransparency = 1
speedText.Text = "Velocidade: 16"
speedText.TextColor3 = Color3.fromRGB(200, 200, 200)
speedText.Font = Enum.Font.Gotham
speedText.TextSize = 14
speedText.TextXAlignment = Enum.TextXAlignment.Left
speedText.Visible = true
speedText.Parent = area

local slider = Instance.new("Frame")
slider.Size = UDim2.new(0.9, 0, 0, 5)
slider.Position = UDim2.new(0.05, 0, 0, 80)
slider.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
slider.Visible = true
slider.Parent = area
Instance.new("UICorner", slider).CornerRadius = UDim.new(1, 0)

local sliderButton = Instance.new("TextButton")
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new(0.5, -10, 0, -7.5)
sliderButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
sliderButton.Text = ""
sliderButton.Parent = slider
Instance.new("UICorner", sliderButton).CornerRadius = UDim.new(1, 0)

local dragging = false
local speed = 16

speedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedButton.Text = "Speed: " .. (speedEnabled and "ON" or "OFF")
    speedButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)
    
    speedText.Visible = speedEnabled
    slider.Visible = speedEnabled
    
    if not speedEnabled then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

sliderButton.MouseButton1Down:Connect(function()
    dragging = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and speedEnabled then
        local mouseX = UserInputService:GetMouseLocation().X
        local sliderX = slider.AbsolutePosition.X
        local sliderW = slider.AbsoluteSize.X
        local rel = math.clamp(mouseX - sliderX, 0, sliderW)
        local perc = rel / sliderW
        speed = 16 + math.floor(perc * 100)
        sliderButton.Position = UDim2.new(perc, -10, 0, -7.5)
        speedText.Text = "Velocidade: " .. speed
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

-- ========== FLY ==========
local flyEnabled = false
local flyConnection = nil
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.9, 0, 0, 35)
flyButton.Position = UDim2.new(0.05, 0, 0, 130)
flyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
flyButton.Text = "Fly: OFF"
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.Font = Enum.Font.GothamSemibold
flyButton.TextSize = 16
flyButton.Parent = area
Instance.new("UICorner", flyButton).CornerRadius = UDim.new(0, 6)

flyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyButton.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    flyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if flyEnabled then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if humanoid and root then
                humanoid.PlatformStand = true
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.P = 9e4
                bodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
                bodyGyro.CFrame = root.CFrame
                bodyGyro.Parent = root

                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
                bodyVelocity.Parent = root

                flyConnection = RunService.RenderStepped:Connect(function()
                    if not flyEnabled then
                        if bodyGyro and bodyGyro.Parent then bodyGyro:Destroy() end
                        if bodyVelocity and bodyVelocity.Parent then bodyVelocity:Destroy() end
                        if humanoid then humanoid.PlatformStand = false end
                        if flyConnection then flyConnection:Disconnect() end
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
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local bg = root:FindFirstChildOfClass("BodyGyro")
                if bg then bg:Destroy() end
                local bv = root:FindFirstChildOfClass("BodyVelocity")
                if bv then bv:Destroy() end
            end
        end
    end
end)

-- ========== NOCLIP ==========
local noclipEnabled = false
local noclipConnection = nil
local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0.9, 0, 0, 35)
noclipButton.Position = UDim2.new(0.05, 0, 0, 175)
noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
noclipButton.Text = "Noclip: OFF"
noclipButton.TextColor3 = Color3.new(1, 1, 1)
noclipButton.Font = Enum.Font.GothamSemibold
noclipButton.TextSize = 16
noclipButton.Parent = area
Instance.new("UICorner", noclipButton).CornerRadius = UDim.new(0, 6)

noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    noclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

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

-- ========== ESP ==========
local espEnabled = true
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0.9, 0, 0, 35)
espButton.Position = UDim2.new(0.05, 0, 0, 220)
espButton.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
espButton.Text = "ESP: ON"
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.Font = Enum.Font.GothamSemibold
espButton.TextSize = 16
espButton.Parent = area
Instance.new("UICorner", espButton).CornerRadius = UDim.new(0, 6)

-- Variáveis do ESP
local espObjects = {}

-- Função para criar ESP em um jogador
local function createESP(player)
    if player == LocalPlayer or not player.Character then return end
    
    local character = player.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    if not rootPart then return end
    
    -- Remove ESP antigo se existir
    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do
            pcall(function() obj:Destroy() end)
        end
    end
    
    -- Criar Highlight (contorno)
    local highlight = Instance.new("Highlight")
    highlight.Name = "MeuESP"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    
    -- Criar BillboardGui (nome e distância)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "MeuESP_Text"
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
    
    espObjects[player] = {highlight, billboard}
end

-- Criar ESP para jogadores existentes
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        task.spawn(function()
            if player.Character then
                task.wait(1)
                createESP(player)
            end
        end)
    end
end

-- Eventos de jogadores
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        createESP(player)
    end)
    if player.Character then
        task.wait(1)
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do
            pcall(function() obj:Destroy() end)
        end
        espObjects[player] = nil
    end
end)

-- Atualizar ESP
RunService.RenderStepped:Connect(function()
    for player, objects in pairs(espObjects) do
        if player and player.Character and player.Character.Parent then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid and humanoid.Health > 0 then
                if espEnabled then
                    local dist = (Camera.CFrame.Position - rootPart.Position).Magnitude
                    local healthPercent = humanoid.Health / humanoid.MaxHealth
                    objects[1].FillColor = Color3.new(1 - healthPercent, healthPercent, 0)
                    objects[1].Enabled = true
                    objects[2].Enabled = true
                    for _, label in pairs(objects[2]:GetChildren()) do
                        if label:IsA("TextLabel") and label.Text:match("%.1fm") then
                            label.Text = string.format("%.1fm", dist)
                        end
                    end
                else
                    objects[1].Enabled = false
                    objects[2].Enabled = false
                end
            else
                objects[1].Enabled = false
                objects[2].Enabled = false
            end
        end
    end
end)

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    espButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)
end)

-- ========== AIMBOT ==========
local aimbotEnabled = false
local aimbotButton = Instance.new("TextButton")
aimbotButton.Size = UDim2.new(0.9, 0, 0, 35)
aimbotButton.Position = UDim2.new(0.05, 0, 0, 265)
aimbotButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
aimbotButton.Text = "Aimbot: OFF"
aimbotButton.TextColor3 = Color3.new(1, 1, 1)
aimbotButton.Font = Enum.Font.GothamSemibold
aimbotButton.TextSize = 16
aimbotButton.Parent = area
Instance.new("UICorner", aimbotButton).CornerRadius = UDim.new(0, 6)

-- Slider de FOV
local fovText = Instance.new("TextLabel")
fovText.Size = UDim2.new(0.9, 0, 0, 25)
fovText.Position = UDim2.new(0.05, 0, 0, 310)
fovText.BackgroundTransparency = 1
fovText.Text = "FOV: 90"
fovText.TextColor3 = Color3.fromRGB(200, 200, 200)
fovText.Font = Enum.Font.Gotham
fovText.TextSize = 14
fovText.TextXAlignment = Enum.TextXAlignment.Left
fovText.Visible = true
fovText.Parent = area

local fovSlider = Instance.new("Frame")
fovSlider.Size = UDim2.new(0.9, 0, 0, 5)
fovSlider.Position = UDim2.new(0.05, 0, 0, 340)
fovSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
fovSlider.Visible = true
fovSlider.Parent = area
Instance.new("UICorner", fovSlider).CornerRadius = UDim.new(1, 0)

local fovButton = Instance.new("TextButton")
fovButton.Size = UDim2.new(0, 20, 0, 20)
fovButton.Position = UDim2.new(0.5, -10, 0, -7.5)
fovButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
fovButton.Text = ""
fovButton.Parent = fovSlider
Instance.new("UICorner", fovButton).CornerRadius = UDim.new(1, 0)

local fovDragging = false
local fov = 90

fovButton.MouseButton1Down:Connect(function()
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
        local sliderX = fovSlider.AbsolutePosition.X
        local sliderW = fovSlider.AbsoluteSize.X
        local rel = math.clamp(mouseX - sliderX, 0, sliderW)
        local perc = rel / sliderW
        fov = 30 + math.floor(perc * 270)
        fovButton.Position = UDim2.new(perc, -10, 0, -7.5)
        fovText.Text = "FOV: " .. fov
    end
end)

local function IsEnemy(player)
    if not LocalPlayer.Team or not player.Team then return true end
    return LocalPlayer.Team ~= player.Team
end

aimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotButton.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
    aimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestTarget = nil
        local closestDist = fov
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and IsEnemy(player) then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local screenPoint, onScreen = Camera:WorldToScreenPoint(head.Position)
                    if onScreen then
                        local mousePos = UserInputService:GetMouseLocation()
                        local dist = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closestTarget = head
                        end
                    end
                end
            end
        end
        if closestTarget then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, closestTarget.Position), 0.3)
        end
    end
end)

-- ========== TELEPORTE ==========
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0.9, 0, 0, 35)
teleportButton.Position = UDim2.new(0.05, 0, 0, 380)
teleportButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
teleportButton.Text = "Teleport: Selecionar"
teleportButton.TextColor3 = Color3.new(1, 1, 1)
teleportButton.Font = Enum.Font.GothamSemibold
teleportButton.TextSize = 16
teleportButton.Parent = area
Instance.new("UICorner", teleportButton).CornerRadius = UDim.new(0, 6)

local selectedPlayer = nil
local playerList = {}

teleportButton.MouseButton1Click:Connect(function()
    -- Atualiza lista de jogadores
    playerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    if #playerList > 0 then
        -- Simples: escolhe o primeiro da lista (poderia ser melhorado com um dropdown)
        selectedPlayer = playerList[1]
        teleportButton.Text = "Teleport: " .. selectedPlayer
    else
        selectedPlayer = nil
        teleportButton.Text = "Teleport: Nenhum jogador"
    end
end)

local teleportAction = Instance.new("TextButton")
teleportAction.Size = UDim2.new(0.9, 0, 0, 35)
teleportAction.Position = UDim2.new(0.05,
