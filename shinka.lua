-- Shinka Hub v4.0 - Completo + Discord
local p=game:GetService"Players"local rs=game:GetService"RunService"local u=game:GetService"UserInputService"local l=game:GetService"Lighting"local lp=p.LocalPlayer local c=workspace.CurrentCamera
local ts=game:GetService"TweenService"
local pg=lp:WaitForChild("PlayerGui")

-- GUI principal com animação
local hub=Instance.new("ScreenGui")hub.Name="ShinkaHub"hub.Parent=pg hub.ResetOnSpawn=false hub.Enabled=false
local main=Instance.new("Frame")main.Size=UDim2.new(0,350,0,450)main.Position=UDim2.new(0.5,-175,0.5,-225)main.BackgroundColor3=Color3.fromRGB(30,30,35)main.Active=true main.Draggable=true main.Parent=hub
Instance.new("UICorner",main).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",main).Color=Color3.fromRGB(100,0,255)

-- Barra de título
local bar=Instance.new("Frame")bar.Size=UDim2.new(1,0,0,30)bar.BackgroundColor3=Color3.fromRGB(40,40,45)bar.Parent=main
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,8)
local titulo=Instance.new("TextLabel")titulo.Size=UDim2.new(0,150,1,0)titulo.Position=UDim2.new(0,10,0,0)titulo.BackgroundTransparency=1 titulo.Text="Shinka Hub v4"titulo.TextColor3=Color3.fromRGB(220,220,255)titulo.TextSize=18 titulo.Font=Enum.Font.GothamBold titulo.TextXAlignment=Enum.TextXAlignment.Left titulo.Parent=bar

-- Botão minimizar
local min=Instance.new("TextButton")min.Size=UDim2.new(0,25,0,25)min.Position=UDim2.new(1,-60,0,2.5)min.BackgroundColor3=Color3.fromRGB(80,80,150)min.Text="−"min.TextColor3=Color3.new(1,1,1)min.Font=Enum.Font.GothamBold min.TextSize=20 min.Parent=bar
min.MouseButton1Click:Connect(function()hub.Enabled=false end)

-- Botão fechar
local cls=Instance.new("TextButton")cls.Size=UDim2.new(0,25,0,25)cls.Position=UDim2.new(1,-30,0,2.5)cls.BackgroundColor3=Color3.fromRGB(200,50,50)cls.Text="×"cls.TextColor3=Color3.new(1,1,1)cls.Font=Enum.Font.GothamBold cls.TextSize=20 cls.Parent=bar
cls.MouseButton1Click:Connect(function()hub:Destroy()end)

-- Botão flutuante para reabrir (SH)
local reopen=Instance.new("TextButton")reopen.Size=UDim2.new(0,50,0,50)reopen.Position=UDim2.new(0,10,0.5,-25)reopen.BackgroundColor3=Color3.fromRGB(100,0,255)reopen.Text="SH"reopen.TextColor3=Color3.new(1,1,1)reopen.Font=Enum.Font.GothamBold reopen.TextSize=20 reopen.Parent=hub
reopen.Visible=false reopen.MouseButton1Click:Connect(function()hub.Enabled=true reopen.Visible=false end)
min.MouseButton1Click:Connect(function()hub.Enabled=false reopen.Visible=true end)

-- Abas (agora com 5 abas: Movement, Visuals, ESP, Aimbot, Discord)
local abas={"Movement","Visuals","ESP","Aimbot","Discord"}local icons={"⚡","👁️","📡","🎯","💬"}local botoes={}
for i=1,5 do
    local btn=Instance.new("TextButton")btn.Size=UDim2.new(0,60,0,30)btn.Position=UDim2.new(0,5+(i-1)*65,0,35)btn.BackgroundColor3=Color3.fromRGB(50,50,55)btn.Text=icons[i]btn.TextColor3=Color3.fromRGB(200,200,200)btn.Font=Enum.Font.GothamSemibold btn.TextSize=16 btn.Parent=main
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)
    botoes[i]=btn
end

local area=Instance.new("Frame")area.Size=UDim2.new(1,-20,0,350)area.Position=UDim2.new(0,10,0,70)area.BackgroundColor3=Color3.fromRGB(40,40,45)area.Parent=main
Instance.new("UICorner",area).CornerRadius=UDim.new(0,8)
local conteiner=Instance.new("Frame")conteiner.Size=UDim2.new(1,-20,1,-20)conteiner.Position=UDim2.new(0,10,0,10)conteiner.BackgroundTransparency=1 conteiner.Parent=area

