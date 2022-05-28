RegisterNetEvent("srp-burgershot:startprocess3")
AddEventHandler("srp-burgershot:startprocess3", function()
    local rank = exports["isPed"]:GroupRank("burger_shot")
    if rank > 0 then    
        if exports["srp-inventory"]:hasEnoughOfItem("rawpatty", 2) then 
            local finished = exports["srp-taskbarskill"]:taskBar(5500,8)
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "rawpatty", 2)
                TriggerEvent('player:receiveItem', 'patty', math.random(1, 2))
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
                TriggerEvent("animation:PlayAnimation","layspike")
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need more patty to process! (Required Amount: 2)', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)


RegisterNetEvent("srp-burgershot:startfryer")
AddEventHandler("srp-burgershot:startfryer", function()
    local rank = exports["isPed"]:GroupRank("burger_shot")
    if rank > 0 then    
        if exports["srp-inventory"]:hasEnoughOfItem("potato", 1) then 
            local finished = exports["srp-taskbarskill"]:taskBar(5500,8)
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "potato", 1)
                TriggerEvent('player:receiveItem', 'fries', math.random(1, 2))
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
                TriggerEvent("animation:PlayAnimation","layspike")
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need potatoes! (Required Amount: 1)', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

RegisterNetEvent("srp-burgershot:pay")
AddEventHandler("srp-burgershot:pay", function(amount)
    TriggerServerEvent("server:GroupPayment","burger_shot", amount)
end)

---RegisterNetEvent("srp-burgershot:startjob")
---AddEventHandler("srp-burgershot:startjob", function()
  ---  local rank = exports["isPed"]:GroupRank("burger_shot")
  ---  local vehicle = GetHashKey('panto')
 ---   if rank > 0 then     
 --       RequestModel(vehicle)
    
 ---       while not HasModelLoaded(vehicle) do
 ---           Wait(1)
 --       end
    
 ---       local plate = "BURGER" .. math.random(1, 100)
 ---       local spawned_car = CreateVehicle(vehicle, -1168.9582519531, -895.20001220703, 13.9296875, 34.015747070312, true, false)
 ----       SetVehicleEngineTorqueMultiplier(spawned_car, 0.2)
 ---       SetVehicleOnGroundProperly(spawned_car)
----        SetVehicleNumberPlateText(spawned_car, plate)
 ---       SetPedIntoVehicle(GetPlayerPed(-1), spawned_car, - 1)
---        SetModelAsNoLongerNeeded(vehicle)
 ---       TriggerEvent("keys:addNew",spawned_car,plate)
 ---       Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
 ---   else
---        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
---    end
---end)

--- Burger >> Beef

---RegisterNetEvent("srp-burgershot:startprocess")
---AddEventHandler("srp-burgershot:startprocess", function()
 --   local finished = exports['srp-taskbar']:taskBar(5000, 'Grabbing Cow')
 --   local rank = exports["isPed"]:GroupRank("burger_shot")
 --   if rank > 0 then     
 --       if (finished == 100) then
 ---           TriggerEvent('player:receiveItem', 'cow', 1)
 -----           FreezeEntityPosition(GetPlayerPed(-1),false)
 ---           ClearPedTasks(GetPlayerPed(-1))
---            Citizen.Wait(1000)
 ---           TriggerEvent("animation:PlayAnimation","layspike")
 ---           Citizen.Wait(1000)
 ---       end
 ---   else
 ---       TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
----    end
---end)


---RegisterNetEvent("srp-burgershot:startprocess2")
---AddEventHandler("srp-burgershot:startprocess2", function()
---    local rank = exports["isPed"]:GroupRank("burger_shot")
---    if rank > 0 then     
 ---       if exports["srp-inventory"]:hasEnoughOfItem("cow", 1) then 
  ---          local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
 ---           LoadDict(dict)
 ---           FreezeEntityPosition(GetPlayerPed(-1),true)
---            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
 ---           SetEntityHeading(GetPlayerPed(-1), 82.204727172852)
 ---           local finished = exports['srp-taskbar']:taskBar(5000, 'Cutting Up Cow')
  ---          if (finished == 100) then
 ---               TriggerEvent("inventory:removeItem", "cow", 1)
  ---              TriggerEvent('player:receiveItem', 'beef', math.random(10, 20))
  ---              FreezeEntityPosition(GetPlayerPed(-1),false)
  ---              ClearPedTasks(GetPlayerPed(-1))
 ---               Citizen.Wait(1000)
 ---               TriggerEvent("animation:PlayAnimation","layspike")
 ---           end
 ---       else
 ---           TriggerEvent('DoLongHudText', 'You need more cow to process! (Required Amount: 1)', 2)
 ---       end
 ---   else
 ---       TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
 ---   end
--end)

