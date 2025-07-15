local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Rayfield Example Window",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
local Tab = Window:CreateTab("Farm", 4483362458) -- Title, Image
local Dropdown = Tab:CreateDropdown({
   Name = "Weapon:",
   Options = {"Melee","Sword","Gun","Blox Fruit"},
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
   -- The function that takes place when the selected option is changed
   -- The variable (Options) is a table of strings for the current selected options
   end,
})
local Toggle = Tab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
local function getQuestPorLevel(level)
    for _,q in pairs(Quests) do
        if level >= q[1] and level <= q[2] then
            return q
        end
    end
    return nil
end

-- Função para voar até posição
local function voarAte(pos)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

-- Função para pegar quest
local function pegarQuest(questName)
    for _,npc in pairs(workspace.NPCs:GetChildren()) do
        if npc.Name == questName then
            voarAte(npc.Position)
            wait(1)
            fireclickdetector(npc.ClickDetector)
            wait(1)
        end
    end
end

-- Função para encontrar e atacar NPC
local function atacarNPC(npcName)
    local arma = game.Players.LocalPlayer.Backpack:FindFirstChild(armaSelecionada)
    if arma then
        arma.Parent = game.Players.LocalPlayer.Character
    end
    for _,npc in pairs(workspace.Enemies:GetChildren()) do
        if npc.Name == npcName and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            voarAte(npc.HumanoidRootPart.Position + Vector3.new(0,3,0))
            repeat
                npc.Humanoid.Health = npc.Humanoid.Health - 20 -- Simula dano
                arma:Activate() -- Simula clique
                wait(0.2)
            until npc.Humanoid.Health <= 0
        end
    end
end

-- Loop principal
while wait(1) do
    local level = game.Players.LocalPlayer.Data.Level.Value
    local quest = getQuestPorLevel(level)
    if quest then
        pegarQuest(quest[3])
        atacarNPC(quest[4])
    else
        print("Level fora da tabela, atualize o script!")
    end
end
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})
local Toggle = Tab:CreateToggle({
   Name = "Farm Nearest Mobs",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})
local Toggle = Tab:CreateToggle({
   Name = "Farm All Spawn Bosses",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})




local Tab = Window:CreateTab("Status", 4483362458) -- Title, Image




local Tab = Window:CreateTab("Fruit", 4483362458) -- Title, Image




local Tab = Window:CreateTab("Misc", 4483362458) -- Title, Image