-- Função auxiliar para criar botões dentro das abas
local function novobtn(p,txt,cor,f)local b=Instance.new("TextButton")b.Size=UDim2.new(0.9,0,0,35)b.Position=UDim2.new(0.05,0,p,0)b.BackgroundColor3=cor or Color3.fromRGB(60,60,70)b.Text=txt b.TextColor3=Color3.new(1,1,1)b.Font=Enum.Font.GothamSemibold b.TextSize=14 b.Parent=conteiner
Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)if f then b.MouseButton1Click:Connect(f)end return b end

-- ===== ABA MOVEMENT =====
local moveF=Instance.new("Frame")moveF.Size=UDim2.new(1,0,1,0)moveF.BackgroundTransparency=1 moveF.Parent=conteiner
local spdTxt=Instance.new("TextLabel")spdTxt.Size=UDim2.new(0.9,0,0,20)spdTxt.Position=UDim2.new(0.05,0,0,10)spdTxt.BackgroundTransparency=1 spdTxt.Text="Walkspeed: 16"spdTxt.TextColor3=Color3.fromRGB(200,200,200)spdTxt.Font=Enum.Font.Gotham spdTxt.TextSize=14 spdTxt.TextXAlignment=Enum.TextXAlignment.Left spdTxt.Parent=moveF
local slider=Instance.new("Frame")slider.Size=UDim2.new(0.9,0,0,5)slider.Position=UDim2.new(0.05,0,0,35)slider.BackgroundColor3=Color3.fromRGB(80,80,90)slider.Parent=moveF
local sliderBtn=Instance.new("TextButton")sliderBtn.Size=UDim2.new(0,20,0,20)sliderBtn.Position=UDim2.new(0.5,-10,0,-7.5)sliderBtn.BackgroundColor3=Color3.fromRGB(100,0,255)sliderBtn.Text=""sliderBtn.Parent=slider
local fly=false local flyBtn=novobtn(70,"Fly: OFF",nil,function()fly=not fly flyBtn.Text="Fly: "..(fly and"ON"or"OFF")flyBtn.BackgroundColor3=fly and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)
local noclip=false local noclipConn local noclipBtn=novobtn(110,"Noclip: OFF",nil,function()noclip=not noclip noclipBtn.Text="Noclip: "..(noclip and"ON"or"OFF")noclipBtn.BackgroundColor3=noclip and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)
if noclip then noclipConn=rs.Stepped:Connect(function()if lp.Character then for _,v in pairs(lp.Character:GetChildren())do if v:IsA"BasePart"then v.CanCollide=false end end end end)else if noclipConn then noclipConn:Disconnect()noclipConn=nil end end end)
local spd=16 sliderBtn.MouseButton1Down:Connect(function()local drag;drag=rs.RenderStepped:Connect(function()local m=u:GetMouseLocation()local sx=slider.AbsolutePosition.X local sw=slider.AbsoluteSize.X local rel=math.clamp(m.X-sx,0,sw)local perc=rel/sw spd=math.floor(16+perc*100)sliderBtn.Position=UDim2.new(perc,-10,0,-7.5)spdTxt.Text="Walkspeed: "..spd if lp.Character and lp.Character:FindFirstChild("Humanoid")then lp.Character.Humanoid.WalkSpeed=spd end end)end)
u.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag:Disconnect()end end)

-- ===== ABA VISUALS =====
local visF=Instance.new("Frame")visF.Size=UDim2.new(1,0,1,0)visF.BackgroundTransparency=1 visF.Parent=conteiner
local origBright,origFog,origShadow=l.Brightness,l.FogEnd,l.GlobalShadows
local fb=false local fbBtn=novobtn(10,"Fullbright: OFF",nil,function()fb=not fb
if fb then l.Brightness=2 l.GlobalShadows=false l.Ambient=Color3.new(1,1,1)else l.Brightness=origBright l.GlobalShadows=origShadow l.Ambient=Color3.new(0,0,0)end
fbBtn.Text="Fullbright: "..(fb and"ON"or"OFF")fbBtn.BackgroundColor3=fb and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)
local nf=false local nfBtn=novobtn(50,"No Fog: OFF",nil,function()nf=not nf
if nf then l.FogEnd=1e5 else l.FogEnd=origFog end
nfBtn.Text="No Fog: "..(nf and"ON"or"OFF")nfBtn.BackgroundColor3=nf and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)

-- ===== ABA ESP (funcional) =====
local espF=Instance.new("Frame")espF.Size=UDim2.new(1,0,1,0)espF.BackgroundTransparency=1 espF.Parent=conteiner
local espInfo=Instance.new("TextLabel")espInfo.Size=UDim2.new(0.9,0,0,60)espInfo.Position=UDim2.new(0.05,0,0,10)espInfo.BackgroundTransparency=1 espInfo.Text="ESP ativo automaticamente.\nContorno colorido por vida e etiqueta."espInfo.TextColor3=Color3.fromRGB(200,200,200)espInfo.TextWrapped=true espInfo.Parent=espF

