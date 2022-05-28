-- UPSTAIRS DOOR 1

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(256.62463378906, 219.63626098633, 105.28650665283) - player)
        if distance < 5.0 then
        	 Wait(1)
             DrawMarker(27,256.62463378906, 219.63626098633, 105.28650665283, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
             if exports["isPed"]:isPed("countpolice") >= 6 then
             if IsControlJustReleased(0,38) and distance < 5.0 then
                if exports["srp-inventory"]:hasEnoughOfItem("thermite",1,false) then
                TriggerEvent('av_vault:bomba') 
                local finished = exports["srp-taskbar"]:taskBar(8000,"Melting Lock")
                if finished == 100 then
                    TriggerEvent("inventory:removeItem", "thermite", 1)
                    exports['srp-memory']:StartMinigame({
                        success = 'bobcat:success:panel',
                        fail = 'bobcat:fail:panel'
                    })
					Citizen.Wait(3600000)
                            end
                        else
                            TriggerEvent("DoLongHudText", "Get the fuck out newbie!", 2)
                    end
                end
            end
        else
            Wait(3000)
        end
    end
end)

-- UPSTAIRS DOOR 2 

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(261.9811, 223.1754, 105.2842) - player)
        if distance < 5.0 then
            Wait(1)
            DrawMarker(27,261.9811, 223.1754, 105.2842, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
            if exports["isPed"]:isPed("countpolice") >= 6 then
            if IsControlJustReleased(0,38) and distance < 5.0 then
                if exports["srp-inventory"]:hasEnoughOfItem("Gruppe6Card222",1,false ) then
                if exports["srp-inventory"]:hasEnoughOfItem("laptop",1,false ) then
                TriggerEvent("mhacking:show")
                TriggerEvent("mhacking:start",7,13,upstairshacking)
                TriggerEvent("inventory:removeItem", "Gruppe6Card222", 1)
                TriggerEvent("inventory:removeItem", "laptop", 1)
                Citizen.Wait(3600000)
                            end
                        end
                    end
                end
            else
            Wait(3000)
        end
    end
end)

-- Vault Door

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(253.33, 228.42, 101.68) - player)
        if distance < 1.5 then
			DrawMarker(27,253.2766, 228.3611, 100.6845, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then 
                 if exports["srp-inventory"]:hasEnoughOfItem("Gruppe6Card2",1,false) then
                    if exports['srp-inventory']:hasEnoughOfItem('laptop', 1) then
                    StartVaultKid()
                    local vault = exports["srp-taskbar"]:taskBar(9000,"Hooking up Laptop!")
                    if vault == 100 then
                    exports['srp-memory']:StartMinigame({
                        success = 'vault:success:panel',
                        fail = 'vault:fail:panel'
                    })
                    TriggerEvent("inventory:removeItem", "Gruppe6Card2", 1)
                    TriggerEvent("inventory:removeItem", "laptop", 1)
					TriggerEvent('srp:alert:bigbank2')
                    Citizen.Wait(3600000)
                            end
                        end
                    end
                 end
             end
            else
                Wait(3000)
        end        
    end
end)

