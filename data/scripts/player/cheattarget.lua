
function initialize()
    local ship = Entity(Player(sender).craftIndex)
    if ship == nil then return 0,"","" end
    ship.selectedObject:addScriptOnce("data/scripts/lib/entitydbg.lua")
    terminate()
end
