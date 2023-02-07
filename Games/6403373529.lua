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
local mainTab = window:CreateTab("Slap Battles")

getgenv().settings = {
    testTog = false,
}

if makefolder and isfolder and not isfolder("Lime") then
    makefolder("Lime")
    
    makefolder("Lime/Savefile")
    makefolder("Lime/Data")
end

if readfile and isfile and isfile("Lime/Savefile/SlapBattles.lime") then
    getgenv().settings = game:GetService("HttpService"):JSONDecode(readfile("Lime/Savefile/SlapBattles.lime"))
end

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

sound:Destroy()
getgenv().isLoaded = true

notifLib:SendNotification("Success", "Lime Hub was successfully loaded!", 3)

while wait() do
    if game.PlaceId ~= 9431156611 then
        slapLabel:UpdateText("Players Slapped: " .. timeSlapped)
    end
    
    ragdollLabel:UpdateText("Times Ragdolled: " .. timeRagdolled)
    
    while wait(1) do
        playtime = playtime + 1
        playLabel:UpdateText("Playtime In Seconds: " .. playtime)
    end
end