-- DOWNSTAITS DOOR UNLOCK --

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(252.6576, 221.1492, 100.6845) - player)
        if distance < 1.5 then
			DrawMarker(27,252.6576, 221.1492, 100.6845, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then 
                if exports["srp-inventory"]:hasEnoughOfItem("thermite",5,false) then
					-- TriggerEvent('srp:alert:bigbank2')
                    TriggerEvent("inventory:removeItem", "thermite", 5)
                    if exports['srp-thermite']:startGame(18,1,7,500) then
                    seguridad = true
                    bomba = true
                    TriggerEvent('av_vault2:bomba')
                    Citizen.Wait(3600000)
                        end
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

-- DOWNSTAITS DOOR UNLOCK 2 --

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(261.0443, 215.2489, 101.6834) - player)
        if distance < 1.5 then
			DrawMarker(27,261.0453, 215.2493, 100.6845, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then 
					-- TriggerEvent('srp:alert:bigbank2')
                    TriggerEvent("inventory:removeItem", "thermite", 5)
                    if exports['srp-thermite']:startGame(18,1,7,500) then
                    seguridad = true
                    bomba = true
                    TriggerEvent('av_vault3:bomba')
                    Citizen.Wait(3600000)
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

-- GIMME THE LOOT GIMME THE LOOT! -- 

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(262.47128295898, 212.8659362793, 100.78332519531) - player)
        if distance < 1.5 then
			DrawMarker(27,262.47128295898, 212.8659362793, 100.78332519531, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Drilling Into Bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                    TriggerEvent( "player:receiveItem", "markedbills", math.random(1, 100) )
                    TriggerEvent('srp:alert:bigbank2')
                    Citizen.Wait(3600000)
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(264.61862182617, 212.13189697266, 100.77891540527) - player)
        if distance < 1.5 then
			DrawMarker(27,264.61862182617, 212.13189697266, 100.77891540527, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Drilling Into Bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                    TriggerEvent( "player:receiveItem", "markedbills", math.random(1, 100) )
                    TriggerEvent('srp:alert:bigbank2')
                    Citizen.Wait(3600000)
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(259.6801, 218.0425, 100.6834) - player)
        if distance < 1.5 then
			DrawMarker(27,259.6801, 218.0425, 100.6845, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Drilling Into Bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                    TriggerEvent( "player:receiveItem", "markedbills", math.random(1, 100) )
                    Citizen.Wait(3600000)
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(258.1505, 214.2146, 100.6834) - player)
        if distance < 1.5 then
			DrawMarker(27,258.1505, 214.2146, 100.6845, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Drilling Into Bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                    TriggerEvent( "player:receiveItem", "markedbills", math.random(1, 100) )
                    TriggerEvent('srp:alert:bigbank2')
                    Citizen.Wait(3600000)
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(263.50704956055, 216.30137634277, 100.78331756592) - player)
        if distance < 1.5 then
			DrawMarker(27,263.50704956055, 216.30137634277, 100.78331756592, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Drilling Into Bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                    TriggerEvent( "player:receiveItem", "markedbills", math.random(1, 100) )
                    TriggerEvent('srp:alert:bigbank2')
                    Citizen.Wait(3600000)
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(265.70611572266, 215.58245849609, 100.78332519531) - player)
        if distance < 1.5 then
			DrawMarker(27,265.70611572266, 215.58245849609, 100.78332519531, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Drilling Into Bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                    TriggerEvent( "player:receiveItem", "markedbills", math.random(1, 100) )
                    TriggerEvent('srp:alert:bigbank2')
                    Citizen.Wait(3600000)
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(266.1162, 213.4917, 100.6834) - player)
        if distance < 1.5 then
			DrawMarker(27,266.1162, 213.4917, 100.6845, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            if exports["isPed"]:isPed("countpolice") >= 6 then
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Drilling Into Bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                    TriggerEvent( "player:receiveItem", "markedbills", math.random(1, 100) )
                    TriggerEvent('srp:alert:bigbank2')
                    Citizen.Wait(3600000)
                    end
                 end
             end
        else
            Wait(3000)
        end        
    end
end)

-- Functions

function upstairshacking(success, timeremaining)
    if success then
        TriggerServerEvent("srp-doors:alterlockstate", 131, false)
        TriggerEvent('mhacking:hide')
    else
        print('Failure')
        TriggerEvent('mhacking:hide')
    end
end


-- Animation

