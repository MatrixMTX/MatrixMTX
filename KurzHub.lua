local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Kurz Hub", HidePremium = false, IntroEnabled = false, SaveConfig = true, ConfigFolder = "KurzHub"})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Values
local Typing = false
_G.ESP = false
_G.Color = Color3.fromHSV(0.0666667, 0.509804, 1)

_G.SendNotifications = true   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the ESP script would run with default settings regardless of any changes you made.

_G.TeamCheck = false   -- If set to true then the script would create ESP only for the enemy team members.

_G.ESPVisible = false   -- If set to true then the ESP will be visible and vice versa.
_G.TextColor = _G.Color   -- The color that the boxes would appear as.
_G.TextSize = 14   -- The size of the text.
_G.Center = true   -- If set to true then the script would be located at the center of the label.
_G.Outline = true   -- If set to true then the text would have an outline.
_G.OutlineColor = Color3.fromRGB(0, 0, 0)   -- The outline color of the text.
_G.TextTransparency = 0.7   -- The transparency of the text.
_G.TextFont = Drawing.Fonts.UI   -- The font of the text. (UI, System, Plex, Monospace) 

_G.WS = 16
_G.JH = 50
_G.KeepData = false
_G.isJumping = false

-- Functions
function ESP()
	if _G.ESP then
		local highlight = Instance.new("Highlight")
		highlight.Name = "Highlight"

		for _, v in next, Players:GetPlayers() do
			if v.Name ~= Players.LocalPlayer.Name then
				local ESP = Drawing.new("Text")

				RunService.RenderStepped:Connect(function()
					if _G.ESP == false then coroutine.yield() end
					if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
						local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)

						ESP.Size = _G.TextSize
						ESP.Center = _G.Center
						ESP.Outline = _G.Outline
						ESP.OutlineColor = _G.OutlineColor
						ESP.Color = _G.Color
						ESP.Transparency = _G.TextTransparency
						ESP.Font = _G.TextFont

						if OnScreen == true then
							local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
							local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
							local Dist = (Part1 - Part2).Magnitude
							ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
							ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
							if _G.TeamCheck == true then 
								if Players.LocalPlayer.Team ~= v.Team then
									ESP.Visible = _G.ESP
								else
									ESP.Visible = false
								end
							else
								ESP.Visible = _G.ESP
							end
						else
							ESP.Visible = false
						end
					else
						ESP.Visible = false
					end
					for i, s in pairs(Players:GetChildren()) do
						repeat wait() until s.Character
						if not s.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and _G.ESP then
							local highlightClone = highlight:Clone()
							highlightClone.Adornee = s.Character
							highlightClone.Parent = s.Character:FindFirstChild("HumanoidRootPart")
							highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							highlightClone.OutlineColor = _G.Color
							highlightClone.FillTransparency = 1
							highlightClone.Name = "Highlight"
							task.wait()
						end
					end
				end)

				Players.PlayerRemoving:Connect(function()
					ESP.Visible = false
				end)
			end
		end
		-- 활성화 로직
		for i, v in pairs(Players:GetChildren()) do
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
			if _G.ESP == false then coroutine.yield() end
			Player.CharacterAdded:Connect(function(v)
				if _G.ESP == false then coroutine.yield() end
				if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and _G.ESP then
					local highlightClone = highlight:Clone()
					highlightClone.Adornee = player.Character
					highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
					highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					highlightClone.OutlineColor = _G.Color
					highlightClone.FillTransparency = 1
					highlightClone.Name = "Highlight"
				end
				if v.Name ~= Players.LocalPlayer.Name then 
					local ESP = Drawing.new("Text")

					RunService.RenderStepped:Connect(function()
						if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
							local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)

							ESP.Size = _G.TextSize
							ESP.Center = _G.Center
							ESP.Outline = _G.Outline
							ESP.OutlineColor = _G.OutlineColor
							ESP.Color = _G.Color
							ESP.Transparency = _G.TextTransparency

							if OnScreen == true then
								local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
								local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
								local Dist = (Part1 - Part2).Magnitude
								ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
								ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
								if _G.TeamCheck == true then 
									if Players.LocalPlayer.Team ~= Player.Team then
										ESP.Visible = _G.ESP
									else
										ESP.Visible = false
									end
								else
									ESP.Visible = _G.ESP
								end
							else
								ESP.Visible = false
							end
						else
							ESP.Visible = false
						end
					end)

					Players.PlayerRemoving:Connect(function(playerRemoved)
						ESP.Visible = false
						if playerRemoved.Character and playerRemoved.Character:FindFirstChild("HumanoidRootPart") and playerRemoved.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and _G.ESP then
							playerRemoved.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight"):Destroy()
						end
					end)
				end
			end)
		end)

		if _G.DefaultSettings == true then
			_G.TeamCheck = false
			_G.ESPVisible = false
			_G.TextColor = _G.Color
			_G.TextSize = 14
			_G.Center = true
			_G.Outline = false
			_G.OutlineColor = Color3.fromRGB(0, 0, 0)
			_G.DisableKey = Enum.KeyCode.Q
			_G.TextTransparency = 0.75
		end

		UserInputService.TextBoxFocused:Connect(function()
			Typing = true
		end)

		UserInputService.TextBoxFocusReleased:Connect(function()
			Typing = false
		end)
	else
		for i, v in pairs(Players:GetChildren()) do
			if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
				v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight"):Destroy()
			end
		end
		coroutine.yield()
	end
	coroutine.yield()
    return
end

function InfiniteJump()
	if _G.isJumping then
		game:GetService("UserInputService").JumpRequest:connect(function()
			if _G.isJumping then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			else
				coroutine.yield()
			end
		end)
	else
		coroutine.yield()
	end
end

-- Coroutine

local ESP_Coroutine = coroutine.create(ESP)
local InfJump_Coroutine = coroutine.create(InfiniteJump)

-- Tabs

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local EspTab = Window:MakeTab({
	Name = "ESP",
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
	ValueName = "Speed",
	Callback = function(Value)
		_G.WS = Value
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = _G.WS
	end
})

PlayerTab:AddSlider({
	Name = "JumpHeight",
	Min = 50,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Height",
	Callback = function(Value)
		_G.JH = Value
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = _G.JH
	end
})

PlayerTab:AddToggle({
    Name = "Keep Data",
    Default = false,
    Callback = function(Value)
        _G.KeepData = Value
    end
})

PlayerTab:AddToggle({
	Name = "Infinite Jump",
	Default = false,
	Callback = function(Value)
		_G.isJumping = Value
		coroutine.resume(InfJump_Coroutine)
	end
})

EspTab:AddToggle({
	Name = "ESP Mode",
	Default = false,
	Callback = function(Value)
		_G.ESP = Value
		coroutine.resume(ESP_Coroutine)
		print(Value)
	end    
})

EspTab:AddColorpicker({
	Name = "ESP Outline",
	Default = Color3.fromRGB(255, 255, 255),
	Callback = function(Value)
		_G.Color = Value
	end
})

OrionLib.init()

-- While

while wait() do
    if _G.KeepData then
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = _G.WS
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = _G.JH
    end
end
