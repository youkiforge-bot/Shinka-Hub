-- =============================================
-- SHINKA HUB - ESTILO SPEED HUB X
-- =============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHub"
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Janela principal (começa com altura 0 para animação)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 0) -- Largura maior para caber abas
frame.Position = UDim2.new(0.5, -200, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(100, 0, 255)

-- Barra de título
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 200, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Shinka Hub | Version 4.0"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Botão minimizar
local minButton = Instance.new("TextButton")
minButton.Size = UDim2.new(0, 25, 0, 25)
minButton.Position = UDim2.new(1, -60, 0, 2.5)
minButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
minButton.Text = "−"
minButton.TextColor3 = Color3.new(1, 1, 1)
minButton.Font = Enum.Font.GothamBold
minButton.TextSize = 20
minButton.Parent = titleBar

-- Botão fechar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 2.5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Parent = titleBar
closeButton.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Botão flutuante para reabrir (logo)
local reopenButton = Instance.new("TextButton")
reopenButton.Size = UDim2.new(0, 100, 0, 40)
reopenButton.Position = UDim2.new(0, 10, 0.5, -20)
reopenButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
reopenButton.Text = "ShinkaHub"
reopenButton.TextColor3 = Color3.new(1, 1, 1)
reopenButton.Font = Enum.Font.GothamBold
reopenButton.TextSize = 18
reopenButton.Parent = gui
reopenButton.Visible = false
Instance.new("UICorner", reopenButton).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", reopenButton).Color = Color3.fromRGB(150, 150, 255)

reopenButton.MouseButton1Click:Connect(function()
    gui.Enabled = true
    frame.Size = UDim2.new(0, 400, 0, 0)
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 500)}):Play()
    reopenButton.Visible = false
end)

minButton.MouseButton1Click:Connect(function()
    gui.Enabled = false
    reopenButton.Visible = true
end)

-- Animação de abertura inicial
TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 500)}):Play()

-- Abas
local tabs = {"Movement", "Visuals", "ESP", "Aimbot", "Teleport"}
local tabButtons = {}
local tabFrames = {}

-- Criar botões das abas
for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 70, 0, 30)
    btn.Position = UDim2.new(0, 10 + (i-1)*75, 0, 35)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    tabButtons[i] = btn
end

-- Área de conteúdo
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -20, 1, -80)
contentArea.Position = UDim2.new(0, 10, 0, 70)
contentArea.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
contentArea.Parent = frame
Instance.new("UICorner", contentArea).CornerRadius = UDim.new(0, 8)

-- Container para os frames das abas
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -20, 1, -20)
container.Position = UDim2.new(0, 10, 0, 10)
container.BackgroundTransparency = 1
container.Parent = contentArea

-- Função auxiliar para criar botões dentro das abas
local function createButton(parent, y, text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, y)
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

-- Função auxiliar para criar sliders
local function createSlider(parent, y, label, min, max, default, callback)
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.9, 0, 0, 20)
    textLabel.Position = UDim2.new(0.05, 0, 0, y)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = label .. default
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 14
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = parent

    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0.9, 0, 0, 5)
    sliderFrame.Position = UDim2.new(0.05, 0, 0, y + 25)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    sliderFrame.Parent = parent
    Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(1, 0)

    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 15, 0, 15)
    sliderButton.Position = UDim2.new((default - min) / (max - min), -7.5, 0, -5)
    sliderButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
    sliderButton.Text = ""
    sliderButton.Parent = sliderFrame
    Instance.new("UICorner", sliderButton).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local value = default

    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging then
            local mouseX = UserInputService:GetMouseLocation().X
            local sliderX = sliderFrame.AbsolutePosition.X
            local sliderW = sliderFrame.AbsoluteSize.X
            local rel = math.clamp(mouseX - sliderX, 0, sliderW)
            local perc = rel / sliderW
            value = min + math.floor(perc * (max - min))
            sliderButton.Position = UDim2.new(perc, -7.5, 0, -5)
            textLabel.Text = label .. value
            if callback then callback(value) end
        end
    end)

    return textLabel, sliderFrame, sliderButton
end

-- ========== ABA MOVEMENT ==========
local moveFrame = Instance.new("Frame")
moveFrame.Size = UDim2.new(1, 0, 1, 0)
moveFrame.BackgroundTransparency = 1
moveFrame.Parent = container
tabFrames["Movement"] = moveFrame

