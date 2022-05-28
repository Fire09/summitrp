local truckcoords
local inTruck
local missionBlip = nil
local binCoords = false
local AtGarbageSpot = false
local truckplate = false
local truckTaken = false
local jobCompleted = false
local doingGarbage = false
local maxruns = 0
local runs = 0
local arrived 
local jobBlip
local submitBlip


local submitCoords = vector3(-354.28,-1560.88,24.9)



local JobCoords = {
    {x = 114.83280181885, y = -1462.3127441406, z = 29.295083999634},
    {x = -6.0481648445129, y = -1566.2338867188, z = 29.209197998047},
    {x = -1.8858588933945, y = -1729.5538330078, z = 29.300233840942},
    {x = 159.09, y = -1816.69, z = 27.9},
    {x = 358.94696044922, y = -1805.0723876953, z = 28.966590881348},
    {x = 481.36560058594, y = -1274.8297119141, z = 29.64475440979},
    {x = 254.70010375977, y = -985.32482910156, z = 29.196590423584},
    {x = 240.08079528809, y = -826.91204833984, z = 30.018426895142},
    {x = 342.78308105469, y = -1036.4720458984, z = 29.194206237793},
    {x = 462.17517089844, y = -949.51434326172, z = 27.959424972534},
    {x = 317.53698730469, y = -737.95416259766, z = 29.278547286987},
    {x = 410.22503662109, y = -795.30517578125, z = 29.20943069458},
    {x = 398.36038208008, y = -716.35577392578, z = 29.282489776611},
    {x = 443.96984863281, y = -574.33978271484, z = 28.494501113892},
    {x = -1332.53, y = -1198.49, z = 4.62},
    {x = -45.443946838379, y = -191.32261657715, z = 52.161594390869},
    {x = -31.948055267334, y = -93.437454223633, z = 57.249073028564},
    {x = 283.10873413086, y = -164.81878662109, z = 60.060565948486},
    {x = 441.89678955078, y = 125.97653198242, z = 99.887702941895},
}

local Dumpsters = {
    "prop_dumpster_01a",
    "prop_dumpster_02a",
    "prop_dumpster_02b",
    "prop_dumpster_3a",
    "prop_dumpster_4a",
    "prop_dumpster_4b",
    "prop_skip_01a",
    "prop_skip_02a",
    "prop_skip_06a",
    "prop_skip_05a",
    "prop_skip_03",
    "prop_skip_10a"
}

Citizen.CreateThread(function()
    exports["srp-polyzone"]:AddBoxZone("garbage_start", vector3(-322.24060058594, -1545.8980712891, 31.019908905029), 2, 2, {
        name="garbage_start",
        heading=0,
    })
end)


RegisterNetEvent('srp-polyzone:enter')
AddEventHandler('srp-polyzone:enter', function(name)
    if name == "garbage_start" then
        AtGarbageSpot = true     
    end
end)

RegisterNetEvent('srp-polyzone:exit')
AddEventHandler('srp-polyzone:exit', function(name)
    if name == "garbage_start" then
        AtGarbageSpot = false     
    end
end)

RegisterNetEvent('srp-garbage:starting')
AddEventHandler('srp-garbage:starting', function()
if AtGarbageSpot then
    if not truckTaken then 
        truckTaken = true
        local random = math.random(1, #JobCoords)
        local coordVec = vector3(JobCoords[random].x, JobCoords[random].y, JobCoords[random].z)
        local engine = not GetIsVehicleEngineRunning(veh)
        local car = GetHashKey('trash')
            inTruck = false
            RequestModel(car)
            while not HasModelLoaded(car) do
                Citizen.Wait(0)
            end
            vehicle = CreateVehicle(car, -323.53, -1523.58, 27.00, 269.7, true, false)
            truckplate = GetVehicleNumberPlateText(vehicle)
            inTruck = true
            SetEntityAsMissionEntity(vehicle, true, true)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1) 
            TriggerEvent("keys:addNew", vehicle, truckplate)
            SetVehicleEngineOn(vehicle, engine, false, true)
            Citizen.Wait(1000)
            missionStart(coordVec,vehicle)
        else
            TriggerEvent('DoShortHudText', 'You already taken a truck for the job!', 2)
        end
    end
end)

