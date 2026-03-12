-- =============================================
-- MEU SCRIPT - VERSÃO COM VELOCIDADE
-- =============================================
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local gui = Instance.new("ScreenGui")
gui.Name = "MeuScript"
gui.Parent = player:WaitForChild("PlayerGui")

-- Janela principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 30)
titulo.Text = "Meu Script - Velocidade"
titulo.TextColor3 = Color3.new(1, 1, 1)
titulo.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
titulo.Parent = frame
Instance.new("UICorner", titulo).CornerRadius = UDim.new(0, 8)

-- Área de conteúdo
local area = Instance.new("Frame")
area.Size = UDim2.new(1, -20, 1, -40)
area.Position = UDim2.new(0, 10, 0, 35)
area.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
area.Parent = frame
Instance.new("UICorner", area).CornerRadius = UDim.new(0, 6)

-- Texto da velocidade
local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(0.9, 0, 0, 30)
speedText.Position = UDim2.new(0.05, 0, 0, 10)
speedText.BackgroundTransparency = 1
speedText.Text = "Velocidade: 16"
speedText.TextColor3 = Color3.fromRGB(200, 200, 200)
speedText.Font = Enum.Font.Gotham
speedText.TextSize = 16
speedText.TextXAlignment = Enum.TextXAlignment.Left
speedText.Parent = area

-- Slider (barra)
local slider = Instance.new("Frame")
slider.Size = UDim2.new(0.9, 0, 0, 5)
slider.Position = UDim2.new(0.05, 0, 0, 50)
slider.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
slider.Parent = area
Instance.new("UICorner", slider).CornerRadius = UDim.new(1, 0)

-- Botão do slider (a "bolinha")
local sliderButton = Instance.new("TextButton")
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new(0.5, -10, 0, -7.5)
sliderButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
sliderButton.Text = ""
sliderButton.Parent = slider
Instance.new("UICorner", sliderButton).CornerRadius = UDim.new(1, 0)

-- Lógica do slider
local dragging = false
local speed = 16

sliderButton.MouseButton1Down:Connect(function()
    dragging = true
end)

userInput.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

runService.RenderStepped:Connect(function()
    if dragging then
        -- Calcula a posição do mouse relativa ao slider
        local mouseX = userInput:GetMouseLocation().X
        local sliderX = slider.AbsolutePosition.X
        local sliderW = slider.AbsoluteSize.X
        local relativeX = math.clamp(mouseX - sliderX, 0, sliderW)
        local percent = relativeX / sliderW
        
        -- Atualiza a posição do botão
        sliderButton.Position = UDim2.new(percent, -10, 0, -7.5)
        
        -- Calcula a velocidade (16 a 116)
        speed = 16 + math.floor(percent * 100)
        speedText.Text = "Velocidade: " .. speed
        
        -- Aplica a velocidade no personagem se ele existir
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

print("✅ Script com velocidade carregado! Ajuste o slider.")
