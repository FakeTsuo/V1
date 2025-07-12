--[[
    Blox Fruits Mobile OP Script com Custom Hub GUI Estilizada (inspirada, não idêntica ao Tsuo Hub)
    Todas funções organizadas em suas tabs!
    Use por sua conta e risco!
--]]

-- Tema e configurações
local Theme = {
    MainColor = Color3.fromRGB(40, 40, 80),
    AccentColor = Color3.fromRGB(70, 180, 255),
    ButtonColor = Color3.fromRGB(30, 160, 110),
    ButtonTextColor = Color3.fromRGB(255,255,255),
    TabColor = Color3.fromRGB(20, 20, 60),
    TabTextColor = Color3.fromRGB(200, 200, 230),
    BorderRadius = UDim.new(0,12),
    ShadowColor = Color3.fromRGB(0,0,0),
}

-- Remove GUIs antigos
if game.CoreGui:FindFirstChild("CustomHub") then
    game.CoreGui.CustomHub:Destroy()
end

-- GUI base
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "CustomHub"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 340, 0, 420)
Main.Position = UDim2.new(0.5, -170, 0.5, -210)
Main.BackgroundColor3 = Theme.MainColor
Main.BorderSizePixel = 0
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = Theme.BorderRadius

local DropShadow = Instance.new("ImageLabel", Main)
DropShadow.Image = "rbxassetid://1316045217"
DropShadow.Size = UDim2.new(1,28,1,28)
DropShadow.Position = UDim2.new(0,-14,0,-14)
DropShadow.BackgroundTransparency = 1
DropShadow.ImageTransparency = 0.6
DropShadow.ZIndex = 0
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(10,10,118,118)
DropShadow.ImageColor3 = Theme.ShadowColor

-- Título estilizado
local Title = Instance.new("TextLabel", Main)
Title.Text = "Custom Hub"
Title.Size = UDim2.new(1,0,0,44)
Title.BackgroundTransparency = 1
Title.TextColor3 = Theme.AccentColor
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26
Title.TextStrokeTransparency = 0.7
Title.TextXAlignment = Enum.TextXAlignment.Center

local Line = Instance.new("Frame", Main)
Line.BackgroundColor3 = Theme.AccentColor
Line.Size = UDim2.new(1, -32, 0, 2)
Line.Position = UDim2.new(0, 16, 0, 44)

-- Tabs
local TabBar = Instance.new("Frame", Main)
TabBar.BackgroundColor3 = Theme.TabColor
TabBar.Size = UDim2.new(1, -32, 0, 38)
TabBar.Position = UDim2.new(0,16,0,52)
TabBar.BorderSizePixel = 0
local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0,8)

-- Função de criar Tabs
local Tabs = {}
local function CreateTab(tabname)
    local btn = Instance.new("TextButton", TabBar)
    btn.Text = tabname
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.BackgroundColor3 = Theme.TabColor
    btn.TextColor3 = Theme.TabTextColor
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false

    local tabFrame = Instance.new("Frame", Main)
    tabFrame.Size = UDim2.new(1, -32, 1, -102)
    tabFrame.Position = UDim2.new(0,16,0,100)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false

    Tabs[tabname] = {Button = btn, Frame = tabFrame}
end

-- Criando as Tabs
CreateTab("Farming")
CreateTab("Player")
CreateTab("Teleports")
CreateTab("Visual")

-- Função de trocar tab (com animação simples)
local currentTab = nil
local TweenService = game:GetService("TweenService")
local function SwitchTab(tabname)
    for name, v in pairs(Tabs) do
        v.Frame.Visible = false
        v.Button.BackgroundColor3 = Theme.TabColor
        v.Button.TextColor3 = Theme.TabTextColor
    end
    local tab = Tabs[tabname]
    tab.Frame.Visible = true
    TweenService:Create(tab.Button,TweenInfo.new(0.2),{BackgroundColor3=Theme.AccentColor,TextColor3=Theme.MainColor}):Play()
    currentTab = tabname
