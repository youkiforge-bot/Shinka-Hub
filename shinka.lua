-- ShinkaHub - Brookhaven RP Troll Script
-- Feito com amor para executores (Fluxus, Solara, Krnl, Synapse)
-- Aguarda o jogo carregar
task.wait(0.5)

-- Serviços
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variáveis do jogador local
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Armazenar conexões para limpeza
local Connections = {}
local FlyConnection = nil
local InvisibleLoop = nil
local GodModeConn = nil
local SpamLoop = nil

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinkaHub"
ScreenGui.Parent = (syn and syn.protected_gui) and syn.protected_gui() or (gethui and gethui()) or CoreGui or game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Função para criar sombra/glow em textos
local function createGlow(textLabel)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(192, 0, 255) -- roxo neon
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = textLabel
end

-- Tooltip System
local Tooltip = Instance.new("TextLabel")
Tooltip.Name = "Tooltip"
Tooltip.Size = UDim2.new(0, 150, 0, 30)
Tooltip.BackgroundColor3 = Color3.fromRGB(15, 15, 26) -- #0F0F1A
Tooltip.BorderSizePixel = 0
Tooltip.TextColor3 = Color3.fromRGB(0, 240, 255) -- ciano
Tooltip.TextScaled = true
Tooltip.Font = Enum.Font.GothamBold
Tooltip.Visible = false
Tooltip.ZIndex = 10
Tooltip.Parent = ScreenGui
local tooltipCorner = Instance.new("UICorner")
tooltipCorner.CornerRadius = UDim.new(0, 8)
tooltipCorner.Parent = Tooltip
local tooltipStroke = Instance.new("UIStroke")
tooltipStroke.Color = Color3.fromRGB(192, 0, 255)
tooltipStroke.Thickness = 1
tooltipStroke.Parent = Tooltip

-- Função para mostrar tooltip
local function showTooltip(desc, x, y)
    Tooltip.Text = desc
    Tooltip.Position = UDim2.new(0, x + 10, 0, y - 30)
    Tooltip.Visible = true
end

local function hideTooltip()
    Tooltip.Visible = false
end

-- Função para arrastar frames
local function makeDraggable(frame, dragArea)
    local dragging = false
    local dragStartPos
    local frameStartPos

    local function onInputChanged(input, processed)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStartPos
            frame.Position = UDim2.new(0, frameStartPos.X.Offset + delta.X, 0, frameStartPos.Y.Offset + delta.Y)
        end
    end

    local function onInputBegan(input, gp)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = UserInputService:GetMouseLocation()
            local absPos = frame.AbsolutePosition
            local absSize = frame.AbsoluteSize
            local dragAreaAbsPos = dragArea.AbsolutePosition
            local dragAreaAbsSize = dragArea.AbsoluteSize
            if mousePos.X >= dragAreaAbsPos.X and mousePos.X <= dragAreaAbsPos.X + dragAreaAbsSize.X and
               mousePos.Y >= dragAreaAbsPos.Y and mousePos.Y <= dragAreaAbsPos.Y + dragAreaAbsSize.Y then
                dragging = true
                dragStartPos = input.Position
                frameStartPos = frame.Position
            end
        end
    end

    local function onInputEnded(input, gp)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end

    local conn1 = UserInputService.InputBegan:Connect(onInputBegan)
    local conn2 = UserInputService.InputChanged:Connect(onInputChanged)
    local conn3 = UserInputService.InputEnded:Connect(onInputEnded)
    table.insert(Connections, conn1)
    table.insert(Connections, conn2)
    table.insert(Connections, conn3)
end

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 650, 0, 420)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 26) -- #0F0F1A
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0.08, 0)
mainCorner.Parent = MainFrame
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(192, 0, 255) -- roxo neon
mainStroke.Thickness = 2
mainStroke.Parent = MainFrame

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0.08, 0)
titleCorner.Parent = TitleBar

-- Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ShinkaHub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 28
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar
createGlow(TitleLabel)

