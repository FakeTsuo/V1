-- Blox Fruits Mobile GUI Script
-- Criado para uso local no Roblox

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar a GUI Principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxFruitsGUI"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Ícone Flutuante
local floatingIcon = Instance.new("ImageButton")
floatingIcon.Name = "FloatingIcon"
floatingIcon.Size = UDim2.new(0, 60, 0, 60)
floatingIcon.Position = UDim2.new(0, 10, 0, 100)
floatingIcon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
floatingIcon.BackgroundTransparency = 0.2
floatingIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
floatingIcon.Parent = screenGui

-- Tornar o ícone arredondado
local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 30)
iconCorner.Parent = floatingIcon

-- Função para arrastar o ícone
local dragging = false
local dragStart = nil
local startPos = nil

local function updateInput(input)
    if dragging then
        local delta = input.Position - dragStart
        floatingIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                         startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

floatingIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = floatingIcon.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

floatingIcon.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or 
       input.UserInputType == Enum.UserInputType.Touch then
        updateInput(input)
    end
end)

-- GUI Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Cantos arredondados para o frame principal
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.Text = "Blox Fruits Mobile GUI"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- Botão de fechar
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

-- ScrollingFrame para os botões
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -20, 1, -60)
scrollFrame.Position = UDim2.new(0, 10, 0, 50)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
scrollFrame.Parent = mainFrame

-- UIListLayout para organizar os botões
local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = scrollFrame

-- Função para criar botões
local function createButton(text, layoutOrder, callback)
    local button = Instance.new("TextButton")
    button.Name = text
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.SourceSans
    button.LayoutOrder = layoutOrder
    button.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

-- Funções do hack
local function autoFarm()
    print("Auto Farm ativado!")
    -- Adicione aqui a lógica do auto farm
end

local function autoQuest()
    print("Auto Quest ativado!")
    -- Adicione aqui a lógica do auto quest
end

local function teleportToSpawn()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    end
end

local function speedHack()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
        print("Speed aumentado para 50!")
    end
end

local function jumpHack()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = 100
        print("Jump aumentado para 100!")
    end
end

local function infiniteJump()
    local InfiniteJumpEnabled = true
    game:GetService("UserInputService").JumpRequest:connect(function()
        if InfiniteJumpEnabled then
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
        end
    end)
    print("Infinite Jump ativado!")
end

local function noclip()
    local noclipEnabled = true
    local function enableNoclip()
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = false
            end
        end
    end
    
    RunService.Stepped:Connect(function()
        if noclipEnabled and player.Character then
            enableNoclip()
        end
    end)
    print("Noclip ativado!")
end

local function killAura()
    print("Kill Aura ativado!")
    local function attack()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = character.HumanoidRootPart
            for _, target in pairs(workspace:GetChildren()) do
                if target:FindFirstChild("Humanoid") and target ~= character then
                    local distance = (humanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude
                    if distance < 50 then
                        -- Simular ataque
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        wait(0.1)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    end
                end
            end
        end
    end
    
    spawn(function()
        while true do
            attack()
            wait(0.5)
        end
    end)
end

local function autoStats()
    print("Auto Stats ativado!")
    -- Adicione aqui a lógica para aumentar stats automaticamente
end

local function fruitNotifier()
    print("Fruit Notifier ativado!")
    -- Adicione aqui a lógica para notificar sobre frutas
end

-- Criar botões
createButton("🚀 Auto Farm", 1, autoFarm)
createButton("📋 Auto Quest", 2, autoQuest)
createButton("🏠 Teleport Spawn", 3, teleportToSpawn)
createButton("⚡ Speed Hack", 4, speedHack)
createButton("🦘 Jump Hack", 5, jumpHack)
createButton("🔄 Infinite Jump", 6, infiniteJump)
createButton("👻 Noclip", 7, noclip)
createButton("⚔️ Kill Aura", 8, killAura)
createButton("📊 Auto Stats", 9, autoStats)
createButton("🍎 Fruit Notifier", 10, fruitNotifier)

-- Atualizar tamanho do ScrollFrame
local function updateScrollFrameSize()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

listLayout.Changed:Connect(updateScrollFrameSize)
updateScrollFrameSize()

-- Eventos do ícone flutuante
floatingIcon.MouseButton1Click:Connect(function()
    if not dragging then
        mainFrame.Visible = not mainFrame.Visible
        
        if mainFrame.Visible then
            -- Animação de abertura
            mainFrame.Size = UDim2.new(0, 0, 0, 0)
            mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            
            local openTween = TweenService:Create(mainFrame, 
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 300, 0, 400), Position = UDim2.new(0.5, -150, 0.5, -200)}
            )
            openTween:Play()
        end
    end
end)

-- Evento do botão fechar
closeButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(mainFrame, 
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
    )
    closeTween:Play()
    
    closeTween.Completed:Connect(function()
        mainFrame.Visible = false
    end)
end)

-- Animação do ícone flutuante
local function animateIcon()
    local tween = TweenService:Create(floatingIcon, 
        TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Rotation = 5}
    )
    tween:Play()
end

animateIcon()

-- Notificação de carregamento
local function showNotification(text)
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 250, 0, 50)
    notificationFrame.Position = UDim2.new(0.5, -125, 0, -60)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui
    
    local notificationCorner = Instance.new("UICorner")
    notificationCorner.CornerRadius = UDim.new(0, 10)
    notificationCorner.Parent = notificationFrame
    
    local notificationLabel = Instance.new("TextLabel")
    notificationLabel.Size = UDim2.new(1, 0, 1, 0)
    notificationLabel.BackgroundTransparency = 1
    notificationLabel.Text = text
    notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationLabel.TextScaled = true
    notificationLabel.Font = Enum.Font.SourceSans
    notificationLabel.Parent = notificationFrame
    
    -- Animação da notificação
    local slideTween = TweenService:Create(notificationFrame, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, -125, 0, 10)}
    )
    slideTween:Play()
    
    wait(3)
    
    local fadeOutTween = TweenService:Create(notificationFrame, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = UDim2.new(0.5, -125, 0, -60)}
    )
    fadeOutTween:Play()
    
    fadeOutTween.Completed:Connect(function()
        notificationFrame:Destroy()
    end)
end

-- Mostrar notificação de carregamento
showNotification("Blox Fruits GUI Carregado!")

print("Blox Fruits Mobile GUI carregado com sucesso!")
