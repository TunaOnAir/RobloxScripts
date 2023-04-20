local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local outline = Instance.new("Highlight")
outline.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

local ConnectionData = {}
local InstanceData = {}

function addESP(character)
	InstanceData[character] = outline:Clone()
	InstanceData[character].Parent = character
end

function connect(player)
	ConnectionData[player] = player.CharacterAdded:Connect(addESP)
end

function disconnect(player)
	InstanceData[player.Character] = nil
	if not ConnectionData[player] then return end
	ConnectionData[player]:Disconnect()
	ConnectionData[player] = nil
end

for _, player in Players:GetPlayers() do
	if player.Name == Player.Name then continue end
	addESP(player.Character)
	connect(player)
end

Players.PlayerAdded:Connect(connect)
Players.PlayerRemoving:Connect(disconnect)
