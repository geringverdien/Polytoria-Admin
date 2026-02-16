local __module_env = {}

-- polybundle: module dev/lib/GUI.module.lua
__module_env["dev/lib/GUI.module.lua"] = (function()
local open = false
local openPosition = Vector2.New(0.99, 0)
local closedPosition = Vector2.New(0.99, -0.33)


-- Instance2Lua (github.com/geringverdien/Polytoria-Instance2Lua) --
local AdminGUI = Instance.New("GUI");
AdminGUI.Name = "AdminGUI";
AdminGUI.Visible = true;
local HolderFrame = Instance.New("UIView");
HolderFrame.Name = "HolderFrame";
HolderFrame.PivotPoint = Vector2.New(1, 0);
HolderFrame.PositionOffset = Vector2.New(0, 0);
HolderFrame.PositionRelative = closedPosition;
HolderFrame.Rotation = 0;
HolderFrame.SizeOffset = Vector2.New(0, 0);
HolderFrame.SizeRelative = Vector2.New(0.175, 0.375);
HolderFrame.Visible = true;
HolderFrame.ClipDescendants = false;
HolderFrame.Color = Color.New(1.000, 1.000, 1.000, 0.000);
HolderFrame.BorderColor = Color.New(0.133, 0.133, 0.133, 0.898);
HolderFrame.BorderWidth = 0;
HolderFrame.CornerRadius = 0;
HolderFrame.Parent = AdminGUI;
local UIVerticalLayout = Instance.New("UIVerticalLayout");
UIVerticalLayout.Name = "UIVerticalLayout";
UIVerticalLayout.PivotPoint = Vector2.New(0, 0);
UIVerticalLayout.PositionOffset = Vector2.New(0, 0);
UIVerticalLayout.PositionRelative = Vector2.New(0, 0);
UIVerticalLayout.Rotation = 0;
UIVerticalLayout.SizeOffset = Vector2.New(0, 0);
UIVerticalLayout.SizeRelative = Vector2.New(1, 1);
UIVerticalLayout.Visible = true;
UIVerticalLayout.ClipDescendants = false;
UIVerticalLayout.ChildAlignment = TextAnchor.UpperLeft;
UIVerticalLayout.ChildControlHeight = false;
UIVerticalLayout.ChildControlWidth = false;
UIVerticalLayout.ChildForceExpandHeight = false;
UIVerticalLayout.ChildForceExpandWidth = false;
UIVerticalLayout.ChildScaleHeight = false;
UIVerticalLayout.ChildScaleWidth = false;
UIVerticalLayout.PaddingBottom = 0;
UIVerticalLayout.PaddingLeft = 5;
UIVerticalLayout.PaddingRight = 0;
UIVerticalLayout.PaddingTop = 5;
UIVerticalLayout.ReverseAlignment = false;
UIVerticalLayout.Spacing = 5;
UIVerticalLayout.Parent = HolderFrame;
local CMDInput = Instance.New("UITextInput");
CMDInput.Name = "CMDInput";
CMDInput.PivotPoint = Vector2.New(0, 1);
CMDInput.PositionOffset = Vector2.New(0, 0);
CMDInput.PositionRelative = Vector2.New(0, 0);
CMDInput.Rotation = 0;
CMDInput.SizeOffset = Vector2.New(-10, 0);
CMDInput.SizeRelative = Vector2.New(1, 0.1);
CMDInput.Visible = true;
CMDInput.ClipDescendants = false;
CMDInput.Color = Color.New(0.264, 0.264, 0.264, 1.000);
CMDInput.BorderColor = Color.New(0.000, 0.000, 0.000, 1.000);
CMDInput.BorderWidth = 0;
CMDInput.CornerRadius = 0;
CMDInput.Text = "";
CMDInput.Placeholder = "; or click here to enter commands";
CMDInput.PlaceholderColor = Color.New(0.500, 0.500, 0.500, 1.000);
CMDInput.TextColor = Color.New(0.870, 0.870, 0.870, 1.000);
CMDInput.FontSize = 10;
CMDInput.Font = TextFontPreset.RobotoMono;
CMDInput.AutoSize = true;
CMDInput.MaxFontSize = 10;
CMDInput.JustifyText = TextJustify.Left;
CMDInput.VerticalAlign = TextVerticalAlign.Middle;
CMDInput.IsReadOnly = false;
CMDInput.IsMultiline = false;
CMDInput.Parent = UIVerticalLayout;
local SuggestionHolder = Instance.New("UIView");
SuggestionHolder.Name = "SuggestionHolder";
SuggestionHolder.PivotPoint = Vector2.New(0, 0);
SuggestionHolder.PositionOffset = Vector2.New(0, 0);
SuggestionHolder.PositionRelative = Vector2.New(0.5, 0.5);
SuggestionHolder.Rotation = 0;
SuggestionHolder.SizeOffset = Vector2.New(-10, 0);
SuggestionHolder.SizeRelative = Vector2.New(1, 0.87);
SuggestionHolder.Visible = true;
SuggestionHolder.ClipDescendants = false;
SuggestionHolder.Color = Color.New(0.263, 0.263, 0.263, 1.000);
SuggestionHolder.BorderColor = Color.New(0.000, 0.000, 0.000, 1.000);
SuggestionHolder.BorderWidth = 0;
SuggestionHolder.CornerRadius = 0;
SuggestionHolder.Parent = UIVerticalLayout;
local CommandsLabel = Instance.New("UILabel");
CommandsLabel.Name = "CommandsLabel";
CommandsLabel.PivotPoint = Vector2.New(0, 0);
CommandsLabel.PositionOffset = Vector2.New(10, 10);
CommandsLabel.PositionRelative = Vector2.New(0, 0);
CommandsLabel.Rotation = 0;
CommandsLabel.SizeOffset = Vector2.New(-20, -20);
CommandsLabel.SizeRelative = Vector2.New(1, 1);
CommandsLabel.Visible = true;
CommandsLabel.ClipDescendants = false;
CommandsLabel.Color = Color.New(1.000, 1.000, 1.000, 0.000);
CommandsLabel.BorderColor = Color.New(0.000, 0.000, 0.000, 0.000);
CommandsLabel.BorderWidth = 0;
CommandsLabel.CornerRadius = 0;
CommandsLabel.Text = "";
CommandsLabel.TextColor = Color.New(0.000, 0.000, 0.000, 1.000);
CommandsLabel.FontSize = 12;
CommandsLabel.Font = TextFontPreset.RobotoMono;
CommandsLabel.AutoSize = false;
CommandsLabel.MaxFontSize = 100;
CommandsLabel.JustifyText = TextJustify.Left;
CommandsLabel.VerticalAlign = TextVerticalAlign.Top;
CommandsLabel.Parent = SuggestionHolder;


local function SetOpen(isOpen)
    open = isOpen
    local targetPosition = isOpen and openPosition or closedPosition
    Tween:TweenVector2(HolderFrame.PositionRelative, targetPosition, 0.1, 
    function(value)
        HolderFrame.PositionRelative = value
    end,
    TweenType.easeOutQuad,
    function()
        if isOpen then
            CMDInput:Focus()
        end
    end)
end

local function GetGUI()
    return {
        AdminGUI = AdminGUI;
        HolderFrame = HolderFrame;
        CMDInput = CMDInput;
        CommandsLabel = CommandsLabel;
    }
end

return {
    GetGUI = GetGUI;
    SetOpen = SetOpen;
}
end)()

