-- ===================================================================
-- SHINKA HUB - BROOKHAVEN TROLL (PARTE 1/4)
-- ESTRUTURA PRINCIPAL E GUI
-- ===================================================================

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

for _, v in ipairs(CoreGui:GetChildren()) do
    if v.Name == "ShinkaHub_Brookhaven" then
        v:Destroy()
    end
end
ScreenGui.Parent = CoreGui

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Color = color or Color3.fromRGB(60, 60, 80)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function tweenObject(obj, props, time)
    local tween = TweenService:Create(obj, TweenInfo.new(time or 0.2), props)
    tween:Play()
    return tween
end

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
mainFrame.ClipsDescendants = true
mainFrame.Parent = ScreenGui
createCorner(mainFrame, 12)
createStroke(mainFrame, 2, Color3.fromRGB(40, 40, 60))

-- Barra de título
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleBar.Parent = mainFrame
createCorner(titleBar, 12)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.7, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Shinka | Brookhaven Troll"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0.5, -15)
closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = titleBar
createCorner(closeButton, 6)
createStroke(closeButton, 1, Color3.fromRGB(80, 80, 100))
closeButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local minButton = Instance.new("TextButton")
minButton.Size = UDim2.new(0, 30, 0, 30)
minButton.Position = UDim2.new(1, -70, 0.5, -15)
minButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
minButton.Text = "−"
minButton.TextColor3 = Color3.fromRGB(200, 200, 220)
minButton.Font = Enum.Font.GothamBold
minButton.TextSize = 24
minButton.Parent = titleBar
createCorner(minButton, 6)
createStroke(minButton, 1, Color3.fromRGB(80, 80, 100))

local mainContent = Instance.new("Frame")
mainContent.Name = "MainContent"
mainContent.Size = UDim2.new(1, 0, 1, -40)
mainContent.Position = UDim2.new(0, 0, 0, 40)
mainContent.BackgroundTransparency = 1
mainContent.Parent = mainFrame

-- Sistema de minimizar
local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 200, 0, 40)
minimizedFrame.Position = mainFrame.Position
minimizedFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
minimizedFrame.Visible = false
minimizedFrame.Parent = ScreenGui
createCorner(minimizedFrame, 8)
createStroke(minimizedFrame, 2, Color3.fromRGB(40, 40, 60))

local minLabel = Instance.new("TextLabel")
minLabel.Size = UDim2.new(1, -40, 1, 0)
minLabel.Position = UDim2.new(0, 10, 0, 0)
minLabel.BackgroundTransparency = 1
minLabel.Text = "Shinka Troll"
minLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
minLabel.Font = Enum.Font.GothamBold
minLabel.TextSize = 16
minLabel.TextXAlignment = Enum.TextXAlignment.Left
minLabel.Parent = minimizedFrame

local restoreButton = Instance.new("TextButton")
restoreButton.Size = UDim2.new(0, 30, 0, 30)
restoreButton.Position = UDim2.new(1, -35, 0.5, -15)
restoreButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
restoreButton.Text = "⬆"
restoreButton.TextColor3 = Color3.fromRGB(200, 200, 220)
restoreButton.Font = Enum.Font.GothamBold
restoreButton.TextSize = 18
restoreButton.Parent = minimizedFrame
createCorner(restoreButton, 6)

local isMinimized = false
minButton.MouseButton1Click:Connect(function()
    isMinimized = true
    mainFrame.Visible = false
    minimizedFrame.Visible = true
    minimizedFrame.Position = mainFrame.Position
end)
restoreButton.MouseButton1Click:Connect(function()
    isMinimized = false
    mainFrame.Visible = true
    minimizedFrame.Visible = false
    mainFrame.Position = minimizedFrame.Position
end)

-- Arrastar GUI
local dragging, dragStart, startPos
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
-- PARTE 2/4 – FUNÇÕES DE CRIAÇÃO DE UI E ABAS
-- ===================================================================

-- Toggle
local function createToggle(parent, name, label, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, -5, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 45, 0, 22)
    bg.Position = UDim2.new(1, -50, 0.5, -11)
    bg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    bg.Parent = container
    createCorner(bg, 30)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = bg
    createCorner(circle, 9)

    local state = default or false
    getgenv()[name] = state

    local function updateVisual()
        if state then
            tweenObject(circle, {Position = UDim2.new(1, -20, 0.5, -9)})
            tweenObject(bg, {BackgroundColor3 = Color3.fromRGB(0, 150, 200)})
        else
            tweenObject(circle, {Position = UDim2.new(0, 2, 0.5, -9)})
            tweenObject(bg, {BackgroundColor3 = Color3.fromRGB(60, 60, 80)})
        end
    end
    updateVisual()

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = container
    btn.MouseButton1Click:Connect(function()
        state = not state
        getgenv()[name] = state
        updateVisual()
    end)

    return container
