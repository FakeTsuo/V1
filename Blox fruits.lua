--[[
    Blox Fruits Auto Farm Script - Mesclado (Primeiro, Segundo e Terceiro Mar)
    Inclui: Nome da Missão, NPC, CFrame, Nome da Ilha, Nome do Monstro
    Script educacional!
]]

local Quests = {
    -- FORMATO:
    --[nivel] = {
    --      sea = <1/2/3>,
    --      questName = "Nome da Missão",
    --      npcName = "Nome do NPC",
    --      npcCFrame = CFrame.new(x, y, z),
    --      islandName = "Nome da Ilha",
    --      monsterName = "Nome do Monstro",
    --      monsterCFrame = CFrame.new(x, y, z)
    -- }
    -- ===== PRIMEIRO MAR =====
    [1] = {sea=1, questName="BanditQuest1", npcName="Bandit Quest Giver", npcCFrame=CFrame.new(1060,16,1548), islandName="Starter Island", monsterName="Bandit", monsterCFrame=CFrame.new(1199,52,1536)},
    [15] = {sea=1, questName="MonkeyQuest", npcName="Adventurer", npcCFrame=CFrame.new(-1603,36,153), islandName="Jungle", monsterName="Monkey", monsterCFrame=CFrame.new(-1462,39,110)},
    [20] = {sea=1, questName="GorillaQuest", npcName="Adventurer", npcCFrame=CFrame.new(-1603,36,153), islandName="Jungle", monsterName="Gorilla", monsterCFrame=CFrame.new(-1328,62,-530)},
    [30] = {sea=1, questName="BuggyQuest1", npcName="Pirate Quest Giver", npcCFrame=CFrame.new(-1140,5,3827), islandName="Pirate Village", monsterName="Pirate", monsterCFrame=CFrame.new(-1122,5,3936)},
    [40] = {sea=1, questName="BuggyQuest2", npcName="Pirate Quest Giver", npcCFrame=CFrame.new(-1140,5,3827), islandName="Pirate Village", monsterName="Brute", monsterCFrame=CFrame.new(-1215,5,4337)},
    [60] = {sea=1, questName="DesertQuest1", npcName="Desert Adventurer", npcCFrame=CFrame.new(932,7,4484), islandName="Desert", monsterName="Desert Bandit", monsterCFrame=CFrame.new(932,7,4484)},
    [75] = {sea=1, questName="DesertQuest2", npcName="Desert Adventurer", npcCFrame=CFrame.new(932,7,4484), islandName="Desert", monsterName="Desert Officer", monsterCFrame=CFrame.new(1572,10,4410)},
    [90] = {sea=1, questName="SnowQuest1", npcName="Snow Quest Giver", npcCFrame=CFrame.new(1387,87,-1295), islandName="Frozen Village", monsterName="Snow Bandit", monsterCFrame=CFrame.new(1347,88,-1379)},
    [105] = {sea=1, questName="SnowQuest2", npcName="Snow Quest Giver", npcCFrame=CFrame.new(1387,87,-1295), islandName="Frozen Village", monsterName="Snowman", monsterCFrame=CFrame.new(1175,90,-1449)},
    [120] = {sea=1, questName="MarineQuest2", npcName="Marine Leader", npcCFrame=CFrame.new(-4505,20,4260), islandName="Marine Fortress", monsterName="Petty Officer", monsterCFrame=CFrame.new(-4855,22,4328)},
    [130] = {sea=1, questName="SkyQuest1", npcName="TheMole", npcCFrame=CFrame.new(-4842,718,-2625), islandName="Skylands", monsterName="Sky Bandit", monsterCFrame=CFrame.new(-4956,295,-2900)},
    [145] = {sea=1, questName="SkyQuest2", npcName="TheMole", npcCFrame=CFrame.new(-4842,718,-2625), islandName="Skylands", monsterName="Dark Master", monsterCFrame=CFrame.new(-5253,389,-2272)},
    [150] = {sea=1, questName="PrisonerQuest1", npcName="Prisoner Quest Giver", npcCFrame=CFrame.new(5305,2,474), islandName="Prison", monsterName="Prisoner", monsterCFrame=CFrame.new(5206,96,604)},
    [190] = {sea=1, questName="MagmaQuest1", npcName="Magma Admiral", npcCFrame=CFrame.new(-5328,16,-5296), islandName="Magma Village", monsterName="Military Soldier", monsterCFrame=CFrame.new(-5398,76,-5895)},
    [200] = {sea=1, questName="MagmaQuest2", npcName="Magma Admiral", npcCFrame=CFrame.new(-5328,16,-5296), islandName="Magma Village", monsterName="Military Spy", monsterCFrame=CFrame.new(-5786,76,-5837)},
    [225] = {sea=1, questName="FishmanQuest1", npcName="Fishman Quest Giver", npcCFrame=CFrame.new(61122,19,1569), islandName="Underwater City", monsterName="Fishman Warrior", monsterCFrame=CFrame.new(60922,19,1546)},
    [250] = {sea=1, questName="FishmanQuest2", npcName="Fishman Quest Giver", npcCFrame=CFrame.new(61122,19,1569), islandName="Underwater City", monsterName="Fishman Commando", monsterCFrame=CFrame.new(61872,19,1496)},
    [300] = {sea=1, questName="SkyExp1Quest", npcName="God's Guard Quest Giver", npcCFrame=CFrame.new(-7895,5546,-380), islandName="Upper Skylands", monsterName="God's Guard", monsterCFrame=CFrame.new(-7855,5636,-524)},
    -- ===== SEGUNDO MAR =====
    [700] = {sea=2, questName="Area1Quest1", npcName="Raider Quest Giver", npcCFrame=CFrame.new(-429,5606,238), islandName="Kingdom of Rose", monsterName="Raider", monsterCFrame=CFrame.new(-746,5606,273)},
    [725] = {sea=2, questName="Area1Quest2", npcName="Raider Quest Giver", npcCFrame=CFrame.new(-429,5606,238), islandName="Kingdom of Rose", monsterName="Mercenary", monsterCFrame=CFrame.new(-874,5606,395)},
    [775] = {sea=2, questName="Area2Quest1", npcName="Swan Pirate Quest Giver", npcCFrame=CFrame.new(634,873,384), islandName="Kingdom of Rose", monsterName="Swan Pirate", monsterCFrame=CFrame.new(877,1227,230)},
    [800] = {sea=2, questName="Area2Quest2", npcName="Swan Pirate Quest Giver", npcCFrame=CFrame.new(634,873,384), islandName="Kingdom of Rose", monsterName="Factory Staff", monsterCFrame=CFrame.new(295,73,-56)},
    [850] = {sea=2, questName="MarineQuest3", npcName="Marine Quest Giver", npcCFrame=CFrame.new(-2440,73,-3217), islandName="Green Zone", monsterName="Marine Lieutenant", monsterCFrame=CFrame.new(-2440,73,-3217)},
    [925] = {sea=2, questName="GorillaQuest", npcName="Kong Quest Giver", npcCFrame=CFrame.new(-1329,331,490), islandName="Green Zone", monsterName="Kong", monsterCFrame=CFrame.new(-1329,331,490)},
    [1000] = {sea=2, questName="ZombieQuest1", npcName="Zombie Quest Giver", npcCFrame=CFrame.new(-5536,342,8445), islandName="Haunted Castle", monsterName="Zombie", monsterCFrame=CFrame.new(-5536,342,8445)},
    [1100] = {sea=2, questName="ShipEngineerQuest", npcName="Ship Engineer", npcCFrame=CFrame.new(-6524,8,-132), islandName="Hot and Cold", monsterName="Lab Subordinate", monsterCFrame=CFrame.new(-5788,16,-154)},
    -- ===== TERCEIRO MAR =====
    [1500] = {sea=3, questName="PiratePortQuest", npcName="Pirate Port Quest Giver", npcCFrame=CFrame.new(-287,44,5576), islandName="Pirate Port", monsterName="Pirate Millionaire", monsterCFrame=CFrame.new(-217,44,5785)},
    [1575] = {sea=3, questName="GreatTreeQuest", npcName="Great Tree Quest Giver", npcCFrame=CFrame.new(2347,25,-6458), islandName="Great Tree", monsterName="Marine Commodore", monsterCFrame=CFrame.new(2445,25,-6700)},
    [1700] = {sea=3, questName="CastleQuest", npcName="Castle Quest Giver", npcCFrame=CFrame.new(-5488,313,8477), islandName="Haunted Castle", monsterName="Reborn Skeleton", monsterCFrame=CFrame.new(-5398,313,8789)},
    [1800] = {sea=3, questName="HydraIslandQuest", npcName="Hydra Island Quest Giver", npcCFrame=CFrame.new(5225,604,345), islandName="Hydra Island", monsterName="Island Empress", monsterCFrame=CFrame.new(5690,611,244)},
    [1975] = {sea=3, questName="FloatingTurtleQuest", npcName="Floating Turtle Quest Giver", npcCFrame=CFrame.new(-10579,331, -8752), islandName="Floating Turtle", monsterName="Fishman Raider", monsterCFrame=CFrame.new(-10994,331,-8945)},
    [2075] = {sea=3, questName="MansionQuest", npcName="Mansion Quest Giver", npcCFrame=CFrame.new(-12495,332,3742), islandName="Mansion", monsterName="Forest Pirate", monsterCFrame=CFrame.new(-13003,332,4022)},
    -- Adicione mais quests conforme necessário!
}

