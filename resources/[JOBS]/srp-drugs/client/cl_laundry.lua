local ongoing = false
local laundery = false

RegisterNetEvent("laundrystart")
AddEventHandler("laundrystart", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1122.4, -3193.39, -40.4, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("rollcash",50,false) and ongoing == false then
		TriggerEvent("animation:coke")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 358.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(20000,"Cleaning Money")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","rollcash", 50)

				TriggerEvent("DoLongHudText", "You Pressed Something Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","rollcash", 50)

				TriggerEvent("DoLongHudText", "You Successfully Washed Money, Wait 1 Minute For It To Dry.")
				ongoing = true
				laundery = true
				Citizen.Wait(60000)
				TriggerEvent("DoLongHudText", "Money is almost ready, may wanna go check on it.")
				Citizen.Wait(5000)
				if laundery == true then
					TriggerEvent("DoLongHudText", "Finished!")
					
					TriggerServerEvent('laundry:givemoney')
					ongoing = false
					laundery = false
				elseif laundery == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)

RegisterNetEvent("laundrystart2")
AddEventHandler("laundrystart2", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1122.4, -3193.39, -40.4, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("rollcash",100,false) and ongoing == false then
		TriggerEvent("animation:coke")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 358.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(20000,"Cleaning Money")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","rollcash", 100)

				TriggerEvent("DoLongHudText", "You Pressed Something Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","rollcash", 100)

				TriggerEvent("DoLongHudText", "You Successfully Washed Money, Wait 1 Minute For It To Dry.")
				ongoing = true
				laundery = true
				Citizen.Wait(60000)
				TriggerEvent("DoLongHudText", "Money is almost ready, may wanna go check on it.")
				Citizen.Wait(5000)
				if laundery == true then
					TriggerEvent("DoLongHudText", "Finished!")

					TriggerServerEvent('laundry:givemoney1')
					ongoing = false
					laundery = false
				elseif laundery == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)

RegisterNetEvent("laundrystart3")
AddEventHandler("laundrystart3", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1122.4, -3193.39, -40.4, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("rollcash",500,false) and ongoing == false then
		TriggerEvent("animation:coke")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 358.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(20000,"Cleaning Money")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","rollcash", 500)

				TriggerEvent("DoLongHudText", "You Pressed Something Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","rollcash", 500)

				TriggerEvent("DoLongHudText", "You Successfully Washed Money, Wait 1 Minute For It To Dry.")
				ongoing = true
				laundery = true
				Citizen.Wait(60000)
				TriggerEvent("DoLongHudText", "Money is almost ready, may wanna go check on it.")
				Citizen.Wait(5000)
				if laundery == true then
					TriggerEvent("DoLongHudText", "Finished!")

					TriggerServerEvent('laundry:givemoney2')
					ongoing = false
					laundery = false
				elseif laundery == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)


RegisterNetEvent("laundrystart4")
AddEventHandler("laundrystart4", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1123.97, -3194.4, -40.4, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("band",50,false) and ongoing == false then
		TriggerEvent("animation:coke")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 358.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(20000,"Cleaning Money")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","band", 50)

				TriggerEvent("DoLongHudText", "You Pressed Something Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","band", 50)

				TriggerEvent("DoLongHudText", "You Successfully Washed Money, Wait 1 Minute For It To Dry.")
				ongoing = true
				laundery = true
				Citizen.Wait(60000)
				TriggerEvent("DoLongHudText", "Money is almost ready, may wanna go check on it.")
				Citizen.Wait(5000)
				if laundery == true then
					TriggerEvent("DoLongHudText", "Finished!")

					TriggerServerEvent('laundry:givemoney3')
					ongoing = false
					laundery = false
				elseif laundery == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)

RegisterNetEvent("laundrystart5")
AddEventHandler("laundrystart5", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1123.97, -3194.4, -40.4, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("band",100,false) and ongoing == false then
		TriggerEvent("animation:coke")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 358.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(20000,"Cleaning Money")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","band", 100)

				TriggerEvent("DoLongHudText", "You Pressed Something Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","band", 100)

				TriggerEvent("DoLongHudText", "You Successfully Washed Money, Wait 1 Minute For It To Dry.")
				ongoing = true
				laundery = true
				Citizen.Wait(60000)
				TriggerEvent("DoLongHudText", "Money is almost ready, may wanna go check on it.")
				Citizen.Wait(5000)
				if laundery == true then
					TriggerEvent("DoLongHudText", "Finished!")

					TriggerServerEvent('laundry:givemoney4')
					ongoing = false
					laundery = false
				elseif laundery == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)

