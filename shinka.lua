-- ============================================
-- PARTE 1/4: Speed Hub X | Version 3.7.0
-- Serviços, Variáveis Globais e Funções Auxiliares
-- ============================================

-- ========== Serviços ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- ========== Variáveis Globais (getgenv) ==========
getgenv().AutoVoid = false
getgenv().AutoBlock = false
getgenv().AntiSlow = false
getgenv().SafeModeToggle = false
getgenv().SafeModeHealth = 50
getgenv().SafeModeBackHealth = 69
getgenv().SelectedCharacter = "Bald"  -- para o dropdown

-- ========== Configurações de UI ==========
local Player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedHubX_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Se já existir, destroi para recriar
for _, v in ipairs(CoreGui:GetChildren()) do
    if v.Name == "SpeedHubX_GUI" then
        v:Destroy()
    end
end
ScreenGui.Parent = CoreGui

-- ========== Funções Auxiliares ==========
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

-- ========== Frame Principal ==========
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
mainFrame.ClipsDescendants = true
mainFrame.Parent = ScreenGui

createCorner(mainFrame, 12)
createStroke(mainFrame, 2, Color3.fromRGB(40, 40, 60))

-- Sombra suave (imagem de sombra)
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843" -- sombra arredondada
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

-- Gradient de fundo sutil
createGradient(mainFrame, Color3.fromRGB(25, 25, 35), Color3.fromRGB(15, 15, 22), 45)-- ============================================
-- PARTE 2/4: Speed Hub X | Version 3.7.0
-- Barra de Título, Abas Laterais e Estrutura de Páginas
-- ============================================

-- ========== Barra de Título ==========
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleBar.Parent = mainFrame
createCorner(titleBar, 12)
-- Só arredondar em cima
titleBar.Corner.CornerRadius = UDim.new(0, 12) -- será ajustado depois com um canvas group? melhor deixar assim.

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0.5, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Speed Hub X | Version: 3.7.0"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Botões de controle
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0.5, -15)
closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.Parent = titleBar
createCorner(closeButton, 6)
createStroke(closeButton, 1, Color3.fromRGB(80, 80, 100))

local minButton = Instance.new("TextButton")
minButton.Name = "MinButton"
minButton.Size = UDim2.new(0, 30, 0, 30)
minButton.Position = UDim2.new(1, -80, 0.5, -15)
minButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
minButton.Text = "−"
minButton.TextColor3 = Color3.fromRGB(200, 200, 220)
minButton.Font = Enum.Font.GothamBold
minButton.TextSize = 20
minButton.Parent = titleBar
createCorner(minButton, 6)
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

-- ========== Container Principal (abaixo da barra de título) ==========
local mainContentContainer = Instance.new("Frame")
mainContentContainer.Name = "MainContentContainer"
mainContentContainer.Size = UDim2.new(1, 0, 1, -35)
mainContentContainer.Position = UDim2.new(0, 0, 0, 35)
mainContentContainer.BackgroundTransparency = 1
mainContentContainer.Parent = mainFrame

-- ========== Abas Laterais (ScrollingFrame) ==========
local tabsPanel = Instance.new("ScrollingFrame")
tabsPanel.Name = "TabsPanel"
tabsPanel.Size = UDim2.new(0, 120, 1, -10)
tabsPanel.Position = UDim2.new(0, 5, 0, 5)
tabsPanel.BackgroundTransparency = 1
tabsPanel.ScrollBarThickness = 4
tabsPanel.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
tabsPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
tabsPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
tabsPanel.Parent = mainContentContainer

-- Layout automático vertical
local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 6)
tabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabsLayout.Parent = tabsPanel

-- Dados das abas: Nome, Ícone (emoji), Ordem
local tabsData = {
    {name = "Home", icon = "🏠", order = 1},
    {name = "Main", icon = "⚙️", order = 2},
    {name = "Farming", icon = "🌾", order = 3, highlightColor = Color3.fromRGB(200, 50, 50)},
    {name = "Killer", icon = "⚔️", order = 4},
    {name = "Misc", icon = "🧰", order = 5},
}

local tabButtons = {}
local selectedTab = "Farming" -- padrão

