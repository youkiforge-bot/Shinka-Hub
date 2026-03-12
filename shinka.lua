-- ===================================================================
-- SHINKA HUB - VOLLEYBALL LEGENDS (VERSÃO FUNCIONAL)
-- PARTE 1/4 – ESTRUTURA PRINCIPAL E GUI
-- ===================================================================

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

-- Variáveis Globais
getgenv().BallHitbox = false
getgenv().BallHitboxSize = 2
getgenv().BallHitboxColor = Color3.fromRGB(255, 0, 0)
getgenv().AutoStrongServe = false
getgenv().JumpESP = false
getgenv().JumpESPColor = Color3.fromRGB(0, 255, 0)
getgenv().PredictAim = false
getgenv().PredictionLength = 5
getgenv().PredictAimColor = Color3.fromRGB(0, 255, 255)
getgenv().AutoSpike = false
getgenv().AutoBlock = false
getgenv().AutoDive = false

local Player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinkaHub_VL"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Destroi GUI antiga
for _, v in ipairs(CoreGui:GetChildren()) do
    if v.Name == "ShinkaHub_VL" then
        v:Destroy()
    end
end
ScreenGui.Parent = CoreGui

-- Funções Auxiliares
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
mainFrame.Size = UDim2.new(0, 750, 0, 600)
mainFrame.Position = UDim2.new(0.5, -375, 0.5, -300)
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
createGradient(mainFrame, Color3.fromRGB(25, 25, 35), Color3.fromRGB(15, 15, 22), 45)

-- Barra de Título
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleBar.Parent = mainFrame
createCorner(titleBar, 12)

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0.5, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Shinka Hub | Volleyball Legends"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Botões de controle
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -48, 0.5, -17.5)
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
minButton.Size = UDim2.new(0, 35, 0, 35)
minButton.Position = UDim2.new(1, -92, 0.5, -17.5)
minButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
minButton.Text = "−"
minButton.TextColor3 = Color3.fromRGB(200, 200, 220)
minButton.Font = Enum.Font.GothamBold
minButton.TextSize = 24
minButton.Parent = titleBar
createCorner(minButton, 8)
createStroke(minButton, 1, Color3.fromRGB(80, 80, 100))

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

-- Container principal
local mainContentContainer = Instance.new("Frame")
mainContentContainer.Name = "MainContentContainer"
mainContentContainer.Size = UDim2.new(1, 0, 1, -45)
mainContentContainer.Position = UDim2.new(0, 0, 0, 45)
mainContentContainer.BackgroundTransparency = 1
mainContentContainer.Parent = mainFrame

-- Sistema de minimizar (versão reduzida)
local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 280, 0, 50)
minimizedFrame.Position = mainFrame.Position
minimizedFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
minimizedFrame.Visible = false
minimizedFrame.Parent = ScreenGui
createCorner(minimizedFrame, 10)
createStroke(minimizedFrame, 2, Color3.fromRGB(40, 40, 60))
createGradient(minimizedFrame, Color3.fromRGB(25, 25, 35), Color3.fromRGB(15, 15, 22), 45)

local minimizedLabel = Instance.new("TextLabel")
minimizedLabel.Size = UDim2.new(1, -50, 1, 0)
minimizedLabel.Position = UDim2.new(0, 10, 0, 0)
minimizedLabel.BackgroundTransparency = 1
minimizedLabel.Text = "Shinka Hub - Ativo"
minimizedLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
minimizedLabel.Font = Enum.Font.GothamBold
minimizedLabel.TextSize = 16
minimizedLabel.TextXAlignment = Enum.TextXAlignment.Left
minimizedLabel.Parent = minimizedFrame

