-- ===================================================================
-- SHINKAHUB - PARTE 1/3 (ESTRUTURA PRINCIPAL, BARRA DE TÍTULO E MINIMIZAR)
-- ===================================================================

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

-- Variáveis Globais (getgenv) - Todas as funções do hub
getgenv().AutoFarm = false
getgenv().AutoQuest = false
getgenv().AutoCollect = false
getgenv().AutoVoid = false
getgenv().AutoBlock = false
getgenv().AntiSlow = false
getgenv().SafeModeToggle = false
getgenv().SafeModeHealth = 50
getgenv().SafeModeBackHealth = 69
getgenv().SelectedCharacter = "Bald"
getgenv().AutoKill = false
getgenv().AntiAfk = false
getgenv().Walkspeed = 16
getgenv().Jumppower = 50
getgenv().AutoRaid = false
getgenv().AutoDungeon = false

local Player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinkaHub_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Destroi GUI antiga se existir
for _, v in ipairs(CoreGui:GetChildren()) do
    if v.Name == "ShinkaHub_GUI" then
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
mainFrame.Size = UDim2.new(0, 650, 0, 450)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
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
titleLabel.Text = "ShinkaHub | Version: 3.7.0"
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
-- Frame minimizado (aparece quando minimizado)
local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 220, 0, 45)
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
minimizedLabel.Text = "ShinkaHub"
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
-- SHINKAHUB - PARTE 2/3 (ABAS, PAINEL LATERAL, FUNÇÕES DE CRIAÇÃO DE UI)
-- ===================================================================

-- Painel de abas (ScrollingFrame vertical)
local tabsPanel = Instance.new("ScrollingFrame")
tabsPanel.Name = "TabsPanel"
tabsPanel.Size = UDim2.new(0, 130, 1, -10)
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

-- Dados das abas
local tabsData = {
    {name = "Home", icon = "🏠", order = 1},
    {name = "Main", icon = "⚙️", order = 2},
    {name = "Farming", icon = "🌾", order = 3, highlightColor = Color3.fromRGB(200, 50, 50)},
    {name = "Killer", icon = "⚔️", order = 4},
    {name = "Misc", icon = "🧰", order = 5},
}

local tabButtons = {}
local selectedTab = "Farming" -- padrão

-- Área de conteúdo
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -145, 1, -10)
contentArea.Position = UDim2.new(0, 140, 0, 5)
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
    btn.Size = UDim2.new(1, -10, 0, 42)
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
local function createSlider(parent, name, label, min, max, default, color)
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
    valueLabel.Text = tostring(default)
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
        valueLabel.Text = tostring(value)
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
-- SHINKAHUB - PARTE 3/3 (CONTEÚDO DAS ABAS E HEARTBEAT)
-- ===================================================================

-- Layout automático para as páginas (UIListLayout)
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
createToggle(autoContent, "AutoFarm", "Auto Farm", false)
createToggle(autoContent, "AutoQuest", "Auto Quest", false)
createToggle(autoContent, "AutoCollect", "Auto Collect", false)

-- Seção Player Boost
local boostSection, boostContent = createSection(homePage, "Player Boost")
boostSection.Size = UDim2.new(1, 0, 0, 120)
createSlider(boostContent, "Walkspeed", "Walkspeed", 16, 120, 16, Color3.fromRGB(0, 150, 200))
createSlider(boostContent, "Jumppower", "Jump Power", 50, 200, 50, Color3.fromRGB(0, 150, 200))

-- ========== ABA MAIN ==========
local mainPage = pages["Main"]

-- Seção Teleport
local teleportSection, teleportContent = createSection(mainPage, "Teleport")
teleportSection.Size = UDim2.new(1, 0, 0, 130)

-- Exemplo de botões de teleporte (personalize conforme o jogo)
createButton(teleportContent, "Teleport to Spawn", function()
    local spawn = Workspace:FindFirstChild("Spawn") or Workspace:FindFirstChild("Start")
    if spawn then
        Player.Character:MoveTo(spawn.Position)
    end
end)

createButton(teleportContent, "Teleport to Boss", function()
    local boss = Workspace:FindFirstChild("Boss") or Workspace:FindFirstChild("BossArea")
    if boss then
        Player.Character:MoveTo(boss.Position)
    end
end)

-- Seção Misc
local miscSection, miscContent = createSection(mainPage, "Misc")
miscSection.Size = UDim2.new(1, 0, 0, 90)
createToggle(miscContent, "AntiAfk", "Anti-AFK", false)
createButton(miscContent, "Rejoin Game", function()
    TeleportService:Teleport(game.PlaceId, Player)
end)

-- ========== ABA FARMING (mais completa) ==========
local farmingPage = pages["Farming"]

-- Seção Player
local playerSection, playerContent = createSection(farmingPage, "Player")
playerSection.Size = UDim2.new(1, 0, 0, 130)
createToggle(playerContent, "AutoVoid", "Auto Void", false)
createToggle(playerContent, "AutoBlock", "Auto Block", false)
createToggle(playerContent, "AntiSlow", "Anti-Slow", false)

-- Seção Character
local charSection, charContent = createSection(farmingPage, "Character")
charSection.Size = UDim2.new(1, 0, 0, 90)

