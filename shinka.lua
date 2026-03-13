-- ShinkaHub v2.0 - Estilo AUREUS
-- Criado por: Shinka & Gemini (créditos no rodapé)
-- Versão para celular com funções organizadas e ESP

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Frame principal (estilo AUREUS)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 400)  -- Tamanho para mobile
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)  -- Fundo escuro
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)  -- Dourado
mainFrame.Active = true
mainFrame.Draggable = false  -- Arraste manual
mainFrame.Parent = gui

-- Cantos arredondados
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Barra superior (título e botões)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame
local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topBar
-- Apenas cantos superiores arredondados (para não sobrepor o frame)
-- Mas vamos manter assim.

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ShinkaHub v2"
title.TextColor3 = Color3.fromRGB(255, 215, 0)  -- Dourado
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Botão Minimizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(20, 20, 30)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn
minimizeBtn.Parent = topBar

-- Botão Fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn
closeBtn.Parent = topBar

-- Área de arraste (usando a topBar)
local dragging = false
local dragInput, dragStart, startPos

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Frame minimizado (ícone)
local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 60, 0, 60)
minimizedFrame.Position = UDim2.new(0, 20, 0, 100)
minimizedFrame.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
minimizedFrame.BorderSizePixel = 2
minimizedFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
minimizedFrame.Visible = false
minimizedFrame.Parent = gui
local minFrameCorner = Instance.new("UICorner")
minFrameCorner.CornerRadius = UDim.new(0, 30)
minFrameCorner.Parent = minimizedFrame

local minIcon = Instance.new("TextLabel")
minIcon.Size = UDim2.new(1, 0, 1, 0)
minIcon.BackgroundTransparency = 1
minIcon.Text = "S"
minIcon.TextColor3 = Color3.fromRGB(20, 20, 30)
minIcon.TextScaled = true
minIcon.Font = Enum.Font.GothamBold
minIcon.Parent = minimizedFrame

-- Tornar minimizedFrame arrastável
local draggingMin = false
local dragMinStart, startMinPos

minimizedFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		draggingMin = true
		dragMinStart = input.Position
		startMinPos = minimizedFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingMin = false
			end
		end)
	end
end)

minimizedFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch and draggingMin then
		local delta = input.Position - dragMinStart
		minimizedFrame.Position = UDim2.new(startMinPos.X.Scale, startMinPos.X.Offset + delta.X, startMinPos.Y.Scale, startMinPos.Y.Offset + delta.Y)
	end
end)

-- Função de minimizar/restaurar
minimizeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	minimizedFrame.Visible = true
end)

minimizedFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		-- Ao tocar no ícone, restaura
		minimizedFrame.Visible = false
		mainFrame.Visible = true
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Container para as funções (ScrollingFrame)
local container = Instance.new("ScrollingFrame")
container.Name = "Container"
container.Size = UDim2.new(1, -20, 1, -80)  -- Deixar espaço para a barra superior e rodapé
container.Position = UDim2.new(0, 10, 0, 50)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 4
container.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
container.AutomaticCanvasSize = Enum.AutomaticSize.Y
container.Parent = mainFrame

-- Layout automático
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = container

-- Ajustar canvas size
local function updateCanvas()
	container.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 10)
end
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

-- Função para criar botões
local function createButton(text, color, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 50)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamSemibold
	btn.BorderSizePixel = 2
	btn.BorderColor3 = Color3.fromRGB(0,0,0)
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn
	btn.Parent = container

	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Função para criar campo de entrada com botão
local function createInputBox(placeholder, buttonText, color, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 90)
	frame.BackgroundTransparency = 1
	frame.Parent = container

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, 0, 0, 40)
	box.Position = UDim2.new(0, 0, 0, 0)
	box.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	box.TextColor3 = Color3.new(1,1,1)
	box.PlaceholderText = placeholder
	box.PlaceholderColor3 = Color3.fromRGB(180,180,180)
	box.TextScaled = true
	box.Font = Enum.Font.Gotham
	box.ClearTextOnFocus = false
	box.BorderSizePixel = 2
	box.BorderColor3 = Color3.fromRGB(0,0,0)
	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 6)
	boxCorner.Parent = box
	box.Parent = frame

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.Position = UDim2.new(0, 0, 1, -40)
	btn.BackgroundColor3 = color
	btn.Text = buttonText
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamSemibold
	btn.BorderSizePixel = 2
	btn.BorderColor3 = Color3.fromRGB(0,0,0)
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn
	btn.Parent = frame

	btn.MouseButton1Click:Connect(function()
		callback(box.Text)
	end)

	return frame, box, btn
end

