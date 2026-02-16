local GUI = require("./GUI.module.lua")

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