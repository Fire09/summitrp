
--Rich Pres
local count = 0
RegisterNetEvent('rich:GetPlayers')
AddEventHandler('rich:GetPlayers', function()
    count = 0
    for _, playerId in ipairs(GetPlayers()) do
       count = count + 1
    end
    TriggerClientEvent('rich:TakePlayers', -1, count)
end)

