local garages = {
	[1] = { loc = {484.77066040039,-77.643089294434,77.600166320801}, spawn = {469.40374755859,-65.764274597168,76.935157775879, 242.99423217773}, garage = "A"},
	[2] = { loc = {399.51190185547,-1346.2742919922,31.121940612793}, spawn = {404.08923339844,-1340.2329101563,31.123672485352, 242.99423217773}, garage = "B"},
	[3] = { loc = {82.359413146973,6418.9575195313,31.479639053345}, spawn = {68.428749084473,6394.8129882813,31.233980178833, 242.99423217773}, garage = "C"},
	[4] = { loc = {-606.86322021484,-2236.7624511719,6.0779848098755}, spawn = {-617.38104248047,-2228.3828125,6.0075860023499, 242.99423217773}, garage = "D"},
	[5] = { loc = {364.27685546875,297.84490966797,103.49515533447}, spawn = {370.07534790039,291.43197631836,103.33471679688, 75.475654602051}, garage = "E"},
	[6] = { loc = {-338.31619262695,266.79782104492,85.741966247559}, spawn = {-334.42706298828,278.54644775391,85.945793151855, 355.02752685547}, garage = "F"},
	[7] = { loc = {273.66683959961,-343.83737182617,44.919876098633}, spawn = {272.68188476563,-334.81295776367,44.919876098633, 153.98747253418}, garage = "G"},
	[8] = { loc = {66.215492248535,13.700443267822,69.047248840332}, spawn = {61.096534729004,24.754076004028,69.682136535645, 251.04234313965}, garage = "H"},
	[9] = { loc = {211.79,-808.38,30.833}, spawn = {212.04,-800.325,30.89, 340.09066772461}, garage = "I"},
	[10] = { loc = {-153.09889221191, -1172.3297119141, 23.753244400024}, spawn = {-152.37683105469, -1170.2377929688, 23.061153411865, 84.584053039551}, garage = "Impound Lot"},
	[11] = { loc = {570.81,2729.85,42.07}, spawn = {570.81,2729.85,42.07, 265.97918701172}, garage = 'Harmony Garage'},
	[12] = { loc = {-1287.1, 293.02, 64.82}, spawn = {-1287.1, 293.02, 64.82, 226.61531066895}, garage = 'Richman Garage'},
	[13] = { loc = {-1579.01,-889.11,9.38}, spawn = {-1579.01,-889.11,9.38, 41.792236328125}, garage = 'Pier Garage'},
	[14] = { loc = {-308.38,-986.68,31.08}, spawn = {-308.38,-986.68,31.08, 334.86672973633}, garage = '24/7 Garage'},
	[15] =  { loc = {986.28, -208.47, 70.46}, spawn = {986.28, -208.47, 70.46, 332.49954223633}, garage = 'Run Down Hotel' },
	[16] =  { loc = {847.36, -3219.15, 5.97}, spawn = {847.36, -3219.15, 5.97, 267.53204345703}, garage = 'Docks' },
	[17] = { loc = {-25.56, -1426.93, 30.66}, spawn = {-25.04, -1434.47, 30.65, 183.64}, garage = 'CGF'},--cgf
	[18] = { loc = {339.36, -2043.96, 21.28}, spawn = {339.36, -2043.96, 21.28, 50.71}, garage = 'ESV'},-- vagos
	[19] = { loc = {115.55, -1949.68, 20.69}, spawn = {111.03, -1945.11, 20.78, 43.19}, garage = 'ESB'}, --ballas
	[20] = { loc = {1399.31, 1118.17, 114.84}, spawn = {1390.89, 1118.43, 114.82, 78.29}, garage = 'HTBL'},--htbl
	[21] = { loc = {-679.19, -884.62, 24.49}, spawn = {-685.31, -892.54, 24.5, 268.16}, garage = 'WST'},--triads
	--Del Perro
	[22] =  { loc = {-1486.4266357422, -509.69250488281, 32.860633850098 }, spawn = {-1486.4266357422, -509.69250488281, 32.860633850098 }, garage = 'Perro Parking'},
	[23] =  { loc = {1519.3479003906, 3764.5424804688, 34.037261962891 }, spawn = {1511.3322753906, 3761.8723144531, 34.007591247559 }, garage = 'Sandy Shores'},
    -- MRPD
	[24] =  { loc = {445.26556396484, -986.23608398438, 25.699857711792 }, spawn = {445.95315551758, -986.17218017578, 25.510808944702, 270.70385742188}, garage = 'Police Department'},

}
local markerColor = 
{
	["Red"] = 222,
	["Green"] = 50,
	["Blue"] = 50
}