end

-- Slider
local function createSlider(parent, name, label, min, max, default, suffix)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 55)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 0.4, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local val = Instance.new("TextLabel")
    val.Name = "ValueLabel"
    val.Size = UDim2.new(0.4, 0, 0.4, 0)
    val.Position = UDim2.new(0.6, 0, 0, 0)
    val.BackgroundTransparency = 1
    val.Text = tostring(default) .. suffix
    val.TextColor3 = Color3.fromRGB(255, 255, 255)
    val.Font = Enum.Font.GothamBold
    val.TextSize = 13
    val.TextXAlignment = Enum.TextXAlignment.Right
    val.Parent = container

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, 0, 0, 6)
    sliderBg.Position = UDim2.new(0, 0, 0, 28)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBg.Parent = container
    createCorner(sliderBg, 3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    fill.Parent = sliderBg
    createCorner(fill, 3)

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 14, 0, 14)
    thumb.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.Parent = sliderBg
    createCorner(thumb, 7)

    local dragging = false
    local value = default
    getgenv()[name] = value

    local function update(input)
        local pos = input.Position.X - sliderBg.AbsolutePosition.X
        local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
        value = math.floor((min + (max - min) * percent) * 10 + 0.5) / 10
        fill.Size = UDim2.new(percent, 0, 1, 0)
        thumb.Position = UDim2.new(percent, -7, 0.5, -7)
        val.Text = tostring(value) .. suffix
        getgenv()[name] = value
    end

    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return container
end

-- Botão
local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = parent
    createCorner(btn, 6)
    createStroke(btn, 1, Color3.fromRGB(70, 70, 100))
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Seção
local function createSection(parent, title)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 0)
    section.BackgroundTransparency = 1
    section.Parent = parent

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -10, 0, 25)
    titleLbl.Position = UDim2.new(0, 5, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = Color3.fromRGB(100, 150, 255)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 16
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = section

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -10, 0, 1)
    line.Position = UDim2.new(0, 5, 0, 25)
    line.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
    line.Parent = section

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -10, 1, -30)
    content.Position = UDim2.new(0, 5, 0, 30)
    content.BackgroundTransparency = 1
    content.Parent = section

    return section, content
end

-- Abas
local tabs = {"Player", "Troll", "Credits"}
local tabButtons = {}
local currentTab = "Player"

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 35)
tabBar.Position = UDim2.new(0, 10, 0, 5)
tabBar.BackgroundTransparency = 1
tabBar.Parent = mainContent

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0, (i-1)*125, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = tabBar
    createCorner(btn, 6)
    createStroke(btn, 1, Color3.fromRGB(70, 70, 100))

    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(tabButtons) do
            tweenObject(b, {BackgroundColor3 = Color3.fromRGB(35, 35, 50)})
        end
        tweenObject(btn, {BackgroundColor3 = Color3.fromRGB(60, 60, 100)})
        currentTab = name
        updatePages()
    end)

    tabButtons[name] = btn
end

local pages = {}
for _, name in ipairs(tabs) do
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, -20, 1, -50)
    page.Position = UDim2.new(0, 10, 0, 45)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Parent = mainContent
    pages[name] = page
end

local function updatePages()
    for name, page in pairs(pages) do
        page.Visible = (name == currentTab)
    end
end
updatePages()-- ===================================================================
-- PARTE 3/4 – CONTEÚDO DAS ABAS PLAYER E TROLL
-- ===================================================================

-- ===== ABA PLAYER =====
local playerPage = pages["Player"]
local playerContent = Instance.new("Frame")
playerContent.Size = UDim2.new(1, -10, 1, -10)
playerContent.Position = UDim2.new(0, 5, 0, 5)
playerContent.BackgroundTransparency = 1
playerContent.Parent = playerPage

local playerLayout = Instance.new("UIListLayout")
playerLayout.Padding = UDim.new(0, 10)
playerLayout.Parent = playerContent

-- Seção Player Options
local playerSection, playerOpts = createSection(playerContent, "Player Options")
playerSection.Size = UDim2.new(1, 0, 0, 320)

