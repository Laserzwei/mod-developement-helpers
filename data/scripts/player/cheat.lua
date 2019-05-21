
function initialize()
    local ship = Entity(Player(sender).craftIndex)
    if ship == nil then return 0,"","" end
    if not ship:hasScript("data/scripts/lib/entitydbg.lua") then
        ship:addScript("data/scripts/lib/entitydbg.lua")
    end
    terminate()
end