_showedCar = nil
local showGarages = false
local blips = {
	{469.40374755859,-65.764274597168,76.935157775879,"A"},
	{399.51190185547,-1346.2742919922,31.121940612793,"B"},
	{82.359413146973,6418.9575195313,31.479639053345,"C"},
	{-606.86322021484,-2236.7624511719,6.0779848098755,"D"},
	{364.27685546875,297.84490966797,103.49515533447,"E"},
	{-338.31619262695,266.79782104492,85.741966247559,"F"},
	{273.66683959961,-343.83737182617,44.919876098633,"G"},
	{66.215492248535,13.700443267822,69.047248840332,"H"},
	{211.79,-808.38,30.833,"I"},
	{-153.09889221191, -1172.3297119141, 23.753244400024,"Impound Lot"},
	{570.81,2729.85,42.07,'Harmony Garage'},
	{ -1287.1, 293.02, 64.82, ' Richman Garage' },
	{ -1579.01,-889.11,9.38, ' Pier Garage' },
	{ -308.38,-986.68,31.08, '24/7 Garage' },
	{ 986.28, -208.47, 70.46, 'Run Down Hotel' },
	{847.36, -3219.15, 5.97, 'Docks' },
	{-1486.4266357422, -509.69250488281, 32.860633850098 , 'Perro Parking' },
	{1519.3479003906, 3764.5424804688, 34.037261962891, 'Sandy Shores' },
	{445.265625, -986.24188232422, 25.511480331421, 'Police Department' },
	

}


RegisterNetEvent('Garages:ToggleGarageBlip')
AddEventHandler('Garages:ToggleGarageBlip', function()
    showGarages = not showGarages
    local what = 1
   for _, item in pairs(blips) do
        if not showGarages then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 357)


	
			if what == 10 then
				AddTextComponentString('Impound Lot')
				SetBlipColour(item.blip, 5)
			else
				SetBlipColour(item.blip, 3)
				AddTextComponentString('Garage ' .. item[4])
			end
			what = what + 1



			SetBlipScale(item.blip, 0.5)
			SetBlipAsShortRange(item.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Garage " .. item[4])
			EndTextCommandSetBlipName(item.blip)
        end
    end
end)

Citizen.CreateThread(function()
	showGarages = false
	TriggerEvent('Garages:ToggleGarageBlip')
end)

local garage = {title = "garage", currentpos = nil, marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }}
local selectedGarage = false


RegisterNetEvent("garages:store:cl", function()
	TriggerServerEvent('garages:CheckForVeh')
end)


carCount = 0
firstCar = 0



function doCarDamages(eh, bh, Fuel, veh)
	smash = false
	damageOutside = false
	damageOutside2 = false 
	local engine = eh + 0.0
	local body = bh + 0.0
	if engine < 200.0 then
		engine = 200.0
	end

	if body < 150.0 then
		body = 150.0
	end
	if body < 950.0 then
		smash = true
	end

	if body < 920.0 then
		damageOutside = true
	end

	if body < 920.0 then
		damageOutside2 = true
	end

	local currentVehicle = (veh and IsEntityAVehicle(veh)) and veh or GetVehiclePedIsIn(PlayerPedId(), false)

	Citizen.Wait(100)
	SetVehicleEngineHealth(currentVehicle, engine)
	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end
	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end
	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end
	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.0)
	end
	DecorSetInt(currentVehicle, "CurrentFuel", Fuel)


end

RegisterNetEvent("ListeVehicule", function()
	if DoesEntityExist(_showedCar) then
		SetEntityAsMissionEntity(_showedCar, true, true)
		DeleteVehicle(_showedCar)
		DeleteEntity(_showedCar)
		_showedCar = nil
	end
	TriggerServerEvent("garages:CheckGarageForVeh", current_used_garage)
end)

RegisterNetEvent("garages:menu:selected", function(data)
	TriggerServerEvent('garages:menu:selected:sv', data)
end)

