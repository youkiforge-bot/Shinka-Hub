-- ===================================================================
-- SHINKAHUB - VOLLEYBALL LEGENDS EDITION
-- PARTE 1/3 - ESTRUTURA PRINCIPAL, BARRA DE TÍTULO E MINIMIZAR
-- ===================================================================

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

-- Variáveis Globais (getgenv) - Todas as funções do hub para Volleyball Legends
getgenv().AutoSpike = false
getgenv().AutoBlock = false
getgenv().AutoServe = false
getgenv().AutoDive = false
getgenv().AutoJump = false
getgenv().AutoFarm = false          -- Farm XP / Moedas
getgenv().AutoWin = false            -- Tentar vencer automático (se houver exploit)
getgenv().AntiStun = false
getgenv().InfiniteStamina = false
getgenv().AutoPowerup = false
getgenv().TargetEnemy = false        -- Mira no adversário para spike
getgenv().Walkspeed = 16
getgenv().Jumppower = 50
getgenv().SpikePower = 100           -- Força do spike (se controlável)
getgenv().SelectedTeam = "Auto"       -- Time: Auto, Red, Blue
getgenv().AutoRespawn = false
getgenv().NoCooldown = false

local Player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinkaHub_VL"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Destroi GUI antiga se existir
for _, v in ipairs(CoreGui:GetChildren()) do
    if v.Name == "ShinkaHub_VL" then
        v:Destroy()
    end
end
ScreenGui.Parent = CoreGui

-- Funções Auxiliares de UI
local function createGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color1), ColorSequenceKeypoint.new(1, color2)})
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

local function createStroke(parent, thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Color = color or Color3.fromRGB(60, 60, 80)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function tweenObject(obj, props, time, easing)
    local tweenInfo = TweenInfo.new(time or 0.2, (easing and Enum.EasingStyle[easing]) or Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

-- Frame Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 700, 0, 500)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
mainFrame.ClipsDescendants = true
mainFrame.Parent = ScreenGui
createCorner(mainFrame, 12)
createStroke(mainFrame, 2, Color3.fromRGB(40, 40, 60))

-- Sombra
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

-- Gradiente de fundo
createGradient(mainFrame, Color3.fromRGB(25, 25, 35), Color3.fromRGB(15, 15, 22), 45)

-- Barra de Título
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleBar.Parent = mainFrame
createCorner(titleBar, 12)

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0.5, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "ShinkaHub | Volleyball Legends"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Botões de controle
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 32, 0, 32)
closeButton.Position = UDim2.new(1, -45, 0.5, -16)
closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = titleBar
createCorner(closeButton, 8)
createStroke(closeButton, 1, Color3.fromRGB(80, 80, 100))

local minButton = Instance.new("TextButton")
minButton.Name = "MinButton"
minButton.Size = UDim2.new(0, 32, 0, 32)
minButton.Position = UDim2.new(1, -85, 0.5, -16)
minButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
minButton.Text = "−"
minButton.TextColor3 = Color3.fromRGB(200, 200, 220)
minButton.Font = Enum.Font.GothamBold
minButton.TextSize = 24
minButton.Parent = titleBar
createCorner(minButton, 8)
createStroke(minButton, 1, Color3.fromRGB(80, 80, 100))

-- Hover nos botões
local function hoverEffect(btn, hoverColor)
    btn.MouseEnter:Connect(function()
        tweenObject(btn, {BackgroundColor3 = hoverColor}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        tweenObject(btn, {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}, 0.15)
    end)
end
hoverEffect(closeButton, Color3.fromRGB(70, 70, 90))
hoverEffect(minButton, Color3.fromRGB(70, 70, 90))

-- Container principal (abaixo da barra)
local mainContentContainer = Instance.new("Frame")
mainContentContainer.Name = "MainContentContainer"
mainContentContainer.Size = UDim2.new(1, 0, 1, -40)
mainContentContainer.Position = UDim2.new(0, 0, 0, 40)
mainContentContainer.BackgroundTransparency = 1
mainContentContainer.Parent = mainFrame

-- ========== SISTEMA DE MINIMIZAR ==========
local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 250, 0, 45)
minimizedFrame.Position = mainFrame.Position
minimizedFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
minimizedFrame.Visible = false
minimizedFrame.Parent = ScreenGui
createCorner(minimizedFrame, 10)
createStroke(minimizedFrame, 2, Color3.fromRGB(40, 40, 60))
createGradient(minimizedFrame, Color3.fromRGB(25, 25, 35), Color3.fromRGB(15, 15, 22), 45)

