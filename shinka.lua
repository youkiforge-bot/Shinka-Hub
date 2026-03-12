-- =============================================
-- MEU SCRIPT - VELOCIDADE + FLY + NOCLIP
-- =============================================
local player = game:GetService("Players").LocalPlayer
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local gui = Instance.new("ScreenGui")
gui.Name = "MeuScript"
gui.Parent = player:WaitForChild("PlayerGui")

-- Janela principal (um pouco maior para caber os botões)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 280)
frame.Position = UDim2.new(0.5, -150, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

-- Título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 30)
titulo.Text = "Meu Script - Speed + Fly + Noclip"
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

-- ========== VELOCIDADE ==========
local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(0.9, 0, 0, 25)
speedText.Position = UDim2.new(0.05, 0, 0, 10)
speedText.BackgroundTransparency = 1
speedText.Text = "Velocidade: 16"
speedText.TextColor3 = Color3.fromRGB(200, 200, 200)
speedText.Font = Enum.Font.Gotham
speedText.TextSize = 16
speedText.TextXAlignment = Enum.TextXAlignment.Left
speedText.Parent = area

local slider = Instance.new("Frame")
slider.Size = UDim2.new(0.9, 0, 0, 5)
slider.Position = UDim2.new(0.05, 0, 0, 40)
slider.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
slider.Parent = area
Instance.new("UICorner", slider).CornerRadius = UDim.new(1, 0)

local sliderButton = Instance.new("TextButton")
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new(0.5, -10, 0, -7.5)
sliderButton.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
sliderButton.Text = ""
sliderButton.Parent = slider
Instance.new("UICorner", sliderButton).CornerRadius = UDim.new(1, 0)

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
        local mouseX = userInput:GetMouseLocation().X
        local sliderX = slider.AbsolutePosition.X
        local sliderW = slider.AbsoluteSize.X
        local rel = math.clamp(mouseX - sliderX, 0, sliderW)
        local perc = rel / sliderW
        speed = 16 + math.floor(perc * 100)
        sliderButton.Position = UDim2.new(perc, -10, 0, -7.5)
        speedText.Text = "Velocidade: " .. speed
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

-- ========== FLY ==========
local flyEnabled = false
local flyConnection = nil
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.9, 0, 0, 35)
flyButton.Position = UDim2.new(0.05, 0, 0, 70)
flyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
flyButton.Text = "Fly: OFF"
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.Font = Enum.Font.GothamSemibold
flyButton.TextSize = 16
flyButton.Parent = area
Instance.new("UICorner", flyButton).CornerRadius = UDim.new(0, 6)

flyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyButton.Text = "Fly: " .. (flyEnabled and "ON" or "OFF")
    flyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if flyEnabled then
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if humanoid and root then
                humanoid.PlatformStand = true
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.P = 9e4
                bodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
                bodyGyro.CFrame = root.CFrame
                bodyGyro.Parent = root

                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
                bodyVelocity.Parent = root

                flyConnection = runService.RenderStepped:Connect(function()
                    if not flyEnabled then
                        bodyGyro:Destroy()
                        bodyVelocity:Destroy()
                        humanoid.PlatformStand = false
                        flyConnection:Disconnect()
                        return
                    end
                    local move = Vector3.new(0, 0, 0)
                    if userInput:IsKeyDown(Enum.KeyCode.W) then move = move + workspace.CurrentCamera.CFrame.LookVector end
                    if userInput:IsKeyDown(Enum.KeyCode.S) then move = move - workspace.CurrentCamera.CFrame.LookVector end
                    if userInput:IsKeyDown(Enum.KeyCode.A) then move = move - workspace.CurrentCamera.CFrame.RightVector end
                    if userInput:IsKeyDown(Enum.KeyCode.D) then move = move + workspace.CurrentCamera.CFrame.RightVector end
                    if userInput:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                    if userInput:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
                    bodyVelocity.Velocity = move * 50
                    bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                end)
            end
        end
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local bg = root:FindFirstChildOfClass("BodyGyro")
                if bg then bg:Destroy() end
                local bv = root:FindFirstChildOfClass("BodyVelocity")
                if bv then bv:Destroy() end
            end
        end
    end
end)

-- ========== NOCLIP ==========
local noclipEnabled = false
local noclipConnection = nil
local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0.9, 0, 0, 35)
noclipButton.Position = UDim2.new(0.05, 0, 0, 115)
noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
noclipButton.Text = "Noclip: OFF"
noclipButton.TextColor3 = Color3.new(1, 1, 1)
noclipButton.Font = Enum.Font.GothamSemibold
noclipButton.TextSize = 16
noclipButton.Parent = area
Instance.new("UICorner", noclipButton).CornerRadius = UDim.new(0, 6)

noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
    noclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(60, 60, 70)

    if noclipEnabled then
        noclipConnection = runService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
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

print("✅ Script completo: Velocidade, Fly e Noclip funcionando!")
