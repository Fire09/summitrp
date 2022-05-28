

Citizen.CreateThread(function()    
    TriggerServerEvent("robbery:get:config")
    ResetBankDoors()
end)


RegisterNetEvent("robbery:get:config", function(pConfig)
    Config = pConfig
end)


-- Code
local closestBank = nil
local inRange
local laptop = 0

Citizen.CreateThread(function()
    Citizen.Wait(1)
    while true do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local dist
            inRange = false
            for k, v in pairs(Config.SmallBanks) do
                dist = GetDistanceBetweenCoords(pos, Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"])
                if dist < 15 then
                    closestBank = k
                    inRange = true
                end
            end
            if not inRange then
                Citizen.Wait(1000)
                closestBank = nil
            end

        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1)
    while true do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)

  
        if closestBank ~= nil then
            if not Config.SmallBanks[closestBank]["isOpened"] then
                local dist = GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank].coords.x, Config.SmallBanks[closestBank].coords.y, Config.SmallBanks[closestBank].coords.z)
            end
            if Config.SmallBanks[closestBank]["isOpened"] then
                for k, v in pairs(Config.SmallBanks[closestBank]["lockers"]) do
                    local dist = GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank]["lockers"][k].x, Config.SmallBanks[closestBank]["lockers"][k].y, Config.SmallBanks[closestBank]["lockers"][k].z)
                    if not Config.SmallBanks[closestBank]["lockers"][k]["isBusy"] then
                        if not Config.SmallBanks[closestBank]["lockers"][k]["isOpened"] then
                            if dist < 5 then

                                DrawMarker(27,Config.SmallBanks[closestBank]["lockers"][k].x, Config.SmallBanks[closestBank]["lockers"][k].y, Config.SmallBanks[closestBank]["lockers"][k].z-0.9, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 255,0,0, 60, 0, 0, 2, 0, 0, 0, 0)

                                if dist < 0.5 then
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        OpenLocker(closestBank, k)
                                    end   
                                end
                            end
                        end
                    end
                end
            end
        else
            Citizen.Wait(2500)
        end
    
        Citizen.Wait(1)
    end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)

end

RegisterNetEvent("isRobberyActive:fleeca")
AddEventHandler("isRobberyActive:fleeca", function(pBusy)
    isBusy = pBusy
end)

RegisterNetEvent('srp-fleeca:usb')
AddEventHandler('srp-fleeca:usb', function()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    if exports["isPed"]:isPed("countpolice") >= 0 then
    if closestBank ~= nil then
        TriggerServerEvent("isRobberyActive")
        Citizen.Wait(500)
        if not isBusy then
            if closestBank ~= nil then
                local dist = GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank].coords.x, Config.SmallBanks[closestBank].coords.y, Config.SmallBanks[closestBank].coords.z)
                if dist < 1.5 then				
                    if not Config.SmallBanks[closestBank]["isOpened"] then 
                        if exports['srp-inventory']:hasEnoughOfItem('usbdevice', 1) then
                             ---   exports['srp-dispatch']:SendAlert("AlertFleecaRobbery")
                                StartHeistFleecaPanel()
                                local card = exports["srp-taskbar"]:taskBar(9000,"Hooking up equipment")
                                if card == 100 then
                                    TriggerEvent('inventory:removeItem', 'usbdevice', 1)	
                                    TriggerEvent("client:newStress",true,200)
                                    FreezeEntityPosition(GetPlayerPed(-1), false)
                                    exports['srp-memory']:StartMinigame({
                                        success = 'fleeca1:success:panel',
                                        fail = 'fleeca1:fail:panel'
                                    })
                                end  
                            else
                                TriggerEvent("DoLongHudText", "Not enough cops online.", 2)
                            end
                        else
                            TriggerEvent("DoLongHudText", "Your missing stuff...", 2)
                        end	
                    else
                        TriggerEvent('DoLongHudText', "The bank is already open.", 2)
                    end
              
                end
            end
        else
            TriggerEvent('DoLongHudText', "The security lock is active, opening the door is currently not possible.", 2)
        end
      
    end
end)


RegisterNetEvent('srp-fleeca:client:setBankState')
AddEventHandler('srp-fleeca:client:setBankState', function(bankId, state)
    if bankId == "pacific" then
        -- Config.BigBanks["pacific"]["isOpened"] = state
        -- if state then
        --     OpenPacificDoor()
        -- end
    else
        Config.SmallBanks[bankId]["isOpened"] = state
        if state then
            OpenBankDoor(bankId)
        end
    end
end)

RegisterNetEvent('srp-fleeca:client:enableAllBankSecurity')
AddEventHandler('srp-fleeca:client:enableAllBankSecurity', function()
    for k, v in pairs(Config.SmallBanks) do
        Config.SmallBanks[k]["alarm"] = true
    end
end)

RegisterNetEvent('srp-fleeca:client:disableAllBankSecurity')
AddEventHandler('srp-fleeca:client:disableAllBankSecurity', function()
    for k, v in pairs(Config.SmallBanks) do
        Config.SmallBanks[k]["alarm"] = false
    end
end)

