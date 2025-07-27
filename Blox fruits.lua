-- Cria o botão flutuante na tela
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local originalSpeed = humanoid.WalkSpeed
local boostedSpeed = 75
local duration = 30

-- Interface
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedBoostUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 50)
button.Position = UDim2.new(0.5, -60, 0.85, 0) -- Centro inferior da tela
button.Text = "Velocidade x3"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.Parent = screenGui

-- Controle de uso
local isBoostActive = false

button.MouseButton1Click:Connect(function()
	if isBoostActive then return end
	
	isBoostActive = true
	button.Text = "Acelerando!"
	humanoid.WalkSpeed = boostedSpeed

	task.delay(duration, function()
		-- Garante que o personagem ainda exista
		if humanoid and humanoid.Parent then
			humanoid.WalkSpeed = originalSpeed
		end
		button.Text = "Velocidade x3"
		isBoostActive = false
	end)
end)
