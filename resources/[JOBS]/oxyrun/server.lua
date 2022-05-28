RegisterServerEvent('esxoxy:serverPay')
AddEventHandler('esxoxy:serverPay', function()
    TriggerClientEvent("oxyrunesx:startOxyRun", source)

end)

RegisterServerEvent('oxy:givemoney')
AddEventHandler('oxy:givemoney', function()
local src = source
local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    user:addMoney(1945)
end)