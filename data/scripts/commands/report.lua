
function execute(sender, commandName, who, ...)
    Player(sender).craft:addScriptOnce("data/scripts/player/report.lua", who, ...)
    return 0, "", ""
end

function getDescription()
    return "Allowy you to report any issue you encounter. Something doesn't work: \"/report server This doesn't work\". Another player used exploits: \"/report evilPlayer He exploited x and y!\""
end

function getHelp()
    return "usage /reprt <who> <reason>"
end
