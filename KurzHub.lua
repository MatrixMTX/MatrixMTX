local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Kurz Hub", HidePremium = false, InterText = "Kurz Hub Loader", SaveConfig = true, ConfigFolder = "KurzHub"})

local Tab = Window:MakeTab({
	Name = "Test1",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

OrionLib.init()
