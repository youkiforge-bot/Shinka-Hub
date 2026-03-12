-- Teste básico - botão
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
local botao = Instance.new("TextButton", gui)
botao.Size = UDim2.new(0, 200, 0, 100)
botao.Position = UDim2.new(0.5, -100, 0.5, -50)
botao.Text = "Clique aqui"
botao.BackgroundColor3 = Color3.new(0,1,0)
botao.MouseButton1Click:Connect(function()
    print("Botão clicado!")
end)
print("Teste carregado")
