local curJobPlates = {}
local vehicles = {}

-- RegisterServerEvent('garages:addJobPlate')
-- AddEventHandler('garages:addJobPlate', function(plate)
-- 	local src = source
-- 	if not src then
-- 		return
-- 	end
	
-- 	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
-- 	local character = user:getCurrentCharacter()
-- 	local job = user:getVar("job") or "Unemployed"
-- 	local msg = "10-74 (Negative) Name: " .. character.first_name .. " " .. character.last_name .. " Phone #: " .. character.phone_number .. " Job: " .. job
-- 	curJobPlates[plate] = msg
-- end)

RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(vehicleMods,plate)
	local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	if not user then return end
	local char = user:getCurrentCharacter()
	if not char then return end
	local owner = user:getVar("hexid")
	if not owner then return end
	vehicleMods = json.encode(vehicleMods)
	exports.ghmattimysql:execute("UPDATE characters_cars SET data=@mods WHERE license_plate = @plate",{['mods'] = vehicleMods, ['plate'] = plate})
end)



RegisterServerEvent('garages:CheckGarageForVeh')
AddEventHandler("garages:CheckGarageForVeh", function(garage)
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local owner = char.id
    exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND current_garage = @garage', { ['@cid'] = owner, ['@garage'] = garage }, function(vehicles)
		for i = 1, #vehicles do
            TriggerClientEvent('srp-context:sendMenu', src, {
                {
                    id = vehicles[i].id,
                    header = vehicles[i].model,
                    txt = "Plate: "..vehicles[i].license_plate,
                    params = {
                        event = "garages:menu:selected",
						args = {
							id = vehicles[i].id,
							engine_damage = vehicles[i].engine_damage,
							current_garage = vehicles[i].current_garage,
							body_damage = vehicles[i].body_damage
						}
                    }
                },
            })
        end

    end)
end)


RegisterNetEvent("garages:loaded:in", function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local owner = char.id

    exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid', { ['@cid'] = owner}, function(vehicles)
		TriggerClientEvent('phone:Garage', src, vehicles)
    end)
end)

RegisterNetEvent('garages:menu:selected:sv', function(data)
	local src = source
	local enginePercent = data.engine_damage / 10
	local bodyPercent = data.body_damage / 10
	TriggerClientEvent('srp-context:sendMenu', src, {
		{
			id = 1,
			header = "< Go Back",
			txt = "",
			params = {
				event = "ListeVehicule"
			}
		},
	---	{
	---		id = 2,
	---		header = "Take Out Vehicle",
	---		txt = "",
	---		params = {
	---			event = "SortirVehicule",
	---			args = {
	---				pVeh = data.id
	---			}
	---		}
			
	---	},
		{
			id = 2,
			header = "Vehicle Status",
			txt = data.current_garage.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
		},
		{
            id = 3,
            header = "Close Menu",
			txt = "Close",
			params = {
                event = "",
            }
        },
	})
	TriggerClientEvent("garages:ShowVehicle", src, data.id)
end)


RegisterServerEvent('garages:SetVehIn')
AddEventHandler("garages:SetVehIn",function(plate, garage, fuel)
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	local owner = char.id
	local state = "In"
	exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, fuel = @fuel, coords = @coords WHERE license_plate = @plate", {['garage'] = garage, ['state'] = state, ['plate'] = plate,  ['fuel'] = fuel, ['coords'] = nil})
end)

RegisterServerEvent('garages:SetVehOut')
AddEventHandler('garages:SetVehOut', function(plate)
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state WHERE license_plate = @plate", {['state'] = "Out", ['plate'] = plate})
end)


RegisterServerEvent('garages:CheckForVeh')
AddEventHandler('garages:CheckForVeh', function()
	local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND vehicle_state = @state', {['@cid'] = char.id, ['@state'] = "Out", ['@vehicle'] = vehicle}, function(result)
		if result[1] ~= nil then
			TriggerClientEvent('garages:StoreVehicle', src, result[1].license_plate)
		else
			TriggerClientEvent('DoLongHudText', src, 'You dont own this car', 2)
		end
		
	end)
end)


RegisterServerEvent('garages:CheckForSpawnVeh')
AddEventHandler('garages:CheckForSpawnVeh', function(veh_id, pView, pSpecial)
	local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	local owner = char.id
	local veh_id = veh_id
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE id = @id AND cid = @cid AND repoed = @repoed', {['@id'] = veh_id, ['@cid'] = char.id, ['@repoed'] = "0"}, function(result)
		if result[1] then
			local res = result[1]
			if pView then
				TriggerClientEvent('garages:SpawnVehicle', src, res.current_garage, res.model, res.license_plate, res.vehicle_state, res.fuel, true, result[1].data)
			elseif pSpecial then
				TriggerClientEvent('garages:SpawnVehicle:repo', src, res.current_garage, res.model, res.license_plate, res.vehicle_state, res.fuel, false, result[1].data)
			else
				if res.current_garage == "Impound Lot" then
					if (user:getCash() >= 100) then
						TriggerClientEvent('garages:SpawnVehicle', src, res.current_garage, res.model, res.license_plate, res.vehicle_state, res.fuel, false, result[1].data)
					else
						TriggerClientEvent("garges:force:clear", src)
						TriggerClientEvent("DoLongHudText", src, "You need $100 to retrieve your vehicle from the " ..res.current_garage, 2)
					end
				else
					TriggerClientEvent('garages:SpawnVehicle', src, res.current_garage, res.model, res.license_plate, res.vehicle_state, res.fuel, false, result[1].data)
				end
			end
		else
			TriggerClientEvent("DoLongHudText", src, "This vehicle has been repossed!", 2)
		end
	end)
end)


RegisterServerEvent('ImpoundLot')
AddEventHandler('ImpoundLot', function()
	local pSrc = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(pSrc)
	if (user:getCash() >= 100) then
		user:removeMoney(100)
	end
end)

RegisterServerEvent('srp-imp:ImpoundCar')
AddEventHandler('srp-imp:ImpoundCar', function(plate)
	exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, coords = @coords WHERE license_plate = @plate", {['garage'] = 'Impound Lot', ['state'] = 'Normal Impound', ['plate'] = plate})
	Citizen.Wait(500)
	TriggerEvent("garages:reset:player:function", plate)
end)


RegisterServerEvent("garages:reset:player:function", function(plate)
	exports.ghmattimysql:execute('SELECT `cid` FROM characters_cars WHERE license_plate = ?', {plate}, function(pOwner)
		if pOwner[1] then
			TriggerClientEvent('gargages:update:functions', -1, pOwner[1].cid)
		end
	end)
end)


function ResetGaragesServer()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE repoed = ?', {"0"}, function(vehicles)
		for k, v in ipairs(vehicles) do
			if v.vehicle_state == "Out" then
				exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state,coords = @coords WHERE license_plate = @plate", {['state'] = 'In', ['coords'] = nil, ['plate'] = v.license_plate})
			end
		end
	end)
end


Citizen.CreateThread(function()
    ResetGaragesServer();
end)