-- Botões da barra de título (minimizar e fechar)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "Minimize"
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -80, 0, 0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MinimizeBtn.Text = "–"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 240, 255) -- ciano
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 24
MinimizeBtn.Parent = TitleBar
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0.08, 0)
minCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "Close"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 24
CloseBtn.Parent = TitleBar
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0.08, 0)
closeCorner.Parent = CloseBtn

-- Frame minimizado (inicialmente invisível)
local MinimizedFrame = Instance.new("Frame")
MinimizedFrame.Name = "MinimizedFrame"
MinimizedFrame.Size = UDim2.new(0, 220, 0, 35)
MinimizedFrame.Position = UDim2.new(0.5, -110, 1, -50) -- canto inferior central
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 26)
MinimizedFrame.BorderSizePixel = 0
MinimizedFrame.Visible = false
MinimizedFrame.Parent = ScreenGui
local minFrameCorner = Instance.new("UICorner")
minFrameCorner.CornerRadius = UDim.new(0.08, 0)
minFrameCorner.Parent = MinimizedFrame
local minFrameStroke = Instance.new("UIStroke")
minFrameStroke.Color = Color3.fromRGB(0, 240, 255)
minFrameStroke.Thickness = 2
minFrameStroke.Parent = MinimizedFrame

local MinimizedLabel = Instance.new("TextLabel")
MinimizedLabel.Name = "MinimizedLabel"
MinimizedLabel.Size = UDim2.new(1, 0, 1, 0)
MinimizedLabel.BackgroundTransparency = 1
MinimizedLabel.Text = "ShinkaHub [Minimized]"
MinimizedLabel.TextColor3 = Color3.fromRGB(0, 240, 255)
MinimizedLabel.Font = Enum.Font.GothamBold
MinimizedLabel.TextSize = 18
MinimizedLabel.Parent = MinimizedFrame
createGlow(MinimizedLabel)

-- Tornar frames arrastáveis
makeDraggable(MainFrame, TitleBar)
makeDraggable(MinimizedFrame, MinimizedFrame) -- arrasta pelo próprio frame

-- Ações dos botões da barra
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizedFrame.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    -- Destruir tudo (chamaremos a função destroyScript mais tarde)
    -- Mas por enquanto, podemos só destruir o GUI
    for _, conn in pairs(Connections) do
        conn:Disconnect()
    end
    ScreenGui:Destroy()
end)

-- Restaurar ao clicar na barra minimizada
MinimizedFrame.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MinimizedFrame.Visible = false
    -- Centralizar o frame principal
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
end)

-- Sistema de abas
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, 0, 0, 50)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame
local tabBarCorner = Instance.new("UICorner")
tabBarCorner.CornerRadius = UDim.new(0.08, 0)
tabBarCorner.Parent = TabBar

-- Botões das abas
local Tabs = {}
local TabContents = {}
local TabNames = {"Home", "Movement", "Troll", "Misc"}
local TabColors = { -- cores diferentes para cada aba ativa
    Color3.fromRGB(192, 0, 255), -- roxo
    Color3.fromRGB(0, 240, 255), -- ciano
    Color3.fromRGB(255, 50, 50), -- vermelho
    Color3.fromRGB(0, 255, 100)  -- verde
}

for i, name in ipairs(TabNames) do
    local btn = Instance.new("TextButton")
    btn.Name = name.."Tab"
    btn.Size = UDim2.new(0.25, -2, 1, -10)
    btn.Position = UDim2.new(0.25 * (i-1), 5, 0, 5)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = TabBar
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0.08, 0)
    btnCorner.Parent = btn

    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
        showTooltip("Aba "..name, btn.AbsolutePosition.X, btn.AbsolutePosition.Y)
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 45)}):Play()
        hideTooltip()
    end)

    Tabs[name] = btn

    -- Criar conteúdo da aba
    local content = Instance.new("ScrollingFrame")
    content.Name = name.."Content"
    content.Size = UDim2.new(1, -20, 1, -100)
    content.Position = UDim2.new(0, 10, 0, 100)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 6
    content.ScrollBarImageColor3 = Color3.fromRGB(192, 0, 255)
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Visible = (i == 1) -- primeira aba visível
    content.Parent = MainFrame

    -- Layout para organizar itens verticalmente
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = content

    TabContents[name] = content
