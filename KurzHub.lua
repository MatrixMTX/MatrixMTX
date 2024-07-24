local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 플레이어의 위치를 나타내는 GUI 생성
local playerLocationGui = Instance.new("ScreenGui")
playerLocationGui.Name = "PlayerLocationGui"
playerLocationGui.Parent = LocalPlayer.PlayerGui

local playerLocationText = Instance.new("TextLabel")
playerLocationText.Name = "LocationLabel"
playerLocationText.Size = UDim2.new(0.2, 0, 0.1, 0)
playerLocationText.Position = UDim2.new(0.4, 0, 0.9, 0)
playerLocationText.TextColor3 = Color3.fromRGB(255, 255, 255)
playerLocationText.Font = Enum.Font.SourceSans
playerLocationText.TextSize = 14
playerLocationText.Parent = playerLocationGui

-- 플레이어의 위치를 지속적으로 업데이트하는 함수
local function updatePlayerLocation()
    local playerPosition = LocalPlayer.Character.HumanoidRootPart.Position
    playerLocationText.Text = "X: " .. math.floor(playerPosition.X) .. ", Y: " .. math.floor(playerPosition.Y) .. ", Z: " .. math.floor(playerPosition.Z)
end

-- 1초마다 플레이어의 위치를 업데이트
while true do
    wait(1)
    updatePlayerLocation()
end
