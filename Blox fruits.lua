-- Auto Farm Level Script para Blox Fruits - Versão Completa
-- Criado para mobile com GUI otimizada e funcionalidades avançadas

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variáveis principais
local autoFarmEnabled = false
local espFruitsEnabled = false
local espPlayersEnabled = false
local aimbotEnabled = false
local selectedEnemy = nil
local selectedWeaponType = "Melee"
local farmConnection = nil
local espConnections = {}
local aimbotTarget = nil

-- Configurações
local farmSettings = {
    teleportSpeed = 80,
    attackDelay = 0.1,
    safeDistance = 15,
    maxDistance = 200,
    aimbotFOV = 100,
    aimbotSmoothing = 2
}

-- Tipos de armas
local weaponTypes = {"Melee", "Sword", "Gun", "Blox Fruit"}

-- Lista de inimigos por nível
local enemyList = {
    [1] = {"Bandit", "Monkey"},
    [75] = {"Desert Bandit", "Desert Officer"},
    [150] = {"Jail Guard", "Dangerous Prisoner"},
    [225] = {"Toga Warrior", "Fishman Warrior"},
    [300] = {"Military Soldier", "Military Spy"},
    [375] = {"Magma Admiral", "Lava Pirate"},
    [450] = {"Snow Bandit", "Snowman"},
    [525] = {"Quake Pirate", "Quake Captain"},
    [625] = {"Pirate Millionaire", "Dragon Crew Warrior"},
    [700] = {"Diamond", "Jeremy"},
    [775] = {"Fajita", "Angel"},
    [850] = {"Royal Squad", "Royal Soldier"},
    [925] = {"Galley Pirate", "Galley Captain"},
    [1000] = {"Raider", "Mercenary"},
    [1075] = {"Swan Pirate", "Factory Staff"},
    [1150] = {"Marine Lieutenant", "Marine Captain"},
    [1225] = {"Zombie", "Vampire"},
    [1300] = {"Snow Lurker", "Arctic Warrior"},
    [1375] = {"Sea Soldier", "Neptune"},
    [1450] = {"Fishman Lord", "Fishman Karate"},
    [1525] = {"Shanda", "Cyborg"},
    [1575] = {"Ice Admiral", "Tide Keeper"}
}

-- Criar GUI Principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxFruitsAutoFarm"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Ícone flutuante
local floatingIcon = Instance.new("ImageButton")
floatingIcon.Name = "FloatingIcon"
floatingIcon.Size = UDim2.new(0, 60, 0, 60)
floatingIcon.Position = UDim2.new(0, 20, 0, 100)
floatingIcon.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
floatingIcon.BorderSizePixel = 0
floatingIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
floatingIcon.Parent = screenGui

-- Efeitos do ícone
local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 30)
iconCorner.Parent = floatingIcon

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(255, 255, 255)
iconStroke.Thickness = 2
iconStroke.Transparency = 0.5
iconStroke.Parent = floatingIcon

-- GUI Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 600)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "🍎 Blox Fruits Auto Farm Pro"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- Botão de fechar
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

-- ScrollingFrame para conteúdo
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -20, 1, -60)
scrollFrame.Position = UDim2.new(0, 10, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(70, 130, 180)
scrollFrame.Parent = mainFrame

-- Função para criar seção
local function createSection(title, yPosition)
    local section = Instance.new("Frame")
    section.Name = title .. "Section"
    section.Size = UDim2.new(1, -10, 0, 120)
    section.Position = UDim2.new(0, 5, 0, yPosition)
    section.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    section.BorderSizePixel = 0
    section.Parent = scrollFrame
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 8)
    sectionCorner.Parent = section
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "SectionTitle"
    sectionTitle.Size = UDim2.new(1, 0, 0, 30)
    sectionTitle.Position = UDim2.new(0, 0, 0, 0)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = title
    sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionTitle.TextScaled = true
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.Parent = section
    
    return section
end

-- Seção Auto Farm
local autoFarmSection = createSection("🎯 Auto Farm", 10)

-- Dropdown para seleção de arma
local weaponFrame = Instance.new("Frame")
weaponFrame.Name = "WeaponFrame"
weaponFrame.Size = UDim2.new(1, -10, 0, 35)
weaponFrame.Position = UDim2.new(0, 5, 0, 35)
weaponFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
weaponFrame.BorderSizePixel = 0
weaponFrame.Parent = autoFarmSection

local weaponCorner = Instance.new("UICorner")
weaponCorner.CornerRadius = UDim.new(0, 5)
weaponCorner.Parent = weaponFrame

local weaponLabel = Instance.new("TextLabel")
weaponLabel.Name = "WeaponLabel"
weaponLabel.Size = UDim2.new(0.4, 0, 1, 0)
weaponLabel.Position = UDim2.new(0, 5, 0, 0)
weaponLabel.BackgroundTransparency = 1
weaponLabel.Text = "Arma:"
weaponLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
weaponLabel.TextScaled = true
weaponLabel.Font = Enum.Font.Gotham
weaponLabel.Parent = weaponFrame