local minimizedLabel = Instance.new("TextLabel")
minimizedLabel.Size = UDim2.new(1, -45, 1, 0)
minimizedLabel.Position = UDim2.new(0, 10, 0, 0)
minimizedLabel.BackgroundTransparency = 1
minimizedLabel.Text = "ShinkaHub - VL"
minimizedLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
minimizedLabel.Font = Enum.Font.GothamBold
minimizedLabel.TextSize = 16
minimizedLabel.TextXAlignment = Enum.TextXAlignment.Left
minimizedLabel.Parent = minimizedFrame

local restoreButton = Instance.new("TextButton")
restoreButton.Name = "RestoreButton"
restoreButton.Size = UDim2.new(0, 32, 0, 32)
restoreButton.Position = UDim2.new(1, -40, 0.5, -16)
restoreButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
restoreButton.Text = "⬆"
restoreButton.TextColor3 = Color3.fromRGB(200, 200, 220)
restoreButton.Font = Enum.Font.GothamBold
restoreButton.TextSize = 18
restoreButton.Parent = minimizedFrame
createCorner(restoreButton, 8)
createStroke(restoreButton, 1, Color3.fromRGB(80, 80, 100))
hoverEffect(restoreButton, Color3.fromRGB(70, 70, 90))

-- Arrastar o frame minimizado
local minimizedDragging = false
local minimizedDragStart, minimizedStartPos

minimizedFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        minimizedDragging = true
        minimizedDragStart = input.Position
        minimizedStartPos = minimizedFrame.Position
    end
end)

minimizedFrame.InputChanged:Connect(function(input)
    if minimizedDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - minimizedDragStart
        minimizedFrame.Position = UDim2.new(minimizedStartPos.X.Scale, minimizedStartPos.X.Offset + delta.X, minimizedStartPos.Y.Scale, minimizedStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        minimizedDragging = false
    end
end)

-- Estado de minimizado
local isMinimized = false

local function minimize()
    isMinimized = true
    mainFrame.Visible = false
    minimizedFrame.Visible = true
    minimizedFrame.Position = mainFrame.Position
end

local function maximize()
    isMinimized = false
    mainFrame.Visible = true
    minimizedFrame.Visible = false
    mainFrame.Position = minimizedFrame.Position
end

minButton.MouseButton1Click:Connect(minimize)
restoreButton.MouseButton1Click:Connect(maximize)
closeButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Arrastar a GUI principal
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ========== FIM DA PARTE 1/3 ==========-- ===================================================================
-- SHINKAHUB - VOLLEYBALL LEGENDS EDITION
-- PARTE 2/3 - ABAS, PAINEL LATERAL, FUNÇÕES DE CRIAÇÃO DE UI
-- ===================================================================

-- Painel de abas (ScrollingFrame vertical)
local tabsPanel = Instance.new("ScrollingFrame")
tabsPanel.Name = "TabsPanel"
tabsPanel.Size = UDim2.new(0, 140, 1, -10)
tabsPanel.Position = UDim2.new(0, 5, 0, 5)
tabsPanel.BackgroundTransparency = 1
tabsPanel.ScrollBarThickness = 4
tabsPanel.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
tabsPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
tabsPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
tabsPanel.Parent = mainContentContainer

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 8)
tabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Parent = tabsPanel

-- Dados das abas (adaptado para Volleyball Legends)
local tabsData = {
    {name = "Home", icon = "🏠", order = 1},
    {name = "Match", icon = "🏐", order = 2, highlightColor = Color3.fromRGB(255, 140, 0)},
    {name = "Player", icon = "⚡", order = 3},
    {name = "Combat", icon = "⚔️", order = 4},
    {name = "Misc", icon = "🧰", order = 5},
}

local tabButtons = {}
local selectedTab = "Match" -- padrão

-- Área de conteúdo
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -155, 1, -10)
contentArea.Position = UDim2.new(0, 150, 0, 5)
contentArea.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
contentArea.Parent = mainContentContainer
createCorner(contentArea, 10)
createStroke(contentArea, 1, Color3.fromRGB(50, 50, 70))

