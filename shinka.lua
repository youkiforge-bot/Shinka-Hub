-- Teste Mínimo - Apenas um botão
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TesteHub"
gui.Parent = player:WaitForChild("PlayerGui")

local botao = Instance.new("TextButton")
botao.Size = UDim2.new(0, 100, 0, 50)
botao.Position = UDim2.new(0.5, -50, 0.5, -25)
botao.Text = "Clique aqui"
botao.BackgroundColor3 = Color3.new(0, 1, 0)
botao.Parent = gui

botao.MouseButton1Click:Connect(function()
    print("Botão funcionou!")
end)
