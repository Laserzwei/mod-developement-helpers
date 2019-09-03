
function execute(sender, commandName)
    Player(sender).craft:addScriptOnce("data/scripts/entity/resourcetool.lua")
    return 0, "", ""
end

function getDescription()
    return "Allows viewing and modifyin of all online players resources."
end

function getHelp()
    return "usage /resourcetool "
end
