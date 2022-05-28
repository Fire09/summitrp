local blips = {
    {title="Sell Iron", colour=5, id=500, scale=0.5, x = 2341.77118652344, y =  3129.06130126953, z = 48.21114105225},
    {title="Smelter", colour=5, id=365, scale=0.5, x = 1084.8002929688, y = -2002.1312255859, z = 31.418100357056},
    {title="Wash Stones", colour=5, id=365, scale=0.5, x = 1984.2188720703, y =  552.18225097656, z = 161.0832824707},
    {title="Mining", colour=5, id=365, scale=0.5, x = 2996.46088134766, y =  2754.3775, z = 43.12809265137}
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, info.scale)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

local currentlyMining = false
local currentlySmelting = false
local pFarmed = 0


RegisterNetEvent("start-mining")
AddEventHandler("start-mining", function()
	if exports["srp-inventory"]:hasEnoughOfItem("pickaxe",1,false) and not currentlyMining then 
        currentlyMining = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

            FreezeEntityPosition(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
            Citizen.Wait(200)
            
            local pickaxe = GetHashKey("prop_tool_pickaxe")
            
            -- Loads model
            RequestModel(pickaxe)
            while not HasModelLoaded(pickaxe) do
            Wait(1)
            end
            
            local anim = "melee@hatchet@streamed_core_fps"
            local action = "plyr_front_takedown"
            
            -- Loads animation
            RequestAnimDict(anim)
            while not HasAnimDictLoaded(anim) do
                Wait(1)
            end
            
            local object = CreateObject(pickaxe, coords.x, coords.y, coords.z, true, false, false)
            AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, 57005), 0.1, 0.0, 0.0, -90.0, 25.0, 35.0, true, true, false, true, 1, true)
            TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
            -- SetEntityHeading(PlayerPedId(), 294.89007568359)

            local finished = exports ["srp-taskbarskill"]:taskBar(18000,math.random(10,20))
            if (finished == 100) then
                local finished = exports ["srp-taskbarskill"]:taskBar(18000,math.random(10,20))
                if (finished == 100) then
                    local finished = exports ["srp-taskbarskill"]:taskBar(18000,math.random(10,20))
                    if (finished == 100) then
                        TriggerEvent('player:receiveItem', "stone", math.random(1,5))
                        pFarmed = pFarmed + 1    
                    else
                        TriggerEvent("DoLongHudText", "Unlucky", 2)
                        currentlyMining = false
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(playerPed, false)
                        DeleteObject(object)
                    
                    end
                else
                    TriggerEvent("DoLongHudText", "Unlucky", 2)
                    currentlyMining = false
                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(playerPed, false)
                    DeleteObject(object)
                
                end
                              
            else
                TriggerEvent("DoLongHudText", "Unlucky", 2)
                currentlyMining = false
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(playerPed, false)
                DeleteObject(object)
            
            end

            currentlyMining = false
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(playerPed, false)
            DeleteObject(object)
        

    else
		TriggerEvent('DoLongHudText', 'You need a pickaxe', 2)
    end
end)




