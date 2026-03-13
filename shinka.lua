-- ShinkaHub - Script Universal para Celular
-- Criado por: ShinkaHub
-- Versão: 1.0

-- Carrega a biblioteca de Fly externa (opcional, o botão irá chamar)
-- loadstring aqui apenas se quiser carregar automático, mas deixaremos no botão

-- Criar GUI principal
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal (movível e minimizável)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 350)  -- Tamanho adequado para celular
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -175)  -- Centralizado
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 160, 255)
mainFrame.Active = true
mainFrame.Draggable = false  -- Vamos implementar arraste manual para evitar conflitos
mainFrame.Parent = gui

-- Arredondar cantos (opcional)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "ShinkaHub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Botão Minimizar (Fecha o frame principal, mas deixa um ícone para reabrir)
local minimizeBtn = Instance.new("ImageButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
minimizeBtn.AutoButtonColor = false
minimizeBtn.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"  -- Placeholder, talvez usar um ícone
-- Para melhorar, usaremos um TextLabel com "-"
local minText = Instance.new("TextLabel")
minText.Size = UDim2.new(1, 0, 1, 0)
minText.BackgroundTransparency = 1
minText.Text = "-"
minText.TextColor3 = Color3.new(1,1,1)
minText.TextScaled = true
minText.Font = Enum.Font.GothamBold
minText.Parent = minimizeBtn
minimizeBtn.Parent = mainFrame

-- Botão Arrastar (usaremos o título como área de arrasto)
local dragArea = title  -- Pode usar o título para arrastar

-- Variáveis para arraste
local dragging = false
local dragInput
local dragStart
local startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

dragArea.InputBegan:Connect(function(input)
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

dragArea.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch and dragging then
		updateDrag(input)
	end
end)

-- Botão para minimizar (esconde o mainFrame e mostra um ícone flutuante)
local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 60, 0, 60)
minimizedFrame.Position = UDim2.new(0, 20, 0, 100)  -- Posição inicial
minimizedFrame.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
minimizedFrame.BorderSizePixel = 2
minimizedFrame.BorderColor3 = Color3.fromRGB(255,255,255)
minimizedFrame.Visible = false
minimizedFrame.Parent = gui
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 30)
minCorner.Parent = minimizedFrame

local minIcon = Instance.new("TextLabel")
minIcon.Size = UDim2.new(1, 0, 1, 0)
minIcon.BackgroundTransparency = 1
minIcon.Text = "S"
minIcon.TextColor3 = Color3.new(1,1,1)
minIcon.TextScaled = true
minIcon.Font = Enum.Font.GothamBold
minIcon.Parent = minimizedFrame

-- Tornar minimizedFrame arrastável
local dragMin = minimizedFrame
local draggingMin = false
local dragMinStart
local startMinPos

dragMin.InputBegan:Connect(function(input)
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

dragMin.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch and draggingMin then
		local delta = input.Position - dragMinStart
		minimizedFrame.Position = UDim2.new(startMinPos.X.Scale, startMinPos.X.Offset + delta.X, startMinPos.Y.Scale, startMinPos.Y.Offset + delta.Y)
	end
end)

-- Alternar visibilidade
minimizeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	minimizedFrame.Visible = true
end)

minimizedFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		-- Se tocar no ícone minimizado, restaura
		minimizedFrame.Visible = false
		mainFrame.Visible = true
	end
end)

-- Agora adicionar funcionalidades dentro do mainFrame
-- Criar um ScrollingFrame para conter os botões (evitar overflow)
local container = Instance.new("ScrollingFrame")
container.Name = "Container"
container.Size = UDim2.new(1, -20, 1, -70)
container.Position = UDim2.new(0, 10, 0, 40)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 4
container.CanvasSize = UDim2.new(0,0,0,0)  -- Ajustar depois
container.AutomaticCanvasSize = Enum.AutomaticSize.Y
container.Parent = mainFrame

-- Layout automático
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = container

