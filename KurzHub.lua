local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Kurz Hub", HidePremium = false, IntroText = "Kurz Hub Loader", SaveConfig = true, ConfigFolder = "KurzHub"})
local Players = game:GetService("Players"):GetChildren()
local RunService = game:GetService("RunService")
local highlight = Instance.new("Highlight")
highlight.Name = "Highlight"

-- Values
_G.ESP = false
_G.Color = Color3.fromHSV(0,0,1)
_G.WS = 16
_G.JH = 50

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
				highlightClone.OutlineColor = _G.Color
				highlightClone.FillTransparency = 1
				highlightClone.Name = "Highlight"
			end
		end

		game.Players.PlayerAdded:Connect(function(player)
			repeat wait() until player.Character
			if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and _G.ESP then
				local highlightClone = highlight:Clone()
				highlightClone.Adornee = player.Character
				highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
				highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlightClone.OutlineColor = _G.Color
				highlightClone.FillTransparency = 1
				highlightClone.Name = "Highlight"
			end
		end)

		game.Players.PlayerRemoving:Connect(function(playerRemoved)
			if playerRemoved.Character and playerRemoved.Character:FindFirstChild("HumanoidRootPart") and playerRemoved.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and _G.ESP then
				playerRemoved.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight"):Destroy()
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
					highlightClone.OutlineColor = Color3.fromHSV(_G.Color)
					highlightClone.FillTransparency = 1
					highlightClone.Name = "Highlight"
					task.wait()
				end
			end
		end)
	else
		for i, v in pairs(Players) do
			if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
				v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight"):Destroy()
			end
		end
	end    
end

function SpeedJump()
    while wait() do
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Walkspeed = _G.WS
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = _G.JH
    end
end

-- Tabs

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

PlayerTab:AddSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "WS",
    Callback = function(Value)
        _G.WS = Value
    end
})

PlayerTab:AddSlider({
    Name = "JumpHeight",
    Min = 16,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "JH",
    Callback = function(Value)
        _G.JH = Value
    end
})

PlayerTab:AddToggle({
	Name = "ESP",
    Default = false,
	Callback = function(Value)
      	_G.ESP = Value
        print(Value)
  	end    
})

PlayerTab:AddColorpicker({
	Name = "ESP Outline",
	Default = Color3.fromRGB(255, 255, 255),
	Callback = function(Value)
        _G.Color = Value
        _G.ESP = false
		print(Value)
        _G.ESP = true
	end
})

OrionLib.init()
ESP()
SpeedJump()
