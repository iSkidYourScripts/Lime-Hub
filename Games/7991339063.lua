if getgenv().LimeActive ~= nil then local notifv4 = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))() notifv4:SendNotification("Error", "Lime is already loaded! (Press CTRL to show your current Lime Hub instance)", 3) return else getgenv().LimeActive = 0 end getgenv().isLoaded = false getgenv().lastTick = tick() local isTping = false local isTyping = false local timeSlapped = 0 local timeRagdolled = 0
local localPlr = game.Players.LocalPlayer
game:GetService("UserInputService").InputBegan:Connect(function(input, typing)
    isTyping = typing
end)
local sound = Instance.new("Sound", workspace) sound.SoundId = "rbxassetid://8499261098" sound.PlayOnRemove = true sound.Volume = 3

function readConfig()
    if not isfile("/Lime/Savefile/Bindings.lime") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Lime/Savefile/Bindings.lime"))["Key"]] or Enum.KeyCode.RightControl end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/iSkidYourScripts/Lime-Hub/main/Libraries/LimeUI.lua",true))()
local notifLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/iSkidYourScripts/Lime-Hub/main/Libraries/Notifications.lua"))()
--[[
Lime Hub V2 >>> Juego sin nombre [V2.2.11]

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

StoneNicolas93#0001 <<< Lead Developer
YOU! <<< Using and empowering Lime

>>>>>>>>>>> <<<<<<<<<<<

Thank you for using Lime!

-- [!] Lime hub is completely open source! If you have found an obfuscated and or secured version of Lime,
-- it may contain malicious and or dangerous archives or scripts that will harm your computer and client!

-- [>] Have bug reports or found an issue with Lime? Don't be afraid to make a pull request or issue on
-- our official github page! We will answer every issue and pull request, and help you solve issues!

- StoneNicolas93#0001 / iSkidYourScripts / Founder of Lime
--]]











getgenv().settings = {
    walkSpeed = 20,
    wsTog = false,
    jumpPower = 50,
    jpTog = false,
    clickTp = false,
    infJump = false,
    invis = false,
    boxspam = false,
    crouchspam = false,
    god = false,
    spyEnabled = false,
    target = localPlr.Name,
    autoDeposit = false,
    tpInterval = 0.25,
    monsterEsp = false,
    playerEsp = false,

}