local weaponDropdown = Instance.new("TextButton")
weaponDropdown.Name = "WeaponDropdown"
weaponDropdown.Size = UDim2.new(0.55, 0, 0.8, 0)
weaponDropdown.Position = UDim2.new(0.4, 5, 0.1, 0)
weaponDropdown.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
weaponDropdown.BorderSizePixel = 0
weaponDropdown.Text = "⚔️ " .. selectedWeaponType
weaponDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
weaponDropdown.TextScaled = true
weaponDropdown.Font = Enum.Font.Gotham
weaponDropdown.Parent = weaponFrame

local weaponDropdownCorner = Instance.new("UICorner")
weaponDropdownCorner.CornerRadius = UDim.new(0, 5)
weaponDropdownCorner.Parent = weaponDropdown

-- Botão Auto Farm
local autoFarmButton = Instance.new("TextButton")
autoFarmButton.Name = "AutoFarmButton"
autoFarmButton.Size = UDim2.new(1, -10, 0, 40)
autoFarmButton.Position = UDim2.new(0, 5, 0, 75)
autoFarmButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
autoFarmButton.BorderSizePixel = 0
autoFarmButton.Text = "🎯 Iniciar Auto Farm"
autoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmButton.TextScaled = true
autoFarmButton.Font = Enum.Font.Gotham
autoFarmButton.Parent = autoFarmSection

local farmCorner = Instance.new("UICorner")
farmCorner.CornerRadius = UDim.new(0, 8)
farmCorner.Parent = autoFarmButton

-- Seção ESP
local espSection = createSection("👁️ ESP System", 140)

-- ESP Frutas
local espFruitsButton = Instance.new("TextButton")
espFruitsButton.Name = "ESPFruitsButton"
espFruitsButton.Size = UDim2.new(0.48, 0, 0, 35)
espFruitsButton.Position = UDim2.new(0, 5, 0, 35)
espFruitsButton.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
espFruitsButton.BorderSizePixel = 0
espFruitsButton.Text = "🍎 ESP Frutas"
espFruitsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espFruitsButton.TextScaled = true
espFruitsButton.Font = Enum.Font.Gotham
espFruitsButton.Parent = espSection

local espFruitsCorner = Instance.new("UICorner")
espFruitsCorner.CornerRadius = UDim.new(0, 5)
espFruitsCorner.Parent = espFruitsButton

-- ESP Players
local espPlayersButton = Instance.new("TextButton")
espPlayersButton.Name = "ESPPlayersButton"
espPlayersButton.Size = UDim2.new(0.48, 0, 0, 35)
espPlayersButton.Position = UDim2.new(0.52, 0, 0, 35)
espPlayersButton.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
espPlayersButton.BorderSizePixel = 0
espPlayersButton.Text = "👥 ESP Players"
espPlayersButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espPlayersButton.TextScaled = true
espPlayersButton.Font = Enum.Font.Gotham
espPlayersButton.Parent = espSection

local espPlayersCorner = Instance.new("UICorner")
espPlayersCorner.CornerRadius = UDim.new(0, 5)
espPlayersCorner.Parent = espPlayersButton

-- Aimbot
local aimbotButton = Instance.new("TextButton")
aimbotButton.Name = "AimbotButton"
aimbotButton.Size = UDim2.new(1, -10, 0, 35)
aimbotButton.Position = UDim2.new(0, 5, 0, 75)
aimbotButton.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
aimbotButton.BorderSizePixel = 0
aimbotButton.Text = "🎯 Aimbot"
aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotButton.TextScaled = true
aimbotButton.Font = Enum.Font.Gotham
aimbotButton.Parent = espSection

local aimbotCorner = Instance.new("UICorner")
aimbotCorner.CornerRadius = UDim.new(0, 5)
aimbotCorner.Parent = aimbotButton

-- Seção Status
local statusSection = createSection("📊 Status", 270)

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -10, 1, -35)
statusLabel.Position = UDim2.new(0, 5, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Desativado\nArma: " .. selectedWeaponType
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = statusSection

-- Ajustar tamanho do ScrollFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 400)

-- Função ESP para frutas
local function createFruitESP()
    for _, fruit in pairs(workspace:GetChildren()) do
        if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "FruitESP"
            billboardGui.Adornee = fruit.Handle
            billboardGui.Size = UDim2.new(0, 100, 0, 50)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.Parent = fruit.Handle
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = fruit.Name
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamBold
            textLabel.Parent = billboardGui
            
            table.insert(espConnections, billboardGui)
        end
    end
end

-- Função ESP para players
local function createPlayerESP()
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "PlayerESP"
            billboardGui.Adornee = otherPlayer.Character.HumanoidRootPart
            billboardGui.Size = UDim2.new(0, 100, 0, 50)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.Parent = otherPlayer.Character.HumanoidRootPart
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = otherPlayer.Name
            textLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamBold
            textLabel.Parent = billboardGui
            
            table.insert(espConnections, billboardGui)
        end
    end
