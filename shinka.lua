-- Shinka Hub Base (Funcional no Celular)
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Janela principal
local janela = Instance.new("Frame")
janela.Size = UDim2.new(0, 300, 0, 400)
janela.Position = UDim2.new(0.5, -150, 0.5, -200)
janela.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
janela.Active = true
janela.Draggable = true
janela.Parent = gui
Instance.new("UICorner", janela).CornerRadius = UDim.new(0, 8)

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 30)
titulo.Text = "Shinka Hub"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
titulo.Parent = janela
Instance.new("UICorner", titulo).CornerRadius = UDim.new(0, 8)

-- Abas (botões)
local abas = {"Movement", "Visuals", "ESP", "Aimbot"}
local botoes = {}
for i, nome in ipairs(abas) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 70, 0, 30)
    btn.Position = UDim2.new(0, 5 + (i-1)*75, 0, 35)
    btn.Text = nome
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = janela
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    botoes[i] = btn
end

-- Área de conteúdo
local area = Instance.new("Frame")
area.Size = UDim2.new(1, -10, 0, 320)
area.Position = UDim2.new(0, 5, 0, 70)
area.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
area.Parent = janela
Instance.new("UICorner", area).CornerRadius = UDim.new(0, 6)

-- Conteúdo da aba Movement (apenas um exemplo)
local texto = Instance.new("TextLabel")
texto.Size = UDim2.new(1, -10, 1, -10)
texto.Position = UDim2.new(0, 5, 0, 5)
texto.BackgroundTransparency = 1
texto.Text = "Movement ativo"
texto.TextColor3 = Color3.new(1,1,1)
texto.Parent = area

print("Shinka Hub Base carregado")
