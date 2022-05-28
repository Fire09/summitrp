RegisterServerEvent('mission:finished')
AddEventHandler('mission:finished', function(money)
    local src = source
    local player = GetPlayerName(src)
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    if money ~= nil then
        user:addMoney(money)
        if money > 110 then
        end
    end
end)

local counter = 0
RegisterServerEvent('delivery:status')
AddEventHandler('delivery:status', function(status)
    if status == -1 then
        counter = 0
    elseif status == 1 then
        counter = 2
    end
    TriggerClientEvent('delivery:deliverables', -1, counter, math.random(1,13))
end)