createToggle(playerOpts, "Fly", "Voar (Fly)", false)
createSlider(playerOpts, "FlySpeed", "Velocidade de voo", 10, 200, 50, "")
createSlider(playerOpts, "Speed", "Velocidade de andar", 16, 120, 16, "")
createSlider(playerOpts, "JumpPower", "Pulo", 50, 200, 50, "")
createToggle(playerOpts, "Invisible", "Invisível", false)
createToggle(playerOpts, "NoClip", "NoClip (atravessar paredes)", false)

-- ===== ABA TROLL =====
local trollPage = pages["Troll"]
local trollContent = Instance.new("Frame")
trollContent.Size = UDim2.new(1, -10, 1, -10)
trollContent.Position = UDim2.new(0, 5, 0, 5)
trollContent.BackgroundTransparency = 1
trollContent.Parent = trollPage

local trollLayout = Instance.new("UIListLayout")
trollLayout.Padding = UDim.new(0, 10)
trollLayout.Parent = trollContent

local trollSection, trollOpts = createSection(trollContent, "Funções Troll")
trollSection.Size = UDim2.new(1, 0, 0, 300)

createToggle(trollOpts, "SitOthers", "Sentar outros players", false)
createToggle(trollOpts, "FreezeOthers", "Congelar outros players", false)
createToggle(trollOpts, "ExplodeCars", "Explodir carros próximos", false)

createButton(trollOpts, "🎯 Selecionar alvo (clique)", function()
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 250, 0, 300)
    menu.Position = UDim2.new(0.5, -125, 0.5, -150)
    menu.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    menu.Parent = ScreenGui
    createCorner(menu, 8)
    createStroke(menu, 1, Color3.fromRGB(60, 60, 80))

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -10, 0, 30)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "Selecione um jogador"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = menu

    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(1, -10, 1, -80)
    list.Position = UDim2.new(0, 5, 0, 35)
    list.BackgroundTransparency = 1
    list.ScrollBarThickness = 4
    list.CanvasSize = UDim2.new(0, 0, 0, 0)
    list.AutomaticCanvasSize = Enum.AutomaticSize.Y
    list.Parent = menu

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = list

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
            btn.Text = plr.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.Parent = list
            createCorner(btn, 6)

            btn.MouseButton1Click:Connect(function()
                getgenv().TrollTarget = plr
                menu:Destroy()
            end)
        end
    end

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(1, -10, 0, 30)
    close.Position = UDim2.new(0, 5, 1, -35)
    close.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    close.Text = "Fechar"
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.Font = Enum.Font.Gotham
    close.TextSize = 14
    close.Parent = menu
    createCorner(close, 6)
    close.MouseButton1Click:Connect(function() menu:Destroy() end)
end)

createButton(trollOpts, "💺 Sentar alvo", function()
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
            local bp = Instance.new("BodyPosition")
            bp.Position = seat.Position
            bp.MaxForce = Vector3.new(4000, 4000, 4000)
            bp.Parent = hrp
            task.delay(1, function() if bp then bp:Destroy() end if seat then seat:Destroy() end end)
        end
    end
end)

createButton(trollOpts, "❄️ Congelar alvo", function()
    if getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local hrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = true end
    end
end)

createButton(trollOpts, "🔥 Descongelar alvo", function()
    if getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local hrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = false end
    end
end)-- ===================================================================
-- PARTE 4/4 – CRÉDITOS E HEARTBEAT (FUNÇÕES ATIVAS)
-- ===================================================================

-- ===== ABA CREDITS =====
local creditsPage = pages["Credits"]
local creditsContent = Instance.new("Frame")
creditsContent.Size = UDim2.new(1, -10, 1, -10)
creditsContent.Position = UDim2.new(0, 5, 0, 5)
creditsContent.BackgroundTransparency = 1
creditsContent.Parent = creditsPage

local creditsLayout = Instance.new("UIListLayout")
creditsLayout.Padding = UDim.new(0, 15)
creditsLayout.Parent = creditsContent

local creditsSection, creditsOpts = createSection(creditsContent, "Créditos")
creditsSection.Size = UDim2.new(1, 0, 0, 180)

local creditLbl = Instance.new("TextLabel")
creditLbl.Size = UDim2.new(1, -10, 0, 30)
creditLbl.BackgroundTransparency = 1
creditLbl.Text = "👑 Criado por: ImShinka"
creditLbl.TextColor3 = Color3.fromRGB(255, 255, 100)
creditLbl.Font = Enum.Font.GothamBold
creditLbl.TextSize = 18
creditLbl.TextXAlignment = Enum.TextXAlignment.Left
creditLbl.Parent = creditsOpts