local addedGarages = {}
RegisterNetEvent("SortirVehicule", function(data)
	local vehID = data.pVeh
	if firstCar == 0 then carCount = 0 end
	local impound = false
	local dist = #(vector3(550.09,-55.45,71.08) - GetEntityCoords(LocalPed()))

	if dist < 15.0 then
		impound = true
	end
	local garagecount = 1
	for i = 1, #garages do
		if current_used_garage == garages[i] then
			garagecount = i
		end
	end
	local garagefree = false

	if addedGarages[current_used_garage] ~= nil then
		garagefree = true
	end
	for i = 1, #garages do
		if garages[i].garage == "House" then
			garagefree = true
		end
	end

	TriggerServerEvent('garages:CheckForSpawnVeh', vehID, false)
	firstCar = 1
end)

function LocalPed()
	return PlayerPedId()
end

RegisterNetEvent("garages:ShowVehicle", function(vehID)
	TriggerServerEvent('garages:CheckForSpawnVeh', vehID, true)
end)

RegisterNetEvent("garages:retreive:repo", function(vehID)
	TriggerServerEvent('garages:CheckForSpawnVeh', vehID, false, true)
end)


RegisterNetEvent("car:dopayment")
AddEventHandler("car:dopayment", function(plate)
	local rankCarshop = exports["isPed"]:GroupRank("car_shop")
    local rankImport = exports["isPed"]:GroupRank("illegal_carshop")
    local salesman = false
	if rankCarshop > 0 or rankImport > 0 then
		salesman = true
	end
	TriggerServerEvent('car:dopayment', plate, salesman)
end)

RegisterNetEvent("car:carpaymentsowed")
AddEventHandler("car:carpaymentsowed", function()
    TriggerServerEvent("car:Outstanding")
end)

current_used_garage = "Any"

Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {18,"Enter"},["generalUseThird"] = {47,"G"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
	Controlkey["generalUseThird"] = table["generalUseThird"]
end)

RegisterNetEvent('garges:force:clear', function()
	if DoesEntityExist(_showedCar) then
		SetEntityAsMissionEntity(_showedCar, true, true)
		DeleteVehicle(_showedCar)
		DeleteEntity(_showedCar)
		_showedCar = nil
	end
end)

