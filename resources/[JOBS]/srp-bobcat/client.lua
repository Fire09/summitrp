Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(882.27, -2257.61, 32.44) - player)
        if distance < 5.0 then
        	 Wait(1)
           ---  DrawMarker(32,882.27, -2257.61, 32.46, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
             if exports["isPed"]:isPed("countpolice") >= 6 then
             if IsControlJustReleased(0,38) and distance < 5.0 then
                if exports["srp-inventory"]:hasEnoughOfItem("thermite",1,false) then
                TriggerEvent('bobcatdoor1:bomba') 
                local finished = exports["srp-taskbar"]:taskBar(8000,"Melting Lock")
                if finished == 100 then
                    TriggerEvent("inventory:removeItem", "thermite", 1)
                    exports['srp-memory']:StartMinigame({
                        success = 'bobcat1:success:panel',
                        fail = 'bobcat1:fail:panel'
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


Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(880.53, -2263.67, 32.44) - player)
        if distance < 5.0 then
        	 Wait(1)
           ---  DrawMarker(32,880.53, -2263.67, 32.44, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
             if exports["isPed"]:isPed("countpolice") >= 6 then
             if IsControlJustReleased(0,38) and distance < 5.0 then
                if exports["srp-inventory"]:hasEnoughOfItem("thermite",1,false) then
                TriggerEvent('bobcatdoor:bomba') 
                local finished = exports["srp-taskbar"]:taskBar(8000,"Melting Lock")
                if finished == 100 then
                    TriggerEvent("inventory:removeItem", "thermite", 1)
                    exports['srp-memory']:StartMinigame({
                        success = 'bobcat112:success:panel',
                        fail = 'bobcat112:fail:panel'
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

RegisterNetEvent('bobcatdoor1:bomba')
AddEventHandler('bobcatdoor1:bomba', function()
	local p = PlayerPedId()
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
	 HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') 
			SetEntityCoords(PlayerPedId(), 882.27, -2257.61, 31.44)
			SetEntityHeading(PlayerPedId(), 170.17086791992)
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

RegisterNetEvent('bobcatdoor:bomba')
AddEventHandler('bobcatdoor:bomba', function()
	local p = PlayerPedId()
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
	 HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') 
			SetEntityCoords(PlayerPedId(), 880.53, -2263.67, 31.44)
			SetEntityHeading(PlayerPedId(), 170.17086791992)
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

RegisterNetEvent("bobcat112:success:panel", function()
    TriggerEvent('DoLongHudText', "Success!", 1)
    TriggerEvent("efe:pedicreatele")
    TriggerServerEvent("srp-doors:alterlockstate", 67, false)
    TriggerEvent("efe:ptfxparticlesec")
end)

RegisterNetEvent("bobcat112:fail:panel", function()
    TriggerEvent('DoLongHudText', "you fucked up, that nearly blew", 2)
end)

-------------dioooororor
RegisterNetEvent("bobcat1:success:panel", function()
    TriggerEvent('DoLongHudText', "Success!", 1)
    TriggerEvent("efe:pedicreatele")
    TriggerServerEvent("srp-doors:alterlockstate", 65, false)
    TriggerServerEvent("srp-doors:alterlockstate", 66, false)
    TriggerEvent("efe:ptfxparticle")
end)

RegisterNetEvent("bobcat1:fail:panel", function()
    TriggerEvent('DoLongHudText', "you fucked up, that nearly blew", 2)
end)
  



RegisterNetEvent("efe:ptfxparticle")
AddEventHandler("efe:ptfxparticle", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(882.1320, -2257.34, 32.461)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    print("bobyletmein")
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent("efe:ptfxparticlesec")
AddEventHandler("efe:ptfxparticlesec", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(880.49, -2263.60, 32.441)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    print("bobyletmein")
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('efe:bobcatikincikapi')
AddEventHandler('efe:bobcatikincikapi', function()
	ikincianim()
    TriggerEvent("efe:ikincikapidoorlock")
end)


RegisterNetEvent('efe:pedicreatele') -- İKİNCİ KAPI sexk
AddEventHandler('efe:pedicreatele', function()
    TriggerEvent("efe:bobcatcreateped")
end)

RegisterNetEvent('efe:propcreatle') -- sexk1
AddEventHandler('efe:propcreatle', function()
    TriggerEvent("efe:propcreate")
end)

RegisterNetEvent('efe:propcreate')
AddEventHandler('efe:propcreate', function()
    local weaponbox = CreateObject(GetHashKey("ex_prop_crate_ammo_sc"), 888.0774, -2287.33, 31.441, true,  true, true)
    CreateObject(weaponbox)
    SetEntityHeading(weaponbox, 176.02)
    FreezeEntityPosition(weaponbox, true)

    local weaponbox2 = CreateObject(GetHashKey("ex_prop_crate_expl_sc"), 886.8, -2281.7, 31.441, true,  true, true)
    CreateObject(weaponbox2)
    SetEntityHeading(weaponbox2, 352.02)
    FreezeEntityPosition(weaponbox2, true) 

    local weaponbox3 = CreateObject(GetHashKey("ex_prop_crate_expl_bc"), 882.1840, -2286.8, 31.441, true,  true, true)
    CreateObject(weaponbox3)
    SetEntityHeading(weaponbox3, 158.02)
    FreezeEntityPosition(weaponbox3, true) 

    local weaponbox4 = CreateObject(GetHashKey("ex_prop_crate_ammo_bc"), 881.4557, -2282.61, 31.441, true,  true, true)
    CreateObject(weaponbox4)
    SetEntityHeading(weaponbox4, 52.02)
    FreezeEntityPosition(weaponbox4, true)
end)


RegisterNetEvent('efe:bobcatcreateped')
AddEventHandler('efe:bobcatcreateped', function()
	local bobcatped2 = GetHashKey('csb_mweather')
	AddRelationshipGroup('efe')

		RequestModel(1456041926)
		bobcatped1 = CreatePed(30, 883.4797, -2273.77, 32.441, 30.568, 88.00, true, false)
		SetPedArmour(bobcatped1, 500)
		SetPedAsEnemy(bobcatped1, true)
		SetPedRelationshipGroupHash(bobcatped1, 'efe')
		GiveWeaponToPed(bobcatped1, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
		TaskCombatPed(bobcatped1, GetPlayerPed(-1))
		SetPedAccuracy(bobcatped1, 100)
		SetPedDropsWeaponsWhenDead(bobcatped1, false)
		
		bobcatped2 = CreatePed(30, 1456041926, 892.4030, -2275.25, 32.441, 360.00, true, false)
		SetPedArmour(bobcatped2, 500)
		SetPedAsEnemy(bobcatped2, true)
		SetPedRelationshipGroupHash(bobcatped2, 'efe')
		GiveWeaponToPed(bobcatped2, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
		TaskCombatPed(bobcatped2, GetPlayerPed(-1))
		SetPedAccuracy(bobcatped2, 100)
		SetPedDropsWeaponsWhenDead(bobcatped2, false)

		bobcatped3 = CreatePed(30, 1456041926, 892.6776, -2281.26, 32.441, 350.00, true, false)
		SetPedArmour(bobcatped3, 500)
		SetPedAsEnemy(bobcatped3, true)
		SetPedRelationshipGroupHash(bobcatped3, 'efe')
		GiveWeaponToPed(bobcatped3, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
		TaskCombatPed(bobcatped3, GetPlayerPed(-1))
		SetPedAccuracy(bobcatped3, 100)
		SetPedDropsWeaponsWhenDead(bobcatped3, false)

		bobcatped4 = CreatePed(30, 1456041926, 889.3485, -2292.47, 32.441, 350.00, true, false)
		SetPedArmour(bobcatped4, 500)
		SetPedAsEnemy(bobcatped4, true)
		SetPedRelationshipGroupHash(bobcatped4, 'efe')
		GiveWeaponToPed(bobcatped4, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
		TaskCombatPed(bobcatped4, GetPlayerPed(-1))
		SetPedAccuracy(bobcatped4, 100)
		SetPedDropsWeaponsWhenDead(bobcatped4, false)

		bobcatped5 = CreatePed(30, 1456041926, 880.9854, -2293.40, 32.441, 300.00, true, false)
		SetPedArmour(bobcatped5, 500)
		SetPedAsEnemy(bobcatped5, true)
		SetPedRelationshipGroupHash(bobcatped5, 'efe')
		GiveWeaponToPed(bobcatped5, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
		TaskCombatPed(bobcatped5, GetPlayerPed(-1))
		SetPedAccuracy(bobcatped5, 100)
		SetPedDropsWeaponsWhenDead(bobcatped5, false)


		bobcatped6 = CreatePed(30, 1456041926, 873.4896, -2293.21, 32.441, 266.00, true, false)
		SetPedArmour(bobcatped6, 500)
		SetPedAsEnemy(bobcatped6, true)
		SetPedRelationshipGroupHash(bobcatped6, 'efe')
		GiveWeaponToPed(bobcatped6, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
		TaskCombatPed(bobcatped6, GetPlayerPed(-1))
		SetPedAccuracy(bobcatped6, 100)
		SetPedDropsWeaponsWhenDead(bobcatped6, false)

		bobcatped7 = CreatePed(30, 1456041926,894.1248, -2287.51, 32.446, 298.00, true, false)
		SetPedArmour(bobcatped7, 500)
		SetPedAsEnemy(bobcatped7, true)
		SetPedRelationshipGroupHash(bobcatped7, 'efe')
		GiveWeaponToPed(bobcatped7, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
		TaskCombatPed(bobcatped7, GetPlayerPed(-1))
		SetPedAccuracy(bobcatped7, 100)
		SetPedDropsWeaponsWhenDead(bobcatped7, false)

		bobcatped8 = CreatePed(30, 1456041926, 896.9407, -2280.87, 32.441, 266.00, true, false)
		SetPedArmour(bobcatped8, 500)
		SetPedAsEnemy(bobcatped8, true)
		SetPedRelationshipGroupHash(bobcatped8, 'efe')
		GiveWeaponToPed(bobcatped8, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
		TaskCombatPed(bobcatped8, GetPlayerPed(-1))
		SetPedAccuracy(bobcatped8, 100)
		SetPedDropsWeaponsWhenDead(bobcatped8, false)
end)

RegisterNetEvent('efe:bombabumbe')
AddEventHandler('efe:bombabumbe', function()
	local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
	ActivateInteriorEntitySet(interiorid, "np_prolog_broken")
	RemoveIpl(interiorid, "np_prolog_broken")
	DeactivateInteriorEntitySet(interiorid, "np_prolog_clean")
	RefreshInterior(interiorid)
end)

	
Citizen.CreateThread(function()
    local hash = GetHashKey("cs_drfriedlander")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
end
    rehineped = CreatePed("PED_TYPE_CIVFEMALE", "cs_drfriedlander", 870.1760, -2288.20, 31.441, 175.21, false, false)
    SetBlockingOfNonTemporaryEvents(rehineped, true)
            SetPedDiesWhenInjured(rehineped, false)
            SetPedCanPlayAmbientAnims(rehineped, true)
            SetPedCanRagdollFromPlayerImpact(rehineped, false)
			SetEntityInvincible(rehineped, false)
	        RequestAnimDict('random@arrests@busted', function()
        TaskPlayAnim(rehineped, 'random@arrests@busted', 'idle_a', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
	end)
end)

RegisterNetEvent('efe:pediyurut') -- PED WALK
AddEventHandler('efe:pediyurut', function()
	ClearPedTasks(rehineped)
	TaskGoStraightToCoord(rehineped, 869.2078, -2292.60, 32.441, 150.0, -1, 265.61, 0)
	Citizen.Wait(5000)
	TaskGoStraightToCoord(rehineped, 893.3309, -2294.90, 32.441, 150.0, -1, 350.61, 0)
	Citizen.Wait(13000)
	TriggerEvent("efe:pediyurutiki")
end)

RegisterNetEvent('efe:silahver') -- PED WALK
AddEventHandler('efe:silahver', function()
    TriggerEvent( "player:receiveItem", "1593441988", 1 )
    TriggerEvent( "player:receiveItem", "1649403952", 1 )
    TriggerEvent( "player:receiveItem", "741814745", 1 )
end)



RegisterNetEvent('efe:pediyurutiki') -- PED WALK
AddEventHandler('efe:pediyurutiki', function()
	TaskGoStraightToCoord(rehineped, 894.6337, -2284.97, 32.441, 150.0, -1, 82.56, 0)
	Citizen.Wait(7500)
    RequestAnimDict('weapons@projectile@grenade_str', function()
        TaskPlayAnim(rehineped, 'weapons@projectile@grenade_str', 'throw_h_fb_backward', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    end)
	Citizen.Wait(1000)
	AddExplosion(890.7849, -2284.88, 32.441, 32, 150000.0, true, false, 4.0)
	AddExplosion(894.0084, -2284.90, 32.580, 32, 150000.0, true, false, 4.0)
    TriggerEvent("efe:bombabumbe")
    TriggerEvent("efe:propcreate")
end)