RegisterNetEvent("garbagemenu")
AddEventHandler("garbagemenu", function()
	TriggerEvent('srp-context:sendMenu', {
		{
			id = "1",
			header = "Waste Management",
			txt = "",
		},
        {
			id = "2",
			header = "Start Garbage Job",
			txt = "",
			params = {
				event = "srp-garbage:starting",
			}
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


function submit()
    Citizen.CreateThread(function()
        local pressed = false
        local wait = 100
        while true do
            Citizen.Wait(wait)
            local playerPed = PlayerPedId()
            local plyCoords = GetEntityCoords(playerPed)
            local distance = GetDistanceBetweenCoords(plyCoords,submitCoords, true) 
            if distance < 20 then
                wait = 5
                if IsPedInAnyVehicle(playerPed) then
                    DrawMarker(2, submitCoords+vector3(0.0,0.0,2.0), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)
                    local truck = GetVehiclePedIsIn(playerPed, false)
                    local plate = GetVehicleNumberPlateText(truck)
                    if distance < 2.0 then
                       -- ShowHelpNotification("Press ~INPUT_CONTEXT~ to drop off trash", true, true, 5000)
                      -- TriggerEvent('srp-textui:ShowUI', 'show', ("[E] %s"):format("to drop off trash")) 
                        if IsControlJustReleased(1,46) and not pressed then
                            truckTaken = false
                            pressed = true
                            RemoveBlip(submitBlip)
                            if plate == truckplate then
                                jobCompleted = true
                                local finished = exports["srp-taskbar"]:taskBar(5000,"Dropping off trash")
                                if finished == 100 then
                                    TriggerServerEvent('srp-garbage:pay', jobCompleted)
                                    jobCompleted = false
                                    DeleteVehicle(truck)
                                    for i=1,200,1 do 
                                        if DoesEntityExist(truck) then
                                            DeleteVehicle(truck)
                                        else
                                            truckplate = false
                                            truckTaken = false
                                            return
                                        end
                                    end
                                    truckplate = false
                                    Citizen.Wait(1000)
                                    pressed = false    
                                end
                     
                            else
                                TriggerEvent("DoLongHudText", "This is not our vehicle", 2)
                                Citizen.Wait(1000)
                                pressed = false
                            end
                            Citizen.Wait(1000)
                            pressed = false
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end)
end

function missionStart(coordVec,xtruck)
    local vehicle = xtruck
    arrived = false
    missionBlip = AddBlipForCoord(coordVec)
    SetBlipRoute(missionBlip, true)
    SetBlipRouteColour(missionBlip, 25)
    SetBlipColour(missionBlip, 25)
    Citizen.CreateThread(function()
        local wait = 100
        while not arrived do
            Citizen.Wait(wait)
            local tempdist = GetDistanceBetweenCoords(coordVec, GetEntityCoords(PlayerPedId()),true)
            if  tempdist < 50 then
                wait = 5
                DrawMarker(20, coordVec + vector3(0.0,0.0,3.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                if tempdist < 2 then
                    arrived = true
                    maxruns  = math.random(6,10)
                    Citizen.Wait(1000)
                    SetBlipRoute(missionBlip, false)
                    RemoveBlip(missionBlip)
                    findtrashbins(coordVec,vehicle,0)
                end
            else
                wait = 100
            end
        end
    end)      
end

function findtrashbins(coordVec,xtruck,pickup)
    doingGarbage = true
    local location = coordVec
    local vehicle = xtruck
    local playerPed = PlayerPedId()
    local boneindex = GetPedBoneIndex(playerPed, 57005)
    runs = pickup

    if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
        RequestAnimDict("anim@heists@narcotics@trash")
    end
    while not HasAnimDictLoaded("anim@heists@narcotics@trash") do
        Citizen.Wait(0)
    end

    if runs < maxruns then
        angle = math.random()*math.pi*2;
        r = math.sqrt(math.random());
        x = coordVec.x + r * math.cos(angle) * 100;     
        y = coordVec.y + r * math.sin(angle) * 100;
        for i = 0, #Dumpsters, 1 do 
            local NewBin = GetClosestObjectOfType(x, y, coordVec.z, 100.0, GetHashKey(Dumpsters[i]), false)
            if NewBin ~= 0 then
                local dumpCoords = GetEntityCoords(NewBin)
                jobBlip = AddBlipForCoord(dumpCoords)
                SetBlipSprite(jobBlip, 420)
                SetBlipScale (jobBlip, 0.8)
                SetBlipColour(jobBlip, 25)
                while true do
                    Wait(5) 
                    local userDist = GetDistanceBetweenCoords(dumpCoords,GetEntityCoords(PlayerPedId()),true) 
                    if userDist < 20 then
                        DrawMarker(20, dumpCoords + vector3(0.0,0.0,2.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                        if userDist < 2 then
                           -- ShowHelpNotification("Press ~INPUT_CONTEXT~ to collect trash", true, true, 5000)
                           -- TriggerEvent('srp-textui:ShowUI', 'show', ("[E] %s"):format("to collect trash")) 
                            if IsControlJustReleased(1,46) then
                                local geeky = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true)
                                AttachEntityToEntity(geeky, playerPed, boneindex, 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true)
                                TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
                                RemoveBlip(jobBlip)
                                collectedtrash(geeky,vehicle,location,runs)
                                return
                            end
                        end
                    end
                end
                return
            end
        end
    else
        submit()
        doingGarbage = false
        TriggerEvent("DoLongHudText", "Job done! Return to WM")
        submitBlip = AddBlipForCoord(submitCoords)
        SetBlipColour(submitBlip, 25)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if havingGarbageJob then
            if not IsPedInAnyVehicle(PlayerPedId()) then
                if doingGarbage then
                    DisplayRadar(true)
                else
                    DisplayRadar(false)
                end
            end
        end
    end
end)

local trashCollected = false

function collectedtrash(geeky,vehicle,location,pickup)
    local wait = 100
    local trashbag = geeky
    local pressed = false
    while true do
        Wait(wait)
        local trunkcoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "platelight"))
        local tdistance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),trunkcoord)
        local runs = pickup
        if tdistance < 20 then
            wait = 5
            DrawMarker(20, trunkcoord + vector3(0.0,0.0,0.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if tdistance < 2 then
               -- ShowHelpNotification("Press ~INPUT_CONTEXT~ to throw trash", true, true, 5000)
              --  TriggerEvent('srp-textui:ShowUI', 'show', ("Throw trash bag in back of truck"):format("")) 
                if IsControlJustReleased(1, 46) and not pressed then
                    pressed = true
                    TriggerServerEvent('srp-garbage:reward', true)
                    trashCollected = false
                    ClearPedTasksImmediately(PlayerPedId())
                    TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
                    Citizen.Wait(100)
                    DeleteObject(trashbag)
                    Citizen.Wait(3000)
                    ClearPedTasksImmediately(PlayerPedId())
                    findtrashbins(location,vehicle,runs+1)
                    pressed = false
                    return
                end
            end
        end
    end
end


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

RegisterNetEvent('truck')
AddEventHandler('truck', function()
    Citizen.Wait(0)
    local closest = GetClosestVehicle(-321.61740112305, -1524.6469726562, 27.547359466553, 3.000, 0, 70)
    if DoesEntityExist(closest) then
        TriggerEvent("DoLongHudText", "The area is crowded, you have been refunded!",2)
        return
    end

    if lastPlate ~= nil then
        TriggerEvent("keys:remove",lastPlate)
    end
   

    local myPed = PlayerPedId()
    local player = PlayerId()
    local vehicle = `trash`
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end

  local plate = "GARBAGE ".. GetRandomIntInRange(1000, 9000)
    local spawned_car = CreateVehicle(vehicle, -321.61740112305, -1524.6469726562, 27.547359466553, -20.0, true, false)

    SetVehicleOnGroundProperly(spawned_car)
    SetVehicleNumberPlateText(spawned_car, plate)
    TriggerEvent("keys:addNew",spawned_car,plate)
    TriggerServerEvent('garages:addJobPlate', plate)
    SetPedIntoVehicle(myPed, spawned_car, - 1)
    lastPlate = plate
   
   
  Wait(250)
  TriggerEvent('car:engine')
end)