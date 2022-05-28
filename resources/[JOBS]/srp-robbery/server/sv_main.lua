local robberyBusy = false
local timeOut = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60 * 30) -- 30 mins reset
        print("^1 Resetting all Banks Security's^0")
        TriggerClientEvent("srp-robbery:client:enableAllBankSecurity", -1)
    end
end)

RegisterServerEvent('srp-robbery:server:setBankState')
AddEventHandler('srp-robbery:server:setBankState', function(bankId, state)
    if bankId == "pacific" then
        if not robberyBusy then
            Config.BigBanks["pacific"]["isOpened"] = state
            TriggerClientEvent('srp-robbery:client:setBankState', -1, bankId, state)
            TriggerEvent('srp-robbery:server:setTimeout')
        end
    else
        if not robberyBusy then
            Config.SmallBanks[bankId]["isOpened"] = state
            TriggerClientEvent('srp-robbery:client:setBankState', -1, bankId, state)
            TriggerEvent('srp-robbery:server:SetSmallbankTimeout', bankId)
        end
    end
    robberyBusy = true
end)

RegisterServerEvent('srp-robbery:server:setLockerState')
AddEventHandler('srp-robbery:server:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "pacific" then	
        Config.BigBanks["pacific"]["lockers"][lockerId][state] = bool
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end

    TriggerClientEvent('srp-robbery:client:setLockerState', -1, bankId, lockerId, state, bool)
end)

RegisterServerEvent("isRobberyActive", function()
    local pSrc = source
    TriggerClientEvent("isRobberyActive:fleeca", pSrc, robberyBusy)
end)

RegisterServerEvent("robbery:get:config", function()
    TriggerClientEvent("robbery:get:config", source, Config)
end)


RegisterServerEvent('srp-robbery:server:setTimeout')
AddEventHandler('srp-robbery:server:setTimeout', function()
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
			
                TriggerClientEvent('srp-robbery:client:ClearTimeoutDoors', -1)
                Config.BigBanks["pacific"]["isOpened"] = false
            end)
        end
    end
end)

RegisterServerEvent('srp-robbery:server:SetSmallbankTimeout')
AddEventHandler('srp-robbery:server:SetSmallbankTimeout', function(BankId)
    if not robberyBusy then
        SetTimeout(30 * (30 * 1000), function()
            Config.SmallBanks[BankId]["isOpened"] = false
			
            for k, v in pairs(Config.BigBanks["pacific"]["lockers"]) do
                Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
                Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
            end
			
            timeOut = false
            robberyBusy = false
            TriggerClientEvent('srp-robbery:client:ResetFleecaLockers', -1, BankId)
            TriggerEvent('lh-banking:server:SetBankClosed', BankId, false)
        end)
    end
end)

RegisterServerEvent('srp-robbery:server:SetStationStatus')
AddEventHandler('srp-robbery:server:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
    TriggerClientEvent("srp-robbery:client:SetStationStatus", -1, key, isHit)
    if AllStationsHit() then
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        TriggerClientEvent("srp-robbery:client:disableAllBankSecurity", -1)
    else
        CheckStationHits()
    end
end)
