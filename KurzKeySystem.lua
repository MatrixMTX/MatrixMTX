local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Kurz Key System", HidePremium = false, IntroEnabled = false, SaveConfig = true})
local Players = game:GetService("Players")

-- Notification

OrionLib:MakeNotification({
	Name = "Logged in!",
	Content = "You are logged in as "..Players.LocalPlayer.Name.."",
	Image = "rbxassetid://4483345998",
	Time = 5
})

-- Values

_G.Key = "KurzKey.d2VhcmVzb2dlbm9pb3VzZGV2ZWxvcGVydG9idG9ha2xvYmVy"
_G.KeyInput = "string"

-- Functions

function MakeScriptHub()
    print("Currect Key")
    OrionLib:Destroy()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/MatrixMTX/MatrixMTX/main/KurzHub.lua')))()
end

function Notifications(text)
	OrionLib:MakeNotification({
		Name = "Kurz Key System",
		Content = text,
		Image = "rbxassetid://4483345998",
		Time = 5
	})
end

-- MakeWindow

local Tab = Windows:MakeTab({
    Name = "Key",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddTextBox({
    Name = "Enter Key",
    Default = "Enter Key",
    TextDisappear = true,
    Callback = function(Value)
        _G.KeyInput = Value

    end
})

Tab:AddButton({
    Name = "Check key",
    Callback = function()
        if _G.KeyInput == _G.Key then
            Notifications("You have entered the correct key!")
            MakeScriptHub()
        else
            Notifications("You have entered the incorrect key!")
        end
    end
})