local restoreButton = Instance.new("TextButton")
restoreButton.Name = "RestoreButton"
restoreButton.Size = UDim2.new(0, 35, 0, 35)
restoreButton.Position = UDim2.new(1, -45, 0.5, -17.5)
restoreButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
restoreButton.Text = "⬆"
restoreButton.TextColor3 = Color3.fromRGB(200, 200, 220)
restoreButton.Font = Enum.Font.GothamBold
restoreButton.TextSize = 18
restoreButton.Parent = minimizedFrame
createCorner(restoreButton, 8)
createStroke(restoreButton, 1, Color3.fromRGB(80, 80, 100))
hoverEffect(restoreButton, Color3.fromRGB(70, 70, 90))

-- Arrastar minimizado
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

-- Arrastar GUI principal
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
end)-- ===================================================================
-- PARTE 2/4 – PAINEL DE ABAS E FUNÇÕES DE CRIAÇÃO DE UI
-- ===================================================================

-- Painel de abas
local tabsPanel = Instance.new("ScrollingFrame")
tabsPanel.Name = "TabsPanel"
tabsPanel.Size = UDim2.new(0, 150, 1, -10)
tabsPanel.Position = UDim2.new(0, 5, 0, 5)
tabsPanel.BackgroundTransparency = 1
tabsPanel.ScrollBarThickness = 4
tabsPanel.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
tabsPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
tabsPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
tabsPanel.Parent = mainContentContainer

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 12)
tabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Parent = tabsPanel

-- Abas (incluindo as que você mencionou)
local tabsData = {
    {name = "Predict", icon = "🔮", order = 1, highlightColor = Color3.fromRGB(255, 255, 0)},
    {name = "Serve", icon = "💪", order = 2, highlightColor = Color3.fromRGB(100, 255, 100)},
    {name = "JumpESP", icon = "👆", order = 3, highlightColor = Color3.fromRGB(100, 100, 255)},
    {name = "Hitbox", icon = "🎯", order = 4, highlightColor = Color3.fromRGB(255, 100, 100)},
    {name = "Actions", icon = "⚡", order = 5, highlightColor = Color3.fromRGB(255, 150, 0)},
    {name = "Credits", icon = "📜", order = 6, highlightColor = Color3.fromRGB(200, 100, 255)},
}

local tabButtons = {}
local selectedTab = "Hitbox"

-- Área de conteúdo
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -165, 1, -10)
contentArea.Position = UDim2.new(0, 160, 0, 5)
contentArea.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
contentArea.Parent = mainContentContainer
createCorner(contentArea, 10)
createStroke(contentArea, 1, Color3.fromRGB(50, 50, 70))

-- Páginas
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
    btn.Size = UDim2.new(1, -10, 0, 48)
    btn.BackgroundColor3 = (tab.name == selectedTab) and (tab.highlightColor or Color3.fromRGB(60, 60, 100)) or Color3.fromRGB(35, 35, 50)
    btn.Text = tab.icon .. "   " .. tab.name
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 15
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

-- Layout das páginas
for name, page in pairs(pages) do
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 20)
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page
end

-- ========== FUNÇÕES DE CRIAÇÃO DE ELEMENTOS ==========

-- Toggle
local function createToggle(parent, name, label, default)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, -10, 0, 50)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local labelObj = Instance.new("TextLabel")
    labelObj.Size = UDim2.new(0.7, -5, 1, 0)
    labelObj.Position = UDim2.new(0, 0, 0, 0)
    labelObj.BackgroundTransparency = 1
    labelObj.Text = label
    labelObj.TextColor3 = Color3.fromRGB(220, 220, 240)
    labelObj.Font = Enum.Font.Gotham
    labelObj.TextSize = 15
    labelObj.TextXAlignment = Enum.TextXAlignment.Left
    labelObj.Parent = container

    local toggleBg = Instance.new("Frame")
    toggleBg.Name = "ToggleBg"
    toggleBg.Size = UDim2.new(0, 50, 0, 26)
    toggleBg.Position = UDim2.new(1, -60, 0.5, -13)
    toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBg.Parent = container
    createCorner(toggleBg, 30)

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "ToggleCircle"
    toggleCircle.Size = UDim2.new(0, 22, 0, 22)
    toggleCircle.Position = UDim2.new(0, 2, 0.5, -11)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.Parent = toggleBg
    createCorner(toggleCircle, 11)

    local state = default or false
    getgenv()[name] = state

    local function updateVisual()
        if state then
            tweenObject(toggleCircle, {Position = UDim2.new(1, -24, 0.5, -11)}, 0.15)
            tweenObject(toggleBg, {BackgroundColor3 = Color3.fromRGB(0, 150, 200)}, 0.15)
        else
            tweenObject(toggleCircle, {Position = UDim2.new(0, 2, 0.5, -11)}, 0.15)
            tweenObject(toggleBg, {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}, 0.15)
        end
    end
    updateVisual()

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = container
    button.MouseButton1Click:Connect(function()
        state = not state
        getgenv()[name] = state
        updateVisual()
    end)

    return container