-- Slider de velocidade
local speedLabel, speedSlider, speedButton = createSlider(moveFrame, 10, "Walkspeed: ", 16, 116, 16, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

-- Fly
local flyEnabled = false
local flyConn = nil
local flyBtn = createButton(moveFrame, 70, "Fly: OFF", nil, function()
    flyEnabled = not flyEnabled
    flyBtn.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    flyBtn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if flyEnabled then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if hum and root then
                hum.PlatformStand = true
                local bg = Instance.new("BodyGyro")
                bg.P = 9e4
                bg.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
                bg.CFrame = root.CFrame
                bg.Parent = root

                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.MaxForce = Vector3.new(9e4, 9e4, 9e4)
                bv.Parent = root

                flyConn = RunService.RenderStepped:Connect(function()
                    if not flyEnabled then
                        bg:Destroy()
                        bv:Destroy()
                        hum.PlatformStand = false
                        flyConn:Disconnect()
                        return
                    end
                    local move = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - Camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - Camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
                    bv.Velocity = move * 50
                    bg.CFrame = Camera.CFrame
                end)
            end
        end
    else
        if flyConn then
            flyConn:Disconnect()
            flyConn = nil
        end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum.PlatformStand = false end
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

-- Noclip
local noclipEnabled = false
local noclipConn = nil
local noclipBtn = createButton(moveFrame, 110, "Noclip: OFF", nil, function()
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    noclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if noclipEnabled then
        noclipConn = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
    end
end)

-- ========== ABA VISUALS ==========
local visFrame = Instance.new("Frame")
visFrame.Size = UDim2.new(1, 0, 1, 0)
visFrame.BackgroundTransparency = 1
visFrame.Parent = container
tabFrames["Visuals"] = visFrame

local origBright, origFog, origShadow = Lighting.Brightness, Lighting.FogEnd, Lighting.GlobalShadows

local fbEnabled = false
local fbBtn = createButton(visFrame, 10, "Fullbright: OFF", nil, function()
    fbEnabled = not fbEnabled
    fbBtn.Text = "Fullbright: " .. (fbEnabled and "ON" or "OFF")
    fbBtn.BackgroundColor3 = fbEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)
    if fbEnabled then
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.new(1, 1, 1)
    else
        Lighting.Brightness = origBright
        Lighting.GlobalShadows = origShadow
        Lighting.Ambient = Color3.new(0, 0, 0)
    end
end)

local nfEnabled = false
local nfBtn = createButton(visFrame, 50, "No Fog: OFF", nil, function()
    nfEnabled = not nfEnabled
    nfBtn.Text = "No Fog: " .. (nfEnabled and "ON" or "OFF")
    nfBtn.BackgroundColor3 = nfEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)
    if nfEnabled then
        Lighting.FogEnd = 1e5
    else
        Lighting.FogEnd = origFog
    end
end)

-- ========== ABA ESP ==========
local espFrame = Instance.new("Frame")
espFrame.Size = UDim2.new(1, 0, 1, 0)
espFrame.BackgroundTransparency = 1
espFrame.Parent = container
tabFrames["ESP"] = espFrame

local espEnabled = true
local espBtn = createButton(espFrame, 10, "ESP: ON", Color3.fromRGB(0, 100, 50), function()
    espEnabled = not espEnabled
    espBtn.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)
end)

local espInfo = Instance.new("TextLabel")
espInfo.Size = UDim2.new(0.9, 0, 0, 50)
espInfo.Position = UDim2.new(0.05, 0, 0, 50)
espInfo.BackgroundTransparency = 1
espInfo.Text = "ESP ativo automaticamente.\nContorno colorido por vida."
espInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
espInfo.TextWrapped = true
espInfo.Parent = espFrame

-- Variáveis do ESP
local espObjects = {}
local function createESP(player)
    if player == LocalPlayer or not player.Character then return end
    local char = player.Character
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not root then return end

    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do
            pcall(function() obj:Destroy() end)
        end
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ShinkaESP"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ShinkaESP_Text"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = root

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

for _, pl in pairs(Players:GetPlayers()) do
    if pl ~= LocalPlayer then
        task.spawn(function()
            if pl.Character then
                task.wait(1)
                createESP(pl)
            end
        end)
    end
end

Players.PlayerAdded:Connect(function(pl)
    pl.CharacterAdded:Connect(function()
        task.wait(1)
        createESP(pl)
    end)
    if pl.Character then
        task.wait(1)
        createESP(pl)
    end
end)

