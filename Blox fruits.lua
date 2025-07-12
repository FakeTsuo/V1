--[[
BLOX FRUITS MOBILE - SCRIPT OP ALL-IN-ONE
By Copilot (2024)
Compatível com Delta Mobile, Hydrogen, Arceus X, Codex, etc
]]--

-- Proteção anti-crash
pcall(function() game:GetService("CoreGui")["BF_OP_GUI"]:Destroy() end)

local plr = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Replicated = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")

-- GUI PRINCIPAL
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "BF_OP_GUI"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,270,0,485)
frame.Position = UDim2.new(0,10,0,130)
frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
frame.Active = true
frame.Draggable = true

local function makeBtn(txt, y)
    local b = Instance.new("TextButton")
    b.Parent = frame
    b.Size = UDim2.new(0,240,0,34)
    b.Position = UDim2.new(0,15,0,y)
    b.BackgroundColor3 = Color3.fromRGB(44,44,54)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 16
    b.Text = txt
    return b
end

local btnAutoFarm = makeBtn("Auto Farm: OFF",10)
local btnAutoQuest = makeBtn("Auto Quest: OFF",54)
local btnAutoStats = makeBtn("Auto Stats: OFF",98)
local btnBuso = makeBtn("Auto Buso Haki: OFF",142)
local btnTP = makeBtn("Teleport GUI",186)
local btnSpeed = makeBtn("Speed Hack: OFF",230)
local btnFPS = makeBtn("FPS Boost",274)
local btnSafe = makeBtn("Safe Mode: OFF",318)
local lblstatus = Instance.new("TextLabel", frame)
lblstatus.Size = UDim2.new(0,240,0,32)
lblstatus.Position = UDim2.new(0,15,0,370)
lblstatus.BackgroundTransparency = 1
lblstatus.Text = "Blox Fruits Mobile Script - Copilot"
lblstatus.TextColor3 = Color3.new(1,1,1)
lblstatus.Font = Enum.Font.SourceSansBold
lblstatus.TextSize = 14

-- ESTADOS
local autoFarm, autoQuest, autoStats, autoBuso, speedHack, safeMode = false, false, false, false, false, false

-- FUNÇÕES OP

-- FPS BOOST
btnFPS.MouseButton1Click:Connect(function()
    setfpscap = setfpscap or function() end
    setfpscap(30)
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then pcall(function() v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end) end
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
    end
    game:GetService("Lighting").FogEnd = 1e10
    game:GetService("Lighting").Brightness = 1
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").ClockTime = 14
    lblstatus.Text = "FPS Boost Ativado!"
end)

-- SPEED HACK
btnSpeed.MouseButton1Click:Connect(function()
    speedHack = not speedHack
    btnSpeed.Text = "Speed Hack: " .. (speedHack and "ON" or "OFF")
    if speedHack then
        plr.Character.Humanoid.WalkSpeed = 120
    else
        plr.Character.Humanoid.WalkSpeed = 16
    end
end)

-- SAFE MODE
btnSafe.MouseButton1Click:Connect(function()
    safeMode = not safeMode
    btnSafe.Text = "Safe Mode: " .. (safeMode and "ON" or "OFF")
end)

-- AUTO BUSO HAKI
btnBuso.MouseButton1Click:Connect(function()
    autoBuso = not autoBuso
    btnBuso.Text = "Auto Buso Haki: " .. (autoBuso and "ON" or "OFF")
end)

-- AUTO STATS
btnAutoStats.MouseButton1Click:Connect(function()
    autoStats = not autoStats
    btnAutoStats.Text = "Auto Stats: " .. (autoStats and "ON" or "OFF")
end)

-- AUTO QUEST
btnAutoQuest.MouseButton1Click:Connect(function()
    autoQuest = not autoQuest
    btnAutoQuest.Text = "Auto Quest: " .. (autoQuest and "ON" or "OFF")
end)

-- AUTO FARM
btnAutoFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    btnAutoFarm.Text = "Auto Farm: " .. (autoFarm and "ON" or "OFF")
end)