-- ========== Área de Conteúdo Principal ==========
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -135, 1, -10)
contentArea.Position = UDim2.new(0, 130, 0, 5)
contentArea.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
contentArea.Parent = mainContentContainer
createCorner(contentArea, 10)
createStroke(contentArea, 1, Color3.fromRGB(50, 50, 70))

-- Criar páginas para cada aba
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
end-- ============================================
-- PARTE 3/4: Speed Hub X | Version 3.7.0
-- Construção das Abas e Conteúdo da Aba Farming
-- ============================================

-- ========== Construir Abas ==========
local function createTabButton(tab)
    local btn = Instance.new("TextButton")
    btn.Name = tab.name .. "Tab"
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = (tab.name == selectedTab) and (tab.highlightColor or Color3.fromRGB(60, 60, 100)) or Color3.fromRGB(35, 35, 50)
    btn.Text = tab.icon .. "   " .. tab.name
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = tabsPanel
    createCorner(btn, 8)
    createStroke(btn, 1, Color3.fromRGB(70, 70, 100))

    -- Efeito hover (menos intenso que selecionado)
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
        -- Atualizar visual da aba anterior
        if tabButtons[selectedTab] then
            tweenObject(tabButtons[selectedTab], {BackgroundColor3 = Color3.fromRGB(35, 35, 50)}, 0.2)
        end
        -- Nova aba
        selectedTab = tab.name
        tweenObject(btn, {BackgroundColor3 = tab.highlightColor or Color3.fromRGB(60, 60, 100)}, 0.2)
        -- Mostrar página correspondente
        for name, page in pairs(pages) do
            page.Visible = (name == selectedTab)
        end
    end)

    tabButtons[tab.name] = btn
end

for _, tab in ipairs(tabsData) do
    createTabButton(tab)
end

-- Ajustar canvas do ScrollingFrame após criar todos
tabsPanel.CanvasSize = UDim2.new(0, 0, 0, tabsLayout.AbsoluteContentSize.Y + 10)

-- ========== Conteúdo da aba FARMING ==========
local farmingPage = pages["Farming"]

-- Função para criar toggle (switch)
local function createToggle(parent, name, label, default, callback)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, -10, 0, 35)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local labelObj = Instance.new("TextLabel")
    labelObj.Name = "Label"
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
    toggleBg.Size = UDim2.new(0, 45, 0, 22)
    toggleBg.Position = UDim2.new(1, -50, 0.5, -11)
    toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBg.Parent = container
    createCorner(toggleBg, 12)

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "ToggleCircle"
    toggleCircle.Size = UDim2.new(0, 18, 0, 18)
    toggleCircle.Position = UDim2.new(0, 2, 0.5, -9)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.Parent = toggleBg
    createCorner(toggleCircle, 9)

    local state = default or false
    getgenv()[name] = state

    local function updateVisual()
        if state then
            tweenObject(toggleCircle, {Position = UDim2.new(1, -20, 0.5, -9)}, 0.15)
            tweenObject(toggleBg, {BackgroundColor3 = Color3.fromRGB(0, 150, 200)}, 0.15)
        else
            tweenObject(toggleCircle, {Position = UDim2.new(0, 2, 0.5, -9)}, 0.15)
            tweenObject(toggleBg, {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}, 0.15)
        end
    end
    updateVisual()

    toggleBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            getgenv()[name] = state
            updateVisual()
            if callback then callback(state) end
        end
    end)

    return container
end

-- Função para criar slider
local function createSlider(parent, name, label, min, max, default, color)
    local container = Instance.new("Frame")
    container.Name = name .. "SliderContainer"
    container.Size = UDim2.new(1, -10, 0, 45)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local labelObj = Instance.new("TextLabel")
    labelObj.Size = UDim2.new(0.5, 0, 0.4, 0)
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
    valueLabel.Size = UDim2.new(0.5, 0, 0.4, 0)
    valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 13
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = container

    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "SliderBg"
    sliderBg.Size = UDim2.new(1, 0, 0, 6)
    sliderBg.Position = UDim2.new(0, 0, 0, 22)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBg.Parent = container
    createCorner(sliderBg, 3)

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = color or Color3.fromRGB(200, 50, 50)
    fill.Parent = sliderBg
    createCorner(fill, 3)

    local thumb = Instance.new("Frame")
    thumb.Name = "Thumb"
    thumb.Size = UDim2.new(0, 12, 0, 12)
    thumb.Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.Parent = sliderBg
    createCorner(thumb, 6)
    createStroke(thumb, 1, Color3.fromRGB(150, 150, 150))

    local dragging = false
    local value = default
    getgenv()[name] = value

    local function updateSlider(input)
        local pos = input.Position.X - sliderBg.AbsolutePosition.X
        local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
        value = min + (max - min) * percent
        value = math.floor(value + 0.5) -- inteiro
        fill.Size = UDim2.new(percent, 0, 1, 0)
        thumb.Position = UDim2.new(percent, -6, 0.5, -6)
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
    end-- ============================================
