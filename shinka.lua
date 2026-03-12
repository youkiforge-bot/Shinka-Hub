-- Shinka Hub - Versão Estável (GitHub)
local p=game:GetService"Players"local rs=game:GetService"RunService"local u=game:GetService"UserInputService"local l=game:GetService"Lighting"local lp=p.LocalPlayer local c=workspace.CurrentCamera

-- GUI principal
local hub=Instance.new("ScreenGui")hub.Name="ShinkaHub"hub.Parent=game.CoreGui
local main=Instance.new("Frame")main.Size=UDim2.new(0,500,0,300)main.Position=UDim2.new(0.5,-250,0.5,-150)main.BackgroundColor3=Color3.fromRGB(30,30,35)main.Active=true main.Draggable=true main.Parent=hub
Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",main).Color=Color3.fromRGB(100,0,255)

-- Barra de título
local bar=Instance.new("Frame")bar.Size=UDim2.new(1,0,0,30)bar.BackgroundColor3=Color3.fromRGB(40,40,45)bar.Parent=main
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,8)
local titulo=Instance.new("TextLabel")titulo.Size=UDim2.new(0,150,1,0)titulo.Position=UDim2.new(0,10,0,0)titulo.BackgroundTransparency=1 titulo.Text="Shinka Hub"titulo.TextColor3=Color3.fromRGB(220,220,255)titulo.TextSize=18 titulo.Font=Enum.Font.GothamBold titulo.TextXAlignment=Enum.TextXAlignment.Left titulo.Parent=bar
local min=Instance.new("TextButton")min.Size=UDim2.new(0,25,0,25)min.Position=UDim2.new(1,-60,0,2.5)min.BackgroundColor3=Color3.fromRGB(80,80,150)min.Text="−"min.TextColor3=Color3.new(1,1,1)min.Font=Enum.Font.GothamBold min.TextSize=20 min.Parent=bar min.MouseButton1Click:Connect(function()hub.Enabled=not hub.Enabled end)
local cls=Instance.new("TextButton")cls.Size=UDim2.new(0,25,0,25)cls.Position=UDim2.new(1,-30,0,2.5)cls.BackgroundColor3=Color3.fromRGB(200,50,50)cls.Text="×"cls.TextColor3=Color3.new(1,1,1)cls.Font=Enum.Font.GothamBold cls.TextSize=20 cls.Parent=bar cls.MouseButton1Click:Connect(function()hub:Destroy()end)

-- Abas
local abas={"Movement","Visuals","ESP","Aimbot"}local icons={"⚡","👁️","📡","🎯"}local botoes={}local conteudo={}

for i=1,4 do
    local btn=Instance.new("TextButton")btn.Size=UDim2.new(0,100,0,30)btn.Position=UDim2.new(0,10+(i-1)*105,0,35)btn.BackgroundColor3=Color3.fromRGB(50,50,55)btn.Text=icons[i].." "..abas[i]btn.TextColor3=Color3.fromRGB(200,200,200)btn.Font=Enum.Font.GothamSemibold btn.TextSize=14 btn.Parent=main
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)
    botoes[i]=btn
end

local area=Instance.new("Frame")area.Size=UDim2.new(1,-20,0,220)area.Position=UDim2.new(0,10,0,70)area.BackgroundColor3=Color3.fromRGB(40,40,45)area.Parent=main
Instance.new("UICorner",area).CornerRadius=UDim.new(0,8)
local conteiner=Instance.new("Frame")conteiner.Size=UDim2.new(1,-20,1,-20)conteiner.Position=UDim2.new(0,10,0,10)conteiner.BackgroundTransparency=1 conteiner.Parent=area

-- Função auxiliar para criar botões dentro das abas
local function novobtn(p,txt,cor,f)local b=Instance.new("TextButton")b.Size=UDim2.new(0.9,0,0,30)b.Position=UDim2.new(0.05,0,p,0)b.BackgroundColor3=cor or Color3.fromRGB(60,60,70)b.Text=txt b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.GothamSemibold b.TextSize=14 b.Parent=conteiner
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)if f then b.MouseButton1Click:Connect(f)end return b end