RegisterNetEvent('garages:SpawnVehicle')
AddEventHandler('garages:SpawnVehicle', function(oof, vehicle, plate, state, Fuel, IsViewing, customized)
	local car = GetHashKey(vehicle)
	local customized = json.decode(customized)
	if DoesEntityExist(_showedCar) then
		SetEntityAsMissionEntity(_showedCar, true, true)
		DeleteVehicle(_showedCar)
		DeleteEntity(_showedCar)
		_showedCar = nil
	end
	
	Citizen.CreateThread(function()			
		Citizen.Wait(100)

		if coordlocation == nil then
			local loc = garages[selectedGarage].loc
			local caisseo = GetClosestVehicle(loc[1], loc[2], loc[3], 3.000, 0, 70)
			if DoesEntityExist(caisseo) then
				TriggerEvent("DoLongHudText", "The area is crowded",2)
				return
			end
		end
	if oof == garages[selectedGarage].garage then


		if state == "Out" and cwoordlocation == nil then
			TriggerEvent("DoLongHudText","Not in garage",2)
		else	

			if state == "Normal Impound" and not IsViewing then
				TriggerServerEvent('ImpoundLot')
				TriggerEvent("DoLongHudText","This vehicle cost you $100.",1)
			end

			if state == "Police Impound" then
				TriggerEvent("DoLongHudText","This vehicle cost you $1500.",1)
			end

			RequestModel(car)
			while not HasModelLoaded(car) do
			Citizen.Wait(0)
			end

			
			if coordlocation ~= nil then
				veh = CreateVehicle(car, coordlocation[1],coordlocation[2],coordlocation[3], 0.0, true, false)
			else
				local spawnPos = garages[selectedGarage].spawn
				veh = CreateVehicle(car, spawnPos[1], spawnPos[2], spawnPos[3], spawnPos[4], true, false)
			end


			_showedCar = veh
 							
			SetModelAsNoLongerNeeded(car)
			
			-- if Fuel <= tonumber(5) then
			-- 	exports['mrp-carhud']:setFuel(veh, 20)
			-- else
			-- 	DecorSetInt(veh, "CurrentFuel", Fuel)
			-- end
			
			DecorSetBool(veh, "PlayerVehicle", true)
			SetVehicleOnGroundProperly(veh)
			SetEntityInvincible(veh, false) 

			SetVehicleModKit(veh, 0)

			SetVehicleNumberPlateText(veh, plate)

			if customized ~= nil then
				
				SetVehicleWheelType(veh, customized.wheeltype)
				SetVehicleNumberPlateTextIndex(veh, 3)

				for i = 0, 16 do
					SetVehicleMod(veh, i, customized.mods[tostring(i)])
				end

				for i = 17, 22 do
					ToggleVehicleMod(veh, i, customized.mods[tostring(i)])
				end

				for i = 23, 24 do
					local isCustom = customized.mods[tostring(i)]
					if (isCustom == nil or isCustom == "-1" or isCustom == false or isCustom == 0) then
						isSet = false
					else
						isSet = true
					end
					SetVehicleMod(veh, i, customized.mods[tostring(i)], isCustom)
				end

				for i = 23, 48 do
					SetVehicleMod(veh, i, customized.mods[tostring(i)])
				end

				for i = 0, 3 do
					SetVehicleNeonLightEnabled(veh, i, customized.neon[tostring(i)])
				end

				if customized.extras ~= nil then
					for i = 1, 12 do
						local onoff = tonumber(customized.extras[i])
						if onoff == 1 then
							SetVehicleExtra(veh, i, 0)
						else
							SetVehicleExtra(veh, i, 1)
						end
					end
				end

				if customized.oldLiveries ~= nil and customized.oldLiveries ~= 24  then
					SetVehicleLivery(veh, customized.oldLiveries)
				end

				if customized.plateIndex ~= nil and customized.plateIndex ~= 4 then
					SetVehicleNumberPlateTextIndex(veh, customized.plateIndex)
				end

				-- Xenon Colors
				SetVehicleXenonLightsColour(veh, (customized.xenonColor or -1))
				SetVehicleColours(veh, customized.colors[1], customized.colors[2])
				SetVehicleExtraColours(veh, customized.extracolors[1], customized.extracolors[2])
				SetVehicleNeonLightsColour(veh, customized.lights[1], customized.lights[2], customized.lights[3])
				SetVehicleTyreSmokeColor(veh, customized.smokecolor[1], customized.smokecolor[2], customized.smokecolor[3])
				SetVehicleWindowTint(veh, customized.tint)
				SetVehicleInteriorColour(veh, customized.dashColour)
				SetVehicleDashboardColour(veh, customized.interColour)
			else

				SetVehicleColours(veh, 0, 0)
				SetVehicleExtraColours(veh, 0, 0)

			end


			TriggerEvent("keys:addNew",veh,plate)
			SetVehicleHasBeenOwnedByPlayer(veh,true)
			

			local id = NetworkGetNetworkIdFromEntity(veh)
			SetNetworkIdCanMigrate(id, true)
			

			if GetEntityModel(veh) == `rumpo4` then
				SetVehicleLivery(veh,0)
			end
			
			if GetEntityModel(veh) == `rumpo` then
				SetVehicleLivery(veh,0)
			end

			if GetEntityModel(veh) == `taxi` then

				SetVehicleExtra(veh, 8, 1)
				SetVehicleExtra(veh, 9, 1)
				SetVehicleExtra(veh, 6, 0)

			end




			if not IsViewing then
				_showedCar = nil
				
				SetPedIntoVehicle(PlayerPedId(), veh, - 1)
				TriggerServerEvent('garages:SetVehOut', plate)
				TriggerEvent("menu:update:vehicles")
				Citizen.Wait(500)
				TriggerServerEvent("garages:loaded:in")
			end

			TriggerServerEvent('veh.getVehicles', plate, veh)
				
		end

	else
		TriggerEvent('DoLongHudText', 'Vehicle not in garage', 2)
	end
	end)
end)