-- PARTE 4/4: Speed Hub X | Version 3.7.0
-- Seções, Dropdown, Minimizar, Arrastar e Heartbeat
-- ============================================

-- Função para criar seção com título
local function createSection(parent, title)
    local section = Instance.new("Frame")
    section.Name = title .. "Section"
    section.Size = UDim2.new(1, 0, 0, 0) -- altura ajustada depois
    section.BackgroundTransparency = 1
    section.Parent = parent

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -10, 0, 25)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = section

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -10, 0, 2)
    line.Position = UDim2.new(0, 5, 0, 25)
    line.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    line.Parent = section
    createCorner(line, 1)

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -10, 1, -35)
    content.Position = UDim2.new(0, 5, 0, 30)
    content.BackgroundTransparency = 1
    content.Parent = section

    return section, content
end

-- Layout automático vertical dentro da página
local pageLayout = Instance.new("UIListLayout")
pageLayout.Padding = UDim.new(0, 15)
pageLayout.FillDirection = Enum.FillDirection.Vertical
pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
pageLayout.Parent = farmingPage

-- Seção Player
local playerSection, playerContent = createSection(farmingPage, "Player")
playerSection.Size = UDim2.new(1, 0, 0, 130) -- altura aproximada
createToggle(playerContent, "AutoVoid", "Auto Void", false)
createToggle(playerContent, "AutoBlock", "Auto Block", false)
createToggle(playerContent, "AntiSlow", "Anti-Slow", false)

-- Seção Character
local charSection, charContent = createSection(farmingPage, "Character")
charSection.Size = UDim2.new(1, 0, 0, 90)

-- Dropdown personalizado
local dropdownContainer = Instance.new("Frame")
dropdownContainer.Size = UDim2.new(1, 0, 0, 35)
dropdownContainer.BackgroundTransparency = 1
dropdownContainer.Parent = charContent

local dropdownLabel = Instance.new("TextLabel")
dropdownLabel.Size = UDim2.new(0.5, 0, 1, 0)
dropdownLabel.BackgroundTransparency = 1
dropdownLabel.Text = "Choose Equip Character"
dropdownLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
dropdownLabel.Font = Enum.Font.Gotham
dropdownLabel.TextSize = 13
dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
dropdownLabel.Parent = dropdownContainer

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(0.4, -5, 0, 30)
dropdownBtn.Position = UDim2.new(0.6, 0, 0.5, -15)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
dropdownBtn.Text = "Bald  ˅"
dropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdownBtn.Font = Enum.Font.GothamSemibold
dropdownBtn.TextSize = 13
dropdownBtn.Parent = dropdownContainer
createCorner(dropdownBtn, 6)
createStroke(dropdownBtn, 1, Color3.fromRGB(70, 70, 100))

-- Simular dropdown ao clicar (abre uma lista simples)
local dropdownList = Instance.new("Frame")
dropdownList.Name = "DropdownList"
dropdownList.Size = UDim2.new(0.4, 0, 0, 0)
dropdownList.Position = UDim2.new(0.6, 0, 0, 40)
dropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
dropdownList.Visible = false
dropdownList.Parent = dropdownContainer
createCorner(dropdownList, 6)
createStroke(dropdownList, 1, Color3.fromRGB(60, 60, 80))

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = dropdownList

local characters = {"Bald", "Hair", "Mask", "Cyborg"}
for _, char in ipairs(characters) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundTransparency = 1
    btn.Text = char
    btn.TextColor3 = Color3.fromRGB(220, 220, 240)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.Parent = dropdownList

    btn.MouseButton1Click:Connect(function()
        getgenv().SelectedCharacter = char
        dropdownBtn.Text = char .. "  ˅"
        dropdownList.Visible = false
    end)
