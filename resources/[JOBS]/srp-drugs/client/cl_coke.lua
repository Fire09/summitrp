local ongoing = false
local cooking = false

RegisterNetEvent("coke:start")
AddEventHandler("coke:start", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1101.84, -3192.16, -38.99, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("cocaleafs",50,false) and exports["srp-inventory"]:hasEnoughOfItem("petrol",2,false) and ongoing == false then
		TriggerEvent("animation:coke")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 358.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(20000,"Mixing Materials")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","cocaleafs", 50)
				TriggerEvent("inventory:removeItem","petrol", 2)
				TriggerEvent("DoLongHudText", "You Placed The Ingredients In Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","cocaleafs", 50)
				TriggerEvent("inventory:removeItem","petrol", 2)
				TriggerEvent("DoLongHudText", "You Successfully Made Pure Bag of Cocaine, Wait 3 Minutes For Results.")
				ongoing = true
				cooking = true
				Citizen.Wait(180000)
				TriggerEvent("DoLongHudText", "Coke almost ready, may wanna go check on it.")
				Citizen.Wait(5000)
				if cooking == true then
					TriggerEvent("DoLongHudText", "Finished!")
					TriggerEvent("player:receiveItem","coke5g", 2)
					ongoing = false
					cooking = false
				elseif cooking == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)


RegisterNetEvent('animation:load')
AddEventHandler('animation:load', function(dict)
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end)

RegisterNetEvent('animation:coke')
AddEventHandler('animation:coke', function()
	inanimation = true
	local lPed = GetPlayerPed(-1)
	RequestAnimDict("mini@repair")
	while not HasAnimDictLoaded("mini@repair") do
		Citizen.Wait(0)
	end

	if IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
		ClearPedSecondaryTask(lPed)
	else
		TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 49, 0, 0, 0, 0)
		seccount = 4
		while seccount > 0 do
			Citizen.Wait(10000)
			FreezeEntityPosition(PlayerPedId(),false)
			seccount = seccount - 1
		end
		ClearPedSecondaryTask(lPed)
	end		
	inanimation = false
end)



RegisterNetEvent("stopcooking")
AddEventHandler("stopcooking", function()
	if cooking == true then
		TriggerEvent("DoLongHudText", "Failed, You Left The Cocaine Lab To Early!")
		cooking = false
		ongoing = false
	end
end)

--------HARVESTING/COKE/WEED


local JustPickedWeed = false
local JustDriedWeed = false
local JustPackedWeed = false



RegisterNetEvent('weed:spam-prevent')
AddEventHandler('weed:spam-prevent', function(prevent)
	if prevent == "picking" then
		Wait(300000)
		JustPickedWeed = false
	elseif prevent == "drying" then
		Wait(300000)
		JustDriedWeed = false
	else
		Wait(300000)
		JustPackedWeed = false
	end
end)

Citizen.CreateThread(function()
listOn = false
	while true do

		Wait(5)

		local PlayerPos = GetEntityCoords(PlayerPedId())
		
		
		if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
			-- HARVEST WEED - START
			if GetDistanceBetweenCoords(PlayerPos, 2221.7973632813,5577.0966796875,53.844783782959, true) <= 10 then		
							
				if JustDriedWeed or JustPackedWeed then
						TriggerEvent("DoLongHudText","You are too tired from a different task, either wait 5 minutes or get help!")
				else
						if not JustPickedWeed then
							JustPickedWeed = true
							TriggerEvent("weed:spam-prevent","picking")
						end
						TriggerEvent("animation:farm")
						TriggerEvent("player:receiveItem","wetbud",math.random(3))
					end
				end
	
							-- HARVEST COCALEAFS - START
							if GetDistanceBetweenCoords(PlayerPos, 3525.9473632813,2546.7766796875,8.724783782959, true) <= 5 then		
								
								if JustDriedWeed or JustPackedWeed then
									TriggerEvent("DoLongHudText","You are too tired from a different task, either wait 5 minutes or get help!")
								else
									if not JustPickedWeed then
										JustPickedWeed = true
										TriggerEvent("weed:spam-prevent","picking")
									end
									TriggerEvent("animation:farm")
									TriggerEvent("player:receiveItem","cocaleafs",math.random(3))
								end
							end	
				-- HARVEST WEED - END			
			
				Wait(2500)

			end
	
		end
	
	end)
	
	
	RegisterNetEvent('animation:farm')
	AddEventHandler('animation:farm', function()
	
			inanimation = true
			local lPed = GetPlayerPed(-1)
			RequestAnimDict("amb@world_human_gardener_plant@male@base")
			while not HasAnimDictLoaded("amb@world_human_gardener_plant@male@base") do
				Citizen.Wait(0)
			end
			
			if IsEntityPlayingAnim(lPed, "amb@world_human_gardener_plant@male@base", "base", 3) then
				ClearPedSecondaryTask(lPed)
			else
				TaskPlayAnim(lPed, "amb@world_human_gardener_plant@male@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
				seccount = 4
				while seccount > 0 do
					Citizen.Wait(1000)
					seccount = seccount - 1
				end
				ClearPedSecondaryTask(lPed)
			end		
			inanimation = false
	
	end)
	
