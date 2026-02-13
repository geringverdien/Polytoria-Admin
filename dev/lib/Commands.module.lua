local GUI = require("./GUI.module.lua")

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
    local cmd = string.lower(cmd)
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

local function FindTargetPlayer(name)
    local Players = game["Players"]
    for _, player in pairs(Players:GetPlayers()) do
        if string.find(string.lower(player.Name), string.lower(name)) then
            return player
        end
    end
    return game["Players"].LocalPlayer
end

return {
    AddCommand = AddCommand,
    GetCommand = GetCommand,
    GetCommands = GetCommands,
    RunCommand = RunCommand,
    FindTargetPlayer = FindTargetPlayer,
}