-- TELEPORT GUI
btnTP.MouseButton1Click:Connect(function()
    local tpGui = Instance.new("Frame",gui)
    tpGui.Size = UDim2.new(0,210,0,310)
    tpGui.Position = UDim2.new(0,300,0,140)
    tpGui.BackgroundColor3 = Color3.fromRGB(45,45,55)
    tpGui.Draggable = true
    tpGui.Active = true
    tpGui.Name = "TPFRAME"
    local places = {
        {"Starter Island",Vector3.new(-260, 7, 388)}, {"Jungle",Vector3.new(-1337, 11, 495)}, 
        {"Pirate Village",Vector3.new(-1122, 5, 3877)}, {"Desert",Vector3.new(1094, 15, 4192)},
        {"Middle",Vector3.new(-521, 8, 4168)}, {"Sky",Vector3.new(-4956, 295, -2847)},
        {"Frozen Village",Vector3.new(1122, 7, -1426)}, {"Marine Ford",Vector3.new(-4505, 20, 4260)},
        {"Colosseum",Vector3.new(-1428, 7, -3014)}, {"Prison",Vector3.new(5278, 38, 474)},
        {"Magma",Vector3.new(-5585, 15, 8027)}, {"Underwater",Vector3.new(61163, 5, 1569)},
        {"Fountain City",Vector3.new(5251, 38, 4012)}
    }
    for i,v in pairs(places) do
        local b = Instance.new("TextButton",tpGui)
        b.Size = UDim2.new(0,190,0,25)
        b.Position = UDim2.new(0,10,0,10+((i-1)*22))
        b.BackgroundColor3 = Color3.fromRGB(65,65,80)
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.SourceSansBold
        b.TextSize = 14
        b.Text = v[1]
        b.MouseButton1Click:Connect(function()
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(v[2])
        end)
    end
    tpGui.MouseLeave:Connect(function() tpGui:Destroy() end) -- fecha ao tirar mouse
end)

