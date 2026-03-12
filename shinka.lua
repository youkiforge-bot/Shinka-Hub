-- Shinka Hub - Aba Movement (teste)
local p = game:GetService("Players")
local rs = game:GetService("RunService")
local u = game:GetService("UserInputService")
local lp = p.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

local hub = Instance.new("ScreenGui")
hub.Name = "ShinkaHub"
hub.Parent = pg

-- Janela principal
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 300)
main.Position = UDim2.new(0.5, -150, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(30,30,35)
main.Active = true
main.Draggable = true
main.Parent = hub
Instance.new("UICorner", main).CornerRadius = UDim.new(0,8)

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1,0,0,30)
titulo.Text = "Shinka Hub - Movement"
titulo.TextColor3 = Color3.new(1,1,1)
titulo.BackgroundColor3 = Color3.fromRGB(50,50,55)
titulo.Parent = main
Instance.new("UICorner", titulo).CornerRadius = UDim.new(0,8)

-- Slider de velocidade
local spdTxt = Instance.new("TextLabel")
spdTxt.Size = UDim2.new(0.9,0,0,20)
spdTxt.Position = UDim2.new(0.05,0,0,40)
spdTxt.BackgroundTransparency = 1
spdTxt.Text = "Walkspeed: 16"
spdTxt.TextColor3 = Color3.fromRGB(200,200,200)
spdTxt.Parent = main

local slider = Instance.new("Frame")
slider.Size = UDim2.new(0.9,0,0,5)
slider.Position = UDim2.new(0.05,0,0,65)
slider.BackgroundColor3 = Color3.fromRGB(80,80,90)
slider.Parent = main

local sliderBtn = Instance.new("TextButton")
sliderBtn.Size = UDim2.new(0,20,0,20)
sliderBtn.Position = UDim2.new(0.5,-10,0,-7.5)
sliderBtn.BackgroundColor3 = Color3.fromRGB(100,0,255)
sliderBtn.Text = ""
sliderBtn.Parent = slider

-- Botão Fly
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.9,0,0,35)
flyBtn.Position = UDim2.new(0.05,0,0,100)
flyBtn.BackgroundColor3 = Color3.fromRGB(60,60,70)
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.Parent = main
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0,6)

-- Botão Noclip
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0.9,0,0,35)
noclipBtn.Position = UDim2.new(0.05,0,0,145)
noclipBtn.BackgroundColor3 = Color3.fromRGB(60,60,70)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.Parent = main
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0,6)

-- LÓGICA DO SLIDER
local spd = 16
sliderBtn.MouseButton1Down:Connect(function()
    local drag
    drag = rs.RenderStepped:Connect(function()
        local mouse = u:GetMouseLocation()
        local sX = slider.AbsolutePosition.X
        local sW = slider.AbsoluteSize.X
        local rel = math.clamp(mouse.X - sX, 0, sW)
        local perc = rel / sW
        spd = math.floor(16 + perc * 100)
        sliderBtn.Position = UDim2.new(perc, -10, 0, -7.5)
        spdTxt.Text = "Walkspeed: " .. spd
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = spd
        end
    end)
    u.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag:Disconnect()
        end
    end)
end)

-- LÓGICA DO FLY (simplificada - apenas muda o texto por enquanto)
local fly = false
flyBtn.MouseButton1Click:Connect(function()
    fly = not fly
    flyBtn.Text = "Fly: " .. (fly and "ON" or "OFF")
    flyBtn.BackgroundColor3 = fly and Color3.fromRGB(0,100,50) or Color3.fromRGB(60,60,70)
    -- Aqui você pode adicionar a lógica real de fly depois
end)

-- LÓGICA DO NOCLIP (simplificada)
local noclip = false
noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = "Noclip: " .. (noclip and "ON" or "OFF")
    noclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(0,100,50) or Color3.fromRGB(60,60,70)
    -- Lógica real pode ser adicionada depois
end)

print("Shinka Hub - Movement carregado!")