-- Páginas (uma por aba)
local pages = {}
for _, tab in ipairs(tabsData) do
    local page = Instance.new("Frame")
    page.Name = tab.name .. "Page"
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.new(0, 10, 0, 10)
    page.BackgroundTransparency = 1
    page.Visible = (tab.name == selectedTab)
    page.Parent = contentArea
    pages[tab.name] = page
end

-- Função para criar botões de aba
local function createTabButton(tab)
    local btn = Instance.new("TextButton")
    btn.Name = tab.name .. "Tab"
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.BackgroundColor3 = (tab.name == selectedTab) and (tab.highlightColor or Color3.fromRGB(60, 60, 100)) or Color3.fromRGB(35, 35, 50)
    btn.Text = tab.icon .. "   " .. tab.name
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = tabsPanel
    createCorner(btn, 10)
    createStroke(btn, 1, Color3.fromRGB(70, 70, 100))

    btn.MouseEnter:Connect(function()
        if selectedTab ~= tab.name then
            tweenObject(btn, {BackgroundColor3 = Color3.fromRGB(50, 50, 75)}, 0.15)
        end
    end)
    btn.MouseLeave:Connect(function()
        if selectedTab ~= tab.name then
            tweenObject(btn, {BackgroundColor3 = Color3.fromRGB(35, 35, 50)}, 0.15)
        else
            tweenObject(btn, {BackgroundColor3 = tab.highlightColor or Color3.fromRGB(60, 60, 100)}, 0.15)
        end
    end)

    btn.MouseButton1Click:Connect(function()
        if selectedTab == tab.name then return end
        if tabButtons[selectedTab] then
            tweenObject(tabButtons[selectedTab], {BackgroundColor3 = Color3.fromRGB(35, 35, 50)}, 0.2)
        end
        selectedTab = tab.name
        tweenObject(btn, {BackgroundColor3 = tab.highlightColor or Color3.fromRGB(60, 60, 100)}, 0.2)
        for name, page in pairs(pages) do
            page.Visible = (name == selectedTab)
        end
    end)

    tabButtons[tab.name] = btn
end

for _, tab in ipairs(tabsData) do
    createTabButton(tab)
end
tabsPanel.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 10)

-- ========== FUNÇÕES PARA CRIAR ELEMENTOS NAS PÁGINAS ==========

-- Criar um Toggle (ligar/desligar)
local function createToggle(parent, name, label, default)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, -10, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local labelObj = Instance.new("TextLabel")
    labelObj.Size = UDim2.new(0.7, -5, 1, 0)
    labelObj.Position = UDim2.new(0, 0, 0, 0)
    labelObj.BackgroundTransparency = 1
    labelObj.Text = label
    labelObj.TextColor3 = Color3.fromRGB(220, 220, 240)
    labelObj.Font = Enum.Font.Gotham
    labelObj.TextSize = 14
    labelObj.TextXAlignment = Enum.TextXAlignment.Left
    labelObj.Parent = container

    local toggleBg = Instance.new("Frame")
    toggleBg.Name = "ToggleBg"
    toggleBg.Size = UDim2.new(0, 48, 0, 24)
    toggleBg.Position = UDim2.new(1, -55, 0.5, -12)
    toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBg.Parent = container
    createCorner(toggleBg, 30)

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "ToggleCircle"
    toggleCircle.Size = UDim2.new(0, 20, 0, 20)
    toggleCircle.Position = UDim2.new(0, 2, 0.5, -10)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.Parent = toggleBg
    createCorner(toggleCircle, 10)

    local state = default or false
    getgenv()[name] = state

    local function updateVisual()
        if state then
            tweenObject(toggleCircle, {Position = UDim2.new(1, -22, 0.5, -10)}, 0.15)
            tweenObject(toggleBg, {BackgroundColor3 = Color3.fromRGB(0, 150, 200)}, 0.15)
        else
            tweenObject(toggleCircle, {Position = UDim2.new(0, 2, 0.5, -10)}, 0.15)
            tweenObject(toggleBg, {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}, 0.15)
        end
    end
    updateVisual()

    toggleBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            getgenv()[name] = state
            updateVisual()
        end
    end)

    return container
