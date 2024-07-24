local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Kurz Hub", HidePremium = false, IntroText = "Kurz Hub Loader", SaveConfig = true, ConfigFolder = "KurzHub"})
local Players = game:GetService("Players"):GetChildren()
local RunService = game:GetService("RunService")
local highlight = Instance.new("Highlight")
highlight.Name = "Highlight"

-- Functions
local isEnabled = true -- 초기 상태를 활성화로 설정

-- 활성화/비활성화 함수
local function ESP()
    isEnabled = _G.ESP
    
    if isEnabled then
        -- 활성화 로직
        for i, v in pairs(Players) do
            repeat wait() until v.Character
            if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                local highlightClone = highlight:Clone()
                highlightClone.Adornee = v.Character
                highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
                highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlightClone.Name = "Highlight"
            end
        end
        
        game.Players.PlayerAdded:Connect(function(player)
            repeat wait() until player.Character
            if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                local highlightClone = highlight:Clone()
                highlightClone.Adornee = player.Character
                highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
                highlightClone.Name = "Highlight"
            end
        end)
        
        game.Players.PlayerRemoving:Connect(function(playerRemoved)
            playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
        end)
        
        RunService.Heartbeat:Connect(function()
            for i, v in pairs(Players) do
                repeat wait() until v.Character
                if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
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
        -- 비활성화 로직
        for i, v in pairs(Players) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("HumanoidRootPart").Highlight then
                v.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
            end
        end
        
        game.Players.PlayerAdded:Disconnect()
        game.Players.PlayerRemoving:Disconnect()
        RunService.Heartbeat:Disconnect()
    end
end


-- Tabs

local Tab = Window:MakeTab({
	Name = "Test1",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "ESP",
    Default = false,
	Callback = function()
      	_G.ESP = value
        ESP()
  	end    
})

OrionLib.init()