end

-- Função para limpar ESP
local function clearESP()
    for _, connection in pairs(espConnections) do
        if connection and connection.Parent then
            connection:Destroy()
        end
    end
    espConnections = {}
end

-- Função Aimbot
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = otherPlayer
            end
        end
    end
    
    return closestPlayer
end

-- Função para encontrar inimigo mais próximo
local function findNearestEnemy()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local playerLevel = player.Data.Level.Value
    local nearestEnemy = nil
    local shortestDistance = math.huge
    
    local appropriateEnemies = {}
    for level, enemies in pairs(enemyList) do
        if playerLevel >= level then
            for _, enemyName in pairs(enemies) do
                table.insert(appropriateEnemies, enemyName)
            end
        end
    end
    
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
            local humanoid = enemy.Humanoid
            if humanoid.Health > 0 then
                for _, appropriateEnemy in pairs(appropriateEnemies) do
                    if string.find(enemy.Name, appropriateEnemy) then
                        local distance = (character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                        if distance < shortestDistance and distance < farmSettings.maxDistance then
                            shortestDistance = distance
                            nearestEnemy = enemy
                        end
                    end
                end
            end
        end
    end
    
    return nearestEnemy
end

-- Função para teleportar
local function teleportToEnemy(enemy)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    if not enemy or not enemy:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local enemyPosition = enemy.HumanoidRootPart.Position
    local teleportPosition = enemyPosition + Vector3.new(0, 5, 0)
    
    character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
    return true
end

-- Função para atacar com diferentes armas
local function attackWithSelectedWeapon()
    local character = player.Character
    if not character or not character:FindFirstChild("Humanoid") then
        return
    end
    
    if selectedWeaponType == "Melee" then
        -- Ataque corpo a corpo
        local humanoid = character.Humanoid
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("RemoteEvent") then
            tool.RemoteEvent:FireServer()
        end
        
    elseif selectedWeaponType == "Sword" then
        -- Ataque com espada
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and tool.ToolTip:find("Sword") then
            if tool:FindFirstChild("RemoteEvent") then
                tool.RemoteEvent:FireServer()
            end
        end
        
    elseif selectedWeaponType == "Gun" then
        -- Ataque com arma de fogo
        local tool = character:FindFirstChildOfClass("Tool")
        if tool and (tool.ToolTip:find("Gun") or tool.ToolTip:find("Rifle")) then
            if tool:FindFirstChild("RemoteEvent") then
                tool.RemoteEvent:FireServer()
            end
        end
        
    elseif selectedWeaponType == "Blox Fruit" then
        -- Usar habilidades da Blox Fruit
        local keys = {"Z", "X", "C", "V", "F"}
        for _, key in pairs(keys) do
            local args = {
                [1] = key,
                [2] = true
            }
            if game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") then
                game:GetService("ReplicatedStorage").Remotes.KeyEvent:FireServer(unpack(args))
            end
            wait(0.1)
        end
    end
end

-- Função principal de auto farm
local function autoFarm()
    if not autoFarmEnabled then
        return
    end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local nearestEnemy = findNearestEnemy()
    if nearestEnemy then
        selectedEnemy = nearestEnemy
        statusLabel.Text = "Status: Farmando " .. nearestEnemy.Name .. "\nArma: " .. selectedWeaponType
        
        if teleportToEnemy(nearestEnemy) then
            wait(0.5)
            
            while nearestEnemy and nearestEnemy.Parent and nearestEnemy.Humanoid.Health > 0 and autoFarmEnabled do
                attackWithSelectedWeapon()
                
                if not nearestEnemy or nearestEnemy.Humanoid.Health <= 0 then
                    break
                end
                
                wait(farmSettings.attackDelay)
            end
        end
    else
        statusLabel.Text = "Status: Procurando inimigos...\nArma: " .. selectedWeaponType
    end
end

-- Função para alternar auto farm
local function toggleAutoFarm()
    autoFarmEnabled = not autoFarmEnabled
    
    if autoFarmEnabled then
        autoFarmButton.Text = "🛑 Parar Auto Farm"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
        
        farmConnection = RunService.Heartbeat:Connect(function()
            if autoFarmEnabled then
                autoFarm()
            end
        end)
    else
        autoFarmButton.Text = "🎯 Iniciar Auto Farm"
        autoFarmButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        statusLabel.Text = "Status: Desativado\nArma: " .. selectedWeaponType
        
        if farmConnection then
            farmConnection:Disconnect()
            farmConnection = nil
        end
    end
end

-- Função para alternar ESP frutas
local function toggleESPFruits()
    espFruitsEnabled = not espFruitsEnabled
    
    if espFruitsEnabled then
        espFruitsButton.Text = "🍎 ESP Frutas ON"
        espFruitsButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        createFruitESP()
    else
        espFruitsButton.Text = "🍎 ESP Frutas OFF"
        espFruitsButton.BackgroundColor3 = Color3.