end

-- Criar um Slider
local function createSlider(parent, name, label, min, max, default, color, suffix)
    suffix = suffix or ""
    local container = Instance.new("Frame")
    container.Name = name .. "SliderContainer"
    container.Size = UDim2.new(1, -10, 0, 50)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local labelObj = Instance.new("TextLabel")
    labelObj.Size = UDim2.new(0.6, 0, 0.4, 0)
    labelObj.Position = UDim2.new(0, 0, 0, 0)
    labelObj.BackgroundTransparency = 1
    labelObj.Text = label
    labelObj.TextColor3 = Color3.fromRGB(200, 200, 220)
    labelObj.Font = Enum.Font.Gotham
    labelObj.TextSize = 13
    labelObj.TextXAlignment = Enum.TextXAlignment.Left
    labelObj.Parent = container

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "ValueLabel"
    valueLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
    valueLabel.Position = UDim2.new(0.6, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default) .. suffix
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 13
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = container

    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "SliderBg"
    sliderBg.Size = UDim2.new(1, 0, 0, 8)
    sliderBg.Position = UDim2.new(0, 0, 0, 25)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBg.Parent = container
    createCorner(sliderBg, 4)

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = color or Color3.fromRGB(200, 50, 50)
    fill.Parent = sliderBg
    createCorner(fill, 4)

    local thumb = Instance.new("Frame")
    thumb.Name = "Thumb"
    thumb.Size = UDim2.new(0, 14, 0, 14)
    thumb.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.Parent = sliderBg
    createCorner(thumb, 7)
    createStroke(thumb, 1, Color3.fromRGB(150, 150, 150))

    local dragging = false
    local value = default
    getgenv()[name] = value

    local function updateSlider(input)
        local pos = input.Position.X - sliderBg.AbsolutePosition.X
        local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
        value = min + (max - min) * percent
        value = math.floor(value + 0.5)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        thumb.Position = UDim2.new(percent, -7, 0.5, -7)
        valueLabel.Text = tostring(value) .. suffix
        getgenv()[name] = value
    end

    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return container
end

-- Criar uma seção com título
local function createSection(parent, title)
    local section = Instance.new("Frame")
    section.Name = title .. "Section"
    section.Size = UDim2.new(1, 0, 0, 0)
    section.BackgroundTransparency = 1
    section.Parent = parent

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -10, 0, 30)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = section

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -10, 0, 2)
    line.Position = UDim2.new(0, 5, 0, 30)
    line.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    line.Parent = section
    createCorner(line, 1)

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -10, 1, -40)
    content.Position = UDim2.new(0, 5, 0, 35)
    content.BackgroundTransparency = 1
    content.Parent = section

    return section, content
end