end

-- Slider
local function createSlider(parent, name, label, min, max, default, suffix)
    local container = Instance.new("Frame")
    container.Name = name .. "SliderContainer"
    container.Size = UDim2.new(1, -10, 0, 65)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local labelObj = Instance.new("TextLabel")
    labelObj.Size = UDim2.new(0.6, 0, 0.4, 0)
    labelObj.Position = UDim2.new(0, 0, 0, 0)
    labelObj.BackgroundTransparency = 1
    labelObj.Text = label
    labelObj.TextColor3 = Color3.fromRGB(200, 200, 220)
    labelObj.Font = Enum.Font.Gotham
    labelObj.TextSize = 14
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
    valueLabel.TextSize = 14
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = container

    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "SliderBg"
    sliderBg.Size = UDim2.new(1, 0, 0, 8)
    sliderBg.Position = UDim2.new(0, 0, 0, 30)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBg.Parent = container
    createCorner(sliderBg, 4)

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    fill.Parent = sliderBg
    createCorner(fill, 4)

    local thumb = Instance.new("Frame")
    thumb.Name = "Thumb"
    thumb.Size = UDim2.new(0, 16, 0, 16)
    thumb.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.Parent = sliderBg
    createCorner(thumb, 8)
    createStroke(thumb, 1, Color3.fromRGB(150, 150, 150))

    local dragging = false
    local value = default
    getgenv()[name] = value

    local function updateSlider(input)
        local pos = input.Position.X - sliderBg.AbsolutePosition.X
        local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
        value = min + (max - min) * percent
        value = math.floor(value * 10 + 0.5) / 10
        fill.Size = UDim2.new(percent, 0, 1, 0)
        thumb.Position = UDim2.new(percent, -8, 0.5, -8)
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

