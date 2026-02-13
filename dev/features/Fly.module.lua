local FlyLib = {}

local flySpeed = 32
local isFlying = false 

local startedFlying = false
local stoppedFlying = false

local player = game["Players"].LocalPlayer
local forward = false
local backward = false
local left = false
local right = false
local up = false
local down = false

local oldWalkSpeed = player.WalkSpeed
local oldMaxStamina = player.MaxStamina
local position = player.Position

local onRendered
local onKeyDown
local onKeyUp

local cos = math.cos
local sin = math.sin

local function ToggleFly(enable)
	stoppedFlying = not enable
	startedFlying = enable
	isFlying = enable
end


local function degreesToRadians(degrees)
	return degrees * math.pi / 180
end

local function getForwardVectorFromRotation(rotation)
	rotation.x = degreesToRadians(rotation.x)
	rotation.y = degreesToRadians(rotation.y)
	rotation.z = degreesToRadians(rotation.z)
    local forward = Vector3.new()
    forward.x = cos(rotation.x) * sin(rotation.y)
    forward.y = -sin(rotation.x)
    forward.z = cos(rotation.x) * cos(rotation.y)
    return forward.normalized
end

local function getRightVectorFromRotation(rotation)
	rotation.x = degreesToRadians(rotation.x)
	rotation.y = degreesToRadians(rotation.y)
	rotation.z = degreesToRadians(rotation.z)
    local right = Vector3.new()
    right.x = cos(rotation.y)
    right.z = -sin(rotation.y)
    return right.normalized
end

local function getUpVectorFromRotation(rotation)
	rotation.x = degreesToRadians(rotation.x)
	rotation.y = degreesToRadians(rotation.y)
	rotation.z = degreesToRadians(rotation.z)
    local up = Vector3.new()
    up.x = sin(rotation.x) * sin(rotation.y)
    up.y = cos(rotation.x)
    up.z = sin(rotation.x) * cos(rotation.y)
    return up.normalized
end


onKeyDown = function(key)
	if Input.IsInputFocused then return end
	if key == "E" then
		up = true
	elseif key == "Q" then
		down = true
	elseif key == "W" then
		forward = true
	elseif key == "S" then
		backward = true
	elseif key == "A" then
		left = true
	elseif key == "D" then
		right = true
	end
end

onKeyUp = function(key)
	if key == "E" then
		up = false
	elseif key == "Q" then 
		down = false
	elseif key == "W" then
		forward = false
	elseif key == "S" then
		backward = false
	elseif key == "A" then
		left = false
	elseif key == "D" then
		right = false
	end
end

onRendered = function(deltaTime)
	if isFlying then
		if startedFlying then
			startedFlying = false
			position = player.Position
			player.WalkSpeed = 0
			player.Stamina = 0
			player.MaxStamina = 0
		end
		player.Velocity = player.Velocity * 0
		local forwardVec = getForwardVectorFromRotation(Camera.Rotation)
		local rightVec = getRightVectorFromRotation(Camera.Rotation)
		if not player.IsInputFocused then
			if up then
				position = position + Vector3.new(0, flySpeed, 0) * deltaTime
			end
			if down then
				position = position - Vector3.new(0, flySpeed, 0) * deltaTime
			end
			if forward then
				position = position + forwardVec * flySpeed * deltaTime
			end
			if backward then
				position = position - forwardVec * flySpeed * deltaTime
			end
			if left then
				position = position - rightVec * flySpeed * deltaTime
			end
			if right then
				position = position + rightVec * flySpeed * deltaTime
			end
		end
		player.Position = position
		player.Rotation = Camera.Rotation
		
	end
	if stoppedFlying then
		stoppedFlying = false
		player.CanMove = true
		player.WalkSpeed = oldWalkSpeed
		player.MaxStamina = oldMaxStamina
		player.Stamina = oldMaxStamina
		player.Rotation = Vector3.New(0, player.Rotation.y, 0)
	end
end

Input.KeyDown:Connect(onKeyDown)
Input.KeyUp:Connect(onKeyUp)
game.Rendered:Connect(onRendered)

FlyLib.ToggleFly = ToggleFly
FlyLib.SetSpeed = function(speed)
	flySpeed = tonumber(speed) or 32
end
FlyLib.Stop = function()
	ToggleFly(false)
	game.Rendered:Disconnect(onRendered)
	Input.KeyDown:Disconnect(onKeyDown)
	Input.KeyUp:Disconnect(onKeyUp)
end

return FlyLib