RegisterNetEvent("laundrystart6")
AddEventHandler("laundrystart6", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1125.42, -3194.44, -40.4, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("markedbills",50,false) and ongoing == false then
		TriggerEvent("animation:coke")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 358.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(20000,"Cleaning Money")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","markedbills", 50)

				TriggerEvent("DoLongHudText", "You Pressed Something Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","markedbills", 50)

				TriggerEvent("DoLongHudText", "You Successfully Washed Money, Wait 1 Minute For It To Dry.")
				ongoing = true
				laundery = true
				Citizen.Wait(60000)
				TriggerEvent("DoLongHudText", "Money is almost ready, may wanna go check on it.")
				Citizen.Wait(5000)
				if laundery == true then
					TriggerEvent("DoLongHudText", "Finished!")

					TriggerServerEvent('laundry:givemoney5')
					ongoing = false
					laundery = false
				elseif laundery == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)

RegisterNetEvent("laundrystart7")
AddEventHandler("laundrystart7", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1125.66, -3194.44, -40.4, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("markedbills",100,false) and ongoing == false then
		TriggerEvent("animation:coke")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 358.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(20000,"Cleaning Money")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","markedbills", 100)

				TriggerEvent("DoLongHudText", "You Pressed Something Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","markedbills", 100)

				TriggerEvent("DoLongHudText", "You Successfully Washed Money, Wait 1 Minute For It To Dry.")
				ongoing = true
				laundery = true
				Citizen.Wait(60000)
				TriggerEvent("DoLongHudText", "Money is almost ready, may wanna go check on it.")
				Citizen.Wait(5000)
				if laundery == true then
					TriggerEvent("DoLongHudText", "Finished!")

					TriggerServerEvent('laundry:givemoney6')
					ongoing = false
					laundery = false
				elseif laundery == false then
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
			Citizen.Wait(30000)
			FreezeEntityPosition(PlayerPedId(),false)
			seccount = seccount - 1
		end
		ClearPedSecondaryTask(lPed)
	end		
	inanimation = false
end)

RegisterNetEvent('laundrystart22')
AddEventHandler('laundrystart22', function()
	TriggerEvent('srp-context:sendMenu', {
		{
            id = 1,
            header = "Clean Money",
            txt = ""
        },
        {
            id = 2,
            header = "Clean 50 Rolls",
			txt = "",
			params = {
                event = "laundrystart"
            }
        },
		{
            id = 3,
            header = "Clean 100 Rolls",
			txt = "",
			params = {
                event = "laundrystart2"
            }
        },
		{
			id = 4,
			header = "Clean 500 Rolls",
			txt = "",
			params = {
				event = "laundrystart3"
			}
		},
    })
end)

RegisterNetEvent("laundrystart:clean")
AddEventHandler("laundrystart:clean", function()
	TriggerServerEvent("laundrystart2:clean")
	TriggerServerEvent("launderystart3:clean")
end)


RegisterNetEvent("stoplaundery")
AddEventHandler("stoplaundery", function()
	if laundery == true then
		TriggerEvent("DoLongHudText", "Failed, You Left The Laundry To Early!")
		laundery = false
		ongoing = false
	end
end)

RegisterNetEvent('laundrystar23')
AddEventHandler('laundrystart23', function()
	TriggerEvent('srp-context:sendMenu', {
		{
            id = 1,
            header = "Clean Money",
            txt = ""
        },
        {
            id = 2,
            header = "Clean 50 Bands",
			txt = "",
			params = {
                event = "laundrystart4"
            }
        },
		{
            id = 3,
            header = "Clean 100 Bands",
			txt = "",
			params = {
                event = "laundrystart5"
            }
        },
	})
end)

RegisterNetEvent("laundrystart:clean")
AddEventHandler("laundrystart:clean", function()
	TriggerServerEvent("laundrystart4:clean")
	TriggerServerEvent("launderystart5:clean")
end)

RegisterNetEvent("stoplaundery")
AddEventHandler("stoplaundery", function()
	if laundery == true then
		TriggerEvent("DoLongHudText", "Failed, You Left The Laundry To Early!")
		laundery = false
		ongoing = false
	end
end)

RegisterNetEvent('laundrystar24')
AddEventHandler('laundrystart24', function()
	TriggerEvent('srp-context:sendMenu', {
		{
            id = 1,
            header = "Clean Money",
            txt = ""
        },
        {
            id = 2,
            header = "Clean 50 Marked Bills",
			txt = "",
			params = {
                event = "laundrystart6"
            }
        },
		{
            id = 3,
            header = "Clean 100 Marked Bills",
			txt = "",
			params = {
                event = "laundrystart7"
            }
        },
	})
end)

RegisterNetEvent("laundrystart:clean")
AddEventHandler("laundrystart:clean", function()
	TriggerServerEvent("laundrystart6:clean")
	TriggerServerEvent("launderystart7:clean")
end)

RegisterNetEvent("stoplaundery")
AddEventHandler("stoplaundery", function()
	if laundery == true then
		TriggerEvent("DoLongHudText", "Failed, You Left The Laundry To Early!")
		laundery = false
		ongoing = false
	end
end)
