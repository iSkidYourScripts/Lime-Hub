if getgenv().LimeActive ~= nil then 
   local notifv4 = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()
   notifv4:SendNotification("Error", "Lime is already loaded! (Press CTRL to show your current Lime Hub instance)", 3)
   return 
else getgenv().LimeActive = 0 end getgenv().isLoaded = false getgenv().lastTick = tick() local isTping = false local isTyping = false local timeSlapped = 0 local timeRagdolled = 0
-- AntiCheat Bypass (Kitzoon#7750)
if game.PlaceId == 9431156611 and getrawmetatable and hookmetamethod then
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if not checkcaller() and tostring(self) == "WS" and tostring(method) == "FireServer" then
            return
        end
        if not checkcaller() and tostring(self) == "AdminGUI" and tostring(method) == "FireServer" then
            return
        end
        return old(self, ...)
    end)
elseif game.PlaceId ~= 9431156611 and getrawmetatable and hookmetamethod then
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        
        if not checkcaller() and tostring(self) == "WalkSpeedChanged" and tostring(method) == "FireServer" then
            return
        end
        if not checkcaller() and tostring(self) == "AdminGUI" and tostring(method) == "FireServer" then
            return
        end
        return old(self, ...)
    end)
end
game:GetService("UserInputService").InputBegan:Connect(function(input, typing)
    isTyping = typing
end)
local sound = Instance.new("Sound", workspace) sound.SoundId = "rbxassetid://8499261098" sound.PlayOnRemove = true sound.Volume = 3

function readConfig()
    if not isfile("/Lime/Savefile/Bindings.lime") then return Enum.KeyCode.RightControl else return Enum.KeyCode[game:GetService("HttpService"):JSONDecode(readfile("/Lime/Savefile/Bindings.lime"))["Key"]] or Enum.KeyCode.RightControl end
end

local Config = {
    WindowName = "Lime | " .. "Slap Battles 👏",
    Color = Color3.fromRGB(112, 240, 84),
    Keybind = readConfig()
}

local localPlr = game:GetService("Players").LocalPlayer
local notifLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/iSkidYourScripts/Lime-Hub/main/Libraries/Notifications.lua"))()
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/iSkidYourScripts/Lime-Hub/main/Libraries/BracketV3.lua"))()
local ESPlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/iSkidYourScripts/Lime-Hub/main/Libraries/SimpleESP.lua"))()


local window = library:CreateWindow(Config, game:GetService("CoreGui"))


getgenv().settings = {
   autoClicker = false,
   clickTp = false,
   autoToxic = false,
}

if makefolder and isfolder and not isfolder("Lime") then makefolder("Lime") makefolder("Lime/Savefile") makefolder("Lime/Data") end
if readfile and isfile and isfile("Lime/Savefile/SlapBattles.lime") then getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Lime/Savefile/SlapBattles.lime")) end
local function saveSettings()
    if writefile then
        writefile("Lime/Savefile/SlapBattles.lime", game:GetService("HttpService"):JSONEncode(getgenv().settings))
    end