-- Aba Movement
local moveF=Instance.new("Frame")moveF.Size=UDim2.new(1,0,1,0)moveF.BackgroundTransparency=1 moveF.Parent=conteiner
local spdTxt=Instance.new("TextLabel")spdTxt.Size=UDim2.new(0.9,0,0,20)spdTxt.Position=UDim2.new(0.05,0,0,10)spdTxt.BackgroundTransparency=1 spdTxt.Text="Walkspeed: 16"spdTxt.TextColor3=Color3.fromRGB(200,200,200)spdTxt.Font=Enum.Font.Gotham spdTxt.TextSize=14 spdTxt.TextXAlignment=Enum.TextXAlignment.Left spdTxt.Parent=moveF
local slider=Instance.new("Frame")slider.Size=UDim2.new(0.9,0,0,5)slider.Position=UDim2.new(0.05,0,0,35)slider.BackgroundColor3=Color3.fromRGB(80,80,90)slider.Parent=moveF
local btnSlider=Instance.new("TextButton")btnSlider.Size=UDim2.new(0,15,0,15)btnSlider.Position=UDim2.new(0.5,-7,0,-5)btnSlider.BackgroundColor3=Color3.fromRGB(100,0,255)btnSlider.Text=""btnSlider.Parent=slider
local fly=false local flyBtn=novobtn(70,"Fly: OFF",nil,function()fly=not fly flyBtn.Text="Fly: "..(fly and"ON"or"OFF")flyBtn.BackgroundColor3=fly and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)
local noclip=false local noclipConn local noclipBtn=novobtn(110,"Noclip: OFF",nil,function()noclip=not noclip noclipBtn.Text="Noclip: "..(noclip and"ON"or"OFF")noclipBtn.BackgroundColor3=noclip and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)
if noclip then noclipConn=rs.Stepped:Connect(function()if lp.Character then for _,v in pairs(lp.Character:GetChildren())do if v:IsA"BasePart"then v.CanCollide=false end end end end)else if noclipConn then noclipConn:Disconnect()noclipConn=nil end end end)
local spd=16 btnSlider.MouseButton1Down:Connect(function()local drag;drag=rs.RenderStepped:Connect(function()local m=u:GetMouseLocation()local sx=slider.AbsolutePosition.X local sw=slider.AbsoluteSize.X local rel=math.clamp(m.X-sx,0,sw)local perc=rel/sw spd=math.floor(16+perc*100)btnSlider.Position=UDim2.new(perc,-7,0,-5)spdTxt.Text="Walkspeed: "..spd if lp.Character and lp.Character:FindFirstChild("Humanoid")then lp.Character.Humanoid.WalkSpeed=spd end end)end)
u.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag:Disconnect()end end)

-- Aba Visuals
local visF=Instance.new("Frame")visF.Size=UDim2.new(1,0,1,0)visF.BackgroundTransparency=1 visF.Parent=conteiner
local origBright,origFog,origShadow=l.Brightness,l.FogEnd,l.GlobalShadows
local fb=false local fbBtn=novobtn(10,"Fullbright: OFF",nil,function()fb=not fb
if fb then l.Brightness=2 l.GlobalShadows=false l.Ambient=Color3.new(1,1,1)else l.Brightness=origBright l.GlobalShadows=origShadow l.Ambient=Color3.new(0,0,0)end
fbBtn.Text="Fullbright: "..(fb and"ON"or"OFF")fbBtn.BackgroundColor3=fb and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)
local nf=false local nfBtn=novobtn(50,"No Fog: OFF",nil,function()nf=not nf
if nf then l.FogEnd=1e5 else l.FogEnd=origFog end
nfBtn.Text="No Fog: "..(nf and"ON"or"OFF")nfBtn.BackgroundColor3=nf and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)

