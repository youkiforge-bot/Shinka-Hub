-- Shinka Hub Light
local p=game:GetService"Players"local rs=game:GetService"RunService"local u=game:GetService"UserInputService"local l=game:GetService"Lighting"local lp=p.LocalPlayer
local g=Instance.new("ScreenGui",lp.PlayerGui)
local f=Instance.new("Frame",g)f.Size=UDim2.new(0,300,0,300)f.Position=UDim2.new(0.5,-150,0.5,-150)f.BackgroundColor3=Color3.fromRGB(30,30,35)f.Active=true f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
local t=Instance.new("TextLabel",f)t.Size=UDim2.new(1,0,0,30)t.Text="Shinka Hub Light"t.TextColor3=Color3.new(1,1,1)t.BackgroundColor3=Color3.fromRGB(50,50,55)
local abas={"Movement","Visuals"}local botoes={}
for i=1,2 do
    local btn=Instance.new("TextButton",f)btn.Size=UDim2.new(0,120,0,30)btn.Position=UDim2.new(0,10+(i-1)*130,0,35)btn.Text=abas[i]btn.BackgroundColor3=Color3.fromRGB(50,50,55)btn.TextColor3=Color3.new(1,1,1)
    botoes[i]=btn
end
local area=Instance.new("Frame",f)area.Size=UDim2.new(1,-20,0,200)area.Position=UDim2.new(0,10,0,70)area.BackgroundColor3=Color3.fromRGB(40,40,45)
local c=Instance.new("Frame",area)c.Size=UDim2.new(1,-20,1,-20)c.Position=UDim2.new(0,10,0,10)c.BackgroundTransparency=1

-- Movement
local m=Instance.new("Frame",c)m.Size=UDim2.new(1,0,1,0)m.BackgroundTransparency=1
local spd=Instance.new("TextLabel",m)spd.Size=UDim2.new(0.9,0,0,20)spd.Position=UDim2.new(0.05,0,0,10)spd.Text="Walkspeed: 16"spd.TextColor3=Color3.fromRGB(200,200,200)
local s=Instance.new("Frame",m)s.Size=UDim2.new(0.9,0,0,5)s.Position=UDim2.new(0.05,0,0,35)s.BackgroundColor3=Color3.fromRGB(80,80,90)
local sb=Instance.new("TextButton",s)sb.Size=UDim2.new(0,20,0,20)sb.Position=UDim2.new(0.5,-10,0,-7.5)sb.BackgroundColor3=Color3.fromRGB(100,0,255)sb.Text=""
local spdVal=16 sb.MouseButton1Down:Connect(function()local d;d=rs.RenderStepped:Connect(function()local mx=u:GetMouseLocation().X local sx=s.AbsolutePosition.X local sw=s.AbsoluteSize.X local perc=(mx-sx)/sw if perc<0 then perc=0 elseif perc>1 then perc=1 end spdVal=16+math.floor(perc*100)sb.Position=UDim2.new(perc,-10,0,-7.5)spd.Text="Walkspeed: "..spdVal if lp.Character and lp.Character:FindFirstChild("Humanoid")then lp.Character.Humanoid.WalkSpeed=spdVal end end)u.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then d:Disconnect()end end)end)

-- Visuals
local v=Instance.new("Frame",c)v.Size=UDim2.new(1,0,1,0)v.BackgroundTransparency=1 v.Visible=false
local fb=false local fbBtn=Instance.new("TextButton",v)fbBtn.Size=UDim2.new(0.9,0,0,35)fbBtn.Position=UDim2.new(0.05,0,0,20)fbBtn.Text="Fullbright: OFF"fbBtn.BackgroundColor3=Color3.fromRGB(60,60,70)fbBtn.TextColor3=Color3.new(1,1,1)fbBtn.MouseButton1Click:Connect(function()fb=not fb if fb then l.Brightness=2 l.GlobalShadows=false l.Ambient=Color3.new(1,1,1)else l.Brightness=1 l.GlobalShadows=true l.Ambient=Color3.new(0,0,0)end fbBtn.Text="Fullbright: "..(fb and"ON"or"OFF")fbBtn.BackgroundColor3=fb and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)

-- Alternar abas
botoes[1].MouseButton1Click:Connect(function()m.Visible=true v.Visible=false end)
botoes[2].MouseButton1Click:Connect(function()m.Visible=false v.Visible=true end)

print("Shinka Light carregado")