-- Rodapé com créditos
local footer = Instance.new("TextLabel")
footer.Name = "Credits"
footer.Size = UDim2.new(1, -20, 0, 30)
footer.Position = UDim2.new(0, 10, 1, -35)
footer.BackgroundTransparency = 0.5
footer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
footer.Text = "Shinka & Gemini"
footer.TextColor3 = Color3.fromRGB(255, 215, 0)
footer.TextScaled = true
footer.Font = Enum.Font.Gotham
footer.BorderSizePixel = 0
local footerCorner = Instance.new("UICorner")
footerCorner.CornerRadius = UDim.new(0, 6)
footerCorner.Parent = footer
footer.Parent = mainFrame

-- Início das funções

-- 1. Speed
createInputBox("Digite a velocidade (ex: 50)", "Aplicar Speed", Color3.fromRGB(0, 120, 255), function(value)
	local speed = tonumber(value)
	if speed and speed > 0 and LocalPlayer.Character then
		local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = speed
		end
	else
		-- Notificação simples (opcional)
	end
end)

-- 2. Fly (carrega script externo)
createButton("Fly (Ativar)", Color3.fromRGB(255, 120, 0), function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- 3. NoClip
local noclipActive = false
local noclipConnection
createButton("NoClip", Color3.fromRGB(200, 0, 200), function()
	noclipActive = not noclipActive
	if noclipActive then
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

-- 4. Infinito Jump
local infJumpActive = false
local jumpConnection
createButton("Infinito Jump", Color3.fromRGB(0, 200, 100), function()
	infJumpActive = not infJumpActive
	if infJumpActive then
		jumpConnection = UserInputService.JumpRequest:Connect(function()
			if LocalPlayer.Character then
				local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
	else
		if jumpConnection then
			jumpConnection:Disconnect()
			jumpConnection = nil
		end
	end
end)

-- 5. Teleport para Mouse
createButton("Teleport para Mouse", Color3.fromRGB(255, 50, 50), function()
	local target = Mouse.Hit
	if target and LocalPlayer.Character then
		local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if root then
			root.CFrame = target
		end
	end
end)

-- 6. Copiar link do Discord
createButton("Copiar Discord", Color3.fromRGB(100, 100, 255), function()
	local discordLink = "https://discord.gg/SNutmtu6x"
	setclipboard(discordLink)
	-- Notificação
	local notify = Instance.new("TextLabel")
	notify.Size = UDim2.new(0, 200, 0, 50)
	notify.Position = UDim2.new(0.5, -100, 0.5, -25)
	notify.BackgroundColor3 = Color3.fromRGB(0,200,0)
	notify.Text = "Link copiado!"
	notify.TextColor3 = Color3.new(1,1,1)
	notify.TextScaled = true
	notify.Font = Enum.Font.GothamBold
	notify.ZIndex = 10
	notify.Parent = gui
	local notifyCorner = Instance.new("UICorner")
	notifyCorner.CornerRadius = UDim.new(0, 10)
	notifyCorner.Parent = notify
	TweenService:Create(notify, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
	wait(1)
	notify:Destroy()
end)

-- 7. ESP (destacar jogadores)
local espActive = false
local espConnections = {}
local function createESP(player)
	if player == LocalPlayer then return end
	local function addESP(character)
		local highlight = Instance.new("Highlight")
		highlight.Name = "ShinkaESP"
		highlight.FillColor = Color3.fromRGB(255, 0, 0)
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0.5
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = character
	end

	if player.Character then
		addESP(player.Character)
	end
	player.CharacterAdded:Connect(addESP)
end

local function removeESP(player)
	if player.Character then
		local highlight = player.Character:FindFirstChildOfClass("Highlight")
		if highlight and highlight.Name == "ShinkaESP" then
			highlight:Destroy()
		end
	end
end

createButton("ESP (Jogadores)", Color3.fromRGB(255, 255, 0), function()
	espActive = not espActive
	if espActive then
		for _, player in pairs(Players:GetPlayers()) do
			createESP(player)
		end
		-- Conectar para novos jogadores
		espConnections.PlayerAdded = Players.PlayerAdded:Connect(createESP)
		espConnections.PlayerRemoving = Players.PlayerRemoving:Connect(removeESP)
	else
		-- Remover ESP de todos
		for _, player in pairs(Players:GetPlayers()) do
			removeESP(player)
		end
		if espConnections.PlayerAdded then
			espConnections.PlayerAdded:Disconnect()
		end
		if espConnections.PlayerRemoving then
			espConnections.PlayerRemoving:Disconnect()
		end
	end
end)

-- Atualizar canvas após adicionar todos os botões
updateCanvas()

print("ShinkaHub v2 carregado com sucesso!")