RegisterNetEvent('garages:SpawnVehicle:repo')
AddEventHandler('garages:SpawnVehicle:repo', function(oof, vehicle, plate, state, Fuel, IsViewing, customized)
	local car = GetHashKey(vehicle)
	local customized = json.decode(customized)
	if DoesEntityExist(_showedCar) then
		SetEntityAsMissionEntity(_showedCar, true, true)
		DeleteVehicle(_showedCar)
		DeleteEntity(_showedCar)
		_showedCar = nil
	end
	
	Citizen.CreateThread(function()			
		Citizen.Wait(100)

		if coordlocation == nil then
			local caisseo = GetClosestVehicle(-197.79016113281, -1174.8039550781, 23.044046401978, 3.000, 0, 70)
			if DoesEntityExist(caisseo) then
				TriggerEvent("DoLongHudText", "The area is crowded", 2)
				return
			end
		end
	

		RequestModel(car)
		while not HasModelLoaded(car) do
			Citizen.Wait(0)
		end

		
		veh = CreateVehicle(car, -197.79016113281, -1174.8039550781, 23.044046401978, 205.02247619629, true, false)


		_showedCar = veh
						 
		SetModelAsNoLongerNeeded(car)
		
		-- if Fuel <= tonumber(5) then
		-- 	exports['mrp-carhud']:setFuel(veh, 20)
		-- else
		-- 	DecorSetInt(veh, "CurrentFuel", Fuel)
		-- end
		
		DecorSetBool(veh, "PlayerVehicle", true)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh, false) 

		SetVehicleModKit(veh, 0)

		SetVehicleNumberPlateText(veh, plate)

		if customized ~= nil then
			
			SetVehicleWheelType(veh, customized.wheeltype)
			SetVehicleNumberPlateTextIndex(veh, 3)

			for i = 0, 16 do
				SetVehicleMod(veh, i, customized.mods[tostring(i)])
			end

			for i = 17, 22 do
				ToggleVehicleMod(veh, i, customized.mods[tostring(i)])
			end

			for i = 23, 24 do
				local isCustom = customized.mods[tostring(i)]
				if (isCustom == nil or isCustom == "-1" or isCustom == false or isCustom == 0) then
					isSet = false
				else
					isSet = true
				end
				SetVehicleMod(veh, i, customized.mods[tostring(i)], isCustom)
			end

			for i = 23, 48 do
				SetVehicleMod(veh, i, customized.mods[tostring(i)])
			end

			for i = 0, 3 do
				SetVehicleNeonLightEnabled(veh, i, customized.neon[tostring(i)])
			end

			if customized.extras ~= nil then
				for i = 1, 12 do
					local onoff = tonumber(customized.extras[i])
					if onoff == 1 then
						SetVehicleExtra(veh, i, 0)
					else
						SetVehicleExtra(veh, i, 1)
					end
				end
			end

			if customized.oldLiveries ~= nil and customized.oldLiveries ~= 24  then
				SetVehicleLivery(veh, customized.oldLiveries)
			end

			if customized.plateIndex ~= nil and customized.plateIndex ~= 4 then
				SetVehicleNumberPlateTextIndex(veh, customized.plateIndex)
			end

			-- Xenon Colors
			SetVehicleXenonLightsColour(veh, (customized.xenonColor or -1))
			SetVehicleColours(veh, customized.colors[1], customized.colors[2])
			SetVehicleExtraColours(veh, customized.extracolors[1], customized.extracolors[2])
			SetVehicleNeonLightsColour(veh, customized.lights[1], customized.lights[2], customized.lights[3])
			SetVehicleTyreSmokeColor(veh, customized.smokecolor[1], customized.smokecolor[2], customized.smokecolor[3])
			SetVehicleWindowTint(veh, customized.tint)
			SetVehicleInteriorColour(veh, customized.dashColour)
			SetVehicleDashboardColour(veh, customized.interColour)
		else

			SetVehicleColours(veh, 0, 0)
			SetVehicleExtraColours(veh, 0, 0)

		end


		TriggerEvent("keys:addNew",veh,plate)
		SetVehicleHasBeenOwnedByPlayer(veh,true)
		

		local id = NetworkGetNetworkIdFromEntity(veh)
		SetNetworkIdCanMigrate(id, true)
		

		if GetEntityModel(veh) == `rumpo4` then
			SetVehicleLivery(veh,0)
		end
		
		if GetEntityModel(veh) == `rumpo` then
			SetVehicleLivery(veh,0)
		end

		if GetEntityModel(veh) == `taxi` then

			SetVehicleExtra(veh, 8, 1)
			SetVehicleExtra(veh, 9, 1)
			SetVehicleExtra(veh, 6, 0)

		end




		if not IsViewing then
			_showedCar = nil
			
			SetPedIntoVehicle(PlayerPedId(), veh, - 1)
			TriggerServerEvent('garages:SetVehOut', plate)
			TriggerEvent("menu:update:vehicles")
			Citizen.Wait(500)
			TriggerServerEvent("garages:loaded:in")
		end

		TriggerServerEvent('veh.getVehicles', plate, veh)
				
	end)
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