if makefolder and isfolder and not isfolder("Lime") then makefolder("Lime") makefolder("Lime/Savefile") makefolder("Lime/Data") end
if readfile and isfile and isfile("Lime/Savefile/RainbowFriends.lime") then getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Lime/Savefile/RainbowFriends.lime")) end
local function saveSettings()
    if writefile then
        writefile("Lime/Savefile/RainbowFriends.lime", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end

local Window = Library:CreateWindow({
    Title = 'Lime V2 | 🌈 Rainbow Friends',
    Center = true, 
    AutoShow = true,
})
local Tabs = {
    Main = Window:AddTab('Main'), 
    Items = Window:AddTab('Items'),
    Visuals = Window:AddTab('Visuals'),
    Extra = Window:AddTab('Extra'),
}
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Player')
LeftGroupBox:AddToggle('clicktp', {
    Text = 'Click Teleport',
    Default = getgenv().settings.clickTp,
    Tooltip = 'Teleports to your mouse cursor position whenever you click.',
})
Toggles.clicktp:OnChanged(function()
    getgenv().settings.clickTp = Toggles.clicktp.Value
    saveSettings()
end)

localPlr:GetMouse().Button1Down:Connect(function() -- Credit to Infinite Yield
    if localPlr.Character ~= nil and localPlr.Character:FindFirstChild("HumanoidRootPart") ~= nil and getgenv().settings.clickTp and not isTping then localPlr.Character.HumanoidRootPart.CFrame = localPlr:GetMouse().Hit + Vector3.new(0,7,0) isTping = true wait(math.random(0, 0.35)) isTping = false end
end)

LeftGroupBox:AddToggle('infj', {
    Text = 'Infinite Jump',
    Default = getgenv().settings.infJump,
    Tooltip = 'Allows you to infinitely jump in mid-air by pressing space.',
})
Toggles.infj:OnChanged(function()
    getgenv().settings.infJump = Toggles.infj.Value
    saveSettings()
end)

LeftGroupBox:AddToggle('feinvis',{
    Text = 'Invisible',
    Default = getgenv().settings.invis,
    Tooltip = "Makes you invisible to everyone, works FE.",
})

Toggles.feinvis:OnChanged(function()
    getgenv().settings.invis = Toggles.feinvis.Value
    if getgenv().settings.invis then
        notifLib:SendNotification('Info', 'You are now invisible to everyone, except monsters.', 5)
    end
    saveSettings()
end)

LeftGroupBox:AddToggle('bspam',{
    Text = 'Box Spammer',
    Default = getgenv().settings.boxspam,
    Tooltip = "Spams the box option, and keeps putting you in a box.",
})

Toggles.bspam:OnChanged(function()
    getgenv().settings.boxspam = Toggles.bspam.Value
    saveSettings()
end)

LeftGroupBox:AddToggle('cspam',{
    Text = 'Crouch Spammer',
    Default = getgenv().settings.crouchspam,
    Tooltip = "Spams the crouching option, useful for trolling.",
})

Toggles.cspam:OnChanged(function()
    getgenv().settings.crouchspam = Toggles.cspam.Value
    saveSettings()
end)

LeftGroupBox:AddToggle('gtog',{
    Text = 'Godmode',
    Default = getgenv().settings.crouchspam,
    Tooltip = "Makes you immune to all of the monsters.",
})

Toggles.gtog:OnChanged(function()
    getgenv().settings.god = Toggles.gtog.Value
    if getgenv().settings.god then
        notifLib:SendNotification('Info', 'You are now immune to all of the monsters, enemies and have infinite health.', 5)
    end
    saveSettings()
end)




LeftGroupBox:AddDivider() ----------------------------------

LeftGroupBox:AddToggle('wsTog',{
    Text = 'Change WalkSpeed',
    Default = getgenv().settings.wsTog,
    Tooltip = "Allows for you to change your character's walkspeed, lets you run faster."
})

Toggles.wsTog:OnChanged(function()
    getgenv().settings.wsTog = Toggles.wsTog.Value
    saveSettings()
end)

LeftGroupBox:AddSlider('wslider', {
    Text = 'WalkSpeed',
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 1,

    Compact = false,
})

Options.wslider:OnChanged(function()
    getgenv().settings.walkSpeed = Options.wslider.Value
    saveSettings()
end)

-------


LeftGroupBox:AddToggle('jpTog',{
    Text = 'Change JumpPower',
    Default = getgenv().settings.jpTog,
    Tooltip = "Allows you to change your character's jump power, lets you jump higher."
})

Toggles.jpTog:OnChanged(function()
    getgenv().settings.jpTog = Toggles.jpTog.Value
    saveSettings()
end)

LeftGroupBox:AddSlider('jslider', {
    Text = 'JumpPower',
    Default = 50,
    Min = 50,
    Max = 100,
    Rounding = 1,

    Compact = false,
})

Options.jslider:OnChanged(function()
    getgenv().settings.jumpPower = Options.jslider.Value
    saveSettings()
end)

LeftGroupBox:AddDivider() ------------------------------------------------------------
local boxBtn = LeftGroupBox:AddButton('Toggle Box', function()
    game:GetService("Players").LocalPlayer.PlayerGui.SurvivorHud.buttons.BoxButton.onPress:Fire()
end)

local cBtn = boxBtn:AddButton('Toggle Crouch', function()
    game:GetService("Players").LocalPlayer.PlayerGui.SurvivorHud.buttons.CrouchButton.onPress:Fire()
end)

-- PLRSPY 
local spysec = Tabs.Main:AddRightGroupbox('Spying')

spysec:AddToggle('spytog',{
    Text = 'Enable Spy',
    Default = getgenv().settings.spyEnabled,
    Tooltip = "Toggles the functionaliy to spy on other players."
})

Toggles.spytog:OnChanged(function()
    getgenv().settings.spyEnabled = Toggles.spytog.Value
    if getgenv().settings.spyEnabled == false then
        workspace.CurrentCamera.CameraSubject = localPlr.Character.Head
    end
    saveSettings()
end)

spysec:AddInput('spybox', {
    Default = localPlr.Name,
    Numeric = false,
    Finished = true,
    Text = 'Enter Username',
    Tooltip = 'Select the player username that you want to spy.',

    Placeholder = 'Username',
})

Options.spybox:OnChanged(function()
    if game.Players:FindFirstChild(Options.spybox.Value) and getgenv().settings.spyEnabled then
        workspace.CurrentCamera.CameraSubject = workspace[Options.spybox.Value].Head
        local string = 'You are now spying on ' .. Options.spybox.Value
        notifLib:SendNotification('Info', string, 3)
    end
end)

-- Trolling

local trollsec = Tabs.Main:AddRightGroupbox('Trolling')

trollsec:AddInput('kbox', {
    Default = localPlr.Name,
    Numeric = false,
    Finished = false,
    Text = 'Target Username',
    Tooltip = 'Select the player target username to troll.',

    Placeholder = 'Target Username',
})

Options.kbox:OnChanged(function()
    if game.Players:FindFirstChild(Options.kbox.Value) then
        getgenv().settings.target = Options.kbox.Value
    end
end)

local kill = trollsec:AddButton('Kill Player', function()
    local plr = getgenv().settings.target
    lpChar = game.Players.LocalPlayer.Character.Torso
    local prevpos = localPlr.Character.HumanoidRootPart.CFrame
    local w = Instance.new("Weld", lpChar)
    w.Part0 = lpChar
    w.Part1 = plr.Character.Torso
    w.C0 = lpChar.CFrame
    w.C1 = lpChar.CFrame * CFrame.new(0, -10000, 0)
    wait(0.25)
    localPlr.Character.HumanoidRootPart.CFrame = prevpos
    w:Destroy()
end)

local bring = kill:AddButton('Bring Player', function()
    local plr = getgenv().settings.target
    lpChar = game.Players.LocalPlayer.Character.Torso
    local prevpos = localPlr.Character.HumanoidRootPart.CFrame
    local w = Instance.new("Weld", lpChar)
    w.Part0 = lpChar
    w.Part1 = plr.Character.Torso
    w.C0 = lpChar.CFrame
    w.C1 = lpChar.CFrame
    wait(0.55)
    w:Destroy()
end)

local rape = trollsec:AddButton('Rape Player', function()
    local anim = "rbxassetid://5918726674"
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace[getgenv().settings.target].HumanoidRootPart.CFrame
end)

-- Items

local itemSec = Tabs.Items:AddLeftGroupbox('Collector')

if workspace:FindFirstChild('Monsters') then
    spysec:AddToggle('autodepothisdoesntmatetrlmfao',{
        Text = 'Auto Deposit',
        Default = false,
        Tooltip = "Automatically deposits items when you collect them."
    })
    
    local depo = itemSec:AddButton('Deposit Items', function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(371.54364013671875, 45.604129791259766, 132.65687561035156)
    end)
    
    local getall = depo:AddButton('Collect All', function()
        for i, v in pairs(game.workspace.Map_C1.ItemSpawns:GetDescendants()) do
            if v.name == "ItemSpawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                wait(math.random(getgenv().settings.tpInterval))
            end
        end
        notifLib:SendNotification('Success', 'Lime V2 is now collecting every item for you. Sit back, and enjoy the show!')
    end)
    
    itemSec:AddDropdown('shitdrop', {
        Values = { 'Teleport', 'Tween', 'Pathfind'},
        Default = 1,
        Multi = false,
    
        Text = 'Method',
        Tooltip = 'Select the method in which the auto-get and deposit items will function with.',
    })
    
    itemSec:AddSlider('islider', {
        Text = 'Teleport Interval',
        Default = 0.25,
        Min = 0.02,
        Max = 4,
        Rounding = 1,
        Compact = false,
    })
    
    Options.islider:OnChanged(function()
        getgenv().settings.tpInterval = Options.islider.Value
        saveSettings()
    end)
else
    itemSec:AddLabel('Join the game to use these!')    
end






-- Visuals
local espSec = Tabs.Visuals:AddLeftGroupbox('Locator')

espSec:AddSlider('fovslide', {
    Text = 'Field of View',
    Default = 90,
    Min = 70,
    Max = 120,
    Rounding = 1,
    Compact = false,
})
Options.fovslide:OnChanged(function()
    workspace.CurrentCamera.FieldOfView = Options.fovslide.Value
    saveSettings()
end)
if workspace:FindFirstChild('Monsters') then
    espSec:AddToggle('monsterEsp',{
        Text = 'Monster Locator',
        Default = false,
        Tooltip = "Locates and shows you where the monsters are at all times."
    })
    
    Toggles.monsterEsp:OnChanged(function()
        getgenv().settings.monsterEsp = Toggles.monsterEsp.Value
        saveSettings()
        if  getgenv().settings.monsterEsp then
            for _,i in pairs(workspace.Monsters:GetChildren()) do
              local highlight = Instance.new("Highlight", i)
              highlight.FillColor = Color3.fromRGB(255, 0, 0)
            end
          else
            for _,i in pairs(workspace.Monsters:GetChildren()) do
                if i:FindFirstChild("Highlight") then
                    i.Highlight:Destroy()
               end
            end
        end
    end)
    
    espSec:AddToggle('plrEsp',{
        Text = 'Player Locator',
        Default = false,
        Tooltip = "Locates and shows where your teammates are at all times."
    })
    
    Toggles.plrEsp:OnChanged(function()
        getgenv().settings.playerEsp = Toggles.plrEsp.Value
        saveSettings()
        if getgenv().settings.playerEsp then
            for _,i in pairs(game.Players:GetChildren()) do
              if i.Character then
                local highlight = Instance.new("Highlight", i.Character)
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
              end
            end
          else
            for _,i in pairs(game.Players:GetChildren()) do
              if i.Character:FindFirstChild("Highlight") then
                i.Character.Highlight:Destroy()
              end
            end
        end
    end)
    
    espSec:AddToggle('itemEsp',{
        Text = 'Item Locator',
        Default = false,
        Tooltip = "Locates and shows you where the items are at all times."
    })
    
    espSec:AddDivider()
    
    espSec:AddToggle('Fullbright', {
        Text = 'Fullbright',
        Default = false,
        Tooltip = 'Allows you to see in the dark.'
    
    })
    
    Toggles.Fullbright:OnChanged(function()
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end)
else
    espSec:AddLabel('Join the game to use these!')
    
end


-- Extra
local creditSec = Tabs.Extra:AddLeftGroupbox('Credits')
creditSec:AddLabel('Lime V2: StoneNicolas93#0001')
creditSec:AddLabel('Rogue Hub: Kitzoon#7750')
creditSec:AddLabel('Rainbow Friends: @RoyStanford')
creditSec:AddLabel('You: ' .. localPlr.Name)

creditSec:AddLabel('Menu Toggle'):AddKeyPicker('MenuKeybind', { Default = 'RightControl', NoUI = true, Text = 'Menu Toggle' }) 
creditSec:AddButton('Unload', function() Library:Unload() end)


Library:SetWatermarkVisibility(true)

Library:SetWatermark('🌈 Rainbow Friends | Lime V2.2.11')
Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

-- Looped Events

game:GetService("RunService").RenderStepped:Connect(function()
    if not isTyping and getgenv().settings.infJump and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then localPlr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    if getgenv().settings.wsTog then game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = getgenv().settings.walkSpeed else game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16 end
    if getgenv().settings.jpTog then game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = getgenv().settings.JumpPower else game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50 end
    if getgenv().settings.invis then
        local removeNametags = false
        local plr = game:GetService("Players").LocalPlayer
        local character = plr.Character
        local hrp = character.HumanoidRootPart
        local old = hrp.CFrame
        if not character:FindFirstChild("LowerTorso") or character.PrimaryPart ~= hrp then
        return print("unsupported")
        end
        if removeNametags then
        local tag = hrp:FindFirstChildOfClass("BillboardGui")
        if tag then tag:Destroy() end
        hrp.ChildAdded:Connect(function(item)
        if item:IsA("BillboardGui") then
        task.wait()
        item:Destroy()
        end
        end)
        end
        local newroot = character.LowerTorso.Root:Clone()
        hrp.Parent = workspace
        character.PrimaryPart = hrp
        character:MoveTo(Vector3.new(old.X,9e9,old.Z))
        hrp.Parent = character
        task.wait(0.5)
        newroot.Parent = hrp
        hrp.CFrame = old
    end
    if getgenv().settings.boxspam and task.wait(0.45) then game:GetService("Players").LocalPlayer.PlayerGui.SurvivorHud.buttons.BoxButton.onPress:Fire() end
    if getgenv().settings.crouchspam and task.wait(0.45) then game:GetService("Players").LocalPlayer.PlayerGui.SurvivorHud.buttons.CrouchButton.onPress:Fire() end
    if getgenv().settings.god then localPlr.Character:WaitForChild("HumanoidRootPart"):Destroy() end
    if getgenv().settings.autoDeposit then
        for i, v in pairs(localPlr.Backpack:GetChildren()) do
            if v:IsA('Tool') then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(371.54364013671875, 45.604129791259766, 132.65687561035156)
            end
        end
    end

end)


sound:Destroy()
getgenv().isLoaded = true
notifLib:SendNotification("Success", "Lime Hub was successfully loaded!", 3)


