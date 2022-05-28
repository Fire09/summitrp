
RegisterNetEvent("gardeningstart")
AddEventHandler("gardeningstart", function()
	TriggerEvent("animation:gardening")
    local finished = exports['srp-taskbar']:taskBar(5000, 'Shaking Tree')   
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'orange', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
        end
end)

RegisterNetEvent("gardeningstart1")
AddEventHandler("gardeningstart1", function()
	TriggerEvent("animation:gardening")
    local finished = exports['srp-taskbar']:taskBar(5000, 'Shaking Tree')   
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'orange', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
        end
end)

RegisterNetEvent("gardeningstart2")
AddEventHandler("gardeningstart2", function()
	TriggerEvent("animation:gardening")
    local finished = exports['srp-taskbar']:taskBar(5000, 'Shaking Tree')   
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'orange', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
        end
end)

RegisterNetEvent("gardeningstart3")
AddEventHandler("gardeningstart3", function()
	TriggerEvent("animation:gardening")
    local finished = exports['srp-taskbar']:taskBar(5000, 'Shaking Tree')   
        if (finished == 100) then
            TriggerEvent('player:receiveItem', 'orange', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
        end
end)


RegisterNetEvent('gardening')
AddEventHandler('gardening', function()
	TriggerEvent('srp-context:sendMenu', {
		{
            id = 1,
            header = "Gardening",
            txt = ""
        },
        {
            id = 2,
            header = "Shake for Oranges",
			txt = "",
			params = {
                event = "gardeningstart"
            }
        },
    })
end)

RegisterNetEvent('gardening1')
AddEventHandler('gardening1', function()
	TriggerEvent('srp-context:sendMenu', {
		{
            id = 1,
            header = "Gardening",
            txt = ""
        },
        {
            id = 2,
            header = "Shake for Oranges",
			txt = "",
			params = {
                event = "gardeningstart1"
            }
        },
    })
end)

RegisterNetEvent('gardening2')
AddEventHandler('gardening2', function()
	TriggerEvent('srp-context:sendMenu', {
		{
            id = 1,
            header = "Gardening",
            txt = ""
        },
        {
            id = 2,
            header = "Shake for Oranges",
			txt = "",
			params = {
                event = "gardeningstart2"
            }
        },
    })
end)

RegisterNetEvent('gardening3')
AddEventHandler('gardening3', function()
	TriggerEvent('srp-context:sendMenu', {
		{
            id = 1,
            header = "Gardening",
            txt = ""
        },
        {
            id = 2,
            header = "Shake for Oranges",
			txt = "",
			params = {
                event = "gardeningstart3"
            }
        },
    })
end)

--------------selll shakewell

RegisterNetEvent("gardeningstartsell")
AddEventHandler("gardeningstartsell", function()
	if exports["srp-inventory"]:hasEnoughOfItem("orange",10,false) then
		local finished = exports["srp-taskbar"]:taskBar(3000,"Selling Oranges")
		if (finished == 100) then
			TriggerEvent("inventory:removeItem","orange", 10)
			TriggerEvent("DoLongHudText", "Thanks For Oranges!")
			Citizen.Wait(5000)
			TriggerServerEvent("gardening:sell")
		end
	end
end)

RegisterNetEvent('gardeningsell1')
AddEventHandler('gardeningsell1', function()
	TriggerEvent('srp-context:sendMenu', {
		{
            id = 1,
            header = "Vendor",
            txt = ""
        },
        {
            id = 2,
            header = "Sell Oranges 10x",
			txt = "",
			params = {
                event = "gardeningstartsell"
            }
        },
    })
end)

RegisterNetEvent('animation:gardening')
AddEventHandler('animation:gardening', function()

		inanimation = true
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("move_m@_idles@shake_off")
		while not HasAnimDictLoaded("move_m@_idles@shake_off") do
			Citizen.Wait(0)
		end
		
		if IsEntityPlayingAnim(lPed, "move_m@_idles@shake_off", "shakeoff_3", 3) then
			ClearPedSecondaryTask(lPed)
		else
			TaskPlayAnim(lPed, "move_m@_idles@shake_off", "shakeoff_3", 8.0, -8, -1, 49, 0, 0, 0, 0)
			seccount = 4
			while seccount > 0 do
				Citizen.Wait(1000)
				seccount = seccount - 1
			end
			ClearPedSecondaryTask(lPed)
		end		
		inanimation = false

end)