end

-- Botões das Tabs
for name, v in pairs(Tabs) do
    v.Button.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)
end

-- Abre primeira tab
SwitchTab("Farming")

-------------------------------
-- Funções OP para Blox Fruits
-------------------------------

-- Variáveis globais
_G.AutoFarm = false
_G.FruitSniper = false

-- Função de Auto Farm (Farme automático de inimigos)
function AutoFarm()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character.Humanoid
    while _G.AutoFarm do
        for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                repeat
                    humanoid:MoveTo(v.HumanoidRootPart.Position)
                    wait(0.2)
                    -- Ataque
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                    wait(0.2)
                until v.Humanoid.Health <= 0 or not _G.AutoFarm
            end
        end
        wait(1)
    end
end

-- Função de Auto Coletar Frutas (Fruit Sniper)
function AutoFruitSniper()
    while _G.FruitSniper do
        for i, v in pairs(game.Workspace:GetChildren()) do
            if v.Name == "Fruit" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                wait(0.2)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
        wait(1)
    end
end

-- Função de Teleporte
function TeleportTo(Position)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
end

-- God Mode (invencível contra NPCs simples)
function GodMode()
    local player = game.Players.LocalPlayer
    player.Character.Humanoid.Name = "GodHumanoid"
end

-- Speed Hack
function SetSpeed(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end

-- Super Jump
function SetJumpPower(value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end

-------------------------------
-- Conteúdo das Tabs
-------------------------------

-- Tab FARMING (Auto Farm & Fruit Sniper)
local FarmLabel = Instance.new("TextLabel", Tabs["Farming"].Frame)
FarmLabel.Text = "Funções de Farming"
FarmLabel.Size = UDim2.new(1,0,0,36)
FarmLabel.Position = UDim2.new(0,0,0,8)
FarmLabel.BackgroundTransparency = 1
FarmLabel.TextColor3 = Theme.AccentColor
FarmLabel.Font = Enum.Font.GothamBold
FarmLabel.TextSize = 22
FarmLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Auto Farm
local FarmBtn = Instance.new("TextButton", Tabs["Farming"].Frame)
FarmBtn.Text = "Ativar Auto Farm"
FarmBtn.Size = UDim2.new(0,180,0,36)
FarmBtn.Position = UDim2.new(0,10,0,50)
FarmBtn.BackgroundColor3 = Theme.ButtonColor
FarmBtn.TextColor3 = Theme.ButtonTextColor
FarmBtn.Font = Enum.Font.GothamSemibold
FarmBtn.TextSize = 18
FarmBtn.BorderSizePixel = 0
local btnCorner1 = Instance.new("UICorner", FarmBtn)
btnCorner1.CornerRadius = Theme.BorderRadius

FarmBtn.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    if _G.AutoFarm then
        FarmBtn.Text = "Parar Auto Farm"
        FarmBtn.BackgroundColor3 = Theme.AccentColor
        spawn(AutoFarm)
    else
        FarmBtn.Text = "Ativar Auto Farm"
        FarmBtn.BackgroundColor3 = Theme.ButtonColor
    end
end)

-- Botão Fruit Sniper
local FruitBtn = Instance.new("TextButton", Tabs["Farming"].Frame)
FruitBtn.Text = "Ativar Fruit Sniper"
FruitBtn.Size = UDim2.new(0,180,0,36)
FruitBtn.Position = UDim2.new(0,10,0,100)
FruitBtn.BackgroundColor3 = Theme.ButtonColor
FruitBtn.TextColor3 = Theme.ButtonTextColor
FruitBtn.Font = Enum.Font.GothamSemibold
FruitBtn.TextSize = 18
FruitBtn.BorderSizePixel = 0
local btnCorner2 = Instance.new("UICorner", FruitBtn)
btnCorner2.CornerRadius = Theme.BorderRadius

FruitBtn.MouseButton1Click:Connect(function()
    _G.FruitSniper = not _G.FruitSniper
    if _G.FruitSniper then
        FruitBtn.Text = "Parar Fruit Sniper"
        FruitBtn.BackgroundColor3 = Theme.AccentColor
        spawn(AutoFruitSniper)
    else
        FruitBtn.Text = "Ativar Fruit Sniper"
        FruitBtn.BackgroundColor3 = Theme.ButtonColor
    end
end)

-- Tab PLAYER (GodMode, Speed, Jump)
local PlayerLabel = Instance.new("TextLabel", Tabs["Player"].Frame)
PlayerLabel.Text = "Funções de Player"
PlayerLabel.Size = UDim2.new(1,0,0,36)
PlayerLabel.Position = UDim2.new(0,0,0,8)
PlayerLabel.BackgroundTransparency = 1
PlayerLabel.TextColor3 = Theme.AccentColor
PlayerLabel.Font = Enum.Font.GothamBold
PlayerLabel.TextSize = 22
PlayerLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Botão God Mode
local GodBtn = Instance.new("TextButton", Tabs["Player"].Frame)
GodBtn.Text = "Ativar GodMode"
GodBtn.Size = UDim2.new(0,140,0,36)
GodBtn.Position = UDim2.new(0,10,0,50)
GodBtn.BackgroundColor3 = Theme.ButtonColor
GodBtn.TextColor3 = Theme.ButtonTextColor
GodBtn.Font = Enum.Font.GothamSemibold
GodBtn.TextSize = 18
GodBtn.BorderSizePixel = 0
local btnCorner3 = Instance.new("UICorner", GodBtn)
btnCorner3.CornerRadius = Theme.BorderRadius

GodBtn.MouseButton1Click:Connect(function()
    GodMode()
    GodBtn.Text = "GodMode ON"
    GodBtn.BackgroundColor3 = Theme.AccentColor
    wait(2)
    GodBtn.Text = "Ativar GodMode"
    GodBtn.BackgroundColor3 = Theme.ButtonColor
end)

-- Botão Speed Hack
local SpeedBtn = Instance.new("TextButton", Tabs["Player"].Frame)
SpeedBtn.Text = "Speed x3"
SpeedBtn.Size = UDim2.new(0,120,0,36)
SpeedBtn.Position = UDim2.new(0,160,0,50)
SpeedBtn.BackgroundColor3 = Theme.ButtonColor
SpeedBtn.TextColor3 = Theme.ButtonTextColor
SpeedBtn.Font = Enum.Font.GothamSemibold
SpeedBtn.TextSize = 18
SpeedBtn.BorderSizePixel = 0
local btnCorner4 = Instance.new("UICorner", SpeedBtn)
btnCorner4.CornerRadius = Theme.BorderRadius

SpeedBtn.MouseButton1Click:Connect(function()
    SetSpeed(48)
    SpeedBtn.Text = "Speed ON"
    SpeedBtn.BackgroundColor3 = Theme.AccentColor
    wait(2)
    SpeedBtn.Text = "Speed x3"
    SpeedBtn.BackgroundColor3 = Theme.ButtonColor
end)

-- Botão Super Jump
local JumpBtn = Instance.new("TextButton", Tabs["Player"].Frame)
JumpBtn.Text = "Super Jump"
JumpBtn.Size = UDim2.new(0,120,0,36)
JumpBtn.Position = UDim2.new(0,10,0,100)
JumpBtn.BackgroundColor3 = Theme.ButtonColor
JumpBtn.TextColor3 = Theme.ButtonTextColor
JumpBtn.Font = Enum.Font.GothamSemibold
JumpBtn.TextSize = 18
JumpBtn.BorderSizePixel = 0
local btnCorner5 = Instance.new("UICorner", JumpBtn)
btnCorner5.CornerRadius = Theme.BorderRadius

JumpBtn.MouseButton1Click:Connect(function()
    SetJumpPower(200)
    JumpBtn.Text = "Jump ON"
    JumpBtn.BackgroundColor3 = Theme.AccentColor
    wait(2)
    JumpBtn.Text = "Super Jump"
    JumpBtn.BackgroundColor3 = Theme.ButtonColor
end)

-- Tab TELEPORTS (Teleporte Personalizado)
local TeleportLabel = Instance.new("TextLabel", Tabs["Teleports"].Frame)
TeleportLabel.Text = "Teleporte Rápido"
TeleportLabel.Size = UDim2.new(1,0,0,36)
TeleportLabel.Position = UDim2.new(0,0,0,8)
TeleportLabel.BackgroundTransparency = 1
TeleportLabel.TextColor3 = Theme.AccentColor
TeleportLabel.Font = Enum.Font.GothamBold
TeleportLabel.TextSize = 22
TeleportLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Exemplo de teleporte para locais populares (adicione mais caso deseje)
local Locais = {
    {"Start Island", Vector3.new(1061, 17, 1427)},
    {"Jungle", Vector3.new(-1217, 11, 341)},
    {"Marine", Vector3.new(-2602, 40, 2000)},
    {"Desert", Vector3.new(1158, 41, 4350)},
}

local y = 50
for _, data in ipairs(Locais) do
    local btn = Instance.new("TextButton", Tabs["Teleports"].Frame)
    btn.Text = data[1]
    btn.Size = UDim2.new(0,170,0,36)
    btn.Position = UDim2.new(0,10,0,y)
    btn.BackgroundColor3 = Theme.ButtonColor
    btn.TextColor3 = Theme.ButtonTextColor
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.BorderSizePixel = 0
    local bcorner = Instance.new("UICorner", btn)
    bcorner.CornerRadius = Theme.BorderRadius
    btn.MouseButton1Click:Connect(function()
        TeleportTo(data[2])
        btn.Text = "Teleportado!"
        btn.BackgroundColor3 = Theme.AccentColor
        wait(1)
        btn.Text = data[1]
        btn.BackgroundColor3 = Theme.ButtonColor
    end)
    y = y + 46
end

-- Tab VISUAL (decorativa ou para futuras funções)
local VisualLabel = Instance.new("TextLabel", Tabs["Visual"].Frame)
VisualLabel.Text = "Custom Hub Visual"
VisualLabel.Size = UDim2.new(1,0,0,36)
VisualLabel.Position = UDim2.new(0,0,0,8)
VisualLabel.BackgroundTransparency = 1
VisualLabel.TextColor3 = Theme.AccentColor
VisualLabel.Font = Enum.Font.GothamBold
VisualLabel.TextSize = 22
VisualLabel.TextXAlignment = Enum.TextXAlignment.Left

local Info = Instance.new("TextLabel", Tabs["Visual"].Frame)
Info.Text = "GUI inspirada em Tsuo Hub\nPersonalize aqui efeitos visuais ou informações!"
Info.Size = UDim2.new(1,-20,0,60)
Info.Position = UDim2.new(0,10,0,50)
Info.BackgroundTransparency = 1
Info.TextColor3 = Theme.TabTextColor
Info.Font = Enum.Font.Gotham
Info.TextSize = 16
Info.TextXAlignment = Enum.TextXAlignment.Left

-------------------------------
-- Fechar GUI
-------------------------------
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Text = "×"
CloseBtn.Size = UDim2.new(0,32,0,32)
CloseBtn.Position = UDim2.new(1,-44,0,12)
CloseBtn.BackgroundColor3 = Theme.AccentColor
CloseBtn.TextColor3 = Theme.MainColor
CloseBtn.Font = Enum.Font.GothamBlack
CloseBtn.TextSize = 28
CloseBtn.BorderSizePixel = 0
local closeCorner = Instance.new("UICorner", CloseBtn)
closeCorner.CornerRadius = UDim.new(1,0)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- [ Fim do Script. ]