-- LOOP PRINCIPAL
spawn(function()
    while wait(0.15) do
        if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then continue end

        -- SAFE MODE (vai para mar ou posição alta se alguém chega perto)
        if safeMode then
            for _,other in pairs(game.Players:GetPlayers()) do
                if other ~= plr and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (plr.Character.HumanoidRootPart.Position - other.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 30 then
                        plr.Character.HumanoidRootPart.CFrame = CFrame.new(0,800,0)
                        wait(2)
                    end
                end
            end
        end

        -- AUTO BUSO HAKI
        if autoBuso then
            pcall(function()
                if not plr.Character:FindFirstChild("HasBuso") then
                    local h = plr.Character.HumanoidRootPart
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end

        -- AUTO STATS (tudo em melee e defesa)
        if autoStats then
            pcall(function()
                local points = plr.Data.Points.Value
                if points >= 3 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Melee",math.floor(points/2))
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Defense",math.ceil(points/2))
                end
            end)
        end

        -- AUTO QUEST e FARM
        if autoFarm or autoQuest then
            local level = plr.Data.Level.Value
            local quest, mob, mobPos
            -- (exemplo, só funciona para 1st sea, você pode adaptar para outros)
            if level < 10 then
                quest = "BanditQuest1"; mob = "Bandit"; mobPos = Vector3.new(1142, 17, 1636)
            elseif level < 30 then
                quest = "MonkeyQuest"; mob = "Monkey"; mobPos = Vector3.new(-1601, 30, 155)
            elseif level < 60 then
                quest = "GorillaQuest"; mob = "Gorilla"; mobPos = Vector3.new(-1246, 6, -507)
            elseif level < 100 then
                quest = "PirateQuest1"; mob = "Pirate"; mobPos = Vector3.new(-1114, 13, 3930)
            else
                quest = "BruteQuest"; mob = "Brute"; mobPos = Vector3.new(-1140, 15, 4350)
            end
            if autoQuest then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Quest",quest,1)
                end)
            end
            if autoFarm then
                -- teleporta até mob
                if mob and mobPos then
                    local mobs = ws.Enemies:GetChildren()
                    for _,enemy in pairs(mobs) do
                        if enemy.Name == mob and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                            plr.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0,4,0)
                            wait(.2)
                            -- Ataca (simula click)
                            pcall(function()
                                for _,v in pairs(plr.Backpack:GetChildren()) do
                                    if v:IsA("Tool") and v:FindFirstChild("RemoteFunction") then
                                        v.RemoteFunction:InvokeServer("Swing")
                                    end
                                end
                                for _,v in pairs(plr.Character:GetChildren()) do
                                    if v:IsA("Tool") and v:FindFirstChild("RemoteFunction") then
                                        v.RemoteFunction:InvokeServer("Swing")
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end

        -- SPEED HACK
        if speedHack and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = 120
        elseif plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = 16
        end

    end
end)

-- AUTO GUN LOGIC (EXECUTA PERIODICAMENTE SE ATIVADO)
spawn(function()
    while wait(6) do
        if autoGun then
            -- Tenta pelo Remote (se aberto)
            local guns = {"Remington 870", "M9", "AK-47"}
            local handler = Replicated:FindFirstChild("ItemHandler")
            if handler and handler:IsA("RemoteFunction") then
                for _,gun in ipairs(guns) do
                    pcall(function()
                        handler:InvokeServer(gun)
                        wait(0.1)
                    end)
                end
                wait(.4)
            end
            -- Tenta touch físico
            local gunParts = {
                Workspace.Prison_ITEMS.giver:FindFirstChild("Remington 870"),
                Workspace.Prison_ITEMS.giver:FindFirstChild("M9"),
                Workspace.Prison_ITEMS.giver:FindFirstChild("AK-47"),
            }
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local oldPos = char.HumanoidRootPart.CFrame
                for _,part in ipairs(gunParts) do
                    if part and part:FindFirstChild("ITEMPICKUP") then
                        char.HumanoidRootPart.CFrame = CFrame.new(part.ITEMPICKUP.Position + Vector3.new(0,2,0))
                        wait(0.25)
                        firetouchinterest(char.HumanoidRootPart, part.ITEMPICKUP, 0)
                        wait(0.15)
                        firetouchinterest(char.HumanoidRootPart, part.ITEMPICKUP, 1)
                        wait(0.15)
                    end
                end
                char.HumanoidRootPart.CFrame = oldPos
            end
        end
    end
end)

-- BOTÕES
btnNome.MouseButton1Click:Connect(function()
    showNome = not showNome
    btnNome.Text = "ESP Nome: " .. (showNome and "ON" or "OFF")
end)
btnCaixa.MouseButton1Click:Connect(function()
    showCaixa = not showCaixa
    btnCaixa.Text = "ESP Caixa: " .. (showCaixa and "ON" or "OFF")
end)
btnLinha.MouseButton1Click:Connect(function()
    showLinha = not showLinha
    btnLinha.Text = "ESP Linha: " .. (showLinha and "ON" or "OFF")
end)
btnTeam.MouseButton1Click:Connect(function()
    teamCheck = not teamCheck
    btnTeam.Text = "Team Check: " .. (teamCheck and "ON" or "OFF")
end)
btnAutoKill.MouseButton1Click:Connect(function()
    autoKill = not autoKill
    btnAutoKill.Text = "Auto Kill: " .. (autoKill and "ON" or "OFF")
end)
btnAutoArrest.MouseButton1Click:Connect(function()
    autoArrest = not autoArrest
    btnAutoArrest.Text = "Auto Arrest: " .. (autoArrest and "ON" or "OFF")
end)
btnAutoGun.MouseButton1Click:Connect(function()
    autoGun = not autoGun
    btnAutoGun.Text = "Auto Gun: " .. (autoGun and "ON" or "OFF")
end)

Players.PlayerRemoving:Connect(function(plr)
    removeDrawingESP(plr)
end)