local Islands = {
    [1] = {
        ["Starter Island"] = CFrame.new(1050, 16, 1547),
        ["Jungle"] = CFrame.new(-1601, 36, 153),
        ["Pirate Village"] = CFrame.new(-1140, 5, 3827),
        ["Desert"] = CFrame.new(932, 7, 4484),
        ["Frozen Village"] = CFrame.new(1387, 87, -1295),
        ["Marine Fortress"] = CFrame.new(-4505, 20, 4260),
        ["Skylands"] = CFrame.new(-4842, 718, -2625),
        ["Prison"] = CFrame.new(5305, 2, 474),
        ["Magma Village"] = CFrame.new(-5328, 16, -5296),
        ["Underwater City"] = CFrame.new(61122, 19, 1569),
        ["Upper Skylands"] = CFrame.new(-7895,5546,-380),
    },
    [2] = {
        ["Kingdom of Rose"] = CFrame.new(-429,5606,238),
        ["Green Zone"] = CFrame.new(-2440,73,-3217),
        ["Haunted Castle"] = CFrame.new(-5536,342,8445),
        ["Hot and Cold"] = CFrame.new(-5788,16,-154),
        -- Adicione mais ilhas do Segundo Mar
    },
    [3] = {
        ["Pirate Port"] = CFrame.new(-287,44,5576),
        ["Great Tree"] = CFrame.new(2347,25,-6458),
        ["Haunted Castle"] = CFrame.new(-5488,313,8477),
        ["Hydra Island"] = CFrame.new(5225,604,345),
        ["Floating Turtle"] = CFrame.new(-10579,331, -8752),
        ["Mansion"] = CFrame.new(-12495,332,3742),
        -- Adicione mais ilhas do Terceiro Mar
    }
}