end

-- Alternar abas
for name, btn in pairs(Tabs) do
    btn.MouseButton1Click:Connect(function()
        for _, content in pairs(TabContents) do
            content.Visible = false
        end
        TabContents[name].Visible = true
        -- Destacar aba ativa
        for _, b in pairs(Tabs) do
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        end
        btn.BackgroundColor3 = Color3.fromRGB(192, 0, 255)
    end)
end-- Função auxiliar para criar toggles
local function createToggle(parent, text, desc, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 40)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 30)
    toggleBtn.Position = UDim2.new(1, -70, 0.5, -15)
    toggleBtn.BackgroundColor3 = default and Color3.fromRGB(0, 240, 255) or Color3.fromRGB(30, 30, 45)
    toggleBtn.Text = default and "ON" or "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 14
    toggleBtn.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim-- Continuação da função createToggle
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0.08, 0)
    btnCorner.Parent = toggleBtn

    -- Tooltip
    toggleBtn.MouseEnter:Connect(function()
        showTooltip(desc, toggleBtn.AbsolutePosition.X, toggleBtn.AbsolutePosition.Y)
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 120)}):Play()
    end)
    toggleBtn.MouseLeave:Connect(function()
        hideTooltip()
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = toggleBtn.BackgroundColor3}):Play()
    end)

    local state = default
    return frame, toggleBtn, function()
        state = not state
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 240, 255) or Color3.fromRGB(30, 30, 45)
        toggleBtn.Text = state and "ON" or "OFF"
        return state
    end
end

-- Função para criar slider
local function createSlider(parent, text, desc, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 60)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.Parent = frame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.9, 0, 0, 10)
    slider.Position = UDim2.new(0, 0, 0, 30)
    slider.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    slider.Parent = frame
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(1, 0)
    sliderCorner.Parent = slider

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
    fill.Parent = slider
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local dragBtn = Instance.new("TextButton")
    dragBtn.Size = UDim2.new(0, 20, 0, 20)
    dragBtn.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
    dragBtn.BackgroundColor3 = Color3.fromRGB(192, 0, 255)
    dragBtn.Text = ""
    dragBtn.Parent = frame
    local dragCorner = Instance.new("UICorner")
    dragCorner.CornerRadius = UDim.new(1, 0)
    dragCorner.Parent = dragBtn

    -- Tooltip
    dragBtn.MouseEnter:Connect(function()
        showTooltip(desc, dragBtn.AbsolutePosition.X, dragBtn.AbsolutePosition.Y)
    end)
    dragBtn.MouseLeave:Connect(hideTooltip)

    local value = default
    local dragging = false

    dragBtn.MouseButton1Down:Connect(function()
        dragging = true
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    RunService.Heartbeat:Connect(function()
        if dragging then
            local mousePos = UserInputService:GetMouseLocation()
            local sliderAbsPos = slider.AbsolutePosition
            local sliderAbsSize = slider.AbsoluteSize
            local relativeX = math.clamp(mousePos.X - sliderAbsPos.X, 0, sliderAbsSize.X)
            local percent = relativeX / sliderAbsSize.X
            value = min + (max - min) * percent
            value = math.round(value * 10) / 10
            fill.Size = UDim2.new(percent, 0, 1, 0)
            dragBtn.Position = UDim2.new(percent, -10, 0.5, -10)
            label.Text = text .. ": " .. value
            callback(value)
        end
    end)

    return frame
end

-- Função para criar botão
local function createButton(parent, text, desc, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.BackgroundColor3 = color or Color3.fromRGB(192, 0, 255)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = parent
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0.08, 0)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.3)}):Play()
        showTooltip(desc, btn.AbsolutePosition.X, btn.AbsolutePosition.Y)
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
        hideTooltip()
    end)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Função para criar caixa de texto
