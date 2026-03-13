-- ===================================================================
-- SHINKA HUB - BROOKHAVEN (FUNÇÕES TROLL)
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
getgenv().Fly = false
getgenv().FlySpeed = 50
getgenv().Speed = 16
getgenv().JumpPower = 50
getgenv().Invisible = false
getgenv().NoClip = false
getgenv().FreezeOthers = false
getgenv().SitOthers = false
getgenv().ExplodeCars = false
getgenv().TrollTarget = nil

local Player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinkaHub_Brookhaven"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Destroi GUI antiga
for _, v in ipairs(CoreGui:GetChildren()) do
    if v.Name == "ShinkaHub_Brookhaven" then
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
titleLabel.Text = "Shinka Hub | Brookhaven (Troll)"
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

-- Sistema de minimizar
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
minimizedLabel.Text = "Shinka Hub - Brookhaven"
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

-- Abas
local tabsData = {
    {name = "Troll", icon = "👹", order = 1, highlightColor = Color3.fromRGB(255, 100, 100)},
    {name = "Player", icon = "🧑", order = 2, highlightColor = Color3.fromRGB(100, 255, 100)},
    {name = "Vehicles", icon = "🚗", order = 3, highlightColor = Color3.fromRGB(100, 100, 255)},
    {name = "Credits", icon = "📜", order = 4, highlightColor = Color3.fromRGB(200, 100, 255)},
}

local tabButtons = {}
local selectedTab = "Troll"

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

-- Botão de ação
local function createButton(parent, text, callback)
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
end-- ===================================================================
-- PARTE 3/4 – CONTEÚDO DAS ABAS TROLL, PLAYER, VEHICLES
-- ===================================================================

-- ========== ABA TROLL ==========
local trollPage = pages["Troll"]

local trollSection, trollContent = createSection(trollPage, "Funções Troll")
trollSection.Size = UDim2.new(1, 0, 0, 350)

createToggle(trollContent, "SitOthers", "Sentar outros players", false)
createToggle(trollContent, "FreezeOthers", "Congelar outros players", false)
createToggle(trollContent, "ExplodeCars", "Explodir carros próximos", false)

createButton(trollContent, "💺 Sentar jogador alvo", function()
    if getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local hrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local seat = Instance.new("Part")
            seat.Size = Vector3.new(4, 1, 4)
            seat.Anchored = true
            seat.CanCollide = false
            seat.Transparency = 1
            seat.CFrame = hrp.CFrame * CFrame.new(0, -2, 0)
            seat.Parent = Workspace
            
            local weld = Instance.new("Weld")
            weld.Part0 = hrp
            weld.Part1 = seat
            weld.C0 = CFrame.new(0, 2, 0)
            weld.Parent = seat
            
            local bodyPosition = Instance.new("BodyPosition")
            bodyPosition.Position = seat.Position
            bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyPosition.Parent = hrp
        end
    else
        print("Selecione um alvo primeiro!")
    end
end)

createButton(trollContent, "❄️ Congelar alvo", function()
    if getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local hrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = true
        end
    end
end)

createButton(trollContent, "🔥 Descongelar alvo", function()
    if getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local hrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
        end
    end
end)

createButton(trollContent, "🎯 Selecionar alvo (clique em um player)", function()
    -- Abre um menu simples de seleção
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 300, 0, 400)
    menu.Position = UDim2.new(0.5, -150, 0.5, -200)
    menu.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    menu.Parent = ScreenGui
    createCorner(menu, 8)
    createStroke(menu, 1, Color3.fromRGB(60, 60, 80))

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 40)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "Selecione um jogador"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = menu

    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(1, -10, 1, -80)
    list.Position = UDim2.new(0, 5, 0, 45)
    list.BackgroundTransparency = 1
    list.ScrollBarThickness = 4
    list.Parent = menu

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = list

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 40)
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
            btn.Text = player.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 16
            btn.Parent = list
            createCorner(btn, 6)

            btn.MouseButton1Click:Connect(function()
                getgenv().TrollTarget = player
                menu:Destroy()
                print("Alvo selecionado:", player.Name)
            end)
        end
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

-- ========== ABA PLAYER ==========
local playerPage = pages["Player"]

local playerSection, playerContent = createSection(playerPage, "Player Options")
playerSection.Size = UDim2.new(1, 0, 0, 250)

createToggle(playerContent, "Fly", "Voar (Fly)", false)
createSlider(playerContent, "FlySpeed", "Velocidade de voo", 10, 200, 50, "")
createSlider(playerContent, "Speed", "Velocidade de andar", 16, 120, 16, "")
createSlider(playerContent, "JumpPower", "Pulo", 50, 200, 50, "")
createToggle(playerContent, "Invisible", "Invisível", false)
createToggle(playerContent, "NoClip", "NoClip (atravessar paredes)", false)

-- ========== ABA VEHICLES ==========
local vehiclesPage = pages["Vehicles"]

local vehiclesSection, vehiclesContent = createSection(vehiclesPage, "Veículos")
vehiclesSection.Size = UDim2.new(1, 0, 0, 200)