--RegisterNetEvent("srp-burgershot:startfryer")
--AddEventHandler("srp-burgershot:startfryer", function()
  ---  local rank = exports["isPed"]:GroupRank("burger_shot")
  ---  if rank > 0 then   
   ---     local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
   ---     LoadDict(dict)
    ---    FreezeEntityPosition(GetPlayerPed(-1),true)
    ---    TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    ---    SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
    ---    local finished = exports['srp-taskbar']:taskBar(20000, 'Dropping Fries')
   ---     if (finished == 100) then
   ---         TriggerEvent('player:receiveItem', 'fries', 1)
   ---         FreezeEntityPosition(GetPlayerPed(-1),false)
   ----         ClearPedTasks(GetPlayerPed(-1))
   ---         Citizen.Wait(1000)
  ---          TriggerEvent("animation:PlayAnimation","layspike")
  ---          Citizen.Wait(1000)
  --      end
  ---  else
  ---      TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
---    end
--end)
RegisterNetEvent("srp-burgershot:makeshake")
AddEventHandler("srp-burgershot:makeshake", function()
    local rank = exports["isPed"]:GroupRank("burger_shot")
    if rank > 0 then    
        if exports["srp-inventory"]:hasEnoughOfItem("milkshakeformula", 1) then 
            local finished = exports["srp-taskbarskill"]:taskBar(5500,8)
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "milkshakeformula", 1)
                TriggerEvent('player:receiveItem', 'mshake', math.random(1))
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
                TriggerEvent("animation:PlayAnimation","layspike")
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You need Milkshake Formula! (Required Amount: 1)', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

---RegisterNetEvent("srp-burgershot:makeshake")
---AddEventHandler("srp-burgershot:makeshake", function()
  ---  local rank = exports["isPed"]:GroupRank("burger_shot")
  ---  if rank > 0 then    
  ---      local finished = exports['srp-taskbar']:taskBar(10000, 'Making Shake')
  ---      if (finished == 100) then
   ---         TriggerEvent('player:receiveItem', 'mshake', 1)
    --        FreezeEntityPosition(GetPlayerPed(-1),false)
   ---         ClearPedTasks(GetPlayerPed(-1))
   --         Citizen.Wait(1000)
  ---          TriggerEvent("animation:PlayAnimation","layspike")
   ---         Citizen.Wait(1000)
 --       end
 ---   else
  ---      TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
 ---   end
---end)

---RegisterNetEvent("srp-burgershot:getcola")
---AddEventHandler("srp-burgershot:getcola", function()
--    local rank = exports["isPed"]:GroupRank("burger_shot")
--    if rank > 0 then    
-----        local finished = exports['srp-taskbar']:taskBar(5000, 'Getting Coca Cola')
 --       if (finished == 100) then
  --          TriggerEvent('player:receiveItem', 'cola', 1)
  --          FreezeEntityPosition(GetPlayerPed(-1),false)
  ---          ClearPedTasks(GetPlayerPed(-1))
  --          Citizen.Wait(1000)
  --          TriggerEvent("animation:PlayAnimation","layspike")
  ---          Citizen.Wait(1000)
  --      end
 --   else
 --       TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
 --   end
--end)


RegisterNetEvent("srp-burgershot:getcola")
AddEventHandler("srp-burgershot:getcola", function()
    local finished = exports["srp-taskbarskill"]:taskBar(5500,8)
    if (finished == 100) then
        TriggerEvent('player:receiveItem', 'cola', 1)
    end
end)
---RegisterNetEvent("srp-burgershot:startprocess4")
---AddEventHandler("srp-burgershot:startprocess4", function()
 ---   local rank = exports["isPed"]:GroupRank("burger_shot")
 ---   if rank > 0 then    
 ---       if exports["srp-inventory"]:hasEnoughOfItem("groundbeef", 1) then 
---            local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
---            LoadDict(dict)
---            FreezeEntityPosition(GetPlayerPed(-1),true)
---            TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
 ---           SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
 ---           local finished = exports['srp-taskbar']:taskBar(20000, 'Cooking Beef')
 ---           if (finished == 100) then
 ---               TriggerEvent("inventory:removeItem", "groundbeef", 1)
 ---               TriggerEvent('player:receiveItem', 'patty', 1)
 ---               FreezeEntityPosition(GetPlayerPed(-1),false)
---                ClearPedTasks(GetPlayerPed(-1))
---                Citizen.Wait(1000)
 --               TriggerEvent("animation:PlayAnimation","layspike")
---                Citizen.Wait(1000)
 ---           end
---        else
---            TriggerEvent('DoLongHudText', 'You need more groundbeef to cook! (Required Amount: 1)', 2)
---        end
  ---  else
---        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
---    end
---end)

RegisterNetEvent("srp-burgershot:RegisterPaymentMenu")
AddEventHandler("srp-burgershot:RegisterPaymentMenu", function()
    local valid = exports["nh-keyboard"]:KeyboardInput({
        header = "Cash Register",
        rows = {
            {
                id = 0,
                txt = "Player ID"
            },
            {
                id = 1,
                txt = "Enter Cost"
            },
        }
    })
    if valid then
        TriggerServerEvent("burger_shot:bill:player", valid[1].input, valid[2].input)
    end
end)


RegisterCommand('bill', function(source)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'burger_shot' then
		TriggerEvent('burger_shot:bill')
	end
end)