-- Resto do script do Auto Farm...

-- GUI Setup (igual ao exemplo anterior)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoFarmBloxFruits"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(90, 0, 130)
MainFrame.BackgroundTransparency = 0.35
MainFrame.BorderSizePixel = 0

-- Floating Icon
local Icon = Instance.new("Frame", ScreenGui)
Icon.Size = UDim2.new(0, 50, 0, 50)
Icon.Position = UDim2.new(0.05, 0, 0.05, 0)
Icon.BackgroundColor3 = Color3.fromRGB(90, 0, 130)
Icon.BackgroundTransparency = 0.5
Icon.BorderSizePixel = 0

-- Spinner para armas
local WeaponTypes = {"Melee", "Sword", "Gun", "Blox Fruit"}
local SelectedWeapon = WeaponTypes[1]
local WeaponDrop = Instance.new("TextButton", MainFrame)
WeaponDrop.Size = UDim2.new(0, 150, 0, 30)
WeaponDrop.Position = UDim2.new(0, 10, 0, 10)
WeaponDrop.BackgroundColor3 = Color3.new(0.2, 0.1, 0.2)
WeaponDrop.Text = "Arma: " .. SelectedWeapon
WeaponDrop.MouseButton1Click:Connect(function()
    local idx = table.find(WeaponTypes, SelectedWeapon)
    SelectedWeapon = WeaponTypes[(idx % #WeaponTypes) + 1]
    WeaponDrop.Text = "Arma: " .. SelectedWeapon
end)

-- Dropdown de ilhas
local Sea = 1 -- O mar atual do jogador (ajuste automaticamente baseado na posição do jogador, se quiser)
local IslandDrop = Instance.new("TextButton", MainFrame)
IslandDrop.Size = UDim2.new(0, 150, 0, 30)
IslandDrop.Position = UDim2.new(0, 10, 0, 50)
IslandDrop.BackgroundColor3 = Color3.new(0.2, 0.1, 0.2)
IslandDrop.Text = "Teleporte Ilha"
IslandDrop.MouseButton1Click:Connect(function()
    -- Exemplo: teleporta para Starter Island no Mar 1
    local cf = Islands[Sea]["Starter Island"]
    if cf then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf + Vector3.new(0, 5, 0)
    end
end)

-- Auto Farm Toggle
local AutoFarm = false
local FarmButton = Instance.new("TextButton", MainFrame)
FarmButton.Size = UDim2.new(0, 150, 0, 30)
FarmButton.Position = UDim2.new(0, 10, 0, 90)
FarmButton.BackgroundColor3 = Color3.new(0.3, 0.1, 0.3)
FarmButton.Text = "Auto Farm: OFF"
FarmButton.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    FarmButton.Text = "Auto Farm: "..(AutoFarm and "ON" or "OFF")
end)

-- Função de Aceitar Missão e Farmar
function GetQuestForLevel(level)
    local selected
    for minLevel, quest in pairs(Quests) do
        if level >= minLevel then selected = quest end
    end
    return selected
end

function FastClick()
    -- Simula clique rápido (ajuste conforme o executor usado)
    mouse1click()
end

spawn(function()
    while wait(1) do
        if AutoFarm then
            local plr = game.Players.LocalPlayer
            local level = plr.Data.Level.Value
            local quest = GetQuestForLevel(level)
            if quest then
                Sea = quest.sea
                -- Teleporta até NPC da missão
                plr.Character.HumanoidRootPart.CFrame = quest.npcCFrame + Vector3.new(0,5,0)
                wait(1)
                -- Aceita a missão
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", quest.questName, 1)
                wait(1)
                -- Voa até os monstros da quest
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob.Name == quest.monsterName and mob.Humanoid.Health > 0 then
                        repeat
                            plr.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,10,0)
                            wait(0.2)
                            FastClick()
                        until mob.Humanoid.Health <= 0 or not AutoFarm
                    end
                end
            end
        end
    end
end)

