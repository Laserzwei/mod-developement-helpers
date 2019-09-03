package.path = package.path .. ";data/scripts/player/?.lua"

function execute(sender, commandName)
    Player(sender).craft:addScriptOnce("data/scripts/entity/moduleViewer.lua")
    return 0, "", ""
end

function getDescription()
    return "Allows viewing and moving of all players items (Upgrades & Turrets) between their Inventories."
end

function getHelp()
    return "usage /moduleviewer"
end
