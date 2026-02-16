local GUI = require("./lib/GUI.module.lua")
local Commands = require("./lib/Commands.module.lua")
local FlyLib = require("./features/Fly.module.lua")
local FreecamLib = require("./features/Freecam.module.lua")

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