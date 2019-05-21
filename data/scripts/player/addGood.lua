if onServer() then
package.path = package.path .. ";data/scripts/lib/?.lua"
include ("utility")
include ("goods")

function initialize()
    local goodName = Player(sender):getValue("goodName")
    local amount = Player(sender):getValue("amount")
    Player(sender):setValue("goodName", nil)
    Player(sender):setValue("amount", nil)
    local ship = Entity(Player(sender).craftIndex)
    if ship == nil then return 0,"","" end
    if goods[goodName] then
        print("rec", goodName, amount)
        ship:addCargo(goods[goodName]:good(), amount)
    else
        Player(sender):sendChatMessage("server", 3 , "Good doesn't exist")
    end
    terminate()
end
end