RegisterNetEvent('srp-fleeca:client:BankSecurity')
AddEventHandler('srp-fleeca:client:BankSecurity', function(key, status)
    Config.SmallBanks[key]["alarm"] = status
end)



function StartHeistFleecaPanel()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, Config.SmallBanks[closestBank].coords.x, Config.SmallBanks[closestBank].coords.y, Config.SmallBanks[closestBank].coords.z-0.9, 2.0, -1, 0.0)
    loadDicts()
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, Config.SmallBanks[closestBank].player_heading)
    Wait(0)
    TaskPlayAnimAdvanced(ply, "anim@heists@ornate_bank@hack", "hack_enter", Config.SmallBanks[closestBank].coords.x, Config.SmallBanks[closestBank].coords.y, Config.SmallBanks[closestBank].coords.z -0.9, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, Config.SmallBanks[closestBank].player_heading)
    while IsEntityPlayingAnim(ply, "anim@heists@ornate_bank@hack", "hack_enter", 3) do
        Wait(0)
    end
    laptop = CreateObject(`hei_prop_hst_laptop`, GetOffsetFromEntityInWorldCoords(ply, 0.2, 0.6, 0.0), 1, 1, 0)
    Wait(0)
    SetEntityRotation(laptop, GetEntityRotation(ply, 2), 2, true)
    PlaceObjectOnGroundProperly(laptop)
    Wait(0)
    TaskPlayAnim(ply, "anim@heists@ornate_bank@hack", "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)

end

function loadDicts()
    RequestAnimDict("anim@heists@ornate_bank@hack")
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@hack")
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Wait(0)
    end
end


function OpenBankDoor(bankId)
    local object = GetClosestObjectOfType(Config.SmallBanks[bankId]["coords"]["x"], Config.SmallBanks[bankId]["coords"]["y"], Config.SmallBanks[bankId]["coords"]["z"], 5.0, Config.SmallBanks[bankId]["object"], false, false, false)
    local timeOut = 10
    local entHeading = Config.SmallBanks[bankId]["heading"].closed

    if object ~= 0 then
        Citizen.CreateThread(function()
            while true do

                if entHeading ~= Config.SmallBanks[bankId]["heading"].open then
                    SetEntityHeading(object, entHeading - 10)
                    entHeading = entHeading - 0.5
                else
                    break
                end

                Citizen.Wait(10)
            end
        end)
    end
end

function ResetBankDoors()
    for k, v in pairs(Config.SmallBanks) do
        local object = GetClosestObjectOfType(Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"], 5.0, Config.SmallBanks[k]["object"], false, false, false)
        if not Config.SmallBanks[k]["isOpened"] then
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].closed)
        else
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].open)
        end
    end

    if not Config.BigBanks["pacific"]["isOpened"] then
        local pacificObject = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][4]["x"], Config.BigBanks["pacific"]["coords"][4]["y"], Config.BigBanks["pacific"]["coords"][4]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        SetEntityHeading(pacificObject, Config.BigBanks["pacific"]["heading"].closed)
    else
        local pacificObject = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][4]["x"], Config.BigBanks["pacific"]["coords"][4]["y"], Config.BigBanks["pacific"]["coords"][4]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        SetEntityHeading(pacificObject, Config.BigBanks["pacific"]["heading"].open)
    end
end

RegisterNetEvent('srp-fleeca:client:setLockerState')
AddEventHandler('srp-fleeca:client:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "pacific" then	
        Config.BigBanks["pacific"]["lockers"][lockerId][state] = bool
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end
end)

RegisterNetEvent('srp-fleeca:client:ResetFleecaLockers')
AddEventHandler('srp-fleeca:client:ResetFleecaLockers', function(BankId)
    Config.SmallBanks[BankId]["isOpened"] = false
    for k,_ in pairs(Config.SmallBanks[BankId]["lockers"]) do
        Config.SmallBanks[BankId]["lockers"][k]["isOpened"] = false
        Config.SmallBanks[BankId]["lockers"][k]["isBusy"] = false
    end
end)



-- local lockpicking = false
-- RegisterNetEvent('animation:fuckyou')
-- AddEventHandler('animation:fuckyou', function()
--     local lPed = PlayerPedId()
--     RequestAnimDict("mini@repair")
--     while not HasAnimDictLoaded("mini@repair") do
--         Citizen.Wait(0)
--     end
--     while lockpicking do

--         if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
--             ClearPedSecondaryTask(lPed)
--             TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
--         end
--         Citizen.Wait(1)
--     end
--     ClearPedTasks(lPed)
-- end)



AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        ResetBankDoors()
    end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function OpenLocker(bankId, lockerId)
    local pos = GetEntityCoords(GetPlayerPed(-1))

    TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isBusy', true)
    if bankId == "pacific" then
        -- print(exports['srp-inventory']:getQuality('hacklaptop'))
        -- if exports['srp-inventory']:hasEnoughOfItem('hacklaptop', 1) then
        --     exports['srp-memory']:StartMinigame({
        --         success = 'pacific:success',
        --         fail = 'pacific:fail'
        --     })
        -- else
        --     TriggerEvent('DoLongHudText', "You dont have any thermite!", 2)
		-- 	TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isBusy', false)
		-- end
    else

        if exports['srp-inventory']:hasEnoughOfItem('drill', 1) then
            local finished = exports["srp-lockpicking"]:lockpick(100,5,2,10)
            if finished == 100 then 
                FreezeEntityPosition(PlayerPedId(), true)
                lockpicking = true
                ExecuteCommand('e search')
                local finished = exports["srp-taskbar"]:taskBar(15000,"Breaking into Bankbox")
                if finished == 100 then
                    lockpicking = false
                    TriggerEvent("fleeca:success")
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isOpened', true)
                    TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isBusy', false)
                    TriggerEvent("fleeca:loot")
                else
                    lockpicking = false
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isOpened', false)
                    TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isBusy', false)
                end
            else
                TriggerEvent("fleeca:fail")
                TriggerEvent("DoLongHudText", "You failed to breach into the vault box and the Drill bit bent its no good now!", 2)
                local pSecondChance = math.random(1, 10)
                if pSecondChance >= 5 then
                    TriggerEvent("DoLongHudText", "You got another shot!")
                    TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isOpened', false)
                    TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isBusy', false)
                end
            end

        else
            TriggerEvent('DoLongHudText', "You need a lockpick for this!", 2)
			TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isBusy', false)
		end
    end
end


-- RegisterNetEvent("fleeca:success:panel", function()
--     TriggerEvent('DoLongHudText', "Success!", 1)
--     TriggerEvent('srp-dispatch:bankrobbery', -1)
--     TriggerServerEvent('srp-fleeca:server:setBankState', closestBank, true)
--     DeleteObject(laptop)
-- end)

-- RegisterNetEvent("pacific:success", function()
--     TriggerEvent("attachItem","minigameThermite")

--     RequestAnimDict("weapon@w_sp_jerrycan")
--     while ( not HasAnimDictLoaded( "weapon@w_sp_jerrycan" ) ) do
--         Wait(10)
--     end
--     FreezeEntityPosition(GetPlayerPed(-1), true)
--     Wait(100)
--     TaskPlayAnim(GetPlayerPed(-1),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
--     Wait(5000)
--     TaskPlayAnim(GetPlayerPed(-1),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
--     TriggerEvent("destroyProp")
--     FreezeEntityPosition(GetPlayerPed(-1), false)
--     ClearPedTasks(PlayerPedId())

--     TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isOpened', true)
--     TriggerServerEvent('srp-fleeca:server:setLockerState', bankId, lockerId, 'isBusy', false)
-- end)


-- RegisterNetEvent("pacific:fail", function()
--     TriggerEvent("DoLongHudText", "Failed", 2)
-- end)

RegisterNetEvent("fleeca:fail", function()
    TriggerEvent("DoLongHudText", "Failed", 2)
    TriggerEvent("inventory:removeItem", "drill", 1)
end)


-- RegisterNetEvent("fleeca:fail:panel", function()
--     TriggerServerEvent("inventory:deg:item", "hacklaptop")
--     TriggerEvent('DoLongHudText', "Failed", 2)
--     DeleteObject(laptop)
-- end)



RegisterNetEvent("fleeca:loot")
AddEventHandler("fleeca:loot", function()
 local roll = math.random(5)
-- if roll == 1 then
   -- TriggerEvent("player:receiveItem", "", 1)
 if roll == 1 then
     TriggerEvent("player:receiveItem", "goldbar", math.random(2, 10))
     TriggerEvent("player:receiveItem", "bdiamond", math.random(10, 25))
     TriggerEvent("player:receiveItem", "goldcoin", math.random(15, 35))
 elseif roll == 2 then
     TriggerEvent("player:receiveItem", "band", math.random(30, 95))
     TriggerEvent("player:receiveItem", "cashstack", math.random(50, 85))
     TriggerEvent("player:receiveItem", "rollcash", math.random(55, 250))
elseif roll == 3 then
    TriggerEvent('DoLongHudText', "Damn the box was empty!", 2)
 end
end)



RegisterNetEvent("fleeca1:success:panel", function()
    TriggerEvent('DoLongHudText', "Success!", 1)
    TriggerEvent('srp-dispatch:bankrobbery', -1)
    TriggerServerEvent('srp-fleeca:server:setBankState', closestBank, true)
    DeleteObject(laptop)
end)

RegisterNetEvent("fleeca1:fail:panel", function()
    TriggerServerEvent("inventory:deg:item", "hacklaptop")
    TriggerEvent('DoLongHudText', "Failed", 2)
    TriggerEvent('srp-dispatch:bankrobbery', -1)
    DeleteObject(laptop)
end)