Players.PlayerRemoving:Connect(function(pl)
    if espObjects[pl] then
        for _, obj in pairs(espObjects[pl]) do
            pcall(function() obj:Destroy() end)
        end
        espObjects[pl] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    for pl, objs in pairs(espObjects) do
        if pl and pl.Character and pl.Character.Parent then
            local root = pl.Character:FindFirstChild("HumanoidRootPart") or pl.Character:FindFirstChild("Torso")
            local hum = pl.Character:FindFirstChild("Humanoid")
            if root and hum and hum.Health > 0 then
                if espEnabled then
                    local dist = (Camera.CFrame.Position - root.Position).Magnitude
                    local hp = hum.Health / hum.MaxHealth
                    objs[1].FillColor = Color3.new(1 - hp, hp, 0)
                    objs[1].Enabled = true
                    objs[2].Enabled = true
                    for _, lbl in pairs(objs[2]:GetChildren()) do
                        if lbl:IsA("TextLabel") and lbl.Text:match("%.1fm") then
                            lbl.Text = string.format("%.1fm", dist)
                        end
                    end
                else
                    objs[1].Enabled = false
                    objs[2].Enabled = false
                end
            else
                objs[1].Enabled = false
                objs[2].Enabled = false
            end
        end
    end
end)

-- ========== ABA AIMBOT ==========
local aimFrame = Instance.new("Frame")
aimFrame.Size = UDim2.new(1, 0, 1, 0)
aimFrame.BackgroundTransparency = 1
aimFrame.Parent = container
tabFrames["Aimbot"] = aimFrame

local aimEnabled = false
local aimBtn = createButton(aimFrame, 10, "Aimbot: OFF", nil, function()
    aimEnabled = not aimEnabled
    aimBtn.Text = "Aimbot: " .. (aimEnabled and "ON" or "OFF")
    aimBtn.BackgroundColor3 = aimEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)
end)

local fovLabel, fovSlider, fovButton = createSlider(aimFrame, 50, "FOV: ", 30, 300, 90, function(val)
    fov = val
end)

local function IsEnemy(player)
    if not LocalPlayer.Team or not player.Team then return true end
    return LocalPlayer.Team ~= player.Team
end

RunService.RenderStepped:Connect(function()
    if aimEnabled then
        local closest = nil
        local closestDist = fov
        for _, pl in pairs(Players:GetPlayers()) do
            if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("Humanoid") and pl.Character.Humanoid.Health > 0 and IsEnemy(pl) then
                local head = pl.Character:FindFirstChild("Head")
                if head then
                    local sp, onScreen = Camera:WorldToScreenPoint(head.Position)
                    if onScreen then
                        local mp = UserInputService:GetMouseLocation()
                        local dist = (Vector2.new(sp.X, sp.Y) - mp).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closest = head
                        end
                    end
                end
            end
        end
        if closest then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, closest.Position), 0.3)
        end
    end
end)

-- ========== ABA TELEPORT ==========
local tpFrame = Instance.new("Frame")
tpFrame.Size = UDim2.new(1, 0, 1, 0)
tpFrame.BackgroundTransparency = 1
tpFrame.Parent = container
tabFrames["Teleport"] = tpFrame

local selectedPlayer = nil
local selectBtn = createButton(tpFrame, 10, "Selecionar jogador", nil, function()
    local list = {}
    for _, pl in pairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer then
            table.insert(list, pl.Name)
        end
    end
    if #list > 0 then
        selectedPlayer = list[1]
        selectBtn.Text = "Teleport: " .. selectedPlayer
    else
        selectedPlayer = nil
        selectBtn.Text = "Nenhum jogador"
    end
end)

local tpBtn = createButton(tpFrame, 50, "Ir até o jogador", Color3.fromRGB(100, 0, 255), function()
    if selectedPlayer and Players:FindFirstChild(selectedPlayer) then
        local target = Players[selectedPlayer]
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetRoot = target.Character.HumanoidRootPart
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 3, 0)
            end
        end
    else
        print("Nenhum jogador selecionado")
    end
end)

-- ========== CONTROLE DE ABAS ==========
for i, name in ipairs(tabs) do
    tabFrames[name].Visible = (i == 1) -- só a primeira visível
    tabButtons[i].MouseButton1Click:Connect(function()
        for _, f in pairs(tabFrames) do
            f.Visible = false
        end
        tabFrames[name].Visible = true
        for j, btn in ipairs(tabButtons) do
            btn.BackgroundColor3 = (j == i) and Color3.fromRGB(80, 80, 120) or Color3.fromRGB(50, 50, 55)
        end
    end)
end

print("✅ Shinka Hub estilo Speed Hub X carregado! Minimize com o botão '−' e reabra com o botão 'ShinkaHub'.")
