-- Shinka Hub Light + Aimbot
local p=game:GetService"Players"local rs=game:GetService"RunService"local u=game:GetService"UserInputService"local l=game:GetService"Lighting"local lp=p.LocalPlayer local c=workspace.CurrentCamera
local g=Instance.new("ScreenGui",lp.PlayerGui)
local f=Instance.new("Frame",g)f.Size=UDim2.new(0,300,0,400)f.Position=UDim2.new(0.5,-150,0.5,-200)f.BackgroundColor3=Color3.fromRGB(30,30,35)f.Active=true f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
local t=Instance.new("TextLabel",f)t.Size=UDim2.new(1,0,0,30)t.Text="Shinka Hub Light"t.TextColor3=Color3.new(1,1,1)t.BackgroundColor3=Color3.fromRGB(50,50,55)
local abas={"Movement","Visuals","ESP","Aimbot"}local botoes={}
for i=1,4 do
    local btn=Instance.new("TextButton",f)btn.Size=UDim2.new(0,70,0,30)btn.Position=UDim2.new(0,10+(i-1)*75,0,35)btn.Text=abas[i]btn.BackgroundColor3=Color3.fromRGB(50,50,55)btn.TextColor3=Color3.new(1,1,1)
    botoes[i]=btn
end
local area=Instance.new("Frame",f)area.Size=UDim2.new(1,-20,0,300)area.Position=UDim2.new(0,10,0,70)area.BackgroundColor3=Color3.fromRGB(40,40,45)
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

-- ESP
local espF=Instance.new("Frame",c)espF.Size=UDim2.new(1,0,1,0)espF.BackgroundTransparency=1 espF.Visible=false
local espTxt=Instance.new("TextLabel",espF)espTxt.Size=UDim2.new(0.9,0,0,60)espTxt.Position=UDim2.new(0.05,0,0,10)espTxt.Text="ESP ativo automaticamente.\nContorno colorido por vida."espTxt.TextColor3=Color3.fromRGB(200,200,200)espTxt.TextWrapped=true

-- Lógica do ESP (igual)
local esp={}
local function criarESP(pl)
    if pl==lp or not pl.Character then return end
    local ch=pl.Character
    local r=ch:FindFirstChild("HumanoidRootPart")or ch:FindFirstChild("Torso")if not r then return end
    if esp[pl]then for _,o in pairs(esp[pl])do pcall(o.Destroy,o)end end
    local h=Instance.new("Highlight",ch)h.FillColor=Color3.fromRGB(255,0,0)h.FillTransparency=0.5 h.OutlineColor=Color3.new(1,1,1)h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    local b=Instance.new("BillboardGui",r)b.Size=UDim2.new(0,200,0,50)b.StudsOffset=Vector3.new(0,3,0)b.AlwaysOnTop=true
    local n=Instance.new("TextLabel",b)n.Size=UDim2.new(1,0,0.6,0)n.BackgroundTransparency=1 n.Text=pl.Name n.TextColor3=Color3.new(1,1,1)n.TextStrokeColor3=Color3.new(0,0,0)n.TextStrokeTransparency=0.3 n.TextScaled=true n.Font=Enum.Font.GothamBold
    local d=Instance.new("TextLabel",b)d.Size=UDim2.new(1,0,0.4,0)d.Position=UDim2.new(0,0,0.6,0)d.BackgroundTransparency=1 d.Text="0m"d.TextColor3=Color3.fromRGB(0,255,255)d.TextStrokeColor3=Color3.new(0,0,0)d.TextStrokeTransparency=0.3 n.TextScaled=true
    esp[pl]={h,b}
end
p.PlayerAdded:Connect(function(pl)pl.CharacterAdded:Connect(function()task.wait(1)criarESP(pl)end)if pl.Character then task.wait(1)criarESP(pl)end end)
p.PlayerRemoving:Connect(function(pl)if esp[pl]then for _,o in pairs(esp[pl])do pcall(o.Destroy,o)end esp[pl]=nil end end)
for _,pl in pairs(p:GetPlayers())do if pl~=lp and pl.Character then task.spawn(function()task.wait(1)criarESP(pl)end)end end
rs.RenderStepped:Connect(function()
    for pl,ob in pairs(esp)do
        if pl and pl.Character and pl.Character.Parent then
            local r=pl.Character:FindFirstChild("HumanoidRootPart")or pl.Character:FindFirstChild("Torso")
            local hum=pl.Character:FindFirstChild("Humanoid")
            if r and hum and hum.Health>0 then
                local dist=(c.CFrame.Position-r.Position).Magnitude
                local hp=hum.Health/hum.MaxHealth
                ob[1].FillColor=Color3.new(1-hp,hp,0)
                if ob[2] then
                    ob[2].Enabled=true
                    for _,l in pairs(ob[2]:GetChildren())do
                        if l:IsA"TextLabel"and l.Text:match("%.1fm")then l.Text=string.format("%.1fm",dist)end
                    end
                end
            else if ob[2]then ob[2].Enabled=false end end
        end
    end
end)

