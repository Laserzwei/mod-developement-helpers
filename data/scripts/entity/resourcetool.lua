
package.path = package.path .. ";data/scripts/lib/?.lua;"
include ("utility")
include ("randomext")
include ("stringutility")
include ("callable")

--data
local resources = {
[1] = MaterialType.Iron,
[2] = MaterialType.Titanium,
[3] = MaterialType.Naonite,
[4] = MaterialType.Trinium,
[5] = MaterialType.Xanion,
[6] = MaterialType.Ogonite,
[7] = MaterialType.Avorion,
[8] = {name = "Cr", color = ColorRGB(0.7, 0.7, 0.2)}
}

local selectedPlayer
local lines = {}
local elementToData = {}

function initialize()

end

function interactionPossible(playerIndex, option)
    return Player().index == playerIndex
end

function initUI()

        local res = getResolution()
        local size = vec2(450, 330)

        local menu = ScriptUI()
        window = menu:createWindow(Rect(res * 0.5 - size * 0.5, res * 0.5 + size * 0.5))

        window.caption = "Resource Tool"
        window.showCloseButton = 1
        window.moveable = 1
        menu:registerWindow(window, "Resource Tool")

        local playerx = 10
        local textx = 10
        local y = 10
        local plusButtonX = 160
        local minusButtonX = 190
        local labelx = 220

        playerSelectionCombo = window:createValueComboBox(Rect(playerx, y, playerx + 200, y + 25), "playerSelected")
        y = y + 35
        for i,mat in ipairs(resources) do
            local material = Material(mat)
            local tb = window:createTextBox(Rect(textx,y,textx+140,y+25), "onTextEntered")
            tb.allowedCharacters = "1234567890"
            elementToData[tb.index] = i
            local plusButton = window:createButton(Rect(plusButtonX, y, plusButtonX+25,y+25), "", "onplusButtonPressed")
            plusButton.icon = "data/textures/icons/plus.png"
            elementToData[plusButton.index] = i
            local minusButton = window:createButton(Rect(minusButtonX, y, minusButtonX+25,y+25), "", "onminusButtonPressed")
            minusButton.icon = "data/textures/icons/minus.png"
            elementToData[minusButton.index] = i
            local label = window:createLabel(vec2(labelx,y), "", 12)
            label.color = material.color
            if i == 8 then label.color = resources[8].color end
            elementToData[label.index] = i
            lines[i] = {textBox = tb, plusButton = plusButton, minusButton = minusButton, matLabel = label}
            y = y +35
        end

        uiInitialized = true
        invokeServerFunction("sendPlayers")
end

function onShowWindow()
    invokeServerFunction("sendPlayers")
end

function sendPlayers()
    local players = {Server():getOnlinePlayers()} or {}
    local indices, namedIndex = {}, {}
    for _, player in pairs(players) do
        table.insert(indices, player.index)
        namedIndex[player.index] = player.name
    end
    invokeClientFunction(Player(callingPlayer), "receivePlayers", indices, namedIndex)
end
callable(nil, "sendPlayers")

function receivePlayers(indices, namedIndex)
    playerSelectionCombo:clear()
    playerSelectionCombo:addEntry(nil, "-Select Player-")
    for k,playerIndex in ipairs(indices) do
        playerSelectionCombo:addEntry(playerIndex, namedIndex[playerIndex])
    end
end

function refreshUI()
    if selectedPlayer and valid(Player(selectedPlayer)) then
        local player = Player(selectedPlayer)
        local playerResources = {player:getResources()}
        for i,line in ipairs(lines) do
            if i == 8 then
                line.matLabel.caption = createMonetaryString(tostring(player.money)).." "..resources[i].name%_t
            else
                line.matLabel.caption = createMonetaryString(tostring(playerResources[i])).." "..Material(resources[i]).name%_t
            end
        end
    else
        for i,line in ipairs(lines) do
            if i == 8 then
                line.matLabel.caption = ""
            else
                line.matLabel.caption = ""
            end
        end
    end
end

function onTextEntered(box)
end

function onplusButtonPressed(button)
    if not selectedPlayer then return end
    local text = lines[elementToData[button.index]].textBox.text
    local amount = 0
    if string.len(text) > 0 then
        amount = tonumber(text)
    end
    sendResRequest(amount, elementToData[button.index])
end

function onminusButtonPressed(button)
    if not selectedPlayer then return end
    local text = lines[elementToData[button.index]].textBox.text
    local amount = 0
    if string.len(text) > 0 then
        amount = tonumber(text)
    end
    sendResRequest(-amount, elementToData[button.index])
end

function sendResRequest(amount, index)
    local res = {}
    for i=1, 8, 1 do
        res[i] = 0
    end
    res[index] = amount
    invokeServerFunction("alterResources", res, selectedPlayer)
end

function alterResources(res, playerIndex)
    if not Server():hasAdminPrivileges(Player(callingPlayer)) then print(Player(callingPlayer).name, "Tried to access alterResources") return end
    local player = Player(playerIndex)
    player:receive("", res[8], res[1], res[2], res[3], res[4], res[5], res[6], res[7])
    invokeClientFunction(Player(callingPlayer), "refreshUI")
end
callable(nil, "alterResources")

function playerSelected(comboBoxIndex, value, selectedIndex)
    selectedPlayer = value
    refreshUI()
end