-- Aba ESP (apenas informativa)
local espF=Instance.new("Frame")espF.Size=UDim2.new(1,0,1,0)espF.BackgroundTransparency=1 espF.Parent=conteiner
local espTxt=Instance.new("TextLabel")espTxt.Size=UDim2.new(0.9,0,0,50)espTxt.Position=UDim2.new(0.05,0,0,10)espTxt.BackgroundTransparency=1 espTxt.Text="ESP ativo automaticamente.\nMostra contorno e distância dos jogadores."espTxt.TextColor3=Color3.fromRGB(180,180,180)espTxt.TextSize=14 espTxt.Font=Enum.Font.Gotham espTxt.TextWrapped=true espTxt.TextXAlignment=Enum.TextXAlignment.Left espTxt.Parent=espF

-- Aba Aimbot
local aimF=Instance.new("Frame")aimF.Size=UDim2.new(1,0,1,0)aimF.BackgroundTransparency=1 aimF.Parent=conteiner
local aimOn=false local aimBtn=novobtn(10,"Aimbot: OFF",nil,function()aimOn=not aimOn aimBtn.Text="Aimbot: "..(aimOn and"ON"or"OFF")aimBtn.BackgroundColor3=aimOn and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)
local fovTxt=Instance.new("TextLabel")fovTxt.Size=UDim2.new(0.9,0,0,20)fovTxt.Position=UDim2.new(0.05,0,0,50)fovTxt.BackgroundTransparency=1 fovTxt.Text="FOV: 90"fovTxt.TextColor3=Color3.fromRGB(200,200,200)fovTxt.Font=Enum.Font.Gotham fovTxt.TextSize=14 fovTxt.TextXAlignment=Enum.TextXAlignment.Left fovTxt.Parent=aimF
local fovSlider=Instance.new("Frame")fovSlider.Size=UDim2.new(0.9,0,0,5)fovSlider.Position=UDim2.new(0.05,0,0,75)fovSlider.BackgroundColor3=Color3.fromRGB(80,80,90)fovSlider.Parent=aimF
local fovBtn=Instance.new("TextButton")fovBtn.Size=UDim2.new(0,15,0,15)fovBtn.Position=UDim2.new(0.5,-7,0,-5)fovBtn.BackgroundColor3=Color3.fromRGB(100,0,255)fovBtn.Text=""fovBtn.Parent=fovSlider
local fov=90 fovBtn.MouseButton1Down:Connect(function()local drag;drag=rs.RenderStepped:Connect(function()local m=u:GetMouseLocation()local sx=fovSlider.AbsolutePosition.X local sw=fovSlider.AbsoluteSize.X local rel=math.clamp(m.X-sx,0,sw)local perc=rel/sw fov=math.floor(30+perc*270)fovBtn.Position=UDim2.new(perc,-7,0,-5)fovTxt.Text="FOV: "..fov end)end)
u.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag:Disconnect()end end)

rs.RenderStepped:Connect(function()if aimOn then local t,nil d=fov for _,pl in pairs(p:GetPlayers())do if pl~=lp and pl.Character and pl.Character:FindFirstChild("Humanoid")and pl.Character.Humanoid.Health>0 then
local r=pl.Character:FindFirstChild("HumanoidRootPart")or pl.Character:FindFirstChild("Torso")if r then local sp,on=c:WorldToScreenPoint(r.Position)if on then local mp=u:GetMouseLocation()local dd=(Vector2.new(sp.X,sp.Y)-mp).Magnitude if dd<d then d=dd t=r end end end end end
if t then c.CFrame=c.CFrame:Lerp(CFrame.lookAt(c.CFrame.Position,t.Position),0.3)end end end)

