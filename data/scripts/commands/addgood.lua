
function execute(sender, commandName, ...)
    local args = {...}
    args[2] = tonumber(args[2])
    if type(args[1]) == "string" and type(args[2]) == "number" then
        Player(sender):setValue("goodName", args[1])
        Player(sender):setValue("amount", args[2])
        Player(sender):addScript("addGood.lua")
    end
    return 0, "", ""
end
 
function getDescription()
    return "A shorter way to get entitydbg"
end

function getHelp()
    return "A shorter way to get entitydbg"
end
