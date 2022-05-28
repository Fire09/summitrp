
started = false


gotdest = false


function gotoOxy()


    currentRoute       = Config.Routes[math.random(1, #Config.Routes)]
    currentDestination = currentRoute.Destinations[math.random(1, #currentRoute.Destinations)]
    --currentAiSpawn = currentRoute.PickupCoordinates[math.random(1, #currentRoute.PickupCoordinates)]
    --currentAiSpawnHeading = currentRoute.PickupHeading[math.random(1, #currentRoute.PickupHeading)]
    gotdest = true
    SetNewWaypoint(currentDestination.x, currentDestination.y)
    DeliveryBlip = AddBlipForCoord(currentDestination.x, currentDestination.y, 45.87)
end


pedcreated = false


Citizen.CreateThread(function()

    while true do

	    Citizen.Wait(1)
	    local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
	    if GetDistanceBetweenCoords(-1563.51, -441.16, 36.97, pedCoords) < 60.0 then
            createoxyPed()
            if GetDistanceBetweenCoords(-1563.51, -441.16, 36.97, pedCoords) < 5.0 then
			    --DrawText3Ds(-1563.51, -441.16, 36.97, "[E] $1500 - Delivery Job") 
			    ---if IsControlJustReleased(0,38) then
				---    TriggerServerEvent("esxoxy:serverPay",1500)
				---    Citizen.Wait(1000)
			   --- end
            end
		else
             pedcreated = false
             DeleteEntity(oxyped)
        end


        local mycoords = GetEntityCoords(carpedDrive)

        if foundcar == true then
            
            if GetDistanceBetweenCoords(mycoords.x, mycoords.y, mycoords.z, pedCoords) < 1.5 then

			    --DrawText3Ds(mycoords.x, mycoords.y, mycoords.z, "[E] To deliver Oxy!") 
			    if IsControlJustReleased(0,38) and boxesped ~= 0 and boxinhand then
				    SetEntityAsNoLongerNeeded(pedCar)
                    SetEntityAsNoLongerNeeded(carpedDrive)
                    --test = false
                    foundcar = false
                    DropBox()
                    PlayAmbientSpeech1(carpedDrive, "Generic_Thanks", "Speech_Params_Force_Shouted_Critical")
                    boxinhand = false
                    pedisspawned = false
                    boxesped = boxesped - 1
                    TriggerServerEvent("oxy:givemoney")
				    Citizen.Wait(1000)

                    Wait(100000)
                    GetRandomAI()
			    elseif IsControlJustReleased(0,38) and boxesped == 0 then
                    TriggerServerEvent("DoLongText","No More Oxy G")
                elseif IsControlJustReleased(0,38) and not boxinhand then
                    TriggerEvent("DoLongHudText", "Is this a joke? Are you a cop! Im out of here!!",1 ) --Is this a joke? Are you a cop! Im out of here!!
                    SetEntityAsNoLongerNeeded(pedCar)
                    SetEntityAsNoLongerNeeded(carpedDrive)
                    SetPedScream(carpedDrive)
                    Wait(100000)
                    foundcar = false
                    pedisspawned = false
                end


		    end	
        end

        local carcoords = GetEntityCoords(oxyVehicle)

        if Oxyrun == true then
            
            if GetDistanceBetweenCoords(carcoords.x, carcoords.y, carcoords.z, pedCoords) < 2.0 then
                 if not IsPedInVehicle(PlayerPedId(), oxyVehicle, true) then
			        --DrawText3Ds(carcoords.x, carcoords.y, carcoords.z, "[E] To take out package! " ..boxes.."/5 boxes left") 
			        if IsControlJustReleased(0,38) and boxes ~= 0 and not boxinhand then
                        AnimationBox1(ped)
                        Wait(2000)
                        ClearPedTasksImmediately(ped)
                        TakeBox()
                        boxinhand = true
                        boxes = boxes - 1
			        elseif IsControlJustReleased(0,38) and boxinhand then
                        TriggerEvent("DoLongHudText", "You already have package in your hand!",1)
                    end
                 end    
		    end	
        end

        if boxesped == 0 then 

            TriggerEvent("DoLongHudText", "You dont have anymore packages left. Dump the car it might be hot!",1)-- You dont have anymore packages left. Dump the car it might be hot!
            SetEntityAsNoLongerNeeded(pedCar)
            SetEntityAsNoLongerNeeded(carpedDrive)

            pedisspawned = false
            boxinhand = false
            foundcar = false
            test = false
            started = false
            Oxyrun = false
        end

        if (not DoesEntityExist(oxyVehicle) or GetVehicleEngineHealth(oxyVehicle) < 100.0) and started then
            pedisspawned = false
            boxinhand = false
            foundcar = false
            test = false
            started = false
            Oxyrun = false
		    TriggerEvent("DoLongHudText", "Yo you destroyed the car man! I will get someone else to deilver the packages!",1) -- Yo you ~r~destroyed ~w~the car man! I will get someone else to deilver the packages!
        end

        --if (not DoesEntityExist(carpedDrive) or GetVehicleEngineHealth(pedCar) < 100.0) or IsPedFleeing(carpedDrive) and started and pedisspawned then
        if IsPedDeadOrDying(carpedDrive, 1) and started and pedisspawned then
            print(IsPedDeadOrDying)
            print(started)
            print(pedisspawned)
            pedisspawned = false
            foundcar = false
            test = false
            Oxyrun = false
            TriggerEvent("DoLongHudText", "Something happened to one of your clients another one is on the way!",1) --Something happened to one of your clients another one is on the way!
        end

        if IsPedFleeing(carpedDrive, 1) and started and pedisspawned then
            print(IsPedDeadOrDying)
            print(started)
            print(pedisspawned)
            pedisspawned = false
            foundcar = false
            test = false
            Oxyrun = false
            TriggerEvent("DoLongHudText", "Something happened to one of your clients another one is on the way!",1)
        end



        if gotdest and GetDistanceBetweenCoords(currentDestination.x, currentDestination.y, currentDestination.z, pedCoords) < 50.0 and started == true and pedisspawned == false then
                local ped = PlayerPedId()
		        local pedCoords = GetEntityCoords(ped)
                TriggerEvent("DoLongHudText", "Wait for your clients at the spot! Take the package out and wait",1)
                --ESX.ShowHelpNotification("You are close to the drop off wait for your clients!")
                pedisspawned = true
                RemoveBlip(DeliveryBlip)
                GetRandomAI()
        end
    end
end)

function AnimationBox1(ped)
    TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN', 0, false)
end


pedisspawned = false

boxinhand = false

foundcar = false
test = false

boxesped = 5
boxes = 5

local carpick = {
    [1] = "sultan",
    [2] = "kuruma",
    [3] = "futo",
    [4] = "granger",
    [5] = "tailgater",
}


---function createoxyPed()
---    if not pedcreated then
 --           local hashKey = `g_m_m_chicold_01`
--	        local pedType = GetPedType(hashKey)
 ---           RequestModel(hashKey)
--            oxyped = CreatePed(pedType, hashKey, -1563.51, -441.16, 36.97, 64.41, 1, 1)
---            pedcreated = true
----    end
---end


function GetRandomAI()
       test = true
       -- carforPed = GetRandomVehicleInSphere(1312.87, 2688.83, 37.61, 1500000000, 0, 10)
       local hashKey = `a_m_y_stwhi_02`
	   local pedType = GetPedType(hashKey)
       RequestModel(hashKey)
       carpedDrive = CreatePed(pedType, hashKey, currentRoute.PickupCoordinates, currentRoute.PickupHeading, 1, 1)

       if DoesEntityExist(pedCar) then

	        --SetVehicleHasBeenOwnedByPlayer(pedCar,false)
		    SetEntityAsNoLongerNeeded(pedCar)
		    DeleteEntity(pedCar)
	   end

       local car = GetHashKey(carpick[math.random(#carpick)])
       RequestModel(car)
       while not HasModelLoaded(car) do
           Citizen.Wait(0)
       end

       SetPedSeeingRange(carpedDrive, 0.0)
       SetPedHearingRange(carpedDrive, 0.0)
       SetPedAlertness(carpedDrive, 0)
       
       print(car)

       pedCar = CreateVehicle(car, currentRoute.PickupCoordinates, currentRoute.PickupHeading, true, false)
	   local plt = GetVehicleNumberPlateText(pedCar)
	   DecorSetInt(pedCar,"GamemodeCar",955)
	   --SetVehicleHasBeenOwnedByPlayer(oxyVehicle,true)
       SetPedIntoVehicle(carpedDrive, pedCar, -1)

       --local car1 = GetHashKey("sultan")
       --carforPed = CreateVehicle(car1, 1773.32, 2130.67, 64.40, 168.97, true, false)
       local mycoords = GetEntityCoords(carforPed)

       carped = GetPedInVehicleSeat(carforPed, -1)
       local veh = GetVehiclePedIsIn(carped, false)
       local model = GetEntityModel(veh)
       local displaytext = GetDisplayNameFromVehicleModel(model)
       local name = GetLabelText(displaytext)

       SetEntityAsMissionEntity(veh,true,true)
       SetEntityAsMissionEntity(carped,true,true)

       local plate = GetVehicleNumberPlateText(veh)

       foundcar = true
       Oxyrun = true

       local speed = Config.SpeedOfPedWhenDriving

       print(Config.SpeedOfPedWhenDriving)

       TaskVehicleDriveToCoord(carpedDrive, pedCar, currentDestination.x, currentDestination.y, currentDestination.z, Config.SpeedOfPedWhenDriving, 1, 0, 786603, 15.0, true)

       if carforPed == 0 then
          Oxyrun = true
          test = false
       end


       if carforPed ~= 0 then
          print(mycoords)
       end
end

function DropBox()
    ClearPedTasks(GetPlayerPed(-1))
    DetachEntity(CarryPackage, true, true)
    DeleteObject(CarryPackage)
    CarryPackage = nil
end


function TakeBox()
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(GetPlayerPed(-1), "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    local model = GetHashKey("hei_prop_heist_weed_block_01")
    RequestModel(model)
    while not HasModelLoaded(model) do Citizen.Wait(0) end
    local object = CreateObject(model, pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(object, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
    CarryPackage = object
end

local carpick1 = {
    [1] = "felon",
    [2] = "kuruma",
    [3] = "sultan",
    [4] = "granger",
    [5] = "tailgater",
}

function spawnOxyCar()

	if DoesEntityExist(oxyVehicle) then

	    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
		SetEntityAsNoLongerNeeded(oxyVehicle)
		DeleteEntity(oxyVehicle)
	end

    local car = GetHashKey(carpick1[math.random(#carpick1)])
    RequestModel(car)
    while not HasModelLoaded(car) do
        Citizen.Wait(0)
    end

    TriggerEvent("phone:addnotification", "Carl Jhonson","<b>Carl Jhonson</b> <br>Go to Vagos barrio</br> You have to find a car with drugs in it <br>then lockpick it </br> But don't get caught!!</br><b> Bring it to the spot and sell all their drugs</b> <br></br>")

    started = true

    boxes = 5
    boxesped = 5

    oxyVehicle = CreateVehicle(car, 274.11, -2061.54, 16.58, 78.31, true, false)
	local plt = GetVehicleNumberPlateText(oxyVehicle)
	DecorSetInt(oxyVehicle,"GamemodeCar",955)
	SetVehicleHasBeenOwnedByPlayer(oxyVehicle,true)

    --GetRandomAI()

    while true do
    	Citizen.Wait(1)
    	 --DrawText3Ds(-1563.49, -430.56, 37.87, "Oxy Delivery Car!")
    	 if #(GetEntityCoords(PlayerPedId()) - vector3(274.11, -2061.54, 16.58)) < 8.0 then
    	 	return
    	 end
    end

end



newwaypoint = nil


RegisterNetEvent("oxyrunesx:startOxyRun")
AddEventHandler("oxyrunesx:startOxyRun", function()
    spawnOxyCar()
    gotoOxy()
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