local function createTextBox(parent, text, default, desc)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 40)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 200, 0, 30)
    box.Position = UDim2.new(1, -210, 0.5, -15)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.Text = default
    box.PlaceholderText = "Digite..."
    box.Parent = frame
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0.08, 0)
    boxCorner.Parent = box

    box.MouseEnter:Connect(function()
        showTooltip(desc, box.AbsolutePosition.X, box.AbsolutePosition.Y)
    end)
    box.MouseLeave:Connect(hideTooltip)

    return frame, box
    end-- ========== ABA HOME ==========
local homeContent = TabContents["Home"]
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, 0, 0, 50)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "Bem-vindo ao ShinkaHub!\nUse as abas para trollar no Brookhaven."
welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.TextSize = 18
welcomeLabel.TextWrapped = true
welcomeLabel.Parent = homeContent

-- ========== ABA MOVEMENT ==========
local moveContent = TabContents["Movement"]

-- Fly
local flyFrame, flyToggleBtn, flyToggleFunc = createToggle(moveContent, "Fly", "Ativar/Desativar voo", false)
flyToggleBtn.MouseButton1Click:Connect(function()
    local state = flyToggleFunc()
    if state then
        -- Ativar fly
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Parent = RootPart

        local keys = {W=false, A=false, S=false, D=false, Space=false, LControl=false}
        local speed = 50

        local inputBegan = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.W then keys.W = true
            elseif input.KeyCode == Enum.KeyCode.A then keys.A = true
            elseif input.KeyCode == Enum.KeyCode.S then keys.S = true
            elseif input.KeyCode == Enum.KeyCode.D then keys.D = true
            elseif input.KeyCode == Enum.KeyCode.Space then keys.Space = true
            elseif input.KeyCode == Enum.KeyCode.LeftControl then keys.LControl = true
            end
        end)
        local inputEnded = UserInputService.InputEnded:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.W then keys.W = false
            elseif input.KeyCode == Enum.KeyCode.A then keys.A = false
            elseif input.KeyCode == Enum.KeyCode.S then keys.S = false
            elseif input.KeyCode == Enum.KeyCode.D then keys.D = false
            elseif input.KeyCode == Enum.KeyCode.Space then keys.Space = false
            elseif input.KeyCode == Enum.KeyCode.LeftControl then keys.LControl = false
            end
        end)

        local heartbeat = RunService.Heartbeat:Connect(function()
            if not bodyVelocity or not bodyVelocity.Parent then return end
            local moveDir = Vector3.new()
            if keys.W then moveDir = moveDir + Vector3.new(0,0,-1) end
            if keys.S then moveDir = moveDir + Vector3.new(0,0,1) end
            if keys.A then moveDir = moveDir + Vector3.new(-1,0,0) end
            if keys.D then moveDir = moveDir + Vector3.new(1,0,0) end
            if keys.Space then moveDir = moveDir + Vector3.new(0,1,0) end
            if keys.LControl then moveDir = moveDir + Vector3.new(0,-1,0) end
            if moveDir.Magnitude > 0 then
                moveDir = moveDir.Unit
            end
            bodyVelocity.Velocity = moveDir * speed
        end)

        table.insert(Connections, inputBegan)
        table.insert(Connections, inputEnded)
        table.insert(Connections, heartbeat)

        -- Atualizar slider
        local slider = createSlider(moveContent, "Fly Speed", "Velocidade do voo", 1, 100, 50, function(val)
            speed = val
        end)
        slider.Parent = moveContent
        slider.LayoutOrder = 2
    else
        -- Desativar fly: remover BodyVelocity
        if RootPart:FindFirstChildOfClass("BodyVelocity") then
            RootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
        end
    end
end)

-- WalkSpeed
createSlider(moveContent, "WalkSpeed", "Velocidade de caminhada", 16, 500, 16, function(val)
    Humanoid.WalkSpeed = val
end)

-- JumpPower
createSlider(moveContent, "JumpPower", "Altura do pulo", 50, 300, 50, function(val)
    Humanoid.JumpPower = val
end)

-- ========== ABA TROLL ==========
local trollContent = TabContents["Troll"]

