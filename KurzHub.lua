-- 로컬 스크립트
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 플레이어 위치를 표시하는 GUI 생성
local playerLocationGui = Instance.new("ScreenGui")
playerLocationGui.Name = "PlayerLocationGui"
playerLocationGui.Parent = LocalPlayer.PlayerGui

-- 플레이어 위치를 하이라이트로 표시하는 함수
local function highlightPlayerLocation(player)
    if player == LocalPlayer then return end -- 자신의 위치는 제외

    -- 플레이어의 캐릭터가 있는 경우에만 실행
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local playerHighlight = Instance.new("Highlight")
        playerHighlight.Name = player.Name .. "'s Highlight"
        playerHighlight.FillColor = Color3.fromRGB(255, 255, 0) -- 노란색 하이라이트
        playerHighlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- 흰색 아웃라인
        playerHighlight.OutlineTransparency = 0.5
        playerHighlight.Parent = playerLocationGui
        playerHighlight.Adornee = player.Character.HumanoidRootPart
    end
end

-- 새로운 플레이어가 접속하면 하이라이트 표시
Players.PlayerAdded:Connect(highlightPlayerLocation)

-- 기존 플레이어의 하이라이트 표시
for _, player in ipairs(Players:GetPlayers()) do
    highlightPlayerLocation(player)
end