-- ESP Frutas
spawn(function()
    while wait(2) do
        for _, fruit in pairs(workspace:GetChildren()) do
            if fruit:IsA("Tool") and string.find(fruit.Name, "Fruit") then
                if not fruit:FindFirstChild("FruitESP") then
                    local bill = Instance.new("BillboardGui", fruit)
                    bill.Name = "FruitESP"
                    bill.Size = UDim2.new(0,100,0,50)
                    bill.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bill)
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.Text = fruit.Name.." | Ilha: (descobrir)"
                    txt.TextColor3 = Color3.fromRGB(255, 0, 0)
                    txt.BackgroundTransparency = 1
                end
            end
        end
    end
end)

-- ESP Jogadores
spawn(function()
    while wait(1) do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                if not v.Character.Head:FindFirstChild("PlayerESP") then
                    local bill = Instance.new("BillboardGui", v.Character.Head)
                    bill.Name = "PlayerESP"
                    bill.Size = UDim2.new(0,150,0,50)
                    bill.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bill)
                    txt.Size = UDim2.new(1,0,1,0)
                    local dist = math.floor((v.Character.Head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude)
                    local hp = v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChildOfClass("Humanoid").Health or 0
                    txt.Text = v.Name.." | Vida: ["..math.floor(hp).."] | Dist: "..dist
                    txt.TextColor3 = Color3.new(1,1,1)
                    txt.BackgroundTransparency = 1
                end
            end
        end
    end
end)

-- Teleporte de Mar
local TeleportSea = function(sea)
    -- Teleporta para a primeira ilha do mar escolhido
    local cf = next(Islands[sea])
    if cf then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Islands[sea][cf] + Vector3.new(0,5,0)
    end
end

-- Adapte/expanda conforme desejar!
