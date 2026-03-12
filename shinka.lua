-- Shinka Hub – Versão Final Corrigida (Tudo Funcional)
local p=game:GetService"Players"local rs=game:GetService"RunService"local u=game:GetService"UserInputService"local l=game:GetService"Lighting"local lp=p.LocalPlayer local c=workspace.CurrentCamera
local ts=game:GetService"TweenService"

-- GUI
local g=Instance.new("ScreenGui",lp.PlayerGui)
g.ResetOnSpawn=false

local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,300,0,0)
f.Position=UDim2.new(0.5,-150,0.5,-200)
f.BackgroundColor3=Color3.fromRGB(30,30,35)
f.Active=true f.Draggable=true f.ClipsDescendants=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)

-- Barra de título
local bar=Instance.new("Frame",f)
bar.Size=UDim2.new(1,0,0,30)
bar.BackgroundColor3=Color3.fromRGB(40,40,45)
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,8)
local titulo=Instance.new("TextLabel",bar)
titulo.Size=UDim2.new(0,150,1,0)
titulo.Position=UDim2.new(0,10,0,0)
titulo.BackgroundTransparency=1
titulo.Text="Shinka Hub"
titulo.TextColor3=Color3.fromRGB(220,220,255)
titulo.TextSize=18
titulo.Font=Enum.Font.GothamBold
titulo.TextXAlignment=Enum.TextXAlignment.Left

-- Botões de controle
local min=Instance.new("TextButton",bar)
min.Size=UDim2.new(0,25,0,25)
min.Position=UDim2.new(1,-60,0,2.5)
min.BackgroundColor3=Color3.fromRGB(80,80,150)
min.Text="−"
min.TextColor3=Color3.new(1,1,1)
min.Font=Enum.Font.GothamBold
min.TextSize=20
min.MouseButton1Click:Connect(function() g.Enabled=false end)

local cls=Instance.new("TextButton",bar)
cls.Size=UDim2.new(0,25,0,25)
cls.Position=UDim2.new(1,-30,0,2.5)
cls.BackgroundColor3=Color3.fromRGB(200,50,50)
cls.Text="×"
cls.TextColor3=Color3.new(1,1,1)
cls.Font=Enum.Font.GothamBold
cls.TextSize=20
cls.MouseButton1Click:Connect(function() g:Destroy() end)

-- Botão flutuante SH
local reopen=Instance.new("TextButton",g)
reopen.Size=UDim2.new(0,50,0,50)
reopen.Position=UDim2.new(0,10,0.5,-25)
reopen.BackgroundColor3=Color3.fromRGB(100,0,255)
reopen.Text="SH"
reopen.TextColor3=Color3.new(1,1,1)
reopen.Font=Enum.Font.GothamBold
reopen.TextSize=20
reopen.Visible=false
reopen.MouseButton1Click:Connect(function()
    g.Enabled=true
    f.Size=UDim2.new(0,300,0,0)
    ts:Create(f,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(0,300,0,400)}):Play()
    reopen.Visible=false
end)

min.MouseButton1Click:Connect(function() g.Enabled=false reopen.Visible=true end)

-- Animação inicial
ts:Create(f,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(0,300,0,400)}):Play()

-- Abas
local abas={"Movement","Visuals","ESP","Aimbot"}
local botoes={}
for i=1,4 do
    local btn=Instance.new("TextButton",f)
    btn.Size=UDim2.new(0,70,0,30)
    btn.Position=UDim2.new(0,10+(i-1)*75,0,35)
    btn.Text=abas[i]
    btn.BackgroundColor3=Color3.fromRGB(50,50,55)
    btn.TextColor3=Color3.new(1,1,1)
    botoes[i]=btn
end

local area=Instance.new("Frame",f)
area.Size=UDim2.new(1,-20,0,300)
area.Position=UDim2.new(0,10,0,70)
area.BackgroundColor3=Color3.fromRGB(40,40,45)
Instance.new("UICorner",area).CornerRadius=UDim.new(0,8)

local cont=Instance.new("Frame",area)
cont.Size=UDim2.new(1,-20,1,-20)
cont.Position=UDim2.new(0,10,0,10)
cont.BackgroundTransparency=1