-- Dropdown de personagem
createDropdown(charContent, "Choose Character", {"Bald", "Hair", "Mask", "Cyborg"}, "Bald", function(selected)
    getgenv().SelectedCharacter = selected
end)

createButton(charContent, "Equip Character", function()
    print("Equipando: " .. getgenv().SelectedCharacter)
    -- Coloque aqui a lógica de equipar o personagem no jogo
end)

-- Seção Safe Mode
local safeSection, safeContent = createSection(farmingPage, "Safe Mode")
safeSection.Size = UDim2.new(1, 0, 0, 150)
createToggle(safeContent, "SafeModeToggle", "Auto Safe Mode", false)
createSlider(safeContent, "SafeModeHealth", "Health Threshold", 1, 100, 50, Color3.fromRGB(200, 50, 50))
createSlider(safeContent, "SafeModeBackHealth", "Return Health", 1, 100, 69, Color3.fromRGB(200, 50, 50))

-- ========== ABA KILLER ==========
local killerPage = pages["Killer"]

local killerSection, killerContent = createSection(killerPage, "Combat")
killerSection.Size = UDim2.new(1, 0, 0, 90)
createToggle(killerContent, "AutoKill", "Auto Kill", false)
createToggle(killerContent, "AutoRaid", "Auto Raid", false)
createToggle(killerContent, "AutoDungeon", "Auto Dungeon", false)

local aimSection, aimContent = createSection(killerPage, "Aimbot")
aimSection.Size = UDim2.new(1, 0, 0, 80)
createToggle(aimContent, "Aimbot", "Aimbot", false)
createSlider(aimContent, "AimSensitivity", "Sensitivity", 1, 10, 5, Color3.fromRGB(200, 100, 0))

-- ========== ABA MISC ==========
local miscPage = pages["Misc"]

local visualSection, visualContent = createSection(miscPage, "Visuals")
visualSection.Size = UDim2.new(1, 0, 0, 80)
createToggle(visualContent, "ESP", "ESP", false)
createToggle(visualContent, "Fullbright", "Fullbright", false)

local worldSection, worldContent = createSection(miscPage, "World")
worldSection.Size = UDim2.new(1, 0, 0, 80)
createToggle(worldContent, "NoClip", "NoClip", false)
createToggle(worldContent, "InfiniteJump", "Infinite Jump", false)

-- ========== HEARTBEAT LOOP (TODAS AS FUNÇÕES ATIVAS) ==========
RunService.Heartbeat:Connect(function()
    -- Auto Farm (exemplo)
    if getgenv().AutoFarm then
        -- Lógica de farm: procurar mobs, coletar, etc.
        -- (adaptar para o jogo específico)
    end

    -- Auto Quest
    if getgenv().AutoQuest then
        -- Lógica de quest
    end

    -- Auto Collect
    if getgenv().AutoCollect then
        -- Coletar itens próximos
    end

    -- Auto Void
    if getgenv().AutoVoid then
        -- Prevenir queda no vazio
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = Player.Character.HumanoidRootPart.Position
            if pos.Y < -50 then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) -- teleporte para safe
            end
        end
    end

    -- Auto Block (exemplo: segurar botão de bloqueio)
    if getgenv().AutoBlock then
        -- Simular tecla de bloqueio (depende do jogo)
    end

    -- Anti-Slow (resetar velocidade)
    if getgenv().AntiSlow and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        if Player.Character.Humanoid.WalkSpeed < 16 then
            Player.Character.Humanoid.WalkSpeed = 16
        end
    end

    -- Safe Mode
    if getgenv().SafeModeToggle and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        local health = Player.Character.Humanoid.Health
        if health <= getgenv().SafeModeHealth then
            -- Ativar modo seguro: teleportar para safe area, ativar auto potion, etc.
        elseif health >= getgenv().SafeModeBackHealth then
            -- Desativar modo seguro
        end
    end

    -- Auto Kill (exemplo: atacar inimigos próximos)
    if getgenv().AutoKill then
        -- Lógica de combate
    end

    -- Anti-AFK
    if getgenv().AntiAfk then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end

    -- Walkspeed / Jumppower (aplicar se mudar)
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        if Player.Character.Humanoid.WalkSpeed ~= getgenv().Walkspeed then
            Player.Character.Humanoid.WalkSpeed = getgenv().Walkspeed
        end
        if Player.Character.Humanoid.JumpPower ~= getgenv().Jumppower then
            Player.Character.Humanoid.JumpPower = getgenv().Jumppower
        end
    end

    -- Aimbot (placeholder)
    if getgenv().Aimbot then
        -- Lógica de aimbot
    end

    -- ESP (placeholder)
    if getgenv().ESP then
        -- Desenhar ESP
    end

    -- Fullbright
    if getgenv().Fullbright then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
    end

    -- NoClip (exemplo)
    if getgenv().NoClip and Player.Character then
        for _, part in ipairs(Player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- Infinite Jump
    if getgenv().InfiniteJump then
        -- Implementar via UserInputService (exemplo simples)
        -- Pode ser feito com bind, mas aqui apenas indicamos que está ativo.
    end
end)

-- Infinite Jump (detecção de tecla)
local infiniteJumpConnection
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfiniteJump and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid:ChangeState("Jumping")
    end
end)

print("ShinkaHub v3.7.0 carregado com sucesso! Divirta-se.")
-- ========== FIM DA PARTE 3/3 ==========
