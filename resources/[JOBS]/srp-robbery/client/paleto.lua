local copAmount = 4

isCop = false

function DT(x,y,z,text)
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

function DrawText3Ds(x,y,z)
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterCommand("jewelry", function()
	TriggerServerEvent("jewel:request")
end)


-- Functions

function firstdoor(success, timeremaining)
    if success then
        TriggerServerEvent("srp-doors:alterlockstate", 130, false)
        TriggerEvent('mhacking:hide')
		TriggerEvent("DoLongHudText","Success!")
        ExecuteCommand('e c')
        TriggerEvent('srp-alerts:paleto')
        
    else
        TriggerEvent('mhacking:hide')
		TriggerEvent("DoLongHudText","Failure!")
        ExecuteCommand('e c')
		TriggerEvent('srp-alerts:paleto')
    end
end

function seconddoor(success, timeremaining)
    if success then
        TriggerServerEvent("srp-doors:alterlockstate", 130, false)
        TriggerEvent('mhacking:hide')
		TriggerEvent("DoLongHudText","Success!")
        ExecuteCommand('e c')
    else
        TriggerEvent('mhacking:hide')
		TriggerEvent("DoLongHudText","Failure!")
        ExecuteCommand('e c')
		TriggerEvent('srp-dispatch:Paleto Robbery')
    end
end

--#####################--
--#Paleto Bank Robbery#--
--#####################--

Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(-119.22237792969, 6477.79113067627, 31.574399414062) - player)
        if distance < 3.0 then
        	 Wait(1)
             DrawMarker(27,-119.22237792969, 6477.79113067627, 30.574399414062, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
             if exports["isPed"]:isPed("countpolice") >= 6 then
             if IsControlJustReleased(0,38) and distance < 1.0 then
             	if exports["srp-inventory"]:hasEnoughOfItem("electronickit",1,false) then
                    TriggerEvent("inventory:removeItem", "electronickit", 1)
					TriggerEvent("animation:PlayAnimation","leanbar2")
                    TriggerEvent("mhacking:show")
                    TriggerEvent("mhacking:start",7,13,firstdoor)
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
        local distance = #(vector3(-96.9754589844, 6475.354921875, 31.435726470947) - player)
        if distance < 3.0 then
        	 Wait(1)
             DrawMarker(27,-96.9754589844, 6475.354921875, 31.435726470947, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
             if IsControlJustReleased(0,38) and distance < 1.0 then
                if exports["isPed"]:isPed("countpolice") >= 6 then
             	if exports["srp-inventory"]:hasEnoughOfItem("electronickit",1,false) then
                    TriggerEvent("inventory:removeItem", "electronickit", 1)
					TriggerEvent("animation:PlayAnimation","leanbar2")
                    TriggerEvent("mhacking:show")
                    TriggerEvent("mhacking:start",7,13,seconddoor)
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
        local distance = #(vector3(-107.14723968506, 6473.54296875, 30.730934143066) - player)
        if distance < 1.5 then
			DrawMarker(27,-107.14723968506, 6473.54296875, 30.730934143066, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
					TriggerEvent('srp-dispatch:Paleto Robbery')
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Fidgeting with bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                        TriggerEvent("player:receiveItem", "Bankbox", 1 )
                    Citizen.Wait(3600000)
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
        local distance = #(vector3(-107.49057006836, 6475.623046875, 30.726722717285) - player)
        if distance < 1.5 then
			DrawMarker(27,-107.49057006836, 6475.623046875, 30.726722717285, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
					TriggerEvent('srp-dispatch:Paleto Robbery')
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Fidgeting with bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                        TriggerEvent("player:receiveItem", "Bankbox", 1 )
                    Citizen.Wait(3600000)
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
        local distance = #(vector3(-102.85723114014, 6475.5473632812, 30.726741790771) - player)
        if distance < 1.5 then
			DrawMarker(27,-102.85723114014, 6475.5473632812, 30.726741790771, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
					TriggerEvent('srp-dispatch:Paleto Robbery')
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Fidgeting with bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                        TriggerEvent("player:receiveItem", "Bankbox", 1 )
                    Citizen.Wait(3600000)
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
        local distance = #(vector3(-102.69828033447, 6477.40625, 30.777498245239) - player)
        if distance < 1.5 then
			DrawMarker(27,-102.69828033447, 6477.40625, 30.777498245239, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
					TriggerEvent('srp-dispatch:Paleto Robbery')
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Fidgeting with bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                      TriggerEvent("player:receiveItem", "Bankbox", 1 )
                    Citizen.Wait(3600000)
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
        local distance = #(vector3(-103.86913299561, 6478.4946289062, 30.726720809937) - player)
        if distance < 1.5 then
			DrawMarker(27,-103.86913299561, 6478.4946289062, 30.726720809937, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
					TriggerEvent('srp-dispatch:Paleto Robbery')
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Fidgeting with bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                        TriggerEvent("player:receiveItem", "Bankbox", 1 )
                    Citizen.Wait(3600000)
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
        local distance = #(vector3(-105.94645690918, 6478.6337890625, 30.726657867432) - player)
        if distance < 1.5 then
			DrawMarker(27,-105.94645690918, 6478.6337890625, 30.726657867432, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0)
            Wait(1)
            if IsControlJustReleased(0,38) and distance < 1.5 then
                 if exports["srp-inventory"]:hasEnoughOfItem("drill",1,false) then
                    TriggerEvent("animation:PlayAnimation","welding")
					TriggerEvent('srp-alerts:AlertPaleto')
                    local finished = exports["srp-taskbar"]:taskBar(50000,"Fidgeting with bankbox")
                    TriggerEvent("inventory:removeItem", "drill", 1)
                        TriggerEvent("player:receiveItem", "Bankbox", 1 )
                    Citizen.Wait(3600000)
                 end
             end
        else
            Wait(3000)
        end        
    end
end)