-- Aimbot
local aF=Instance.new("Frame",c)aF.Size=UDim2.new(1,0,1,0)aF.BackgroundTransparency=1 aF.Visible=false
local aimOn=false local aimBtn=Instance.new("TextButton",aF)aimBtn.Size=UDim2.new(0.9,0,0,35)aimBtn.Position=UDim2.new(0.05,0,0,20)aimBtn.Text="Aimbot: OFF"aimBtn.BackgroundColor3=Color3.fromRGB(60,60,70)aimBtn.TextColor3=Color3.new(1,1,1)aimBtn.MouseButton1Click:Connect(function()aimOn=not aimOn aimBtn.Text="Aimbot: "..(aimOn and"ON"or"OFF")aimBtn.BackgroundColor3=aimOn and Color3.fromRGB(0,100,50)or Color3.fromRGB(60,60,70)end)

local fovTxt=Instance.new("TextLabel",aF)fovTxt.Size=UDim2.new(0.9,0,0,20)fovTxt.Position=UDim2.new(0.05,0,0,70)fovTxt.Text="FOV: 90"fovTxt.TextColor3=Color3.fromRGB(200,200,200)fovTxt.TextXAlignment=Enum.TextXAlignment.Left
local fovS=Instance.new("Frame",aF)fovS.Size=UDim2.new(0.9,0,0,5)fovS.Position=UDim2.new(0.05,0,0,95)fovS.BackgroundColor3=Color3.fromRGB(80,80,90)
local fovB=Instance.new("TextButton",fovS)fovB.Size=UDim2.new(0,20,0,20)fovB.Position=UDim2.new(0.5,-10,0,-7.5)fovB.BackgroundColor3=Color3.fromRGB(100,0,255)fovB.Text=""
local fovVal=90 fovB.MouseButton1Down:Connect(function()local d;d=rs.RenderStepped:Connect(function()local mx=u:GetMouseLocation().X local sx=fovS.AbsolutePosition.X local sw=fovS.AbsoluteSize.X local perc=(mx-sx)/sw if perc<0 then perc=0 elseif perc>1 then perc=1 end fovVal=30+math.floor(perc*270)fovB.Position=UDim2.new(perc,-10,0,-7.5)fovTxt.Text="FOV: "..fovVal end)u.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then d:Disconnect()end end)end)

rs.RenderStepped:Connect(function()
    if aimOn then
        local closest=nil local closestDist=fovVal
        for _,pl in pairs(p:GetPlayers())do
            if pl~=lp and pl.Character and pl.Character:FindFirstChild("Humanoid")and pl.Character.Humanoid.Health>0 then
                local r=pl.Character:FindFirstChild("HumanoidRootPart")or pl.Character:FindFirstChild("Torso")
                if r then
                    local sp,on=c:WorldToScreenPoint(r.Position)
                    if on then
                        local mp=u:GetMouseLocation()
                        local dist=(Vector2.new(sp.X,sp.Y)-mp).Magnitude
                        if dist<closestDist then
                            closestDist=dist
                            closest=r
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
botoes[1].MouseButton1Click:Connect(function()m.Visible=true v.Visible=false espF.Visible=false aF.Visible=false end)
botoes[2].MouseButton1Click:Connect(function()m.Visible=false v.Visible=true espF.Visible=false aF.Visible=false end)
botoes[3].MouseButton1Click:Connect(function()m.Visible=false v.Visible=false espF.Visible=true aF.Visible=false end)
botoes[4].MouseButton1Click:Connect(function()m.Visible=false v.Visible=false espF.Visible=false aF.Visible=true end)

print("Shinka Hub Light + Aimbot carregado")