-- Código ESP (mesmo de antes, mantido)
local esp={}local function criarESP(pl)if pl==lp or not pl.Character then return end local ch=pl.Character local r=ch:FindFirstChild("HumanoidRootPart")or ch:FindFirstChild("Torso")if not r then return end
if esp[pl]then for _,o in pairs(esp[pl])do pcall(o.Destroy,o)end end
local h=Instance.new("Highlight",ch)h.FillColor=Color3.fromRGB(255,0,0)h.FillTransparency=0.5 h.OutlineColor=Color3.new(1,1,1)h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
local b=Instance.new("BillboardGui",r)b.Size=UDim2.new(0,200,0,50)b.StudsOffset=Vector3.new(0,3,0)b.AlwaysOnTop=true
local n=Instance.new("TextLabel",b)n.Size=UDim2.new(1,0,0.6,0)n.BackgroundTransparency=1 n.Text=pl.Name n.TextColor3=Color3.new(1,1,1)n.TextStrokeColor3=Color3.new(0,0,0)n.TextStrokeTransparency=0.3 n.TextScaled=true n.Font=Enum.Font.GothamBold
local d=Instance.new("TextLabel",b)d.Size=UDim2.new(1,0,0.4,0)d.Position=UDim2.new(0,0,0.6,0)d.BackgroundTransparency=1 d.Text="0m"d.TextColor3=Color3.fromRGB(0,255,255)d.TextStrokeColor3=Color3.new(0,0,0)d.TextStrokeTransparency=0.3 n.TextScaled=true
esp[pl]={h,b}end
p.PlayerAdded:Connect(function(pl)pl.CharacterAdded:Connect(function()task.wait(1)criarESP(pl)end)if pl.Character then task.wait(1)criarESP(pl)end end)
p.PlayerRemoving:Connect(function(pl)if esp[pl]then for _,o in pairs(esp[pl])do pcall(o.Destroy,o)end esp[pl]=nil end end)
for _,pl in pairs(p:GetPlayers())do if pl~=lp and pl.Character then task.spawn(function()task.wait(1)criarESP(pl)end)end end
rs.RenderStepped:Connect(function()for pl,ob in pairs(esp)do if pl and pl.Character and pl.Character.Parent then local r=pl.Character:FindFirstChild("HumanoidRootPart")or pl.Character:FindFirstChild("Torso")local hum=pl.Character:FindFirstChild("Humanoid")
if r and hum and hum.Health>0 then local dist=(c.CFrame.Position-r.Position).Magnitude local hp=hum.Health/hum.MaxHealth ob[1].FillColor=Color3.new(1-hp,hp,0)
if ob[2]then ob[2].Enabled=true for _,l in pairs(ob[2]:GetChildren())do if l:IsA"TextLabel"and l.Text:match("%.1fm")then l.Text=string.format("%.1fm",dist)end end end
else if ob[2]then ob[2].Enabled=false end end end end end)

-- ===== ABA AIMBOT (corrigido) =====
local aimF=Instance.new("Frame")aimF.Size=UDim2.new(1,0,1,0)aimF.BackgroundTransparency=1 aimF.Parent=conteiner
local aimOn=false local aimBtn=novobtn(10,"Aimbot: OFF",nil,function()aimOn=not aimOn aimBtn.Text="Aimbot: "..(aimOn and"ON"or"OFF")aimBtn.BackgroundColor3=aimOn and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)
local fovTxt=Instance.new("TextLabel")fovTxt.Size=UDim2.new(0.9,0,0,20)fovTxt.Position=UDim2.new(0.05,0,0,60)fovTxt.BackgroundTransparency=1 fovTxt.Text="FOV: 90"fovTxt.TextColor3=Color3.fromRGB(200,200,200)fovTxt.TextXAlignment=Enum.TextXAlignment.Left fovTxt.Parent=aimF
local fovSlider=Instance.new("Frame")fovSlider.Size=UDim2.new(0.9,0,0,5)fovSlider.Position=UDim2.new(0.05,0,0,85)fovSlider.BackgroundColor3=Color3.fromRGB(80,80,90)fovSlider.Parent=aimF
local fovBtn=Instance.new("TextButton")fovBtn.Size=UDim2.new(0,20,0,20)fovBtn.Position=UDim2.new(0.5,-10,0,-7.5)fovBtn.BackgroundColor3=Color3.fromRGB(100,0,255)fovBtn.Text=""fovBtn.Parent=fovSlider
local fovVal=90
local fovDragging=false
fovBtn.MouseButton1Down:Connect(function()fovDragging=true end)
u.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then fovDragging=false end end)
rs.RenderStepped:Connect(function()
    if fovDragging then
        local mx=u:GetMouseLocation().X
        local sx=fovSlider.AbsolutePosition.X
        local sw=fovSlider.AbsoluteSize.X
        local rel=math.clamp(mx-sx,0,sw)
        local perc=rel/sw
        fovVal=math.floor(30+perc*270)
        fovBtn.Position=UDim2.new(perc,-10,0,-7.5)
        fovTxt.Text="FOV: "..fovVal
    end
end)