createButton(vehiclesContent, "💥 Explodir carro mais próximo", function()
    local nearestCar = nil
    local nearestDist = math.huge
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("VehicleSeat") or obj.Name:lower():find("car") or obj.Name:lower():find("vehicle") then
            local part = obj.Parent:FindFirstChild("Body") or obj.Parent:FindFirstChild("MainPart") or obj.Parent:FindFirstChildWhichIsA("BasePart")
            if part and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (part.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearestCar = obj.Parent
                end
            end
        end
    end
    if nearestCar then
        nearestCar:BreakJoints()
        local explosion = Instance.new("Explosion")
        explosion.Position = nearestCar:GetPivot().Position
        explosion.BlastRadius = 10
        explosion.DestroyJointRadiusPercent = 1
        explosion.Parent = Workspace
    end
end)

createButton(vehiclesContent, "🚗 Teleportar para carro mais próximo", function()
    local nearestCar = nil
    local nearestDist = math.huge
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("VehicleSeat") then
            local part = obj.Parent:FindFirstChild("Body") or obj.Parent:FindFirstChild("MainPart") or obj.Parent:FindFirstChildWhichIsA("BasePart")
            if part and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (part.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearestCar = part
                end
            end
        end
    end
    if nearestCar and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = nearestCar.CFrame * CFrame.new(0, 3, 0)
    end
end)

createButton(vehiclesContent, "🔧 Destruir todos os carros", function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("VehicleSeat") then
            local car = obj.Parent
            if car then
                car:BreakJoints()
            end
        end
    end
end)-- ===================================================================
-- PARTE 4/4 – CRÉDITOS E HEARTBEAT (FUNÇÕES ATIVAS)
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

-- Variáveis para controle
local flyBodyVelocity = nil
local flyBodyGyro = nil

RunService.Heartbeat:Connect(function()
    local character = Player.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not character or not humanoid or not rootPart then return end

    -- ===== FLY =====
    if getgenv().Fly then
        if not flyBodyVelocity then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            flyBodyVelocity.Parent = rootPart

            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
            flyBodyGyro.P = 1000
            flyBodyGyro.Parent = rootPart
        end

        local moveDirection = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + (rootPart.CFrame.LookVector * getgenv().FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - (rootPart.CFrame.LookVector * getgenv().FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - (rootPart.CFrame.RightVector * getgenv().FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + (rootPart.CFrame.RightVector * getgenv().FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, getgenv().FlySpeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDirection = moveDirection - Vector3.new(0, getgenv().FlySpeed, 0)
        end

        flyBodyVelocity.Velocity = moveDirection
        flyBodyGyro.CFrame = rootPart.CFrame
    else
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
        if flyBodyGyro then
            flyBodyGyro:Destroy()
            flyBodyGyro = nil
        end
    end

    -- ===== SPEED / JUMP =====
    humanoid.WalkSpeed = getgenv().Speed
    humanoid.JumpPower = getgenv().JumpPower

    -- ===== INVISIBLE =====
    if getgenv().Invisible then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    else
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end

    -- ===== NOCLIP =====
    if getgenv().NoClip then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end

    -- ===== SIT OTHERS (ativo contínuo) =====
    if getgenv().SitOthers and getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local targetHrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if targetHrp then
            -- Força a sentar criando um seat invisível embaixo
            if not targetHrp:FindFirstChild("SitBodyPosition") then
                local seat = Instance.new("Part")
                seat.Size = Vector3.new(4, 1, 4)
                seat.Anchored = true
                seat.CanCollide = false
                seat.Transparency = 1
                seat.CFrame = targetHrp.CFrame * CFrame.new(0, -2, 0)
                seat.Parent = Workspace
                
                local bodyPosition = Instance.new("BodyPosition")
                bodyPosition.Position = seat.Position
                bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyPosition.Parent = targetHrp
                
                -- Marca para não criar múltiplos
                local tag = Instance.new("BoolValue")
                tag.Name = "SitBodyPosition"
                tag.Parent = targetHrp
                
                -- Remove após 1 segundo para não prender para sempre
                task.delay(1, function()
                    if bodyPosition then bodyPosition:Destroy() end
                    if seat then seat:Destroy() end
                    if tag then tag:Destroy() end
                end)
            end
        end
    end

    -- ===== FREEZE OTHERS =====
    if getgenv().FreezeOthers and getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local targetHrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if targetHrp then
            targetHrp.Anchored = true
        end
    else
        if getgenv().TrollTarget and getgenv().TrollTarget.Character then
            local targetHrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
            if targetHrp then
                targetHrp.Anchored = false
            end
        end
    end

    -- ===== EXPLODE CARS (ativo contínuo) =====
    if getgenv().ExplodeCars then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("VehicleSeat") then
                local car = obj.Parent
                if car and car:FindFirstChild("Body") then
                    local dist = (car:GetPivot().Position - rootPart.Position).Magnitude
                    if dist < 20 then
                        car:BreakJoints()
                        local explosion = Instance.new("Explosion")
                        explosion.Position = car:GetPivot().Position
                        explosion.BlastRadius = 10
                        explosion.DestroyJointRadiusPercent = 1
                        explosion.Parent = Workspace
                    end
                end
            end
        end
    end
end)

print("✅ Shinka Hub - Brookhaven (Troll) carregado!")
print("👹 Funções: Fly | Speed | Invisible | Sit/Freeze outros | Explodir carros")
print("📱 Discord: https://discord.gg/SNutmtu6x")