end
function getQuote()
    local userQuotes = game:GetService("HttpService"):JSONDecode(readfile("/Lime/Data/Quotes.txt"))
    return userQuotes[math.random(#userQuotes)]
end
local function getTool() -- Kitzoon#7750
    local tool = localPlr.Character:FindFirstChildOfClass("Tool") or localPlr:WaitForChild("Backpack"):FindFirstChildOfClass("Tool")
    
    if tool ~= nil and tool:FindFirstChild("Glove") ~= nil then
        return tool    
    end
end
local function getBackpackTool() -- get tool from backpack (kitzoon#7750)
    local tool = localPlr:WaitForChild("Backpack"):FindFirstChildOfClass("Tool")
    
    if tool ~= nil and tool:FindFirstChild("Glove") ~= nil then
        return tool
    end
end

-- Main Tab
local mainTab = window:CreateTab("Main")
local playerSec = mainTab:CreateSection("Player")
playerSec:CreateToggle("Glove Autoclicker", getgenv().settings.autoClicker or false, function(bool) getgenv().settings.autoClicker = bool saveSettings() end)
playerSec:CreateToggle("Click Teleport", getgenv().settings.clickTp or false, function(bool)
   getgenv().settings.clickTp = bool saveSettings()
end)
localPlr:GetMouse().Button1Down:Connect(function() -- Credit to Infinite Yield
   if localPlr.Character ~= nil and localPlr.Character:FindFirstChild("HumanoidRootPart") ~= nil and getgenv().settings.clickTp and not isTping then
       localPlr.Character.HumanoidRootPart.CFrame = localPlr:GetMouse().Hit + Vector3.new(0,7,0)
       isTping = true wait(math.random(0, 0.35)) isTping = false
   end
end)

local autoToxic = playerSec:CreateToggle("Auto Toxic", getgenv().settings.autoToxic or false, function(bool)
   getgenv().settings.autoToxic = bool
   saveSettings()
   if getgenv().settings.autoToxic then
       localPlr.leaderstats.Slaps:GetPropertyChangedSignal("Value"):Connect(function()
           if not getgenv().settings.autoToxic or getgenv().slapFarm then return end game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getQuote(), "All")
       end)
   end
end)
-- Extras Tab

local infoTab = window:CreateTab("Extra") local uiSec = infoTab:CreateSection("Interface") local uiColor = uiSec:CreateColorpicker("Theme Color", function(color) window:ChangeColor(color) end)
uiColor:AddToolTip("Changes the Lime Interface theme color.")
uiColor:UpdateColor(Config.Color)

local uiTog = uiSec:CreateToggle("Visibility Toggle", nil, function(bool)
	window:Toggle(bool)
end)
uiTog:AddToolTip("Sets the Lime Visibility Toggle keybind for the Lime Interface.")

uiTog:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(key)
	if key == "Escape" or key == "Backspace" then key = "NONE" end
	
    if key == "NONE" then return else Config.Keybind = Enum.KeyCode[key]; writefile("/Rogue Hub/Configs/Keybind.ROGUEHUB", game:GetService("HttpService"):JSONEncode({Key = key})) end
end)

uiTog:SetState(true)

local uiRainbow = uiSec:CreateToggle("Rainbow UI", nil, function(bool)
	getgenv().rainbowUI = bool
    
    while getgenv().rainbowUI and task.wait() do
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
            
        window:ChangeColor(rainbow)
        uiColor:UpdateColor(rainbow)
    end
end)

-- Credits

local infoSec = infoTab:CreateSection("Credits")
local req = http_request or request or syn.request
infoSec:CreateButton("Lime Hub Founder: StoneNicolas93#0001", function()
    setclipboard("StoneNicolas93#0001")
    
    notifLib:SendNotification("Info", "Copied StoneNicolas93's Discord username and tag to your clipboard.", 3)
end)
infoSec:CreateButton("Gigachad: BluB#9867", function()
    setclipboard("BluB#9867")
    
    notifLib:SendNotification("Info", "Copied BluB's Discord username and tag to your clipboard.", 3)
end)
local discordInvite = infoSec:CreateButton("Join us on discord!", function()
	if req then
        req({
            Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",
            
            Headers = {
                ["Content-Type"] = "application/json",
                ["origin"] = "https://discord.com",
            },
                    
            Body = game:GetService("HttpService"):JSONEncode(
            {
                ["args"] = {
                ["code"] = "Vy7FEdpX2Q",
                },
                
                ["cmd"] = "INVITE_BROWSER",
                ["nonce"] = "."
            })
        })
    else
        setclipboard("https://discord.gg/Vy7FEdpX2Q")
        notifLib:SendNotification("Info", "Lime's Discord invite was copied to your clipboard. Paste it into your URL bar to join!", 3)
    end
end)
discordInvite:AddToolTip("Gives you an invite to our Discord server.")


-- Misc
local miscSec = infoTab:CreateSection("Miscellaneous")
local cSec = infoTab:CreateSection("Cosmetic")
local zoomBackup = localPlr.CameraMaxZoomDistance

local server = miscSec:CreateButton("Serverhop", function()
    -- credits to: inf yield for there serverhop
    local serverList = {}
    
    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
    	if v.playing and type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
    		serverList[#serverList + 1] = v.id
    	end
    end
    
    if #serverList > 0 then
    	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
    else
        error("No servers found")
    end
end)

server:AddToolTip("Joins a different server than the one you're currently in.")

local camZoom = miscSec:CreateToggle("Infinite Zoom", false, function(bool)
    if bool then
        localPlr.CameraMaxZoomDistance = math.huge
    else
        localPlr.CameraMaxZoomDistance = zoomBackup
    end
end)

camZoom:AddToolTip("Lets you infinitely change your camera's zoom.")

local asset = getcustomasset or syn and getsynasset

local hideSlaps = cSec:CreateToggle("Hide Slap Count", getgenv().settings.hideSlapCount or false, function(v)
	game.Players.LocalPlayer.PlayerGui.gui.slapcount.Visible = not v
	saveSettings()
end)
hideSlaps:AddToolTip("Hides your Slap Counter, and makes it invisible.")

local hideFriends = cSec:CreateToggle("Hide Invite Friends", getgenv().settings.hideInviteFriends or false, function(v)
	localPlr.PlayerGui.gui.friend.Visible = not v
	saveSettings()
end)
hideFriends:AddToolTip("Hides the Join Friends button, and makes it invisible.")

local hideOptionsMenu = cSec:CreateToggle("Hide Options Menu", getgenv().settings.hideOptionsMenu or false, function(v)
	localPlr.PlayerGui.gui.MenuOpen.Visible = not v
	saveSettings()
end)
hideOptionsMenu:AddToolTip("Hides the options menu, and makes it invisible.")

-- Looped Events

game:GetService("RunService").RenderStepped:Connect(function()
   if task.wait(math.random(0.8, 2)) and getTool() ~= nil and getgenv().settings.autoClicker then getTool():Activate() end
end)


sound:Destroy()
getgenv().isLoaded = true

notifLib:SendNotification("Success", "Lime Hub was successfully loaded!", 3)