RegisterNetEvent('av_vault:bomba')
AddEventHandler('av_vault:bomba', function()
	local p = PlayerPedId()
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
	 HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') 
			SetEntityCoords(PlayerPedId(), 257.07977294922, 219.40545654297, 105.44011688232)
			SetEntityHeading(PlayerPedId(), 338.17086791992)
			FreezeEntityPosition(PlayerPedId(),true)
            local fwd, _, _, pos = GetEntityMatrix(p)
            local np = (fwd * 0.8) + pos            
            SetEntityCoords(p, np.xy, np.z - 1)
            local rot, pos = GetEntityRotation(p), GetEntityCoords(p)
            SetPedComponentVariation(p, 5, -1, 0, 0)
            local b = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z,  true,  true, false)
            local sc = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2, 0, 0, 1065353216, 0, 1.3)
            SetEntityCollision(b, 0, 1)
            NetworkAddPedToSynchronisedScene(p, sc, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(b, sc, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
            NetworkStartSynchronisedScene(sc)
            Citizen.Wait(1500)
            pos = GetEntityCoords(p)
            prop = CreateObject(GetHashKey("hei_prop_heist_thermite"), pos.x, pos.y, pos.z + 0.2, 1, 1, 1)
            SetEntityCollision(prop, 0, 1)
            AttachEntityToEntity(prop, p, GetPedBoneIndex(p, 28422), 0, 0, 0, 0, 0, 180.0, 1, 1, 0, 1, 1, 1)
            Citizen.Wait(4000)
			DeleteObject(b)
            SetPedComponentVariation(p, 5, 45, 0, 0)
            DetachEntity(prop, 1, 1)
            FreezeEntityPosition(prop, 1)
            SetEntityCollision(prop, 0, 1)
            pCoords = GetEntityCoords(prop)
            TriggerServerEvent('av_vangelico:efecto', prop)
			Citizen.Wait(4000)
			NetworkStopSynchronisedScene(sc)
			DeleteObject(prop)
			seguridad = false
			FreezeEntityPosition(PlayerPedId(),false)
			TriggerServerEvent('av_vault:gas')
end)

RegisterNetEvent('av_vault:bombaFx')
AddEventHandler('av_vault:bombaFx', function(entity)
	RequestNamedPtfxAsset('scr_ornate_heist')
		if HasNamedPtfxAssetLoaded('scr_ornate_heist') then
			SetPtfxAssetNextCall("scr_ornate_heist")
            explosiveEffect = StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn", entity, 0.0, 2.0, 0.0, 0.0, 0.0, 0.0, 2.0, 0, 0, 0, 0)
			Citizen.Wait(4000)
			StopParticleFxLooped(explosiveEffect, 0)
		end
end)

RegisterNetEvent('av_vault2:bomba')
AddEventHandler('av_vault2:bomba', function()
	local p = PlayerPedId()
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
	 HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') 
			SetEntityCoords(PlayerPedId(), 253.3302154541, 221.44309997559, 100.78377532959)
			SetEntityHeading(PlayerPedId(), 163.93002319336)
			FreezeEntityPosition(PlayerPedId(),true)
            local fwd, _, _, pos = GetEntityMatrix(p)
            local np = (fwd * 0.8) + pos            
            SetEntityCoords(p, np.xy, np.z - 1)
            local rot, pos = GetEntityRotation(p), GetEntityCoords(p)
            SetPedComponentVariation(p, 5, -1, 0, 0)
            local b = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z,  true,  true, false)
            local sc = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2, 0, 0, 1065353216, 0, 1.3)
            SetEntityCollision(b, 0, 1)
            NetworkAddPedToSynchronisedScene(p, sc, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(b, sc, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
            NetworkStartSynchronisedScene(sc)
            Citizen.Wait(1500)
            pos = GetEntityCoords(p)
            prop = CreateObject(GetHashKey("hei_prop_heist_thermite"), pos.x, pos.y, pos.z + 0.2, 1, 1, 1)
            SetEntityCollision(prop, 0, 1)
            AttachEntityToEntity(prop, p, GetPedBoneIndex(p, 28422), 0, 0, 0, 0, 0, 180.0, 1, 1, 0, 1, 1, 1)
            Citizen.Wait(4000)
			DeleteObject(b)
            SetPedComponentVariation(p, 5, 45, 0, 0)
            DetachEntity(prop, 1, 1)
            FreezeEntityPosition(prop, 1)
            SetEntityCollision(prop, 0, 1)
            pCoords = GetEntityCoords(prop)
            TriggerServerEvent('av_vangelico:efecto', prop)
			Citizen.Wait(4000)
			NetworkStopSynchronisedScene(sc)
			DeleteObject(prop)
			seguridad = false
			FreezeEntityPosition(PlayerPedId(),false)
			TriggerEvent("srp-doors:changeLock-status", 158, false)
			TriggerServerEvent('av_vangelico:gas')
end)

RegisterNetEvent('av_vault2:bombaFx')
AddEventHandler('av_vault2:bombaFx', function(entity)
	RequestNamedPtfxAsset('scr_ornate_heist')
		if HasNamedPtfxAssetLoaded('scr_ornate_heist') then
			SetPtfxAssetNextCall("scr_ornate_heist")
            explosiveEffect = StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn", entity, 0.0, 2.0, 0.0, 0.0, 0.0, 0.0, 2.0, 0, 0, 0, 0)
			Citizen.Wait(4000)
			StopParticleFxLooped(explosiveEffect, 0)
		end
end)

RegisterNetEvent('av_vault3:bomba')
AddEventHandler('av_vault3:bomba', function()
	local p = PlayerPedId()
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
	 HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') 
			SetEntityCoords(PlayerPedId(), 260.89263916016, 216.04284667969, 100.78374481201)
			SetEntityHeading(PlayerPedId(), 245.74819946289)
			FreezeEntityPosition(PlayerPedId(),true)
            local fwd, _, _, pos = GetEntityMatrix(p)
            local np = (fwd * 0.8) + pos            
            SetEntityCoords(p, np.xy, np.z - 1)
            local rot, pos = GetEntityRotation(p), GetEntityCoords(p)
            SetPedComponentVariation(p, 5, -1, 0, 0)
            local b = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z,  true,  true, false)
            local sc = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2, 0, 0, 1065353216, 0, 1.3)
            SetEntityCollision(b, 0, 1)
            NetworkAddPedToSynchronisedScene(p, sc, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(b, sc, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
            NetworkStartSynchronisedScene(sc)
            Citizen.Wait(1500)
            pos = GetEntityCoords(p)
            prop = CreateObject(GetHashKey("hei_prop_heist_thermite"), pos.x, pos.y, pos.z + 0.2, 1, 1, 1)
            SetEntityCollision(prop, 0, 1)
            AttachEntityToEntity(prop, p, GetPedBoneIndex(p, 28422), 0, 0, 0, 0, 0, 180.0, 1, 1, 0, 1, 1, 1)
            Citizen.Wait(4000)
			DeleteObject(b)
            SetPedComponentVariation(p, 5, 45, 0, 0)
            DetachEntity(prop, 1, 1)
            FreezeEntityPosition(prop, 1)
            SetEntityCollision(prop, 0, 1)
            pCoords = GetEntityCoords(prop)
            TriggerServerEvent('av_vangelico:efecto', prop)
			Citizen.Wait(4000)
			NetworkStopSynchronisedScene(sc)
			DeleteObject(prop)
			seguridad = false
			FreezeEntityPosition(PlayerPedId(),false)
			TriggerEvent("srp-doors:changeLock-status", 159, false)
			TriggerServerEvent('av_vangelico:gas')
end)

RegisterNetEvent('av_vault3:bombaFx')
AddEventHandler('av_vault3:bombaFx', function(entity)
	RequestNamedPtfxAsset('scr_ornate_heist')
		if HasNamedPtfxAssetLoaded('scr_ornate_heist') then
			SetPtfxAssetNextCall("scr_ornate_heist")
            explosiveEffect = StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn", entity, 0.0, 2.0, 0.0, 0.0, 0.0, 0.0, 2.0, 0, 0, 0, 0)
			Citizen.Wait(4000)
			StopParticleFxLooped(explosiveEffect, 0)
		end
end)

 -- VAULT DOOR SHIT NOBODY REALLY CARES
 RegisterNetEvent("utk_oh:openvault_c")
 AddEventHandler("utk_oh:openvault_c", function(method)
     TriggerEvent("utk_oh:vault", method)
     TriggerEvent("utk_oh:vaultsound")
 end)
 RegisterNetEvent("utk_oh:vault")
 AddEventHandler("utk_oh:vault", function(method)
     local obj = GetClosestObjectOfType(UTK.vault.x, UTK.vault.y, UTK.vault.z, 2.0, GetHashKey(UTK.vault.type), false, false, false)
     local count = 0
 
     if method == 1 then
         repeat
             local rotation = GetEntityHeading(obj) - 1.00
 
             SetEntityHeading(obj, 1.00)
             count = count + 1
             Citizen.Wait(10)
         until count == 3600000
     else
         repeat
             local rotation = GetEntityHeading(obj) + 1.00
 
             SetEntityHeading(obj, 1.00)
             count = count + 1
             Citizen.Wait(10)
         until count == 3600000
     end
     FreezeEntityPosition(obj, true)
 end)

 UTK = {
    doorchecks = {
        {x = 253.92, y = 224.56, z = 101.88, he = 160.000, h = GetHashKey("v_ilev_bk_vaultdoor"), status = 0,}
    },
    disableinput = false, -- don't change anything else unless you know what you are doing
    info = {},
    vault = {x = 253.92, y = 224.56, z = 101.88, type = "v_ilev_bk_vaultdoor"},
    cur = 7,
}

RegisterNetEvent("bobcat:success:panel", function()
    TriggerEvent('DoLongHudText', "Success!", 1)
    TriggerServerEvent("srp-doors:alterlockstate", 130, false)
end)

RegisterNetEvent("bobcat:fail:panel", function()
    TriggerEvent('DoLongHudText', "you fucked up, that nearly blew", 2)
end)

RegisterNetEvent("vault:success:panel", function()
    TriggerEvent('DoLongHudText', "Success!", 1)
    TriggerServerEvent("utk_oh:openvault", 1)
    DeleteObject(laptop)
end)

RegisterNetEvent("vault:fail:panel", function()
    TriggerEvent('DoLongHudText', "Failed, that laptop nearly blew", 2)
    DeleteObject(laptop)
end)

function StartVaultKid()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, 253.60346984863, 228.20530700684, 101.68351745605-0.9, 2.0, -1, 0.0)
    loadDicts()
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, 71.801795959473)
    Wait(0)
    TaskPlayAnimAdvanced(ply, "anim@heists@ornate_bank@hack", "hack_enter", 253.60346984863, 228.20530700684, 101.68351745605 -0.9, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, 71.801795959473)
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