local deepLbl = Instance.new("TextLabel")
deepLbl.Size = UDim2.new(1, -10, 0, 25)
deepLbl.BackgroundTransparency = 1
deepLbl.Text = "🤝 Deep (Co-criador)"
deepLbl.TextColor3 = Color3.fromRGB(100, 255, 255)
deepLbl.Font = Enum.Font.Gotham
deepLbl.TextSize = 16
deepLbl.TextXAlignment = Enum.TextXAlignment.Left
deepLbl.Parent = creditsOpts

local discordLbl = Instance.new("TextLabel")
discordLbl.Size = UDim2.new(1, -10, 0, 25)
discordLbl.BackgroundTransparency = 1
discordLbl.Text = "📱 Discord:"
discordLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
discordLbl.Font = Enum.Font.Gotham
discordLbl.TextSize = 16
discordLbl.TextXAlignment = Enum.TextXAlignment.Left
discordLbl.Parent = creditsOpts

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(1, -10, 0, 40)
discordBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
discordBtn.Text = "https://discord.gg/SNutmtu6x"
discordBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
discordBtn.Font = Enum.Font.GothamSemibold
discordBtn.TextSize = 14
discordBtn.Parent = creditsOpts
createCorner(discordBtn, 6)
discordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/SNutmtu6x")
    discordBtn.Text = "Copiado!"
    task.wait(1)
    discordBtn.Text = "https://discord.gg/SNutmtu6x"
end)

-- ===== HEARTBEAT – LÓGICA ATIVA =====
local flyBV, flyBG
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hum or not hrp then return end

    -- Fly
    if getgenv().Fly then
        if not flyBV then
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(4000, 4000, 4000)
            flyBV.Parent = hrp
            flyBG = Instance.new("BodyGyro")
            flyBG.MaxTorque = Vector3.new(4000, 4000, 4000)
            flyBG.P = 1000
            flyBG.Parent = hrp
        end
        local move = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + hrp.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - hrp.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - hrp.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + hrp.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
        flyBV.Velocity = move * getgenv().FlySpeed
        flyBG.CFrame = hrp.CFrame
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
    end

    -- Speed / Jump
    hum.WalkSpeed = getgenv().Speed
    hum.JumpPower = getgenv().JumpPower

    -- Invisible
    if getgenv().Invisible then
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then part.Transparency = 1 end
        end
    else
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then part.Transparency = 0 end
        end
    end

    -- NoClip
    if getgenv().NoClip then
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    else
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end

    -- Freeze Others
    if getgenv().FreezeOthers and getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local targetHrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if targetHrp then targetHrp.Anchored = true end
    elseif getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local targetHrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if targetHrp then targetHrp.Anchored = false end
    end

    -- Sit Others (ativo contínuo)
    if getgenv().SitOthers and getgenv().TrollTarget and getgenv().TrollTarget.Character then
        local targetHrp = getgenv().TrollTarget.Character:FindFirstChild("HumanoidRootPart")
        if targetHrp and not targetHrp:FindFirstChild("SitTag") then
            local seat = Instance.new("Part")
            seat.Size = Vector3.new(4, 1, 4)
            seat.Anchored = true
            seat.CanCollide = false
            seat.Transparency = 1
            seat.CFrame = targetHrp.CFrame * CFrame.new(0, -2, 0)
            seat.Parent = Workspace
            local bp = Instance.new("BodyPosition")
            bp.Position = seat.Position
            bp.MaxForce = Vector3.new(4000, 4000, 4000)
            bp.Parent = targetHrp
            local tag = Instance.new("BoolValue")
            tag.Name = "SitTag"
            tag.Parent = targetHrp
            task.delay(0.5, function()
                if bp then bp:Destroy() end
                if seat then seat:Destroy() end
                if tag then tag:Destroy() end
            end)
        end
    end

    -- Explode Cars
    if getgenv().ExplodeCars then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("VehicleSeat") then
                local car = obj.Parent
                if car and car:FindFirstChild("Body") then
                    local dist = (car:GetPivot().Position - hrp.Position).Magnitude
                    if dist < 25 then
                        car:BreakJoints()
                        local exp = Instance.new("Explosion")
                        exp.Position = car:GetPivot().Position
                        exp.BlastRadius = 10
                        exp.Parent = Workspace
                    end
                end
            end
        end
    end
end)

print("✅ Shinka Hub - Brookhaven Troll carregado!")
print("👤 Player: Fly, Speed, Jump, Invisible, NoClip")
print("👹 Troll: Sentar, Congelar, Explodir carros")
print("📱 Discord: https://discord.gg/SNutmtu6x")
