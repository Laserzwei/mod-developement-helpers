package.path = package.path .. ";data/scripts/lib/?.lua"

function execute(sender, commandName, ...)
    Player(sender):addScriptOnce("cheattarget.lua")
    return 0, "", ""
end

function getDescription()
    return "A shorter way to get entitydbg on the targeted Entity"
end

function getHelp()
    return "A shorter way to get entitydbg on the targeted Entity"
end
