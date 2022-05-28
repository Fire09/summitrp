local steamIds = {
 ---   ["steam:11000010aa15521"] = true --kevin
}



RegisterServerEvent('srp-doors:alterlockstate2')
AddEventHandler('srp-doors:alterlockstate2', function()
    --SRP.DoorCoords[10]["lock"] = 0

    TriggerClientEvent('srp-doors:alterlockstateclient', source, SRP.DoorCoords)

end)

RegisterServerEvent('srp-doors:alterlockstate')
AddEventHandler('srp-doors:alterlockstate', function(alterNum)
    print('lockstate:', alterNum)
    SRP.alterState(alterNum)
end)

RegisterServerEvent('srp-doors:ForceLockState')
AddEventHandler('srp-doors:ForceLockState', function(alterNum, state)
    SRP.DoorCoords[alterNum]["lock"] = state
    TriggerClientEvent('SRP:Door:alterState', -1,alterNum,state)
end)

function isDoorLocked(door)
    if SRP.DoorCoords[door].lock == 1 then
        return true
    else
        return false
    end
end