RegisterNetEvent("washerevent")
AddEventHandler("washerevent", function()
    if exports['srp-inventory']:hasEnoughOfItem("washedpan", 1) and exports['srp-inventory']:hasEnoughOfItem("stone", 1) then
        local bitch = exports['srp-inventory']:getQuantity("stone")
        if bitch >= 1 then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            
            FreezeEntityPosition(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
            Citizen.Wait(200)
            
            local pHasStone = exports['srp-inventory']:getQuantity("stone")
            if pHasStone >= 1 then
                TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                local finished = exports["srp-taskbar"]:taskBar(10000,"Washing Stones")
                if finished == 100 then
                    TriggerEvent("inventory:removeItem","stone", 5)
                    TriggerEvent('player:receiveItem',"washedstone", math.random(1,8))	                    
                end

                
                ClearPedTasks(playerPed)
                FreezeEntityPosition(playerPed, false)
            else
                TriggerEvent('DoLongHudText', 'You need a 1x Stone to wash here!', 2)
            end
        else
            TriggerEvent('DoLongHudText', 'You need a wash pan to wash here!', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You need a wash pan & atleast 1x Stone.', 2)
    end
end)

RegisterNetEvent("SmeltingEvent")
AddEventHandler("SmeltingEvent", function()
    local bitch = exports['srp-inventory']:getQuantity("washedstone")
    if bitch >= 1 then        
        currentlySmelting = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
            
        FreezeEntityPosition(playerPed, true)
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
        Citizen.Wait(200)
                
        local finished = exports["srp-taskbar"]:taskBar(10000,"Smelting Washed Stone")
        if finished == 100 then
            TriggerEvent("inventory:removeItem","washedstone", 1)
                
            local itemLimit1 = exports['srp-inventory']:getQuantity("goldbar")
            local itemLimit2 = exports['srp-inventory']:getQuantity("silverbar")
            local itemLimit3 = exports['srp-inventory']:getQuantity("goldbar")
            local itemLimit4 = exports['srp-inventory']:getQuantity("silverbar")
            local itemLimit5 = exports['srp-inventory']:getQuantity("copperbar")
            local itemLimit6 = exports['srp-inventory']:getQuantity("ironbar")
            
            local rewardChance = math.random(1,10)

            if rewardChance == 1 then
                if itemLimit1 < 10000 then
                    TriggerEvent('player:receiveItem', "ironbar", math.random(1,2))
                    TriggerEvent('DoLongHudText', 'You received a Iron Bar!')
                end
            elseif rewardChance == 2 then
                if itemLimit2 < 10000 then
                    TriggerEvent('player:receiveItem', "ironbar", math.random(1,3))
                    TriggerEvent('DoLongHudText', 'You received a Iron Bar!')
                end
            elseif rewardChance == 3 or rewardChance == 3 or rewardChance == 3 then
                local firstChance = math.random(1,2)
                if firstChance == 1 then
                    if itemLimit3 < 10000 then
                        TriggerEvent('player:receiveItem', "umetal", math.random(1,4))
                        TriggerEvent('DoLongHudText', 'You received a Unknown Material!')
                    end
                else
                    if itemLimit4 < 10000 then
                        TriggerEvent('player:receiveItem', "ironbar", math.random(1,3))
                        TriggerEvent('DoLongHudText', 'You received a Iron Bar!')
                    end
                end
            elseif rewardChance == 6 or rewardChance == 7 or rewardChance == 8 or rewardChance == 9 or rewardChance == 10 then
                local secondChance = math.random(1,2)
                if secondChance == 1 then
                    if itemLimit5 < 10000 then
                        TriggerEvent('player:receiveItem', "ironbar", math.random(1,2))
                        TriggerEvent('DoLongHudText', 'You received a Iron Bar!')
                    end
                else
                    if itemLimit6 < 10000 then
                        TriggerEvent('player:receiveItem', "ironbar", math.random(1, 2))
                        TriggerEvent('DoLongHudText', 'You received a Iron Bar!')
                    end
                end
            end
            
            FreezeEntityPosition(playerPed, false)
            currentlySmelting = false
            keyPressed = false
        end
    else
        TriggerEvent('DoLongHudText', 'You need at least 1x Washed Stone to Smelt here!', 2)
        keyPressed = false
    end

end)



RegisterNetEvent("mining:sell", function(pType)
    local pAmont = exports['srp-inventory']:getQuantity(pType)
    local pTaskbarTimer = pAmont * 2500
    local pFinished = exports["srp-taskbar"]:taskBar(pTaskbarTimer, "Selling Items")
    if (pFinished == 100) then
        TriggerServerEvent("mining-sell:items", pAmont, pType)
    else
        TriggerEvent("DoLongHudText", "You cancelled the sell!", 2)
    end
end)

RegisterNetEvent("receivepickaxe")
AddEventHandler("receivepickaxe", function()
	local finished = exports["srp-taskbar"]:taskBar(4000,"Talking...")
	if (finished == 100) then
		TriggerEvent("DoLongHudText", "Here You Go Man, Good Luck!")
		Citizen.Wait(2000)
		TriggerEvent("player:receiveItem","pickaxe", 1)
	end
end)

RegisterNetEvent("receivewashpan")
AddEventHandler("receivewashpan", function()
	local finished = exports["srp-taskbar"]:taskBar(4000,"Talking...")
	if (finished == 100) then
		TriggerEvent("DoLongHudText", "Here You Go Man, Good Luck!")
		Citizen.Wait(2000)
		TriggerEvent("player:receiveItem","washpan", 1)
	end
end)


RegisterNetEvent("miningmenu")
AddEventHandler("miningmenu", function()
	TriggerEvent('srp-context:sendMenu', {
		{
			id = "1",
			header = "Mining Guide",
			txt = "Learn How To Mine",
			params = {
				event = "mining-info",
			}
		},
        {
			id = "2",
			header = "Ask For Pickaxe",
			txt = "",
			params = {
				event = "receivepickaxe",
			}
		},
        {
			id = "3",
			header = "Ask For Washing Pan",
			txt = "",
			params = {
				event = "receivewashpan",
			}
		},
		{
			id = "4",
			header = "Close Menu",
			txt = "Exit",
			params = {
				event = "",
			}
		},
	})
end)


RegisterNetEvent("mining-info")
AddEventHandler("mining-info", function()
	TriggerEvent('srp-context:sendMenu', {
		{
			id = "1",
			header = "Miner",
			txt = "",
		},
        {
			id = "2",
			header = "Miner Says",
			txt = "Use your F1 muscle behind me to start mining and make sure you have a pickaxe to mine the stone and a wash pan to wash the stone!",
		},
		{
			id = "3",
			header = "Close Menu",
			txt = "Exit",
			params = {
				event = "",
			}
		},
	})
end)
