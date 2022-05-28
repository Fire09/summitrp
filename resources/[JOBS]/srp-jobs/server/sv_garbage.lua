

RegisterNetEvent('srp-garbage:pay')
AddEventHandler('srp-garbage:pay', function(jobStatus)
    local _source = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(_source)
    local identity = GetPlayerIdentifiers(_source)
    if jobStatus then
        if user ~= nil then
            local randomMoney = math.random(700,2000)
            user:addMoney(randomMoney)
        end
    else
        print("Probably a cheater")
    end
end)


RegisterNetEvent('srp-garbage:reward')
AddEventHandler('srp-garbage:reward', function(rewardStatus)
    print("in server side")
    local _source = source
    local matherino = math.random(0, 6)
    if rewardStatus then
        if matherino == 2 then
            TriggerClientEvent('player:receiveItem', _source, 'plastic', math.random(4,6))
            TriggerClientEvent('player:receiveItem', _source, 'rubber', math.random(4,6))
        end
        if math.random(9) == 1 then
            TriggerClientEvent("player:receiveItem", _source, "scrapmetal", 7)
        end
    else
        print("Probably a cheater") 
    end
end)