-- God Mode
local godFrame, godToggleBtn, godToggleFunc = createToggle(trollContent, "God Mode", "Modo imortal (não morre)", false)
godToggleBtn.MouseButton1Click:Connect(function()
    local state = godToggleFunc()
    if state then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        local conn = Humanoid.HealthChanged:Connect(function(health)
            if health <= 0 then
                Humanoid.Health = 100
            end
        end)
        table.insert(Connections, conn)
        GodModeConn = conn
    else
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        if GodModeConn then
            GodModeConn:Disconnect()
            GodModeConn = nil
        end
    end
end)

-- Invisible
local invFrame, invToggleBtn, invToggleFunc = createToggle(trollContent, "Invisible", "Ficar invisível (mantém nome)", false)
invToggleBtn.MouseButton1Click:Connect(function()
    local state = invToggleFunc()
    if state then
        local function setTransparency(trans)
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and not part:IsA("Tool") then
                    part.Transparency = trans
                end
            end
        end
        setTransparency(1)
        InvisibleLoop = task.spawn(function()
            while state do
                setTransparency(1)
                task.wait(0.5)
            end
        end)
    else
        if InvisibleLoop then
            task.cancel(InvisibleLoop)
            InvisibleLoop = nil
        end
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
end)

-- Fling All
createButton(trollContent, "FLING EVERYONE", "Arremessa todos os jogadores aleatoriamente", Color3.fromRGB(255, 50, 50), function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetRoot = player.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Velocity = Vector3.new(math.random(-3000,3000), math.random(1000,3000), math.random(-3000,3000))
            bv.Parent = targetRoot
            task.delay(1.5, function()
                if bv and bv.Parent then
                    bv:Destroy()
                end
            end)
        end
    end
end)

-- Kill Nearest
createButton(trollContent, "Kill Nearest Player", "Mata o jogador mais próximo", Color3.fromRGB(200, 0, 0), function()
    local nearest = nil
    local minDist = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = player
            end
        end
    end
    if nearest and nearest.Character then
        local explosion = Instance.new("Explosion")
        explosion.Position = nearest.Character.HumanoidRootPart.Position
        explosion.BlastRadius = 10
        explosion.DestroyJointRadiusPercent = 0
        explosion.Parent = workspace
        if nearest.Character:FindFirstChild("Humanoid") then
            nearest.Character.Humanoid.Health = 0
        end
    end
end)

-- ========== ABA MISC ==========
local miscContent = TabContents["Misc"]

-- Chat Spam
local spamFrame, spamToggleBtn, spamToggleFunc = createToggle(miscContent, "Chat Spam", "Ativar spam de chat", false)
local spamMsgBox
local spamDelay = 0.5

local msgFrame, msgBox = createTextBox(miscContent, "Mensagem", "ShinkaHub owns this server 😈", "Mensagem a ser enviada")
spamMsgBox = msgBox

local delaySlider = createSlider(miscContent, "Delay", "Intervalo entre mensagens", 0.1, 3, 0.5, function(val)
    spamDelay = val
end)

spamToggleBtn.MouseButton1Click:Connect(function()
    local state = spamToggleFunc()
    if state then
        local sayMsg = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
        if not sayMsg then
            warn("Chat system not found")
            return
        end
        SpamLoop = task.spawn(function()
            while state do
                sayMsg:FireServer(spamMsgBox.Text, "All")
                task.wait(spamDelay)
            end
        end)
    else
        if SpamLoop then
            task.cancel(SpamLoop)
            SpamLoop = nil
        end
    end
end)

-- Destroy Script
createButton(miscContent, "Destroy Script", "Fecha o script e limpa tudo", Color3.fromRGB(255, 100, 0), function()
    for _, conn in pairs(Connections) do
        conn:Disconnect()
    end
    ScreenGui:Destroy()
    if FlyConnection then FlyConnection:Disconnect() end
    if InvisibleLoop then task.cancel(InvisibleLoop) end
    if GodModeConn then GodModeConn:Disconnect() end
    if SpamLoop then task.cancel(SpamLoop) end
    if RootPart:FindFirstChildOfClass("BodyVelocity") then
        RootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
    end
end)

print("ShinkaHub carregado com sucesso!")