-- Criar um botão de ação
local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = parent
    createCorner(btn, 8)
    createStroke(btn, 1, Color3.fromRGB(70, 70, 100))
    
    btn.MouseButton1Click:Connect(callback)
    
    btn.MouseEnter:Connect(function()
        tweenObject(btn, {BackgroundColor3 = Color3.fromRGB(65, 65, 85)}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        tweenObject(btn, {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}, 0.15)
    end)
    
    return btn
end

-- Criar um dropdown simples
local function createDropdown(parent, label, options, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local labelObj = Instance.new("TextLabel")
    labelObj.Size = UDim2.new(0.5, 0, 1, 0)
    labelObj.BackgroundTransparency = 1
    labelObj.Text = label
    labelObj.TextColor3 = Color3.fromRGB(200, 200, 220)
    labelObj.Font = Enum.Font.Gotham
    labelObj.TextSize = 13
    labelObj.TextXAlignment = Enum.TextXAlignment.Left
    labelObj.Parent = container

    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(0.4, -5, 0, 32)
    dropdownBtn.Position = UDim2.new(0.6, 0, 0.5, -16)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    dropdownBtn.Text = default .. "  ▼"
    dropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownBtn.Font = Enum.Font.GothamSemibold
    dropdownBtn.TextSize = 13
    dropdownBtn.Parent = container
    createCorner(dropdownBtn, 6)
    createStroke(dropdownBtn, 1, Color3.fromRGB(70, 70, 100))

    local dropdownList = Instance.new("Frame")
    dropdownList.Name = "DropdownList"
    dropdownList.Size = UDim2.new(0.4, 0, 0, 0)
    dropdownList.Position = UDim2.new(0.6, 0, 0, 38)
    dropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    dropdownList.Visible = false
    dropdownList.Parent = container
    dropdownList.ZIndex = 10
    createCorner(dropdownList, 6)
    createStroke(dropdownList, 1, Color3.fromRGB(60, 60, 80))

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = dropdownList

    for _, option in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundTransparency = 1
        btn.Text = option
        btn.TextColor3 = Color3.fromRGB(220, 220, 240)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        btn.Parent = dropdownList
        btn.ZIndex = 10

        btn.MouseButton1Click:Connect(function()
            dropdownBtn.Text = option .. "  ▼"
            dropdownList.Visible = false
            if callback then callback(option) end
        end)
    end
    dropdownList.Size = UDim2.new(0.4, 0, 0, #options * 30 + 4)

    dropdownBtn.MouseButton1Click:Connect(function()
        dropdownList.Visible = not dropdownList.Visible
    end)

    return container
end

-- ========== FIM DA PARTE 2/3 ==========-- ===================================================================
-- SHINKAHUB - VOLLEYBALL LEGENDS EDITION
-- PARTE 3/3 - CONTEÚDO DAS ABAS E HEARTBEAT (FUNÇÕES ATIVAS)
-- ===================================================================

-- Layout automático para as páginas
for name, page in pairs(pages) do
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 15)
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
end

-- ========== ABA HOME ==========
local homePage = pages["Home"]

-- Seção Auto
local autoSection, autoContent = createSection(homePage, "Auto")
autoSection.Size = UDim2.new(1, 0, 0, 130)
createToggle(autoContent, "AutoFarm", "Auto Farm XP", false)
createToggle(autoContent, "AutoWin", "Auto Win (Experimental)", false)
createToggle(autoContent, "AutoRespawn", "Auto Respawn", false)

-- Seção Info
local infoSection, infoContent = createSection(homePage, "Info")
infoSection.Size = UDim2.new(1, 0, 0, 80)
createButton(infoContent, "Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)
createButton(infoContent, "Server Hop", function()
    -- Tenta encontrar um novo servidor (simplificado)
    local HttpService = game:GetService("HttpService")
    local servers = {}
    -- ... lógica de server hop (pode ser complexa, deixamos simples)
    print("Server Hop não implementado, use Rejoin.")
end)

-- ========== ABA MATCH (Principal do jogo) ==========
local matchPage = pages["Match"]

-- Seção Ações de Jogo
local actionsSection, actionsContent = createSection(matchPage, "Match Actions")
actionsSection.Size = UDim2.new(1, 0, 0, 220)

createToggle(actionsContent, "AutoSpike", "Auto Spike", false)
createToggle(actionsContent, "AutoBlock", "Auto Block", false)
createToggle(actionsContent, "AutoServe", "Auto Serve", false)
createToggle(actionsContent, "AutoDive", "Auto Dive", false)
createToggle(actionsContent, "AutoJump", "Auto Jump", false)
createToggle(actionsContent, "TargetEnemy", "Target Enemy (Aim)", false)

-- Seção Configurações de Jogo
local gameConfigSection, gameConfigContent = createSection(matchPage, "Game Config")
gameConfigSection.Size = UDim2.new(1, 0, 0, 130)

createDropdown(gameConfigContent, "Team", {"Auto", "Red", "Blue"}, "Auto", function(team)
    getgenv().SelectedTeam = team
end)

createSlider(gameConfigContent, "SpikePower", "Spike Power", 50, 200, 100, Color3.fromRGB(255, 100, 0), "%")
createToggle(gameConfigContent, "NoCooldown", "No Cooldown", false)

-- ========== ABA PLAYER ==========
local playerPage = pages["Player"]

-- Seção Atributos
local attrSection, attrContent = createSection(playerPage, "Attributes")
attrSection.Size = UDim2.new(1, 0, 0, 150)

createSlider(attrContent, "Walkspeed", "Walkspeed", 16, 120, 16, Color3.fromRGB(0, 150, 200))
createSlider(attrContent, "Jumppower", "Jump Power", 50, 200, 50, Color3.fromRGB(0, 150, 200))
createToggle(attrContent, "InfiniteStamina", "Infinite Stamina", false)
createToggle(attrContent, "AntiStun", "Anti Stun", false)

-- Seção Visual
local visualSection, visualContent = createSection(playerPage, "Visual")
visualSection.Size = UDim2.new(1, 0, 0, 80)
createToggle(visualContent, "ESP", "ESP Players", false)
createToggle(visualContent, "Fullbright", "Fullbright", false)

-- ========== ABA COMBAT ==========
local combatPage = pages["Combat"]

local combatSection, combatContent = createSection(combatPage, "Combat Options")
combatSection.Size = UDim2.new(1, 0, 0, 150)

createToggle(combatContent, "AutoPowerup", "Auto Power-up", false)
createToggle(combatContent, "AutoSpike", "Auto Spike (Combat)", false) -- pode duplicar, mas é separado
createToggle(combatContent, "AutoBlock", "Auto Block (Combat)", false)
createButton(combatContent, "Reset Character", function()
    if Player.Character then
        Player.Character:BreakJoints()
    end
end)

-- ========== ABA MISC ==========
local miscPage = pages["Misc"]

local miscSection, miscContent = createSection(miscPage, "Extras")
miscSection.Size = UDim2.new(1, 0, 0, 120)
createToggle(miscContent, "AntiAfk", "Anti-AFK", false)
createToggle(miscContent, "NoClip", "NoClip (Experimental)", false)
createToggle(miscContent, "InfiniteJump", "Infinite Jump", false)

-- ========== HEARTBEAT LOOP - LÓGICA ATIVA PARA VOLLEYBALL LEGENDS ==========
RunService.Heartbeat:Connect(function()
    -- Garantir que o personagem existe
    local character = Player.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not character or not humanoid or not rootPart then return end

    -- ===== FUNÇÕES DE MOVIMENTAÇÃO E ATRIBUTOS =====
    if getgenv().Walkspeed then
        humanoid.WalkSpeed = getgenv().Walkspeed
    end
    if getgenv().Jumppower then
        humanoid.JumpPower = getgenv().Jumppower
    end

    -- ===== INFINITE STAMINA =====
    if getgenv().InfiniteStamina then
        -- Exemplo: Stamina pode ser um NumberValue no personagem ou um atributo
        local stamina = character:FindFirstChild("Stamina") or character:FindFirstChild("Energy")
        if stamina and stamina:IsA("NumberValue") then
            stamina.Value = stamina.MaxValue or 100
        end
    end

    -- ===== AUTO SERVE =====
    if getgenv().AutoServe then
        -- Verificar se está no momento de sacar (por exemplo, se há uma bola na mão)
        -- Isso varia de jogo para jogo. Exemplo genérico:
        local ball = Workspace:FindFirstChild("Ball") or Workspace:FindFirstChild("Volleyball")
        if ball and ball:FindFirstChild("Handle") then
            -- Se a bola está perto e o jogador pode sacar
            local serveremote = ReplicatedStorage:FindFirstChild("Serve") or ReplicatedStorage:FindFirstChild("RemoteEvent")
            if serveremote then
                serveremote:FireServer()
            end
        end
    end

    -- ===== AUTO SPIKE =====
    if getgenv().AutoSpike then
        -- Verifica se a bola está no ar e próximo para atacar
        local ball = Workspace:FindFirstChild("Ball") or Workspace:FindFirstChild("Volleyball")
        if ball and ball:FindFirstChild("Handle") then
            local ballPos = ball.Handle.Position
            local charPos = rootPart.Position
            local distance = (ballPos - charPos).Magnitude
            if distance < 15 and ballPos.Y > charPos.Y + 5 then -- Bola acima
                local spikeremote = ReplicatedStorage:FindFirstChild("Spike") or ReplicatedStorage:FindFirstChild("Attack")
                if spikeremote then
                    spikeremote:FireServer()
                end
            end
        end
    end

    -- ===== AUTO BLOCK =====
    if getgenv().AutoBlock then
        -- Se a bola está vindo em direção ao jogador, bloquear
        local ball = Workspace:FindFirstChild("Ball") or Workspace:FindFirstChild("Volleyball")
        if ball and ball:FindFirstChild("Handle") then
            -- Lógica simples: se a bola está se movendo na direção do jogador
            -- (requer análise de velocidade, deixamos simplificado)
            local blockemote = ReplicatedStorage:FindFirstChild("Block") or ReplicatedStorage:FindFirstChild("Defense")
            if blockemote then
                blockemote:FireServer()
            end
        end
    end

    -- ===== AUTO DIVE =====
    if getgenv().AutoDive then
        -- Mergulhar para pegar bola longe
        local ball = Workspace:FindFirstChild("Ball")
        if ball and ball:FindFirstChild("Handle") then
            local ballPos = ball.Handle.Position
            local charPos = rootPart.Position
            if (ballPos - charPos).Magnitude > 20 then
                local diveemote = ReplicatedStorage:FindFirstChild("Dive") or ReplicatedStorage:FindFirstChild("Slide")
                if diveemote then
                    diveemote:FireServer()
                end
            end
        end
    end

    -- ===== AUTO JUMP =====
    if getgenv().AutoJump then
        -- Pular quando a bola estiver próxima (para spike/block)
        local ball = Workspace:FindFirstChild("Ball")
        if ball and ball:FindFirstChild("Handle") then
            local ballPos = ball.Handle.Position
            local charPos = rootPart.Position
            if (ballPos - charPos).Magnitude < 10 and ballPos.Y > charPos.Y then
                humanoid.Jump = true
            end
        end
    end

    -- ===== TARGET ENEMY =====
    if getgenv().TargetEnemy then
        -- Virar o personagem para o adversário (pode ser útil para mirar)
        local enemy = nil
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                enemy = player
                break
            end
        end
        if enemy and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
            local enemyPos = enemy.Character.HumanoidRootPart.Position
            local lookAt = CFrame.lookAt(rootPart.Position, enemyPos)
            rootPart.CFrame = CFrame.new(rootPart.Position, Vector3.new(enemyPos.X, rootPart.Position.Y, enemyPos.Z))
        end
    end

    -- ===== ANTI STUN =====
    if getgenv().AntiStun then
        -- Se o jogador está atordoado, tentar resetar
        if humanoid:GetState() == Enum.HumanoidStateType.Stunned then
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end

    -- ===== AUTO POWER-UP =====
    if getgenv().AutoPowerup then
        -- Procurar power-ups no mapa e pegar
        for _, obj in ipairs(Workspace:GetChildren()) do
            if obj.Name:lower():find("power") or obj.Name:lower():find("boost") then
                if obj:IsA("Part") or obj:IsA("Model") then
                    local pos = obj:IsA("Model") and obj.PrimaryPart and obj.PrimaryPart.Position or obj.Position
                    rootPart.CFrame = CFrame.new(pos)
                end
            end
        end
    end

    -- ===== AUTO FARM (ganhar XP) =====
    if getgenv().AutoFarm then
        -- Pode ser farmar power-ups, ou simplesmente ficar em uma posição que rende XP
        -- Exemplo: mover-se para um local específico
        local farmPos = Vector3.new(0, 20, 0) -- local fictício
        rootPart.CFrame = CFrame.new(farmPos)
    end

    -- ===== ANTI-AFK =====
    if getgenv().AntiAfk then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end

    -- ===== NO COOLDOWN =====
    if getgenv().NoCooldown then
        -- Tentar zerar cooldowns (pode ser via remotes)
        -- Exemplo genérico: procurar valores de cooldown e setar para 0
    end

    -- ===== ESP =====
    if getgenv().ESP then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                -- Desenhar ESP simples (aqui apenas um highlight, mas pode ser mais elaborado)
                -- Para simplificar, não implementaremos desenho 2D agora.
            end
        end
    end

    -- ===== FULLBRIGHT =====
    if getgenv().Fullbright then
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.new(1, 1, 1)
    else
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.new(0, 0, 0)
    end

    -- ===== NOCLIP =====
    if getgenv().NoClip then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- ===== INFINITE JUMP =====
    -- (Já tratado pelo evento abaixo)
end)

-- Infinite Jump (detecção de tecla)
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfiniteJump and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid:ChangeState("Jumping")
    end
end)

print("ShinkaHub - Volleyball Legends carregado! Divirta-se.")
-- ========== FIM DA PARTE 3/3 ==========