-- Função para verificar se um jogador é inimigo
local function isEnemy(player)
    if not lp.Team or not player.Team then return true end -- se algum não tiver time, considera inimigo
    return lp.Team ~= player.Team
end

-- Aimbot mira na cabeça
rs.RenderStepped:Connect(function()
    if aimOn then
        local closest=nil
        local closestDist=fovVal
        for _,pl in pairs(p:GetPlayers())do
            if pl~=lp and pl.Character and pl.Character:FindFirstChild("Humanoid")and pl.Character.Humanoid.Health>0 and isEnemy(pl) then
                local head=pl.Character:FindFirstChild("Head")
                if head then
                    local sp,on=c:WorldToScreenPoint(head.Position)
                    if on then
                        local mp=u:GetMouseLocation()
                        local dist=(Vector2.new(sp.X,sp.Y)-mp).Magnitude
                        if dist<closestDist then
                            closestDist=dist
                            closest=head
                        end
                    end
                end
            end
        end
        if closest then
            c.CFrame=c.CFrame:Lerp(CFrame.lookAt(c.CFrame.Position,closest.Position),0.3)
        end
    end
end)

-- ===== ABA DISCORD =====
local disF=Instance.new("Frame")disF.Size=UDim2.new(1,0,1,0)disF.BackgroundTransparency=1 disF.Parent=conteiner
local discordTxt=Instance.new("TextLabel")discordTxt.Size=UDim2.new(0.9,0,0,40)discordTxt.Position=UDim2.new(0.05,0,0,10)discordTxt.BackgroundTransparency=1 discordTxt.Text="Discord do grupo:"discordTxt.TextColor3=Color3.fromRGB(220,220,255)discordTxt.Font=Enum.Font.GothamBold discordTxt.TextSize=16 discordTxt.TextXAlignment=Enum.TextXAlignment.Left discordTxt.Parent=disF
local linkLabel=Instance.new("TextLabel")linkLabel.Size=UDim2.new(0.9,0,0,30)linkLabel.Position=UDim2.new(0.05,0,0,50)linkLabel.BackgroundColor3=Color3.fromRGB(60,60,70)linkLabel.Text="discord.gg/SNutmtu6x"linkLabel.TextColor3=Color3.fromRGB(100,200,255)linkLabel.Font=Enum.Font.GothamSemibold linkLabel.TextSize=14 linkLabel.Parent=disF
Instance.new("UICorner",linkLabel).CornerRadius=UDim.new(0,6)
local copiarBtn=novobtn(90,"Copiar link",Color3.fromRGB(80,80,150),function()
    setclipboard and setclipboard("https://discord.gg/SNutmtu6x") or print("Link: discord.gg/SNutmtu6x")
end)
local entrarBtn=novobtn(130,"Entrar no Discord",Color3.fromRGB(60,150,60),function()
    -- Tenta abrir URL (nem todos executores suportam)
    syn and syn.request({Url="https://discord.gg/SNutmtu6x",Method="GET"}) or print("Acesse: https://discord.gg/SNutmtu6x")
end)

-- ===== SISTEMA DE ABAS =====
local frames={moveF,visF,espF,aimF,disF}
for i=2,5 do frames[i].Visible=false end
for i=1,5 do
    botoes[i].MouseButton1Click:Connect(function()
        for j=1,5 do frames[j].Visible=false end
        frames[i].Visible=true
        for j=1,5 do botoes[j].BackgroundColor3=Color3.fromRGB(50,50,55) end
        botoes[i].BackgroundColor3=Color3.fromRGB(80,80,120)
    end)
end
botoes[1].BackgroundColor3=Color3.fromRGB(80,80,120)

-- ===== ANIMAÇÃO DE ENTRADA =====
hub.Enabled=true
ts:Create(main,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(0,350,0,450)}):Play()
main.Size=UDim2.new(0,350,0,0)

print("Shinka Hub v4 carregado! Use o botão SH para reabrir.")
