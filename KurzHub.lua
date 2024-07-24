local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Kurz Hub", HidePremium = false, IntroText = "Kurz Hub Loader", SaveConfig = true, ConfigFolder = "KurzHub"})
local Players = game:GetService("Players"):GetChildren()
local RunService = game:GetService("RunService")
local highlight = Instance.new("Highlight")
highlight.Name = "Highlight"

-- Values
_G.ESP = false

-- Functions
function ESP()
	if _G.ESP then
		-- 활성화 로직
		for i, v in pairs(Players) do
			repeat wait() until v.Character
			if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and _G.ESP then
				local highlightClone = highlight:Clone()
				highlightClone.Adornee = v.Character
				highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
				highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlightClone.Name = "Highlight"
			end
		end

		game.Players.PlayerAdded:Connect(function(player)
			repeat wait() until player.Character
			if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and _G.ESP then
				local highlightClone = highlight:Clone()
				highlightClone.Adornee = player.Character
				highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
				highlightClone.Name = "Highlight"
			end
		end)

		game.Players.PlayerRemoving:Connect(function(playerRemoved)
			if playerRemoved.Character and playerRemoved.Character:FindFirstChild("HumanoidRootPart") and _G.ESP then
				playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
			end
		end)

		RunService.Heartbeat:Connect(function()
			for i, v in pairs(Players) do
				repeat wait() until v.Character
				if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and _G.ESP then
					local highlightClone = highlight:Clone()
					highlightClone.Adornee = v.Character
					highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
					highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					highlightClone.Name = "Highlight"
					task.wait()
				end
			end
		end)
	else
		for i, v in pairs(Players) do
			if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
				v.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
			end
		end
	end    
end


-- Tabs

local Tab = Window:MakeTab({
	Name = "Test1",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddToggle({
	Name = "ESP",
    Default = false,
	Callback = function(Value)
      	_G.ESP = Value
        print(Value)
        ESP()
  	end    
})

OrionLib.init()