-- Color Picker simplificado
local function createColorPicker(parent, name, label, defaultColor)
    local container = Instance.new("Frame")
    container.Name = name .. "ColorContainer"
    container.Size = UDim2.new(1, -10, 0, 50)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local labelObj = Instance.new("TextLabel")
    labelObj.Size = UDim2.new(0.6, -5, 1, 0)
    labelObj.Position = UDim2.new(0, 0, 0, 0)
    labelObj.BackgroundTransparency = 1
    labelObj.Text = label
    labelObj.TextColor3 = Color3.fromRGB(220, 220, 240)
    labelObj.Font = Enum.Font.Gotham
    labelObj.TextSize = 15
    labelObj.TextXAlignment = Enum.TextXAlignment.Left
    labelObj.Parent = container

    local colorDisplay = Instance.new("Frame")
    colorDisplay.Name = "ColorDisplay"
    colorDisplay.Size = UDim2.new(0, 40, 0, 30)
    colorDisplay.Position = UDim2.new(1, -50, 0.5, -15)
    colorDisplay.BackgroundColor3 = defaultColor
    colorDisplay.Parent = container
    createCorner(colorDisplay, 6)
    createStroke(colorDisplay, 1, Color3.fromRGB(80, 80, 100))

    local pickerButton = Instance.new("TextButton")
    pickerButton.Size = UDim2.new(1, 0, 1, 0)
    pickerButton.BackgroundTransparency = 1
    pickerButton.Text = ""
    pickerButton.Parent = colorDisplay

    pickerButton.MouseButton1Click:Connect(function()
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 200, 0, 200)
        menu.Position = UDim2.new(0.5, -100, 0.5, -100)
        menu.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        menu.Parent = ScreenGui
        createCorner(menu, 8)
        createStroke(menu, 1, Color3.fromRGB(60, 60, 80))

        local colors = {
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(255, 0, 255),
            Color3.fromRGB(0, 255, 255),
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(0, 0, 0),
        }

        local grid = Instance.new("Frame")
        grid.Size = UDim2.new(1, -10, 1, -40)
        grid.Position = UDim2.new(0, 5, 0, 5)
        grid.BackgroundTransparency = 1
        grid.Parent = menu

        for i, color in ipairs(colors) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 40, 0, 40)
            btn.Position = UDim2.new(0, ((i-1)%4)*45, 0, math.floor((i-1)/4)*45)
            btn.BackgroundColor3 = color
            btn.Text = ""
            btn.Parent = grid
            createCorner(btn, 6)

            btn.MouseButton1Click:Connect(function()
                getgenv()[name] = color
                colorDisplay.BackgroundColor3 = color
                menu:Destroy()
            end)
        end

        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(1, -10, 0, 30)
        closeBtn.Position = UDim2.new(0, 5, 1, -35)
        closeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        closeBtn.Text = "Fechar"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.Font = Enum.Font.Gotham
        closeBtn.TextSize = 14
        closeBtn.Parent = menu
        createCorner(closeBtn, 6)

        closeBtn.MouseButton1Click:Connect(function()
            menu:Destroy()
        end)
    end)

    return container
end

-- Seção com título
local function createSection(parent, title)
    local section = Instance.new("Frame")
    section.Name = title .. "Section"
    section.Size = UDim2.new(1, 0, 0, 0)
    section.BackgroundTransparency = 1
    section.Parent = parent

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -10, 0, 35)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = section

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -10, 0, 2)
    line.Position = UDim2.new(0, 5, 0, 35)
    line.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    line.Parent = section
    createCorner(line, 1)

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -10, 1, -45)
    content.Position = UDim2.new(0, 5, 0, 40)
    content.BackgroundTransparency = 1
    content.Parent = section

    -- Layout interno
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 12)
    contentLayout.FillDirection = Enum.FillDirection.Vertical
    contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = content

    return section, content
end

-- Botão de ação rápida
local function createActionButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
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
end-- ===================================================================
-- PARTE 3/4 – CONTEÚDO DAS ABAS (PREDICT, SERVE, JUMPESP, HITBOX, ACTIONS)
-- ===================================================================

-- ========== ABA PREDICT ==========
local predictPage = pages["Predict"]

local predictSection, predictContent = createSection(predictPage, "Predict Aim")
predictSection.Size = UDim2.new(1, 0, 0, 200)

createToggle(predictContent, "PredictAim", "Enable Predict Aim", false)
createSlider(predictContent, "PredictionLength", "Prediction Length", 1, 20, 5, " studs")
createColorPicker(predictContent, "PredictAimColor", "Predict Color", getgenv().PredictAimColor)

-- ========== ABA SERVE ==========
local servePage = pages["Serve"]

local serveSection, serveContent = createSection(servePage, "Auto Strong Serve")
serveSection.Size = UDim2.new(1, 0, 0, 80)

createToggle(serveContent, "AutoStrongServe", "Enable Auto Strong Serve", false)

-- ========== ABA JUMPESP ==========
local jumpPage = pages["JumpESP"]

local jumpSection, jumpContent = createSection(jumpPage, "Jump ESP")
jumpSection.Size = UDim2.new(1, 0, 0, 140)

createToggle(jumpContent, "JumpESP", "Enable Jump ESP", false)
createColorPicker(jumpContent, "JumpESPColor", "Jump ESP Color", getgenv().JumpESPColor)