-- Função para criar um botão padrão
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
	btn.AutoButtonColor = false
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn
	btn.Parent = container
	
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Função para criar uma caixa de entrada com botão
local function createInputBox(placeholder, buttonText, color, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -10, 0, 80)
	frame.BackgroundTransparency = 1
	frame.Parent = container
	
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, 0, 0, 40)
	box.Position = UDim2.new(0, 0, 0, 0)
	box.BackgroundColor3 = Color3.fromRGB(60,60,70)
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
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.Position = UDim2.new(0, 0, 1, -35)
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

-- Criar botões de funcionalidades

-- 1. Speed (Velocidade)
createInputBox("Digite a velocidade (ex: 50)", "Aplicar Speed", Color3.fromRGB(0, 120, 255), function(value)
	local speed = tonumber(value)
	if speed and speed > 0 then
		player.Character.Humanoid.WalkSpeed = speed
	else
		-- Notificação simples (criar um popup ou aviso)
	end
end)

-- 2. Fly (carrega script externo)
createButton("Fly (Ativar)", Color3.fromRGB(255, 120, 0), function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- 3. NoClip (atravessar paredes)
local noclipActive = false
createButton("NoClip", Color3.fromRGB(200, 0, 200), function()
	noclipActive = not noclipActive
	if noclipActive then
		game:GetService("RunService").Stepped:Connect(function()
			if noclipActive and player.Character then
				for _, part in pairs(player.Character:GetChildren()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	end
end)

-- 4. Infinito Jump
local infJumpActive = false
createButton("Infinito Jump", Color3.fromRGB(0, 200, 100), function()
	infJumpActive = not infJumpActive
	if infJumpActive then
		local uis = game:GetService("UserInputService")
		uis.JumpRequest:Connect(function()
			if infJumpActive and player.Character then
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
	end
end)

-- 5. Teleport (para um jogador ou posição) - Simples: teleportar para mouse
createButton("Teleport para Mouse", Color3.fromRGB(255, 50, 50), function()
	local mouse = player:GetMouse()
	local targetPos = mouse.Hit.p
	if player.Character then
		local root = player.Character:FindFirstChild("HumanoidRootPart")
		if root then
			root.CFrame = CFrame.new(targetPos)
		end
	end
end)

-- 6. Botão Copiar (copia um texto para a área de transferência)
createButton("Copiar (ShinkaHub)", Color3.fromRGB(100, 100, 255), function()
	local textToCopy = "ShinkaHub - https://discord.gg/shinkahub"  -- Exemplo
	setclipboard(textToCopy)
	-- Notificação simples
	local notify = Instance.new("TextLabel")
	notify.Size = UDim2.new(0, 200, 0, 50)
	notify.Position = UDim2.new(0.5, -100, 0.5, -25)
	notify.BackgroundColor3 = Color3.fromRGB(0,200,0)
	notify.Text = "Copiado!"
	notify.TextColor3 = Color3.new(1,1,1)
	notify.TextScaled = true
	notify.Font = Enum.Font.GothamBold
	notify.ZIndex = 10
	notify.Parent = gui
	local notifyCorner = Instance.new("UICorner")
	notifyCorner.CornerRadius = UDim.new(0, 10)
	notifyCorner.Parent = notify
	game:GetService("TweenService"):Create(notify, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
	wait(1)
	notify:Destroy()
end)

-- Ajustar canvas size automaticamente
local function updateCanvas()
	container.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 10)
end
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
updateCanvas()

-- Opcional: botão para fechar completamente (Destroy GUI) - cuidado, talvez não necessário
-- Mas podemos adicionar um botão de "X" no canto superior direito
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -65, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 2
closeBtn.BorderColor3 = Color3.fromRGB(0,0,0)
closeBtn.Parent = mainFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Ajustes finais: garantir que minimizedFrame fique acima de outros elementos
minimizedFrame.ZIndex = 10

print("ShinkaHub carregado com sucesso!")