-- polybundle: module dev/lib/Commands.module.lua
__module_env["dev/lib/Commands.module.lua"] = (function()
local GUI = __module_env["dev/lib/GUI.module.lua"]

local Players = game["Players"]

local Commands = {}

local function splitString(inp, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inp, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

local function parseCommand(cmd)
    cmd = string.lower(cmd)
    local split = splitString(cmd, " ")
    local commandName = split[1]
    table.remove(split, 1)
    return commandName, split
end

local function AddCommand(name, func, description)
    Commands[name] = {
        func = func;
        description = description;
    }
end

local function GetCommand(name)
    return Commands[name]
end

local function GetCommands()
    return Commands
end

local function RunCommand(cmd)
    local commandName, args = parseCommand(cmd)
    local command = GetCommand(commandName)
    if command then
        command.func(args)
    else
        print("Command not found: " .. commandName)
    end
end

local function getRandomTarget()
    local players = Players:GetPlayers()
    return players[math.random(2, #players)]
end

local function FindTargetPlayer(name)
    name = string.lower(name)
    if name == "random" then return getRandomTarget() end
    if name == "me" then return Players.LocalPlayer end
    for _, player in pairs(Players:GetPlayers()) do
        if string.find(string.lower(player.Name), name) then
            return player
        end
    end
    return Players.LocalPlayer
end

return {
    AddCommand = AddCommand,
    GetCommand = GetCommand,
    GetCommands = GetCommands,
    RunCommand = RunCommand,
    FindTargetPlayer = FindTargetPlayer,
}
end)()

-- polybundle: module dev/features/Fly.module.lua
__module_env["dev/features/Fly.module.lua"] = (function()
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
end)()

-- polybundle: module dev/features/Freecam.module.lua
__module_env["dev/features/Freecam.module.lua"] = (function()
local FreecamLib = {}

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

local onRendered
local onKeyDown
local onKeyUp

local cos = math.cos
local sin = math.sin

local oldCameraMode = Camera.Mode
local lastMousePos = Input.MousePosition
local lockedState = Input.CursorLocked
local RMBDown = false

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
    elseif key == "Mouse1" then
        RMBDown = true
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
    elseif key == "Mouse1" then
        RMBDown = false
	end
end

local clamp = function(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

local function normalizeAngle(angle)
    while angle > 180 do
        angle = angle - 360
    end
    while angle < -180 do
        angle = angle + 360
    end
    return angle
end

onRendered = function(deltaTime)
	if isFlying then
		if startedFlying then
			startedFlying = false
			position = Camera.Position
            oldCameraMode = Camera.Mode
            lastMousePos = Input.MousePosition
            lockedState = Input.CursorLocked
            Camera.Mode = CameraMode.Scripted
            --Input.CursorLocked = true
            player.CanMove = false
		end
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
		Camera.Position = position
        local mouseDelta = Input.MousePosition - lastMousePos
        lastMousePos = Input.MousePosition

        if RMBDown then
            local rotX = mouseDelta.y * 10 * deltaTime
            local rotY = mouseDelta.x * 10 * deltaTime
            local currentRot = Camera.Rotation

            local newRotX = normalizeAngle(currentRot.x - rotX)
            newRotX = clamp(newRotX, -89, 89)
            
            currentRot = Vector3.New(
                newRotX,
                currentRot.y + rotY,
                0
            )
            Camera.Rotation = Vector3.New(currentRot.x, currentRot.y, 0)
        end
	end
	if stoppedFlying then
		stoppedFlying = false
        Camera.Mode = oldCameraMode
        --Input.CursorLocked = lockedState
        player.CanMove = true
	end
end

Input.KeyDown:Connect(onKeyDown)
Input.KeyUp:Connect(onKeyUp)
game.Rendered:Connect(onRendered)

FreecamLib.ToggleFly = ToggleFly
FreecamLib.SetSpeed = function(speed)
	flySpeed = tonumber(speed) or 32
end
FreecamLib.Stop = function()
	ToggleFly(false)
	game.Rendered:Disconnect(onRendered)
	Input.KeyDown:Disconnect(onKeyDown)
	Input.KeyUp:Disconnect(onKeyUp)
end

return FreecamLib
end)()

-- polybundle: begin dev\init.lua
spawn(function()
local GUI = __module_env["dev/lib/GUI.module.lua"]
local Commands = __module_env["dev/lib/Commands.module.lua"]
local FlyLib = __module_env["dev/features/Fly.module.lua"]
local FreecamLib = __module_env["dev/features/Freecam.module.lua"]

local Components = GUI.GetGUI()
local MainGUI = Components.AdminGUI
local CMDInput = Components.CMDInput
local CommandList = Components.CommandsLabel
local Players = game["Players"];
local LocalPlayer = Players.LocalPlayer;

local activatetool = activatetool or function() return error("activatetool not implemented in executor") end

local function onSubmit()
    local text = CMDInput.Text
    if text == "" then GUI.SetOpen(false) return end

    CMDInput.Text = ""
    Commands.RunCommand(text)
    GUI.SetOpen(false)
end

local function onFocus()
    GUI.SetOpen(true)
end

local function onChanged()
    local text = string.lower(CMDInput.Text)
    local suggestions = {}

    local commands = Commands.GetCommands()
    for name, cmd in pairs(commands) do
        local cmdString = name .. " - " .. cmd.description
        if string.find(cmdString, text) or string.find(text, name) then
            table.insert(suggestions, cmdString)
        end
    end

    CommandList.Text = table.concat(suggestions, "\n")
end

local function onKeyDown(key)
    if key ~= "Semicolon" then return end
    onFocus()
end

CMDInput.MouseUp:Connect(onFocus)
CMDInput.Submitted:Connect(onSubmit)
CMDInput.Changed:Connect(onChanged)
Input.KeyDown:Connect(onKeyDown)

local function stopScript()
    Input.KeyDown:Disconnect(onKeyDown)
    FlyLib.Stop()
    FreecamLib.Stop()
    MainGUI:Destroy()
end

local function mouseTP()
    local mousePos = Input.MousePosition
    local screenPoint = Vector3.New(mousePos.x, mousePos.y, 0)
    local rayResult = Input:ScreenPointToRay(screenPoint)
    if rayResult then
        LocalPlayer.Position = rayResult.Position + Vector3.New(0, 3, 0)
    end
end

Commands.AddCommand("cmds", function(args)
    local commands = Commands.GetCommands()
    print("commands:")
    for name, cmd in pairs(commands) do
        print(name .. ": " .. cmd.description)
    end
end, "List all commands")

Commands.AddCommand("stop", function(args)
    stopScript()
end, "Stops the admin script")

Commands.AddCommand("goto", function(args)
    local targetName = args[1]
    if not targetName then return end

    local targetPlayer = Commands.FindTargetPlayer(targetName)

    LocalPlayer.Position = targetPlayer.Position
end, "Teleports to a player")

Commands.AddCommand("fly", function(args)
    FlyLib.ToggleFly(true)
end, "Enables fly")

Commands.AddCommand("fc", function(args)
    FreecamLib.ToggleFly(true)
end, "Enables freecam")

Commands.AddCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    LocalPlayer.WalkSpeed = speed
end, "Sets walk speed")

Commands.AddCommand("jumppower", function(args)
    local power = tonumber(args[1]) or 36
    LocalPlayer.JumpPower = power
end, "Sets jump power")

Commands.AddCommand("crash", function()
    spawn(function()
        while true do
            LocalPlayer:Respawn()
        end
    end)
end, "Crashes the server")

Commands.AddCommand("respawn", function()
    LocalPlayer:Respawn()
end, "Respawns the player")

Commands.AddCommand("rescale", function(args)
    local scale = tonumber(args[1]) or 1
    LocalPlayer.Size = Vector3.New(scale, scale, scale)
end, "Change player size to [number]")

Commands.AddCommand("seizure", function()
    FlyLib.ToggleFly(true)
    LocalPlayer.Size = Vector3.New(2^32, 10, 2^32)
end, "Induces seizures")

Commands.AddCommand("size", function(args)
    local x = tonumber(args[1]) or 1
    local y = tonumber(args[2]) or 1
    local z = tonumber(args[3]) or 1
    LocalPlayer.Size = Vector3.New(x, y, z)
end, "Change player size to [x] [y] [z]")

Commands.AddCommand("invis", function(args)
    LocalPlayer.Size = Vector3.New(0.01, 0.01, 0.01)
end, "Makes you invisible")

Commands.AddCommand("mtp", function(args)
    mouseTP()
end, "Teleports to where your mouse is pointing")

Commands.AddCommand("clicktp", function(args)
    local tool = Instance.New("Tool")
    tool.Name = "ClickTP"
    tool.Droppable = false

    tool.Activated:Connect(mouseTP)
    tool.Parent = LocalPlayer["Backpack"]
end, "Gives you a click tp tool")

Commands.AddCommand("firetool", function(args)
    local targetName = args[1]
    if not targetName then return end

    local targetPlayer = Commands.FindTargetPlayer(targetName)
    if not targetPlayer then return end

    local tool = targetPlayer:FindChildByClass("Tool")
    if not tool then return end

    local res = activatetool(tool)
    print("firetool result:", res)

end, "Tries to activate target's tool")

Commands.AddCommand("test", function()
    local player = game["Players"].LocalPlayer
    local tool = player:FindChildByClass("Tool")
    if tool then
        activatetool(tool)
    end
end, "test command")

Commands.AddCommand("unfly", function(args)
    FlyLib.ToggleFly(false)
end, "Disables fly")

Commands.AddCommand("unfc", function(args)
    FreecamLib.ToggleFly(false)
end, "Disables freecam")

Commands.AddCommand("unseizure", function()
    LocalPlayer.Size = Vector3.New(1, 1, 1)
    FlyLib.ToggleFly(false)
end, "Stops seizures")

Commands.AddCommand("vis", function(args)
    LocalPlayer.Size = Vector3.New(1, 1, 1)
    LocalPlayer.Position = LocalPlayer.Position + Vector3.New(0, 3, 0)
end, "Makes you visible")

Commands.AddCommand("flyspeed", function(args)
    local speed = tonumber(args[1]) or 32
    FlyLib.SetSpeed(speed)
end, "Sets fly speed")

Commands.AddCommand("fcspeed", function(args)
    local speed = tonumber(args[1]) or 32
    FreecamLib.SetSpeed(speed)
end, "Sets freecam speed")

-- Commands.AddCommand("follow", function(args)
--     local targetName = args[1]
--     if not targetName then return end

--     local targetPlayer = Commands.FindTargetPlayer(targetName)
--     if not targetPlayer then return end

--     while true do
--         LocalPlayer.Position = targetPlayer.Position - Vector3.New(0, 0, 3)
--         task.wait()
--     end
-- end, "Follows a player")


onChanged()
MainGUI.Parent = game["PlayerGUI"];
end)
-- polybundle: end dev\init.lua
