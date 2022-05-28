local MinigameActive = false
local SuccessTrigger = nil
local FailTrigger = nil

-- RegisterCommand('testminigame', function()
--     StartMinigame({
--         success = 'test:success',
--         fail = 'test:fail',
--     })
-- end)

-- RegisterNetEvent('test:success')
-- AddEventHandler('test:success', function()
--     print('success')
-- end)

-- RegisterNetEvent('test:fail')
-- AddEventHandler('test:fail', function()
--     print('fail')
-- end)

function StartMinigame(data)
    if MinigameActive then return end

    if data ~= nil then
        SuccessTrigger = data.success
        FailTrigger = data.fail

        SetNuiFocus(true, true)
        SendNUIMessage({action = 'start'})
        MinigameActive = true
    end
end

exports('StartMinigame', StartMinigame)

RegisterNUICallback('success', function(data, cb)
    SetNuiFocus(false, false)
    MinigameActive = false
    TriggerEvent(SuccessTrigger)

    SuccessTrigger = nil
    FailTrigger = nil
    cb('ok')
end)

RegisterNUICallback('fail', function(data, cb)
    SetNuiFocus(false, false)
    MinigameActive = false
    TriggerEvent(FailTrigger)

    SuccessTrigger = nil
    FailTrigger = nil
    cb('ok')
end)