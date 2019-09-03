package.path = package.path .. ";data/scripts/lib/?.lua;"
include ("utility")
include ("stringutility")
include ("callable")

local timeBetweenReports = 60  -- in seconds

function initialize(who, ...)
    if onServer() then
        local x,y = Sector():getCoordinates()
        local player = Player()
        local lastReportSend = player:getValue("reportTimestamp") or 0
        if lastReportSend < Server().runtime - timeBetweenReports then
            local snippets = {...}
            local reasonText = ""
            for _,snippet in ipairs(snippets) do reasonText = reasonText.." "..snippet end

            player:setValue("reportTimestamp", Server().runtime)
            printlog("[" .. os.date("%Y-%m-%d %X") .. "] ".."[Report] From: "%_t, player.name, "in:"%_t, x, y, "who: "%_t, who, "reason: "%_t, reasonText)
            analyzeReport(who, ...)
        else
            player:sendChatMessage("Server", ChatMessageType.Whisp, "Report not send. You still have to wait %ds for another report."%_t, round(timeBetweenReports - (Server().runtime - lastReportSend)))
        end
    end
    terminate()
end

function analyzeReport(who, ...)
    player:sendChatMessage("Server", ChatMessageType.Whisp, "Report sent successfully"%_t)
end
