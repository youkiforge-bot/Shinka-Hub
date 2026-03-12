-- Shinka Hub - Versão com Movement
local p=game:GetService"Players"local rs=game:GetService"RunService"local u=game:GetService"UserInputService"local lp=p.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

local hub=Instance.new("ScreenGui")hub.Name="ShinkaHub"hub.Parent=playerGui

local main=Instance.new("Frame")main.Size=UDim2.new(0,300,0,250)main.Position=UDim2.new(0.5,-150,0.5,-125)main.BackgroundColor3=Color3.fromRGB(30,30,35)main.Active=true main.Draggable=true main.Parent=hub
Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)

local titulo=Instance.new("TextLabel")titulo.Size=UDim2.new(1,0,0,30)titulo.Text="Shinka Hub - Movement"titulo.TextColor3=Color3.new(1,1,1)titulo.BackgroundColor3=Color3.fromRGB(50,50,55)titulo.Parent=main
Instance.new("UICorner",titulo).CornerRadius=UDim.new(0,8)

local spdTxt=Instance.new("TextLabel")spdTxt.Size=UDim2.new(0.9,0,0,20)spdTxt.Position=UDim2.new(0.05,0,0,40)spdTxt.BackgroundTransparency=1 spdTxt.Text="Walkspeed: 16"spdTxt.TextColor3=Color3.fromRGB(200,200,200)spdTxt.Parent=main

local slider=Instance.new("Frame")slider.Size=UDim2.new(0.9,0,0,5)slider.Position=UDim2.new(0.05,0,0,65)slider.BackgroundColor3=Color3.fromRGB(80,80,90)slider.Parent=main
local sliderBtn=Instance.new("TextButton")sliderBtn.Size=UDim2.new(0,20,0,20)sliderBtn.Position=UDim2.new(0.5,-10,0,-7.5)sliderBtn.BackgroundColor3=Color3.fromRGB(100,0,255)sliderBtn.Text=""sliderBtn.Parent=slider

local spd=16
sliderBtn.MouseButton1Down:Connect(function()
    local drag
    drag = rs.RenderStepped:Connect(function()
        local m = u:GetMouseLocation()
        local sx = slider.AbsolutePosition.X
        local sw = slider.AbsoluteSize.X
        local rel = math.clamp(m.X - sx, 0, sw)
        local perc = rel / sw
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

print("Shinka Hub Movement carregado!")