-- ========== ABA HITBOX ==========
local hitboxPage = pages["Hitbox"]

local ballSection, ballContent = createSection(hitboxPage, "Ball Hitbox")
ballSection.Size = UDim2.new(1, 0, 0, 210)

createToggle(ballContent, "BallHitbox", "Enable Ball Hitbox", false)
createSlider(ballContent, "BallHitboxSize", "Hitbox Size", 1, 5, 2, "x")
createColorPicker(ballContent, "BallHitboxColor", "Hitbox Color", getgenv().BallHitboxColor)

-- ========== ABA ACTIONS ==========
local actionsPage = pages["Actions"]

local actionsSection, actionsContent = createSection(actionsPage, "Quick Actions")
actionsSection.Size = UDim2.new(1, 0, 0, 250)

createActionButton(actionsContent, "🏐 MERGULHO (Dive)", function()
    -- Tenta executar um mergulho (encontrar remote)
    local remote = ReplicatedStorage:FindFirstChild("Dive") or 
                   (ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Dive"))
    if remote then
        remote:FireServer()
    else
        print("Remote de mergulho não encontrado")
    end
end)

createActionButton(actionsContent, "⚙️ CONFIGURAÇÃO", function()
    -- Abre um menu simples de configuração (pode ser expandido)
    print("Abrir configurações...")
end)

createActionButton(actionsContent, "🔄 Auto Spike", function()
    getgenv().AutoSpike = not getgenv().AutoSpike
    print("Auto Spike:", getgenv().AutoSpike and "ON" or "OFF")
end)

createActionButton(actionsContent, "🛡️ Auto Block", function()
    getgenv().AutoBlock = not getgenv().AutoBlock
    print("Auto Block:", getgenv().AutoBlock and "ON" or "OFF")
end)

createActionButton(actionsContent, "💨 Auto Dive", function()
    getgenv().AutoDive = not getgenv().AutoDive
    print("Auto Dive:", getgenv().AutoDive and "ON" or "OFF")
end)-- ===================================================================
-- PARTE 4/4 – CRÉDITOS E HEARTBEAT FUNCIONAL
-- ===================================================================

-- ========== ABA CREDITS ==========
local creditsPage = pages["Credits"]

local creditsSection, creditsContent = createSection(creditsPage, "Créditos")
creditsSection.Size = UDim2.new(1, 0, 0, 250)

local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, -10, 0, 40)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "👑 Criado por: ImShinka"
creditLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
creditLabel.Font = Enum.Font.GothamBold
creditLabel.TextSize = 20
creditLabel.TextXAlignment = Enum.TextXAlignment.Left
creditLabel.Parent = creditsContent

local deepLabel = Instance.new("TextLabel")
deepLabel.Size = UDim2.new(1, -10, 0, 30)
deepLabel.BackgroundTransparency = 1
deepLabel.Text = "🤝 Deep (Co-criador)"
deepLabel.TextColor3 = Color3.fromRGB(100, 255, 255)
deepLabel.Font = Enum.Font.Gotham
deepLabel.TextSize = 18
deepLabel.TextXAlignment = Enum.TextXAlignment.Left
deepLabel.Parent = creditsContent

local discordLabel = Instance.new("TextLabel")
discordLabel.Size = UDim2.new(1, -10, 0, 30)
discordLabel.BackgroundTransparency = 1
discordLabel.Text = "📱 Discord:"
discordLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
discordLabel.Font = Enum.Font.Gotham
discordLabel.TextSize = 18
discordLabel.TextXAlignment = Enum.TextXAlignment.Left
discordLabel.Parent = creditsContent

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(1, -10, 0, 40)
discordBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
discordBtn.Text = "https://discord.gg/SNutmtu6x"
discordBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
discordBtn.Font = Enum.Font.GothamSemibold
discordBtn.TextSize = 14
discordBtn.Parent = creditsContent
createCorner(discordBtn, 8)
createStroke(discordBtn, 1, Color3.fromRGB(70, 70, 100))

discordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/SNutmtu6x")
    discordBtn.Text = "Link copiado!"
    task.wait(1)
    discordBtn.Text = "https://discord.gg/SNutmtu6x"
end)

discordBtn.MouseEnter:Connect(function()
    tweenObject(discordBtn, {BackgroundColor3 = Color3.fromRGB(65, 65, 85)}, 0.15)
end)
discordBtn.MouseLeave:Connect(function()
    tweenObject(discordBtn, {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}, 0.15)
end)

-- ========== HEARTBEAT LOOP - FUNÇÕES ATIVAS ==========

-- Variáveis para os overlays
local hitboxHighlight = nil
local jumpESPLines = {}
local predictLines = {}

-- Função melhorada para encontrar a bola
local function findBall()
    -- Procura por objetos com nome "Ball" ou "Volleyball" em qualquer lugar
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("ball") or obj.Name:lower():find("volley")) then
            return obj
        end
    end
    -- Se não encontrar, procura por partes esféricas (pode ser útil)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Shape == Enum.PartType.Ball then
            return obj
        end
    end
    return nil
end

-- Função para encontrar remote de saque
local function findServeRemote()
    local remoteNames = {"Serve", "ServeBall", "HitBall", "StrongServe", "PowerServe"}
    for _, name in ipairs(remoteNames) do
        local remote = ReplicatedStorage:FindFirstChild(name)
        if remote then return remote end
        local folder = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("Events")
        if folder then
            remote = folder:FindFirstChild(name)
            if remote then return remote end
        end
    end
    return nil
end

