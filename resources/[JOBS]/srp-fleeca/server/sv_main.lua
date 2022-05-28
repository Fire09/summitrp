local robberyBusy = false
local timeOut = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60 * 30) -- 30 mins reset
        print("^1 Resetting all Fleecas Security's^0")
        TriggerClientEvent("srp-fleeca:client:enableAllBankSecurity", -1)
    end
end)

RegisterServerEvent('srp-fleeca:server:setBankState')
AddEventHandler('srp-fleeca:server:setBankState', function(bankId, state)
    if bankId == "pacific" then
        if not robberyBusy then
            Config.BigBanks["pacific"]["isOpened"] = state
            TriggerClientEvent('srp-fleeca:client:setBankState', -1, bankId, state)
            TriggerEvent('srp-fleeca:server:setTimeout')
        end
    else
        if not robberyBusy then
            Config.SmallBanks[bankId]["isOpened"] = state
            TriggerClientEvent('srp-fleeca:client:setBankState', -1, bankId, state)
            TriggerEvent('srp-fleeca:server:SetSmallbankTimeout', bankId)
        end
    end
    robberyBusy = true
end)

RegisterServerEvent('srp-fleeca:server:setLockerState')
AddEventHandler('srp-fleeca:server:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "pacific" then	
        Config.BigBanks["pacific"]["lockers"][lockerId][state] = bool
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end

    TriggerClientEvent('srp-fleeca:client:setLockerState', -1, bankId, lockerId, state, bool)
end)

RegisterServerEvent("isRobberyActive", function()
    local pSrc = source
    TriggerClientEvent("isRobberyActive:fleeca", pSrc, robberyBusy)
end)

RegisterServerEvent("robbery:get:config", function()
    TriggerClientEvent("robbery:get:config", source, Config)
end)


RegisterServerEvent('srp-fleeca:server:setTimeout')
AddEventHandler('srp-fleeca:server:setTimeout', function()
    if not robberyBusy then
        if not timeOut then
            timeOut = true
            Citizen.CreateThread(function()
                Citizen.Wait(30 * (60 * 1000))
                timeOut = false
                robberyBusy = false

                for k, v in pairs(Config.BigBanks["pacific"]["lockers"]) do
                    Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
                    Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
                end
			
                TriggerClientEvent('srp-fleeca:client:ClearTimeoutDoors', -1)
                Config.BigBanks["pacific"]["isOpened"] = false
            end)
        end
    end
end)

RegisterServerEvent('srp-fleeca:server:SetSmallbankTimeout')
AddEventHandler('srp-fleeca:server:SetSmallbankTimeout', function(BankId)
    if not robberyBusy then
        SetTimeout(30 * (30 * 1000), function()
            Config.SmallBanks[BankId]["isOpened"] = false
			
            for k, v in pairs(Config.BigBanks["pacific"]["lockers"]) do
                Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
                Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
            end
			
            timeOut = false
            robberyBusy = false
            TriggerClientEvent('srp-fleeca:client:ResetFleecaLockers', -1, BankId)
            TriggerEvent('lh-banking:server:SetBankClosed', BankId, false)
        end)
    end
end)

RegisterServerEvent('srp-fleeca:server:SetStationStatus')
AddEventHandler('srp-fleeca:server:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
    TriggerClientEvent("srp-fleeca:client:SetStationStatus", -1, key, isHit)
    if AllStationsHit() then
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        TriggerClientEvent("srp-fleeca:client:disableAllBankSecurity", -1)
    else
        CheckStationHits()
    end
end)