end
dropdownList.Size = UDim2.new(0.4, 0, 0, #characters * 30 + 4)

dropdownBtn.MouseButton1Click:Connect(function()
    dropdownList.Visible = not dropdownList.Visible
end)

-- Botão Equip Character
local equipBtn = Instance.new("TextButton")
equipBtn.Size = UDim2.new(0.5, -5, 0, 30)
equipBtn.Position = UDim2.new(0.5, 5, 0, 40)
equipBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
equipBtn.Text = "Equip Character"
equipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
equipBtn.Font = Enum.Font.GothamBold
equipBtn.TextSize = 13
equipBtn.Parent = charContent
createCorner(equipBtn, 6)
createStroke(equipBtn, 1, Color3.fromRGB(100, 100, 150))

equipBtn.MouseButton1Click:Connect(function()
    print("Equipando personagem:", getgenv().SelectedCharacter)
    -- Aqui você coloca a lógica de equipar
end)

-- Seção Safe Mode
local safeSection, safeContent = createSection(farmingPage, "Safe Mode")
safeSection.Size = UDim2.new(1, 0, 0, 150)

createToggle(safeContent, "SafeModeToggle", "Auto To Safe Mode At Health", false)
createSlider(safeContent, "SafeModeHealth", "Health", 1, 100, 50, Color3.fromRGB(200, 50, 50))
createSlider(safeContent, "SafeModeBackHealth", "Until Health To Back", 1, 100, 69, Color3.fromRGB(200, 50, 50))

-- ========== Conteúdos das outras abas (placeholders) ==========
for name, page in pairs(pages) do
    if name ~= "Farming" then
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 50)
        lbl.Position = UDim2.new(0, 10, 0, 10)
        lbl.BackgroundTransparency = 1
        lbl.Text = "Conteúdo da aba " .. name .. "\n(Placeholder)"
        lbl.TextColor3 = Color3.fromRGB(150, 150, 200)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 18
        lbl.TextWrapped = true
        lbl.Parent = page
    end
end

-- ========== Funcionalidade de Minimizar ==========
local isMinimized = false
local originalSize = mainFrame.Size
local originalContentTransparency = mainContentContainer.BackgroundTransparency

minButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        -- Minimizar: esconder conteúdo e ajustar tamanho
        tweenObject(mainContentContainer, {BackgroundTransparency = 1}, 0.2)
        for _, child in ipairs(mainContentContainer:GetChildren()) do
            if child:IsA("Frame") or child:IsA("ScrollingFrame") then
                tweenObject(child, {BackgroundTransparency = 1}, 0.2)
            end
        end
        tweenObject(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 35)}, 0.3)
    else
        -- Maximizar: restaurar tamanho e mostrar conteúdo
        tweenObject(mainContentContainer, {BackgroundTransparency = 0}, 0.2)
        for _, child in ipairs(mainContentContainer:GetChildren()) do
            if child:IsA("Frame") or child:IsA("ScrollingFrame") then
                tweenObject(child, {BackgroundTransparency = 0}, 0.2)
            end
        end
        tweenObject(mainFrame, {Size = UDim2.new(0, 600, 0, 400)}, 0.3)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ========== Arrastar a GUI ==========
local dragging = false
local dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ========== Heartbeat Loop (Anti-wait) ==========
RunService.Heartbeat:Connect(function()
    -- Aqui você coloca a lógica dos toggles ativos
    if getgenv().AutoVoid then
        -- Exemplo: if player está no void então faz algo
        -- print("Auto Void ativo")
    end
    if getgenv().AutoBlock then
        -- Lógica do Auto Block
    end
    if getgenv().AntiSlow then
        -- Lógica do Anti-Slow
    end
    if getgenv().SafeModeToggle then
        -- Lógica do Safe Mode com base nos sliders
        local health = Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health or 0
        if health <= getgenv().SafeModeHealth then
            -- Ativar modo seguro
        elseif health >= getgenv().SafeModeBackHealth then
            -- Desativar modo seguro
        end
    end
end)

-- Aviso final
print("Speed Hub X v3.7.0 carregado com sucesso!")
