local name = "L"
local job = "J"
local callsign = "B"

Citizen.CreateThread(function()
	while true do
		if NetworkIsSessionStarted() then
			DecorRegister("EmergencyType", 3)
			DecorSetInt(PlayerPedId(), "EmergencyType", 0)
			return
		end
	end
end)

--[[
	Emergency Type Decor:
		1 = police
		2 = ems
]]
RegisterNetEvent('testssss')
AddEventHandler('testssss', function(names,jobs,callsigns)
	name = names
	job = jobs
	callsign = callsigns
end)
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(3000)
-- 		print(name,job,callsign)
-- 	end
-- end)
RegisterNetEvent("srp-jobmanager:playerBecameJob")
AddEventHandler("srp-jobmanager:playerBecameJob", function(job, name, notify)
	if job == "police" then
		TriggerServerEvent("e-blips:updateOfficer")
		Citizen.Wait(3999)
		DecorSetInt(PlayerPedId(), "EmergencyType", 1)
	elseif job == "ems" then
		TriggerServerEvent("e-blips:updateOfficer")
		Citizen.Wait(3999)
		DecorSetInt(PlayerPedId(), "EmergencyType", 2)
	else
		DecorSetInt(PlayerPedId(), "EmergencyType", 0)
	end
end)

-- RegisterNetEvent('e-blips:updateName')
-- AddEventHandler('e-blips:updateNAme', function(name,job,callsign)
-- 	name = name
-- 	job = job
-- 	callsign = callsign
-- end)



RegisterNetEvent("e-blips:updateAfterPedChange")
AddEventHandler("e-blips:updateAfterPedChange", function(job)
	if job == "police" then
		DecorSetInt(PlayerPedId(), "EmergencyType", 1)
	elseif job == "ems" then
		DecorSetInt(PlayerPedId(), "EmergencyType", 2)
	else
		DecorSetInt(PlayerPedId(), "EmergencyType", 0)
	end
end)

local function setDecor()
	local type = 0
	
	TriggerEvent("nowIsCop", function(_isCop)
		TriggerEvent("nowIsEMS", function(_isMedic)
			type = _isCop and 1 or 0
			type = (type == 0 and _isMedic) and 2 or type
			DecorSetInt(PlayerPedId(), "EmergencyType", type)
		end)
	end)
end


local lastLocations = {}

local SlowStacks = {}


function LastLocationBlip(ped,id) 
	local x,y,z = table.unpack(GetEntityCoords(ped))
  	local blip = AddBlipForCoord(x, y, z)
  	lastLocations[id] = blip

end

function StandardBlip(ped,id) 


	blip = AddBlipForEntity(ped)
	SetBlipAsShortRange(blip, true)
	SetBlipSprite(blip, 1)

	print("LSP",callsign,name)
	if DecorGetInt(ped, "EmergencyType") == 1 then
		SetBlipColour(blip, 3)
		ShowHeadingIndicatorOnBlip(blip, true)
		BeginTextCommandSetBlipName("STRING")
		local Officer = "["..callsign.."]"..name
		AddTextComponentString(Officer)
	end

	if DecorGetInt(ped, "EmergencyType") == 2 then
		SetBlipColour(blip, 23)
		ShowHeadingIndicatorOnBlip(blip, true)
		BeginTextCommandSetBlipName("STRING")	
		local Officer = "["..callsign.."]"..name	
		AddTextComponentString(Officer)
	end
	
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	local function createBlip(id)

		local ped = GetPlayerPed(id)
		local localped = PlayerPedId()
		local blip = GetBlipFromEntity(ped)
		
		if not DecorExistOn(ped, "EmergencyType") then return end
		if not DecorExistOn(localped, "EmergencyType") then return end

		local blipExist = DoesBlipExist(blip)

		if blipExist and DecorGetInt(ped, "EmergencyType") <= 0 then RemoveBlip(blip) return end
		if blipExist and DecorGetInt(localped, "EmergencyType") <= 0 then RemoveBlip(blip) return end

		if DecorGetInt(ped, "EmergencyType") <= 0 or DecorGetInt(localped, "EmergencyType") <= 0 then return end

		if blipExist then return end
		
		StandardBlip(ped,id) 

	end

	while true do

		Citizen.Wait(2000)

		if not DecorExistOn(PlayerPedId(), "EmergencyType") then setDecor() end -- Decors don't stick with players when their ped changes, currently only works with police.

		for id = 0, 256 do

			if NetworkIsPlayerActive(id) then

				createBlip(id)

			end

		end

	end

end)

function GetPlayers()
    local players = {}
    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            players[#players + 1] = i
        end
    end
    return players
end