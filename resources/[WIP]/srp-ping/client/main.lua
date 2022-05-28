local pendingPing = nil
local isPending = false

function TimeoutPingRequest()
    Citizen.CreateThread(function()
        local count = 0
        while isPending do
            count = count + 1
            if count >= Config.Timeout and isPending then
                TriggerEvent('DoLongHudText', 'Ping From ' .. pendingPing.name .. ' Timed Out', 1)
                TriggerServerEvent('srp-ping:server:SendPingResult', pendingPing.id, 'timeout')
                pendingPing = nil
                isPending = false
            end
            Citizen.Wait(1000)
        end
    end)
end

function TimeoutBlip()
    Citizen.CreateThread(function()
        while pendingPing ~= nil do
            if pendingPing.count ~= nil then
                if pendingPing.count >= Config.BlipDuration then
                    RemoveBlip(pendingPing.blip)
                    pendingPing = nil
                else
                    pendingPing.count = pendingPing.count + 1
                end
            end
            Citizen.Wait(1000)
        end
    end)
end

function RemoveBlipDistance()
    local player = PlayerPedId()
    Citizen.CreateThread(function()
        while pendingPing ~= nil do
            local plyCoords = GetEntityCoords(player)
            local dist = math.floor(#(vector2(pendingPing.pos.x, pendingPing.pos.y) - vector2(plyCoords.x, plyCoords.y)))

            if dist < Config.DeleteDistance then
                RemoveBlip(pendingPing.blip)
                pendingPing = nil
            else
                Citizen.Wait(math.floor((dist - Config.DeleteDistance) * 30))
            end
        end
    end)
end

RegisterNetEvent('srp-ping:client:SendPing')
AddEventHandler('srp-ping:client:SendPing', function(sender, senderId, pCoords)
    if pendingPing == nil then
        pendingPing = {}
        pendingPing.id = senderId
        pendingPing.name = sender
        pendingPing.pos = pCoords

        TriggerServerEvent('srp-ping:server:SendPingResult', pendingPing.id, 'received')
        TriggerEvent('DoLongHudText', pendingPing.name .. ' Sent You a Ping, Use /ping accept To Accept', 1)
        isPending = true

        if Config.Timeout > 0 then
            TimeoutPingRequest()
        end

    else
        TriggerEvent('DoLongHudText', sender .. ' Attempted To Ping You', 1)
        TriggerServerEvent('srp-ping:server:SendPingResult', senderId, 'unable')
    end
end)

RegisterNetEvent('srp-ping:client:AcceptPing')
AddEventHandler('srp-ping:client:AcceptPing', function()
    if isPending then
        pendingPing.blip = AddBlipForCoord(pendingPing.pos.x, pendingPing.pos.y, pendingPing.pos.z)
        SetBlipSprite(pendingPing.blip, 280)
        SetBlipAsShortRange(pendingPing.blip, true)
        SetBlipScale(pendingPing.blip, 0.7)
        SetBlipColour(pendingPing.blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(pendingPing.name)
        EndTextCommandSetBlipName(pendingPing.blip)
        pendingPing.count = 0

        if Config.RouteToPing then
            SetNewWaypoint(pendingPing.pos.x, pendingPing.pos.y)
        end

        if Config.Timeout > 0 then
            TimeoutBlip()
        end

        if Config.DeleteDistance > 0 then
            RemoveBlipDistance()
        end

        TriggerEvent('DoLongHudText', pendingPing.name .. '\'s Location Showing On Map', 1)
        TriggerServerEvent('srp-ping:server:SendPingResult', pendingPing.id, 'accept')
        isPending = false
    else
        TriggerEvent('DoLongHudText', 'You Have No Pending Ping', 2)
    end
end)

RegisterNetEvent('srp-ping:client:RejectPing')
AddEventHandler('srp-ping:client:RejectPing', function()
    if pendingPing ~= nil then
        TriggerEvent('DoLongHudText', 'Rejected Ping From ' .. pendingPing.name, 2)
        TriggerServerEvent('srp-ping:server:SendPingResult', pendingPing.id, 'reject')
        pendingPing = nil
        isPending = false
    else
        TriggerEvent('DoLongHudText', 'You Have No Pending Ping', 2)
    end
end)

RegisterNetEvent('srp-ping:client:RemovePing')
AddEventHandler('srp-ping:client:RemovePing', function()
    if pendingPing ~= nil then
        RemoveBlip(pendingPing.blip)
        pendingPing = nil
        TriggerEvent('DoLongHudText', 'Player Ping Removed', 2)
    else
        TriggerEvent('DoLongHudText', 'You Have No Pending Ping', 2)
    end
end)

RegisterCommand('ping', function(src, args, raw)
    TriggerServerEvent("srp-ping:attempt",  GetEntityCoords(PlayerPedId()), args[1])
end)