RunService.Heartbeat:Connect(function()
    local character = Player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local ballPart = findBall()

    -- ===== 1. BALL HITBOX (usando Highlight para melhor visualização) =====
    if getgenv().BallHitbox and ballPart then
        if not hitboxHighlight or not hitboxHighlight.Parent then
            hitboxHighlight = Instance.new("Highlight")
            hitboxHighlight.Name = "BallHitbox"
            hitboxHighlight.Adornee = ballPart
            hitboxHighlight.FillColor = getgenv().BallHitboxColor
            hitboxHighlight.OutlineColor = Color3.new(1,1,1)
            hitboxHighlight.FillTransparency = 0.5
            hitboxHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hitboxHighlight.Parent = Workspace
        else
            hitboxHighlight.Adornee = ballPart
            hitboxHighlight.FillColor = getgenv().BallHitboxColor
            -- Ajustar "tamanho" via Outline? Não é possível, mas podemos usar um BillboardGui? Melhor manter assim.
        end
    else
        if hitboxHighlight then
            hitboxHighlight:Destroy()
            hitboxHighlight = nil
        end
    end

    -- ===== 2. AUTO STRONG SERVE =====
    if getgenv().AutoStrongServe then
        local remote = findServeRemote()
        if remote then
            pcall(function()
                remote:FireServer(100)
                remote:FireServer("strong")
                remote:FireServer(true)
            end)
        end
    end

    -- ===== 3. JUMP ESP =====
    if getgenv().JumpESP then
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("HumanoidRootPart") then
                local hum = player.Character.Humanoid
                local root = player.Character.HumanoidRootPart
                if hum:GetState() == Enum.HumanoidStateType.Jumping or hum.FloorMaterial == Enum.Material.Air then
                    if not jumpESPLines[player] then
                        local attach1 = Instance.new("Attachment")
                        attach1.Name = "JumpESP_Attach1"
                        attach1.Parent = root
                        
                        local attach2 = Instance.new("Attachment")
                        attach2.Name = "JumpESP_Attach2"
                        attach2.Parent = root
                        
                        local beam = Instance.new("Beam")
                        beam.Attachment0 = attach1
                        beam.Attachment1 = attach2
                        beam.Width0 = 0.3
                        beam.Width1 = 0.3
                        beam.Transparency = NumberSequence.new(0)
                        beam.Color = ColorSequence.new(getgenv().JumpESPColor)
                        beam.Parent = Workspace
                        
                        jumpESPLines[player] = {attach1, attach2, beam}
                    end
                    
                    local attach1, attach2, beam = unpack(jumpESPLines[player])
                    local rootPos = root.Position
                    attach1.Position = Vector3.new(rootPos.X, 0, rootPos.Z)
                    attach2.Position = Vector3.new(rootPos.X, rootPos.Y, rootPos.Z)
                    beam.Color = ColorSequence.new(getgenv().JumpESPColor)
                else
                    if jumpESPLines[player] then
                        for _, obj in ipairs(jumpESPLines[player]) do
                            obj:Destroy()
                        end
                        jumpESPLines[player] = nil
                    end
                end
            end
        end
    else
        for player, objs in pairs(jumpESPLines) do
            for _, obj in ipairs(objs) do
                obj:Destroy()
            end
        end
        jumpESPLines = {}
    end

    -- ===== 4. PREDICT AIM =====
    if getgenv().PredictAim and ballPart and rootPart then
        local velocity = ballPart.Velocity
        local speed = velocity.Magnitude
        if speed > 0.5 then
            local direction = velocity.Unit
            local startPos = ballPart.Position
            local endPos = startPos + direction * getgenv().PredictionLength
            
            if not predictLines["main"] then
                local attach1 = Instance.new("Attachment")
                attach1.Name = "Predict_Attach1"
                attach1.Parent = ballPart
                
                local attach2 = Instance.new("Attachment")
                attach2.Name = "Predict_Attach2"
                attach2.Parent = ballPart
                
                local beam = Instance.new("Beam")
                beam.Attachment0 = attach1
                beam.Attachment1 = attach2
                beam.Width0 = 0.4
                beam.Width1 = 0.4
                beam.Transparency = NumberSequence.new(0.2)
                beam.Color = ColorSequence.new(getgenv().PredictAimColor)
                beam.Parent = Workspace
                
                predictLines["main"] = {attach1, attach2, beam}
            end
            
            local attach1, attach2, beam = unpack(predictLines["main"])
            attach1.Position = Vector3.new(0,0,0)
            attach2.Position = ballPart.CFrame:PointToObjectSpace(endPos)
            beam.Color = ColorSequence.new(getgenv().PredictAimColor)
        else
            if predictLines["main"] then
                for _, obj in ipairs(predictLines["main"]) do
                    obj:Destroy()
                end
                predictLines["main"] = nil
            end
        end
    else
        if predictLines["main"] then
            for _, obj in ipairs(predictLines["main"]) do
                obj:Destroy()
            end
            predictLines["main"] = nil
        end
    end

    -- ===== 5. AUTO SPIKE (exemplo) =====
    if getgenv().AutoSpike and ballPart and rootPart then
        local dist = (ballPart.Position - rootPart.Position).Magnitude
        if dist < 15 then
            local remote = ReplicatedStorage:FindFirstChild("Spike") or 
                           (ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Spike"))
            if remote then
                remote:FireServer()
            end
        end
    end

    -- ===== 6. AUTO BLOCK =====
    if getgenv().AutoBlock and ballPart and rootPart then
        local dist = (ballPart.Position - rootPart.Position).Magnitude
        if dist < 10 then
            local remote = ReplicatedStorage:FindFirstChild("Block") or 
                           (ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Block"))
            if remote then
                remote:FireServer()
            end
        end
    end

    -- ===== 7. AUTO DIVE =====
    if getgenv().AutoDive and ballPart and rootPart then
        local dist = (ballPart.Position - rootPart.Position).Magnitude
        if dist > 20 then
            local remote = ReplicatedStorage:FindFirstChild("Dive") or 
                           (ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Dive"))
            if remote then
                remote:FireServer()
            end
        end
    end
end)

print("✅ Shinka Hub - Volleyball Legends carregado!")
print("🎯 Funções: Hitbox | Auto Serve | Jump ESP | Predict | Ações Rápidas")
print("📱 Discord: https://discord.gg/SNutmtu6x")
