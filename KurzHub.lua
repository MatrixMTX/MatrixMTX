local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Kurz Hub", HidePremium = false, IntroEnabled = false, SaveConfig = true, ConfigFolder = "KurzHub"})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Mouse = Players.LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- Notification

OrionLib:MakeNotification({
	Name = "Logged in!",
	Content = "You are logged in as "..Players.LocalPlayer.Name.."",
	Image = "rbxassetid://4483345998",
	Time = 5
})

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
_G.CtrlTP = false
_G.KeepData = false
_G.isJumping = false
_G.Clipon = false

-- Functions
function ESP()
	if _G.ESP then
		local highlight = Instance.new("Highlight")
		highlight.Name = "Highlight"

		for _, v in next, Players:GetPlayers() do
			if v.Name ~= Players.LocalPlayer.Name then
				local ESP = Drawing.new("Text")

				Stepped = RunService.RenderStepped:Connect(function()
					if _G.ESP == false then Stepped:Disconnect() end
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
			Player.CharacterAdded:Connect(function(v)
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

					Stepped = RunService.RenderStepped:Connect(function()
						if _G.ESP == false then Stepped:Disconnect() end
						if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
							local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)

							ESP.Size = _G.TextSize
							ESP.Center = _G.Center
							ESP.Outline = _G.Outline
							ESP.OutlineColor = _G.OutlineColor
							ESP.Color = _G.Color
							ESP.Transparency = _G.TextTransparency
							if v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
								v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight").OutlineColor = _G.Color
							end

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
	end
	return
end

function Teleport(pos)
	local Char = Players.LocalPlayer.Character
	if Char then
		Char:MoveTo(pos)
	end
end

function CtrlTP()
	if _G.CtrlTP then
		UserInputService.InputBegan:Connect(function(input)
			if _G.CtrlTP then
				if input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
					Teleport(Mouse.Hit.p)
				end
			else
				return
			end
		end)
	else
		return
	end
end

function KeepData()
	while _G.KeepData == true do
		wait(0.1)
		if _G.KeepData then
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = _G.WS
			game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = _G.JH
		else
			return
		end
	end
	return
end

function InfiniteJump()
	if _G.isJumping then
		game:GetService("UserInputService").JumpRequest:connect(function()
			if _G.isJumping then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			else
				return
			end
		end)
	else
		return
	end
end

function Noclip()
	if _G.Clipon == false then return end
	Stepped = game:GetService("RunService").Stepped:Connect(function()
		if _G.Clipon then
			for a, b in pairs(workspace:GetChildren()) do
				if b.Name == Players.LocalPlayer.Name then
					for i, v in pairs(workspace[Players.LocalPlayer.Name]:GetChildren()) do
						if v:IsA("BasePart") then
							v.CanCollide = false
						end 
					end 
				end 
			end
		else
			Stepped:Disconnect()
		end
	end)
end

function Notifications(text)
	OrionLib:MakeNotification({
		Name = "Kurz Key System",
		Content = ""..text.."",
		Image = "rbxassetid://4483345998",
		Time = 5
	})
end

-- Tabs

local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://13060262529",
	PremiumOnly = false
})

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://2795572800",
	PremiumOnly = false
})

local TpTab = Window:MakeTab({
	Name = "TP",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local EspTab = Window:MakeTab({
	Name = "ESP",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local SettingTab = Window:MakeTab({
	Name = "Setting",
	Icon = "rbxassetid://6031280882",
	PremiumOnly = false
})

local CreditsTab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://6031280882",
	PremiumOnly = false
})

MainTab:AddLabel("Just Main Tab lol")
MainTab:AddLabel("Copyright (C) Kurz")

PlayerTab:AddLabel("Player Setting")

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
	Name = "Infinite Jump",
	Default = false,
	Callback = function(Value)
		_G.isJumping = Value
		InfiniteJump()
	end
})

PlayerTab:AddToggle({
	Name = "Noclip",
	Default = false,
	Callback = function(Value)
		_G.Clipon = Value
		Noclip()
	end
})

PlayerTab:AddLabel("Other Setting")

PlayerTab:AddToggle({
    Name = "Keep Data",
    Default = false,
    Callback = function(Value)
        _G.KeepData = Value
		KeepData()
    end
})

TpTab:AddLabel("Ctrl + Click to TP")
TpTab:AddToggle({
    Name = "CtrlTP",
    Default = false,
    Callback = function(Value)
        _G.CtrlTP = Value
		CtrlTP()
    end
})

EspTab:AddLabel("ESP Setting")

EspTab:AddToggle({
	Name = "ESP Mode",
	Default = false,
	Callback = function(Value)
		_G.ESP = Value
		ESP()
	end    
})

EspTab:AddColorpicker({
	Name = "ESP Outline",
	Default = Color3.fromRGB(255, 255, 255),
	Callback = function(Value)
		_G.Color = Value
	end
})

SettingTab:AddButton({
	Name = "Destroy UI",
	Callback = function()
		OrionLib:Destroy()
	end
})
SettingTab:AddLabel("Show/Hide Key: RightShift")
SettingTab:AddLabel("KurzHub Version: v0.6.8")

CreditsTab:AddLabel("Scripter: TW_ASVZ / Kurz")
CreditsTab:AddLabel("Planner: TW_ASVZ / Kurz")
CreditsTab:AddLabel("UI: TW_ASVZ / Kurz")

OrionLib.init()