-- Função para criar botões dentro das abas
local function criarBotao(pai, y, texto, cor, func)
    local b=Instance.new("TextButton",pai)
    b.Size=UDim2.new(0.9,0,0,35)
    b.Position=UDim2.new(0.05,0,0,y)
    b.BackgroundColor3=cor or Color3.fromRGB(60,60,70)
    b.Text=texto
    b.TextColor3=Color3.new(1,1,1)
    b.Font=Enum.Font.GothamSemibold
    b.TextSize=14
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    if func then b.MouseButton1Click:Connect(func) end
    return b
end

-- ===== MOVEMENT =====
local m=Instance.new("Frame",cont)
m.Size=UDim2.new(1,0,1,0)
m.BackgroundTransparency=1

-- Slider de velocidade
local spdTxt=Instance.new("TextLabel",m)
spdTxt.Size=UDim2.new(0.9,0,0,20)
spdTxt.Position=UDim2.new(0.05,0,0,10)
spdTxt.Text="Walkspeed: 16"
spdTxt.TextColor3=Color3.fromRGB(200,200,200)

local slider=Instance.new("Frame",m)
slider.Size=UDim2.new(0.9,0,0,5)
slider.Position=UDim2.new(0.05,0,0,35)
slider.BackgroundColor3=Color3.fromRGB(80,80,90)

local sliderBtn=Instance.new("TextButton",slider)
sliderBtn.Size=UDim2.new(0,20,0,20)
sliderBtn.Position=UDim2.new(0.5,-10,0,-7.5)
sliderBtn.BackgroundColor3=Color3.fromRGB(100,0,255)
sliderBtn.Text=""

local spd=16
local draggingSpeed=false
sliderBtn.MouseButton1Down:Connect(function() draggingSpeed=true end)
u.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then draggingSpeed=false end end)
rs.RenderStepped:Connect(function()
    if draggingSpeed then
        local mx=u:GetMouseLocation().X
        local sx=slider.AbsolutePosition.X
        local sw=slider.AbsoluteSize.X
        local rel=math.clamp(mx-sx,0,sw)
        local perc=rel/sw
        spd=16+math.floor(perc*100)
        sliderBtn.Position=UDim2.new(perc,-10,0,-7.5)
        spdTxt.Text="Walkspeed: "..spd
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed=spd
        end
    end
end)

-- Fly
local fly=false
local flyBtn=criarBotao(m,70,"Fly: OFF",nil,function()
    fly=not fly
    flyBtn.Text="Fly: "..(fly and"ON"or"OFF")
    flyBtn.BackgroundColor3=fly and Color3.fromRGB(0,100,50) or Color3.fromRGB(60,60,70)
    if fly then
        -- Ativar fly
        local char=lp.Character
        if char then
            local hum=char:FindFirstChild("Humanoid")
            local root=char:FindFirstChild("HumanoidRootPart")
            if hum and root then
                hum.PlatformStand=true
                local bg=Instance.new("BodyGyro",root)
                bg.P=9e4
                bg.MaxTorque=Vector3.new(9e4,9e4,9e4)
                bg.CFrame=root.CFrame
                local bv=Instance.new("BodyVelocity",root)
                bv.Velocity=Vector3.new(0,0,0)
                bv.MaxForce=Vector3.new(9e4,9e4,9e4)
                -- Conexão para atualizar movimento
                local flyConn
                flyConn=rs.RenderStepped:Connect(function()
                    if not fly then
                        bg:Destroy()
                        bv:Destroy()
                        hum.PlatformStand=false
                        flyConn:Disconnect()
                        return
                    end
                    local move=Vector3.new(0,0,0)
                    if u:IsKeyDown(Enum.KeyCode.W) then move=move+c.CFrame.LookVector end
                    if u:IsKeyDown(Enum.KeyCode.S) then move=move-c.CFrame.LookVector end
                    if u:IsKeyDown(Enum.KeyCode.A) then move=move-c.CFrame.RightVector end
                    if u:IsKeyDown(Enum.KeyCode.D) then move=move+c.CFrame.RightVector end
                    if u:IsKeyDown(Enum.KeyCode.Space) then move=move+Vector3.new(0,1,0) end
                    if u:IsKeyDown(Enum.KeyCode.LeftControl) then move=move-Vector3.new(0,1,0) end
                    bv.Velocity=move*50
                    bg.CFrame=c.CFrame
                end)
            end
        end
    end
end)

