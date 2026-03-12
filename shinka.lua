-- Shinka Hub - Versão Mínima Garantida
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHub"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local texto = Instance.new("TextLabel")
texto.Size = UDim2.new(1, 0, 1, 0)
texto.Text = "Shinka Hub Funcionou! 🎉"
texto.TextColor3 = Color3.new(1, 1, 1)
texto.TextScaled = true
texto.Parent = frame

print("Shinka Hub Mínimo carregado")