-- Alternar abas
local function mostrarAba(n)for _,f in pairs({moveF,visF,espF,aimF})do f.Visible=false end
if n=="Movement"then moveF.Visible=true elseif n=="Visuals"then visF.Visible=true elseif n=="ESP"then espF.Visible=true elseif n=="Aimbot"then aimF.Visible=true end end
for i=1,4 do botoes[i].MouseButton1Click:Connect(function()mostrarAba(abas[i])for j=1,4 do botoes[j].BackgroundColor3=j==i and Color3.fromRGB(80,80,120)or Color3.fromRGB(50,50,55)end end)end
mostrarAba("Movement")botoes[1].BackgroundColor3=Color3.fromRGB(80,80,120)

-- ESP (funcional)
local esp={}local function criarESP(pl)if pl==lp or not pl.Character then return end local ch=pl.Character local r=ch:FindFirstChild("HumanoidRootPart")or ch:FindFirstChild("Torso")if not r then return end
if esp[pl]then for _,o in pairs(esp[pl])do pcall(o.Destroy,o)end end
local h=Instance.new("Highlight")h.Name="ShinkaESP"h.FillColor=Color3.fromRGB(255,0,0)h.FillTransparency=0.5 h.OutlineColor=Color3.new(1,1,1)h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop h.Parent=ch
local b=Instance.new("BillboardGui")b.Name="ShinkaESP_Text"b.AlwaysOnTop=true b.Size=UDim2.new(0,200,0,50)b.StudsOffset=Vector3.new(0,3,0)b.Parent=r
local n=Instance.new("TextLabel")n.Size=UDim2.new(1,0,0.6,0)n.BackgroundTransparency=1 n.Text=pl.Name n.TextColor3=Color3.new(1,1,1)n.TextStrokeColor3=Color3.new(0,0,0)n.TextStrokeTransparency=0.3 n.TextScaled=true n.Font=Enum.Font.GothamBold n.Parent=b
local d=Instance.new("TextLabel")d.Size=UDim2.new(1,0,0.4,0)d.Position=UDim2.new(0,0,0.6,0)d.BackgroundTransparency=1 d.Text="0m"d.TextColor3=Color3.fromRGB(0,255,255)d.TextStrokeColor3=Color3.new(0,0,0)d.TextStrokeTransparency=0.3 d.TextScaled=true d.Font=Enum.Font.Gotham d.Parent=b
esp[pl]={h,b}end
p.PlayerAdded:Connect(function(pl)pl.CharacterAdded:Connect(function()task.wait(1)criarESP(pl)end)if pl.Character then task.wait(1)criarESP(pl)end end)
p.PlayerRemoving:Connect(function(pl)if esp[pl]then for _,o in pairs(esp[pl])do pcall(o.Destroy,o)end esp[pl]=nil end end)
for _,pl in pairs(p:GetPlayers())do if pl~=lp and pl.Character then task.spawn(function()task.wait(1)criarESP(pl)end)end end
rs.RenderStepped:Connect(function()for pl,ob in pairs(esp)do if pl and pl.Character and pl.Character.Parent then local r=pl.Character:FindFirstChild("HumanoidRootPart")or pl.Character:FindFirstChild("Torso")local h=pl.Character:FindFirstChild("Humanoid")
if r and h and h.Health>0 then local dist=(c.CFrame.Position-r.Position).Magnitude local hp=h.Health/h.MaxHealth ob[1].FillColor=Color3.new(1-hp,hp,0)
if ob[2]then ob[2].Enabled=true for _,l in pairs(ob[2]:GetChildren())do if l:IsA"TextLabel"and l.Text:match("%.1fm")then l.Text=string.format("%.1fm",dist)end end end
else if ob[2]then ob[2].Enabled=false end end end end end)

-- Atalho INSERT
u.InputBegan:Connect(function(i,g)if not g and i.KeyCode==Enum.KeyCode.Insert then hub.Enabled=not hub.Enabled end end)
print("Shinka Hub carregado! Pressione INSERT para abrir/fechar.")