-- Noclip
local noclip=false
local noclipConn
local noclipBtn=criarBotao(m,110,"Noclip: OFF",nil,function()
    noclip=not noclip
    noclipBtn.Text="Noclip: "..(noclip and"ON"or"OFF")
    noclipBtn.BackgroundColor3=noclip and Color3.fromRGB(0,100,50) or Color3.fromRGB(60,60,70)
    if noclip then
        noclipConn=rs.Stepped:Connect(function()
            if lp.Character then
                for _,v in pairs(lp.Character:GetChildren()) do
                    if v:IsA"BasePart" then v.CanCollide=false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() noclipConn=nil end
    end
end)

-- ===== VISUALS =====
local v=Instance.new("Frame",cont)
v.Size=UDim2.new(1,0,1,0)
v.BackgroundTransparency=1
v.Visible=false

local origBright,origFog,origShadow=l.Brightness,l.FogEnd,l.GlobalShadows
local fb=false
local fbBtn=criarBotao(v,10,"Fullbright: OFF",nil,function()
    fb=not fb
    if fb then
        l.Brightness=2
        l.GlobalShadows=false
        l.Ambient=Color3.new(1,1,1)
    else
        l.Brightness=origBright
        l.GlobalShadows=origShadow
        l.Ambient=Color3.new(0,0,0)
    end
    fbBtn.Text="Fullbright: "..(fb and"ON"or"OFF")
    fbBtn.BackgroundColor3=fb and Color3.fromRGB(0,100,50) or Color3.fromRGB(60,60,70)
end)

local nf=false
local nfBtn=criarBotao(v,60,"No Fog: OFF",nil,function()
    nf=not nf
    if nf then l.FogEnd=1e5 else l.FogEnd=origFog end
    nfBtn.Text="No Fog: "..(nf and"ON"or"OFF")
    nfBtn.BackgroundColor3=nf and Color3.fromRGB(0,100,50) or Color3.fromRGB(60,60,70)
end)

-- ===== ESP (informativo + funcional) =====
local espF=Instance.new("Frame",cont)
espF.Size=UDim2.new(1,0,1,0)
espF.BackgroundTransparency=1
espF.Visible=false

local espTxt=Instance.new("TextLabel",espF)
espTxt.Size=UDim2.new(0.9,0,0,60)
espTxt.Position=UDim2.new(0.05,0,0,10)
espTxt.Text="ESP ativo automaticamente.\nContorno colorido por vida."
espTxt.TextColor3=Color3.fromRGB(200,200,200)
espTxt.TextWrapped=true

-- Código ESP (mesmo de antes, funcional)
local esp={}
local function criarESP(pl)
    if pl==lp or not pl.Character then return end
    local ch=pl.Character
    local r=ch:FindFirstChild("HumanoidRootPart")or ch:FindFirstChild("Torso")if not r then return end
    if esp[pl]then for _,o in pairs(esp[pl])do pcall(o.Destroy,o)end end
    local h=Instance.new("Highlight",ch)
    h.FillColor=Color3.fromRGB(255,0,0)
    h.FillTransparency=0.5
    h.OutlineColor=Color3.new(1,1,1)
    h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    local b=Instance.new("BillboardGui",r)
    b.Size=UDim2.new(0,200,0,50)
    b.StudsOffset=Vector3.new(0,3,0)
    b.AlwaysOnTop=true
    local n=Instance.new("TextLabel",b)
    n.Size=UDim2.new(1,0,0.6,0)
    n.BackgroundTransparency=1
    n.Text=pl.Name
    n.TextColor3=Color3.new(1,1,1)
    n.TextStrokeColor3=Color3.new(0,0,0)
    n.TextStrokeTransparency=0.3
    n.TextScaled=true
    n.Font=Enum.Font.GothamBold
    local d=Instance.new("TextLabel",b)
    d.Size=UDim2.new(1,0,0.4,0)
    d.Position=UDim2.new(0,0,0.6,0)
    d.BackgroundTransparency=1
    d.Text="0m"
    d.TextColor3=Color3.fromRGB(0,255,255)
    d.TextStrokeColor3=Color3.new(0,0,0)
    d.TextStrokeTransparency=0.3
    d.TextScaled=true
    esp[pl]={h,b}
end
p.PlayerAdded:Connect(function(pl)
    pl.CharacterAdded:Connect(function() task.wait(1) criarESP(pl) end)
    if pl.Character then task.wait(1) criarESP(pl) end
end)
p.PlayerRemoving:Connect(function(pl)
    if esp[pl] then for _,o in pairs(esp[pl]) do pcall(o.Destroy,o) end esp[pl]=nil end
end)
for _,pl in pairs(p:GetPlayers()) do
    if pl~=lp and pl.Character then task.spawn(function() task.wait(1) criarESP(pl) end) end
end
rs.RenderStepped:Connect(function()
    for pl,ob in pairs(esp) do
        if pl and pl.Character and pl.Character.Parent then
            local r=pl.Character:FindFirstChild("HumanoidRootPart")or pl.Character:FindFirstChild("Torso")
            local hum=pl.Character:FindFirstChild("Humanoid")
            if r and hum and hum.Health>0 then
                local dist=(c.CFrame.Position-r.Position).Magnitude
                local hp=hum.Health/hum.MaxHealth
                ob[1].FillColor=Color3.new(1-hp,hp,0)
                if ob[2] then
                    ob[2].Enabled=true
                    for _,l in pairs(ob[2]:GetChildren()) do
                        if l:IsA"TextLabel" and l.Text:match("%.1fm") then
                            l.Text=string.format("%.1fm",dist)
                        end
                    end
                end
            else
                if ob[2] then ob[2].Enabled=false end
            end
        end
    end
end)

-- ===== AIMBOT =====
local aF=Instance.new("Frame",cont)
aF.Size=UDim2.new(1,0,1,0)
aF.BackgroundTransparency=1
aF.Visible=false

local aimOn=false
local aimBtn=criarBotao(aF,10,"Aimbot: OFF",nil,function()
    aimOn=not aimOn
    aimBtn.Text="Aimbot: "..(aimOn and"ON"or"OFF")
    aimBtn.BackgroundColor3=aimOn and Color3.fromRGB(0,100,50) or Color3.fromRGB(60,60,70)
end)

-- FOV label e slider
local fovTxt=Instance.new("TextLabel",aF)
fovTxt.Size=UDim2.new(0.9,0,0,20)
fovTxt.Position=UDim2.new(0.05,0,0,60)
fovTxt.Text="FOV: 90"
fovTxt.TextColor3=Color3.fromRGB(200,200,200)
fovTxt.TextXAlignment=Enum.TextXAlignment.Left

local fovS=Instance.new("Frame",aF)
fovS.Size=UDim2.new(0.9,0,0,5)
fovS.Position=UDim2.new(0.05,0,0,85)
fovS.BackgroundColor3=Color3.fromRGB(80,80,90)

local fovB=Instance.new("TextButton",fovS)
fovB.Size=UDim2.new(0,20,0,20)
fovB.Position=UDim2.new(0.5,-10,0,-7.5)
fovB.BackgroundColor3=Color3.fromRGB(100,0,255)
fovB.Text=""

local fov=90
local fovDragging=false
fovB.MouseButton1Down:Connect(function() fovDragging=true end)
u.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then fovDragging=false end end)
rs.RenderStepped:Connect(function()
    if fovDragging then
        local mx=u:GetMouseLocation().X
        local sx=fovS.AbsolutePosition.X
        local sw=fovS.AbsoluteSize.X
        local rel=math.clamp(mx-sx,0,sw)
        local perc=rel/sw
        fov=30+math.floor(perc*270)
        fovB.Position=UDim2.new(perc,-10,0,-7.5)
        fovTxt.Text="FOV: "..fov
    end
end)

-- Função para verificar inimigo
local function isEnemy(player)
    if not lp.Team or not player.Team then return true end
    return lp.Team ~= player.Team
end

-- Loop do aimbot
rs.RenderStepped:Connect(function()
    if aimOn then
        local closest=nil
        local closestDist=fov
        for _,pl in pairs(p:GetPlayers()) do
            if pl~=lp and pl.Character and pl.Character:FindFirstChild("Humanoid") and pl.Character.Humanoid.Health>0 and isEnemy(pl) then
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

-- Alternar abas
local frames={m,v,espF,aF}
for i=2,4 do frames[i].Visible=false end
for i=1,4 do
    botoes[i].MouseButton1Click:Connect(function()
        for j=1,4 do frames[j].Visible=false end
        frames[i].Visible=true
    end)
end

print("Shinka Hub Final – Todas as funções corrigidas!")