Citizen.CreateThread(function()
	Citizen.Wait(1000)
	TriggerEvent("RecreateGarages")
end) 


RegisterNetEvent("RecreateGarages")
AddEventHandler("RecreateGarages", function()
	Citizen.Wait(5000)
	if not garagesRunning then
		garagesRunning = true
		for k,v in ipairs(garages) do
			Citizen.CreateThread(function()
				if v.disabled then return end
				local pos = v.loc
				local gar = v.garage
				while garagesRunning do
					Citizen.Wait(1)

					local dist = #(vector3(pos[1],pos[2],pos[3]) - GetEntityCoords(LocalPed()))
					if dist < 1.0 then
						dist = math.floor(200 - (dist * 10))
						if dist < 0 then dist = 0 end
						DrawMarker(20,pos[1],pos[2],pos[3],0,0,0,0,0,0,0.701,1.0001,0.3001, markerColor.Red,markerColor.Green, markerColor.Blue,dist,0,0,0,0)
					end

					if #(vector3(pos[1],pos[2],pos[3]) - GetEntityCoords(LocalPed())) < 3.0 and IsPedInAnyVehicle(LocalPed(), true) == false then
						current_used_garage = garages[k].garage
						selectedGarage = k
					end
					if dist > 200.0 then
						Citizen.Wait(2000)
					end
				end
			end)
		end
	end
end)


RegisterNetEvent('garages:open', function()
	Citizen.Wait(500)
	TriggerEvent("ListeVehicule")
end)


RegisterNetEvent('gargages:update:functions')
AddEventHandler('gargages:update:functions', function(cidsent)
  local cid = exports["isPed"]:isPed("cid")
  if tonumber(cid) == tonumber(cidsent) then
    TriggerEvent("menu:update:vehicles") -- Resets menu  - garage store / take-out
	TriggerServerEvent("garages:loaded:in") -- Updates Phone
  end
end)

RegisterNetEvent('garages:StoreVehicle')
AddEventHandler('garages:StoreVehicle', function()
	local pos = garages[selectedGarage].loc
	Citizen.CreateThread(function()		
		Citizen.Wait(3000)
		local caissei = GetClosestVehicle(pos[1], pos[2], pos[3], 3.000, 0, 70)
		current_used_garage = garages[selectedGarage].garage
		if not DoesEntityExist(caissei) then caissei = GetVehiclePedIsIn(PlayerPedId(), true) end

		if #(vector3(pos[1],pos[2],pos[3]) - GetEntityCoords(caissei)) > 5 then 
			TriggerEvent("DoLongHudText", "No vehicle",2)
			return
		end
	
		local platecaissei = GetVehicleNumberPlateText(caissei)
		local fuel = GetVehicleFuelLevel(caissei)
    	if current_used_garage == "House" then
    		local d1,d2 = GetModelDimensions(GetEntityModel(caissei))

    		if d2["y"] > 3.4 then
    			TriggerEvent("DoLongHudText","This vehicle is too big.",2)
    			return
    		end
		end
		
		TriggerServerEvent('veh.callDegredation', platecaissei)


		if DoesEntityExist(caissei) then
			NetworkRequestControlOfEntity(caissei)

			local timeout = 0

			while timeout < 1000 and not NetworkHasControlOfEntity(caissei) do
				Citizen.Wait(100)
				timeout = timeout + 100
			end

			SetEntityAsMissionEntity(caissei, true, true)
			DeleteVehicle(caissei)
			DeleteEntity(caissei)

			TriggerEvent('keys:remove', platecaissei)

			TriggerServerEvent('garages:SetVehIn', platecaissei, current_used_garage, fuel)
			TriggerEvent('menu:update:vehicles')
		else
			TriggerEvent("DoLongHudText","No Vehicle",2)
		end   
	end)
end)