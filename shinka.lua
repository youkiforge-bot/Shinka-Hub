-- Shinka Hub - Teste Rápido
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Active = true
frame.Draggable = true

local botao = Instance.new("TextButton", frame)
botao.Size = UDim2.new(0.8, 0, 0, 40)
botao.Position = UDim2.new(0.1, 0, 0.7, 0)
botao.Text = "Clique Aqui"
botao.BackgroundColor3 = Color3.new(0, 0.7, 0)
botao.MouseButton1Click:Connect(function()
    print("Botão funcionou!")
end)

local texto = Instance.new("TextLabel", frame)
texto.Size = UDim2.new(1, 0, 0, 30)
texto.Text = "Shinka Hub"
texto.TextColor3 = Color3.new(1, 1, 1)
texto.BackgroundTransparency = 1

print("Teste carregado")
