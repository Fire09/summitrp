RegisterNetEvent('FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop:spawnVehicle')
local vehshop_blips = {}
local financedPlates = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local commissionbuy = 0
local insideVehShop = false
local rank = 0

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.2,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Rooster Cab", costs = 20000, description = {}, model = "taxirooster"},
				{name = "Flat Bed", costs = 4000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 4000, description = {}, model = "rumpo"},
				{name = "Tesla Model S", costs = 1500000, description = {}, model = "models"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 150, description = {}, model = "bmx"},
			}
		},		
	}
}

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 4000, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 4000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 4000, description = {}, model = "rumpo"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 150, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 2500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 2600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 2900, description = {}, model = "tribike3"},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
				{name = "S Class", description = ''},
				{name = "A Class", description = ''},
				{name = "B Class", description = ''},
				{name = "C Class", description = ''},
				{name = "D Class", description = ''},
				{name = "Misc", description = ''},
				{name = "Off-Road", description = ''},
				{name = "SUVs", description = ''},
				{name = "Patreon", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 7500, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 5000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 3400, description = {}, model = "rumpo"},
			}
		},
		["S Class"] = {
			title = "S Class",
			name = "S Class",
			buttons = {			
			---	{name = "Silvia S14", costs = 950000, description = {}, model = "s14boss"},
				{name = "Mercedes-AMG GT63", costs = 950000, description = {}, model = "gt63"}, ---146MPH
				{name = "Mercedes-Benz AMG", costs = 920000, description = {}, model = "gtrc"}, ---140MPH
				{name = "Maserati GranTurismo", costs = 980000, description = {}, model = "granlb"}, ---145MPH
				{name = "Dodge Challenger", costs = 900000, description = {}, model = "demon"}, ---140MPH
				{name = "DeLorean", costs = 1700000, description = {}, model = "deluxo6str"}, ---135MPH
				{name = "Aston Martin DB11", costs = 990000, description = {}, model = "db11"}, ---145MPH
				{name = "2021 BMW M4", costs = 940000, description = {}, model = "m4"}, ---145MPH
				{name = "Audi R8 V10", costs = 910000, description = {}, model = "r8v10"}, ---145MPH
	
			}
		},
		["A Class"] = {
			title = "A Class",
			name = "A Class",
			buttons = {
				{name = "Nissan Silvia S15", costs = 650000, description = {}, model = "s15rb"}, --145MPH
				{name = "Sentinel SG4", costs = 600000, description = {}, model = "sentinelsg4"}, --140MPH
				{name = "Subaru Impreza", costs = 555000, description = {}, model = "subwrx"}, --137MPH
				{name = "Mitsubishi Lancer Evolution", costs = 585000, description = {}, model = "evo9"}, --140MPH
				{name = "Toyota Supra", costs = 625000, description = {}, model = "tsgr20"}, --141MPH
				{name = "Ford Focus RS", costs = 605000, description = {}, model = "focusrs"}, --140MPH
				{name = "Mitsubishi Eclipse GSX", costs = 580000, description = {}, model = "eclipse"},
				{name = "Honda Integra", costs = 540000, description = {}, model = "dc5"},
				{name = "BMW E46", costs = 520000, description = {}, model = "e46"},
				{name = "Lexus RCF", costs = 620000, description = {}, model = "rcf"},
			}
		},
		["B Class"] = {
			title = "B Class",
			name = "B Class",
			buttons = {
				{name = "Maibatsu Revolution", costs = 1300000, description = {}, model = "revolution6str2"},

			}
		},
		["C Class"] = {
			title = "C Class",
			name = "C Class",
			buttons = {
				{name = "Sentinel", costs = 380000, description = {}, model = "sentinel6str"},
				{name = "Schwartzer", costs = 400000, description = {}, model = "schwarzer2"},
				{name = "Sultan", costs = 350000, description = {}, model = "sultanrsv8"},
				{name = "Stratum", costs = 400000, description = {}, model = "stratumc"},
				{name = "Tampa", costs = 548000, description = {}, model = "tampa4"},
				{name = "Tampa", costs = 575000, description = {}, model = "tampa5"},
				{name = "Yosemite", costs = 425000, description = {}, model = "yosemite6str"},
			}
		},
		["D Class"] = {
			title = "D Class",
			name = "D Class",
			buttons = {
				{name = "Jugular", costs = 75000, description = {}, model = "jugular"},
				{name = "Peyote", costs = 75000, description = {}, model = "peyote2"},
				{name = "Gauntlet 4", costs = 80000, description = {}, model = "gauntlet4"},
				{name = "Caracara", costs = 70000, description = {}, model = "caracara2"},
				{name = "Novak", costs = 100000, description = {}, model = "Novak"},
				{name = "Issi 7", costs = 100000, description = {}, model = "issi7"},
				{name = "Hellion", costs = 110000, description = {}, model = "hellion"},
				{name = "Dynasty", costs = 110000, description = {}, model = "Dynasty"},
				{name = "Gauntlet 3", costs = 100000, description = {}, model = "gauntlet3"},
  			    {name = "Nebula", costs = 83000, description = {}, model = "nebula"},
				{name = "Zion 3", costs = 75000, description = {}, model = "zion3"},
				{name = "Drafter", costs = 101000, description = {}, model = "drafter"},
				{name = "Komoda", costs = 100000, description = {}, model = "komoda"},
				{name = "Rebla", costs = 110000, description = {}, model = "rebla"},
				{name = "Retinue", costs = 80000, description = {}, model = "retinue2"},
				{name = "Sugoi", costs = 100000, description = {}, model = "sugoi"},
				{name = "Sultan 2", costs = 80000, description = {}, model = "sultan2"},
				{name = "VSTR", costs = 186000, description = {}, model = "vstr"},



			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "Bifta", costs = 110000, description = {}, model = "bifta"},
				{name = "Blazer", costs = 117000, description = {}, model = "blazer"},
				{name = "Brawler", costs = 110000, description = {}, model = "brawler"},
				{name = "Dune Buggy", costs = 110000, description = {}, model = "dune"},
				{name = "Rebel", costs = 115000, description = {}, model = "rebel2"},
				{name = "Sandking", costs = 116000, description = {}, model = "sandking"},
				{name = "Kamacho", costs = 110000, description = {}, model = "kamacho"},
				{name = "Dubsta 6x6", costs = 115000, description = {}, model = "dubsta3"},
				{name = "Lifted Mesa", costs = 110000, description = {}, model = "mesa3"},
				{name = "Lego Car", costs = 90000, description = {}, model = "kalahari"},
				{name = "Street Blazer", costs = 95000, description = {}, model = "blazer4"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Cavalcade", costs = 120000, description = {}, model = "cavalcade2"},
				{name = "Granger", costs = 113000, description = {}, model = "granger"},
				{name = "Huntley S", costs = 115000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 117000, description = {}, model = "landstalker"},
				{name = "Radius", costs = 85000, description = {}, model = "radi"},
				{name = "Rocoto", costs = 94000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 100500, description = {}, model = "seminole"},
				{name = "XLS", costs = 110000, description = {}, model = "xls"},
				{name = "Dubsta", costs = 82000, description = {}, model = "dubsta"},
				{name = "Patriot", costs = 96500, description = {}, model = "patriot"},
				{name = "Gresley", costs = 92500, description = {}, model = "gresley"},
			}
		},
		["Misc"] = {
			title = "Misc",
			name = "Misc",
			buttons = {
				{name = "Emperor", costs = 40000, description = {}, model = "emperor2"},
				{name = "Tornado", costs = 40000, description = {}, model = "tornado3"},
				{name = "Bodhi", costs = 50000, description = {}, model = "bodhi2"},		
				{name = "Asea", costs = 65000, description = {}, model = "asea"},
				{name = "Asterope", costs = 100000, description = {}, model = "asterope"},
				{name = "Fugitive", costs = 90000, description = {}, model = "fugitive"},
				{name = "Glendale", costs = 90500, description = {}, model = "glendale"},
				{name = "Intruder", costs = 95000, description = {}, model = "intruder"},
				{name = "Premier", costs = 90000, description = {}, model = "premier"},
				{name = "Regina", costs = 42000, description = {}, model = "regina"},
				{name = "Schafter", costs = 125000, description = {}, model = "schafter2"},
				{name = "Stanier", costs = 100000, description = {}, model = "stanier"},
				{name = "Stratum", costs =112600, description = {}, model = "stratum"},
				{name = "Super Diamond", costs = 110000, description = {}, model = "superd"},
				{name = "Warrener", costs = 115000, description = {}, model = "warrener"},
				{name = "Washington", costs = 98000, description = {}, model = "washington"},
				{name = "Tailgater", costs = 96500, description = {}, model = "tailgater"},
				{name = "Cognoscenti", costs = 90000, description = {}, model = "cognoscenti"},
				{name = "Ford Mustang", costs = 320000, description = {}, model = "66fastback"},
				{name = "Blade", costs = 220000, description = {}, model = "blade"},
				{name = "Buccaneer", costs = 120000, description = {}, model = "buccaneer"},
				{name = "Chino", costs = 220000, description = {}, model = "chino"},
				{name = "Coquette BlackFin", costs = 215000, description = {}, model = "coquette3"},
				{name = "Dominator", costs = 125000, description = {}, model = "dominator"},
				{name = "Dukes", costs = 135000, description = {}, model = "dukes"},
				{name = "Gauntlet", costs = 155000, description = {}, model = "gauntlet"},
				{name = "Faction", costs = 120000, description = {}, model = "faction"},
				{name = "Picador", costs = 100000, description = {}, model = "picador"},
				{name = "Sabre Turbo", costs = 140000, description = {}, model = "sabregt"},
				{name = "Tampa", costs = 155000, description = {}, model = "tampa"},
				{name = "Virgo", costs = 120000, description = {}, model = "virgo"},
				{name = "Vigero", costs = 130000, description = {}, model = "vigero"},
				{name = "Elliie", costs = 195000, description = {}, model = "ellie"},
				{name = "Phoenix", costs = 125000, description = {}, model = "phoenix"},
				{name = "Slam Van", costs = 130000, description = {}, model = "slamvan"},
				{name = "Yosemite", costs = 135000, description = {}, model = "yosemite"},
				{name = "Tulip", costs = 146000, description = {}, model = "tulip"},
				{name = "Vamos", costs = 126000, description = {}, model = "vamos"},
				{name = "Faction 2", costs = 120000, description = {}, model = "faction2"},
				{name = "Faction 3", costs = 140000, description = {}, model = "faction3"},
				{name = "Nightshade", costs = 145000, description = {}, model = "nightshade"},
				{name = "Phoenix", costs = 135000, description = {}, model = "Phoenix"},
				{name = "Ruiner", costs = 130000, description = {}, model = "ruiner"},
				{name = "Dominator GTX", costs = 150000, description = {}, model = "dominator3"},
				{name = "Vamos", costs = 145000, description = {}, model = "vamos"},
				{name = "Bison", costs = 55500, description = {}, model = "bison"},
				{name = "Bobcat XL", costs = 51500, description = {}, model = "bobcatxl"},
				{name = "Gang Burrito", costs = 55000, description = {}, model = "gburrito"},
				{name = "Journey", costs = 55000, description = {}, model = "journey"},
				{name = "Minivan", costs = 55500, description = {}, model = "minivan"},
				{name = "Paradise", costs = 53765, description = {}, model = "paradise"},
				{name = "Surfer", costs = 53000, description = {}, model = "surfer"},
				{name = "Youga", costs = 54000, description = {}, model = "youga"},
				{name = "Moonbeam", costs = 52500, description = {}, model = "moonbeam"},
				{name = "Camper", costs = 53500, description = {}, model = "camper"},
			}
		},
		["motorcycles"] = {
			title = "MOTORCYCLES",
			name = "motorcycles",
			buttons = {		
				{name = "Akuma", costs = 36500, description = {}, model = "AKUMA"},
				{name = "Bagger", costs = 27000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 26500, description = {}, model = "bati"},
				{name = "BF400", costs = 27500, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 27500, description = {}, model = "carbonrs"},
				{name = "Daemon", costs = 22650, description = {}, model = "daemon"},
				{name = "Enduro", costs = 28950, description = {}, model = "enduro"},
				{name = "Faggio", costs = 20500, description = {}, model = "faggio"},
				{name = "Gargoyle", costs = 21500, description = {}, model = "gargoyle"},
				{name = "Hexer", costs = 20500, description = {}, model = "hexer"},
				{name = "Innovation", costs = 20000, description = {}, model = "innovation"},
				{name = "Nemesis", costs = 25000, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 21500, description = {}, model = "pcj"},
				{name = "Ruffian", costs = 22950, description = {}, model = "ruffian"},
				{name = "Sanchez", costs = 22650, description = {}, model = "sanchez"},
				{name = "Sovereign", costs = 22500, description = {}, model = "sovereign"},
				{name = "Zombiea", costs = 22659, description = {}, model = "zombiea"},
				{name = "Vespa", costs = 22300, description = {}, model = "faggio2"},
				{name = "Manchez", costs = 26560, description = {}, model = "manchez"},
			}
		},

		["Patreon"] = {
			title = "Patreon",
			name = "Patreon",
			buttons = { 
				{name = "Apollo Arrow", costs = 200000, description = {}, model = "apolloarrow"},
				{name = "AMG 2020", costs = 200000, description = {}, model = "mbbs20"},
			}
		},


		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 1550, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 1240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 1270, description = {}, model = "fixter"},
				{name = "unicycle", costs = 1100, description = {}, model = "unicycle"},
				{name = "Pro 1", costs = 1600, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 1600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 1600, description = {}, model = "tribike3"},
			}
		},
	}
}



local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-33.737,-1102.322,26.422},
		inside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
		outside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
	}
}

local carspawns = {
	[1] =  { ['x'] = -41.91,['y'] = -1101.82,['z'] = 27.3,['h'] = 354.17, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = -37.26,['y'] = -1093.28,['z'] = 27.3,['h'] = 126.97, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = -47.58,['y'] = -1092.06,['z'] = 27.3,['h'] = 215.98, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = -54.44,['y'] = -1097.62,['z'] = 27.3,['h'] = 353.36, ['info'] = ' Car Spot 4' },
	[5] =  { ['x'] = -49.86,['y'] = -1083.52,['z'] = 27.33,['h'] = 187.9, ['info'] = ' Car Spot 5' },
}

local carTable = {
	[1] = { ["model"] = "audirs6tk", ["baseprice"] = 160000, ["commission"] = 15 }, 
	[2] = { ["model"] = "510", ["baseprice"] = 710000, ["commission"] = 15 },
	[3] = { ["model"] = "sultan2s", ["baseprice"] = 185000, ["commission"] = 15 },
	[4] = { ["model"] = "m4", ["baseprice"] = 420000, ["commission"] = 15 },
	[5] = { ["model"] = "gauntlet6str", ["baseprice"] = 770000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	carTable[currentCarSpawnLocation]["model"] = model
	carTable[currentCarSpawnLocation]["baseprice"] = price
	carTable[currentCarSpawnLocation]["name"] = name
	TriggerServerEvent("carshop:table",carTable)
end



local myspawnedvehs = {}

RegisterCommand('testdrive', function()
	TriggerEvent('car:testdrive')
end)

RegisterNetEvent("car:testdrive")
AddEventHandler("car:testdrive", function()
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end	

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end
	
	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-51.51, -1077.96, 26.92, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,-51.51, -1077.96, 26.92,80.0,true,false)
		local vehplate = "CAR"..math.random(10000,99999) 
		SetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		local plt = GetVehicleNumberPlateText(veh)
		print('plate ', plt)
		TriggerEvent("keys:addNew",veh, plt)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		myspawnedvehs[veh] = true
	else

		TriggerEvent("DoLongHudText","A car is on the spawn point.",2)

	end

end)

RegisterCommand('finance', function()
TriggerEvent('finance')
end)
	

RegisterNetEvent("finance")
AddEventHandler("finance", function()
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end	
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)	
	TriggerServerEvent("finance:enable",vehplate)
end)

RegisterNetEvent("finance:enableOnClient")
AddEventHandler("finance:enableOnClient", function(addplate)
	financedPlates[addplate] = true
	Citizen.Wait(60000)
	financedPlates[addplate] = nil
end)	

RegisterCommand('commission', function(source, args, raw)
	if rank == 0 then
		return
	end
	if rank > 0 then
		local amount = args[1]
		if amount ~= nil then
			TriggerEvent('commission', amount)
		else
			TriggerEvent('DoLongHudText', 'Invalid amount "/commision [amount]', 1)
		end
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)


RegisterNetEvent("commission")
AddEventHandler("commission", function(newAmount)
	if rank == 0 or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("carshop:table",carTable)

		end
	end
end)

RegisterNetEvent("veh_shop:returnTable")
AddEventHandler("veh_shop:returnTable", function(newTable)

	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()

end)

local hasspawned = false

local spawnedvehicles = {}
local vehicles_spawned = false
function BuyMenu()
	for i = 1, #carspawns do

		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) then
				TriggerEvent("DoLongHudText","Attempting Purchase")
				AttemptBuy(i,false)
			end

			if IsControlJustReleased(0,23) or IsDisabledControlJustReleased(0,23) then
				local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
				local addplate = GetVehicleNumberPlateText(veh)
				if financedPlates[addplate] ~= nil then
					TriggerEvent("DoLongHudText","Attempting Purchase")
					AttemptBuy(i,true)
				end
			end
		end
	end
end

function AttemptBuy(tableid,financed)

	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		TriggerEvent("DoLongHudText","Could not locate vehicle",2)
		return
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local name = carTable[tableid]["name"]
	local price = baseprice + (baseprice * commission/100)

	-- if baseprice > 10000 and not financed then
	-- 	TriggerEvent("DoLongHudText","This vehicle must be financed.",2)
	-- 	return
	-- end
	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerServerEvent('CheckMoneyForVeh',name, model, price, financed)
	commissionbuy = (baseprice * commission/200)

end



function OwnerMenu()

	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
				TriggerEvent("DoLongHudText","We Opened")
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end

end

function DrawPrices()
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if rank > 0 then
				if financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy | [F] to Finance ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy. ")
				end
			else
				if financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " [G] to buy | $" .. math.ceil(price/4) .. " upfront, $" .. math.ceil(price) .. " over 10 weeks, [F] to finance. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " [G] to buy. ")
				end			
			end
		end
	end
end
function DrawText3D(x,y,z, text)
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
function SpawnSaleVehicles()
	if not hasspawned then
		TriggerServerEvent("carshop:requesttable")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles(true)
	hasspawned = true
	for i = 1, #carTable do
		local model = GetHashKey(carTable[i]["model"])
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]-1,carspawns[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)

		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		SetVehicleNumberPlateText(veh, i .. "CARSALE")
	end
	vehicles_spawned = true
end

function DespawnSaleVehicles(pDontWait)
	if pDontWait == nil and not pDontWait then
		Wait(15000)
	end
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
end




Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {18,"Enter"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
end)

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 3)
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false

				if #(vector3(-45.98,-1082.97, 26.27) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(-45.98,-1082.97, 26.27,"["..Controlkey["generalUse"][2].."] return vehicle")
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if insideVehShop then
						currentlocation = b
						if not vehicles_spawned then
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 25 then
							DrawPrices()
						end

						DrawMarker(27,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]-0.9,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,50,0,0,0,0)
						
						if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) <= 1 then

							DisplayHelpText('~g~'..Controlkey["generalUse"][2]..'~s~ to browse')
							
							inrange = true
						end

						if vehshop.opened == true then
							DisplayHelpText('~g~'..Controlkey["generalUse"][2]..'~s~ or ~g~'..Controlkey["generalUseSecondary"][2]..'~s~ Accepts ~g~Arrows~s~ Move ~g~Backspace~s~ Exit')
						end

						if rank > 0 then
							OwnerMenu()
						end

						BuyMenu()
						

					else
						if vehicles_spawned then
							DespawnSaleVehicles()
						end
						Citizen.Wait(1000)
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	
	if ownerMenu then
		vehshop = vehshopOwner	
	else
		vehshop = vehshopDefault
	end


	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])




	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end
local endingCreator = false
function CloseCreator(name, veh, price, financed)
	Citizen.CreateThread(function()
		if not endingCreator then
			endingCreator = true
			local ped = LocalPed()
			if not boughtcar then
				local pos = currentlocation.pos.entering
				SetEntityCoords(ped,pos[1],pos[2],pos[3])
				FreezeEntityPosition(ped,false)
				SetEntityVisible(ped,true)
			else			
				local name = name	
				local vehicle = veh
				local price = price		
				local veh = GetVehiclePedIsUsing(ped)
				local model = GetEntityModel(veh)
				local colors = table.pack(GetVehicleColours(veh))
				local extra_colors = table.pack(GetVehicleExtraColours(veh))

				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
				local pos = currentlocation.pos.outside

				FreezeEntityPosition(ped,false)
				RequestModel(model)
				while not HasModelLoaded(model) do
					Citizen.Wait(0)
				end
				personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
				SetModelAsNoLongerNeeded(model)

				if name == "rumpo" then
					SetVehicleLivery(personalvehicle,0)
				end

				if name == "taxi" then
					SetVehicleExtra(personalvehicle, 8, 0)
					SetVehicleExtra(personalvehicle, 9, 0)
					SetVehicleExtra(personalvehicle, 5, 1)
				end



				for i,mod in pairs(mods) do
					SetVehicleModKit(personalvehicle,0)
					SetVehicleMod(personalvehicle,i,mod)
				end

				SetVehicleOnGroundProperly(personalvehicle)

				local plate = GetVehicleNumberPlateText(personalvehicle)
				SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
				local id = NetworkGetNetworkIdFromEntity(personalvehicle)
				SetNetworkIdCanMigrate(id, true)
				Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
				SetVehicleColours(personalvehicle,colors[1],colors[2])
				SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
				TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
				TriggerEvent("keys:addNew", model, plate)
				local vehname = GetDisplayNameFromVehicleModel(model)
				print(vehname)
				SetEntityVisible(ped,true)			
				local primarycolor = colors[1]
				local secondarycolor = colors[2]	
				local pearlescentcolor = extra_colors[1]
				local wheelcolor = extra_colors[2]
				TriggerServerEvent('BuyForVeh', plate, vehname, vehicle, price, financed)
				DespawnSaleVehicles()
				SpawnSaleVehicles()

			end
			vehshop.opened = false
			vehshop.menu.from = 1
			vehshop.menu.to = 10
			endingCreator = false
		end
	end)
end


RegisterNetEvent("carshop:failedpurchase")
AddEventHandler("carshop:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)
RegisterNetEvent("veh_shop:setPlate")
AddEventHandler("veh_shop:setPlate", function(vehicle, plate)

	print('setting plate ', plate)

	SetVehicleNumberPlateText(vehicle, plate)
	Citizen.Wait(1000)
	TriggerEvent("keys:addNew", vehicle, plate)

	TriggerServerEvent('garages:SetVehOut', vehicle, plate)
	TriggerServerEvent('veh.getVehicles', plate, vehicle)
	TriggerServerEvent("garages:CheckGarageForVeh")

	local plt = GetVehicleNumberPlateText(vehicle)
	TriggerServerEvent("request:illegal:upgrades",plate)

end)




function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,51,122,181,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(250,250,250, 255)
	else
		SetTextColour(0, 0, 0, 255)
		
	end
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,51,122,181,250)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255, 255, 255,250) 
	end
	

end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end



function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Cycles" then
			OpenMenu('cycles')
		end
	elseif this == "vehicles" then
		if btn == "B Class" then
			OpenMenu('B Class')
		elseif btn == "Misc" then
			OpenMenu('Misc')
		elseif btn == "Job Vehicles" then
			OpenMenu('jobvehicles')
		elseif btn == "S Class" then
			OpenMenu('S Class')
		elseif btn == "A Class" then
			OpenMenu('A Class')
		elseif btn == "C Class" then
			OpenMenu("C Class")
		elseif btn == "D Class" then
			OpenMenu('D Class')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Patreon" then
			OpenMenu('Patreon')
		end

	elseif this == "jobvehicles" or this == "S Class" or this == "A Class" or this == "Misc" or this == "B Class" or this == "C Class"  or this == "D Class" or this == "offroad" or this == "suvs" or this == "Patreon" or this == "cycles" or this == "motorcycles" then

		if ownerMenu then

			updateCarTable(button.model,button.costs,button.name)

		else

			TriggerServerEvent('CheckMoneyForVeh',button.name, button.model, button.costs)

		end
		
	end

end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "S Class" or vehshop.currentmenu == "A Class" or vehshop.currentmenu == "Misc" or vehshop.currentmenu == "B Class" or vehshop.currentmenu == "C Class" or vehshop.currentmenu == "D Class" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "Patreon" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

function resetscaleform(topspeed,handling,braking,accel,resetscaleform,i)
    scaleform = RequestScaleformMovie(resetscaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

	topspeedc = topspeed / 20
	handlingc = handling / 20
	brakingc = braking / 20
	accelc = accel / 20

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString("LOADING")
    PushScaleformMovieFunctionParameterString("Brand New Vehicle")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Handling")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Downforce")


	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
    PushScaleformMovieFunctionParameterInt( (20 * i)-1 )

	PopScaleformMovieFunctionVoid()

end


--[[Citizen]]--
function Initialize(scaleform,veh,vehname)

    scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString(vehname)
    PushScaleformMovieFunctionParameterString("Brand New Vehicle")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Handling")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Downforce")

	local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 4)
    local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
    local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
    local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 

    if topspeed > 100 then
    	topspeed = 100
    end
    if handling > 100 then
    	handling = 100
    end
    if braking > 100 then
    	braking = 100
    end
    if accel > 100 then
    	accel = 100
    end
    Citizen.Trace(topspeed)
    Citizen.Trace(handling)
    Citizen.Trace(braking)
    Citizen.Trace(accel)

    PushScaleformMovieFunctionParameterInt( topspeed )
    PushScaleformMovieFunctionParameterInt( handling )
    PushScaleformMovieFunctionParameterInt( braking )
    PushScaleformMovieFunctionParameterInt( accel )
    PopScaleformMovieFunctionVoid()

    return scaleform
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1]) ) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				local br = button.rank ~= nil and button.rank or 0
				if rank >= br and i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then

						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)

					end
					y = y + 0.04
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "S Class" or vehshop.currentmenu == "A Class" or vehshop.currentmenu == "Misc" or vehshop.currentmenu == "B Class" or vehshop.currentmenu == "C Class" or vehshop.currentmenu == "D Class" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)


								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

	


								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}

									local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								    local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								    local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								    local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end


								-- not sure why it doesnt refresh itself, but blocks need to be set to their maximum 20 40 60 80 100 before a new number is pushed.
								for i = 1, 5 do
								 	scaleform = resetscaleform(topspeed,handling,braking,accel,"mp_car_stats_01",i)
							        x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
							        Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x-1,y+1.8,z+7.0, 0.0, 180.0, 90.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0)
								end

								scaleform = Initialize("mp_car_stats_01",fakecar.car,fakecar.model)
							end
						end
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					 x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
		        	Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
		       		x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
		       		Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
		    end

		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)

AddEventHandler('FinishMoneyCheckForVeh', function(name, vehicle, price,financed)	
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price, financed)
	TriggerEvent("fistpump")
	local plt = GetVehicleNumberPlateText(vehicle)
	print('plate ', plt)
	TriggerEvent("keys:addNew",vehicle, plt)
	TriggerServerEvent("server:GroupPayment","car_shop",commissionbuy)
end)

ShowVehshopBlips(true)
AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
	--326 car blip 227 225
	ShowVehshopBlips(true)
	firstspawn = 1
end
end)

AddEventHandler('vehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		local plate = GetVehicleNumberPlateText(veh)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
		TriggerEvent('veh_shop:setPlate', veh, plate)
	end
end)

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)

local vehshopLoc = PolyZone:Create({
	vector2(-17.224317550659, -1125.9611816406),
	vector2(-70.010810852051, -1128.2976074219),
	vector2(-76.185691833496, -1127.8470458984),
	vector2(-79.25121307373, -1123.7583007813),
	vector2(-79.670585632324, -1118.4036865234),
	vector2(-59.549613952637, -1063.388671875),
	vector2(-1.2465063333511, -1081.7679443359)
}, {
    name = "veh_shop",
    minZ = 0,
    maxZ = 40.5,
    debugGrid = false,
    gridDivisions = 25
})

local HeadBone = 0x796e;
Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetPedBoneCoords(plyPed, HeadBone)
        local inPoly = vehshopLoc:isPointInside(coord)
        -- if true, then player just entered zone
        if inPoly and not insideVehShop then
            insideVehShop = true
        elseif not inPoly and insideVehShop then
            insideVehShop = false
        end
        Citizen.Wait(500)
    end
end)

local isExportReady = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if insideVehShop and isExportReady then
            rank = exports["isPed"]:GroupRank("car_shop")
            Citizen.Wait(10000)
        end
    end
end)

--PD VEHICLES

---NPOLVIC
RegisterNetEvent("police:buynpolvic")
AddEventHandler("police:buynpolvic", function()
	if exports["isPed"]:isPed("myJob") == 'police' then
		TriggerServerEvent('police:buynpolvic_sv')
	else
		TriggerEvent('DoLongHudText', 'You are not a Police officer!', 2)
	end
end)
----npolvette
RegisterNetEvent("police:buynpolstang")
AddEventHandler("police:buynpolstang", function()
	if exports["isPed"]:isPed("myJob") == 'police' then
		TriggerServerEvent('police:buynpolstang_sv')
	else
		TriggerEvent('DoLongHudText', 'You are not a Police officer!', 2)
	end
end)
----mustang
RegisterNetEvent("police:buynpolvette")
AddEventHandler("police:buynpolvette", function()
	if exports["isPed"]:isPed("myJob") == 'police' then
		TriggerServerEvent('police:buynpolvette_sv')
	else
		TriggerEvent('DoLongHudText', 'You are not a Police officer!', 2)
	end
end)
----mustang
RegisterNetEvent("police:buypoltaurus")
AddEventHandler("police:buypoltaurus", function()
	if exports["isPed"]:isPed("myJob") == 'police' then
		TriggerServerEvent('police:buypoltaurus_sv')
	else
		TriggerEvent('DoLongHudText', 'You are not a Police officer!', 2)
	end
end)
----npolchal
RegisterNetEvent("police:buynpolchal")
AddEventHandler("police:buynpolchal", function()
	if exports["isPed"]:isPed("myJob") == 'police' then
		TriggerServerEvent('police:buynpolchal_sv')
	else
		TriggerEvent('DoLongHudText', 'You are not a Police officer!', 2)
	end
end)
----NPOLVIC
RegisterNetEvent("police:npolvicbuy2")
AddEventHandler("police:npolvicbuy2", function()
	local vehicle = veh
	local price = price		
	local veh = GetVehiclePedIsUsing(ped)
	local colors = table.pack(GetVehicleColours(veh))
	local extra_colors = table.pack(GetVehicleExtraColours(veh))

	local mods = {}
	for i = 0,24 do
		mods[i] = GetVehicleMod(veh,i)
	end
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))

	FreezeEntityPosition(ped,false)
	RequestModel('npolvic')
	while not HasModelLoaded('npolvic') do
		Citizen.Wait(0)
	end
	personalvehicle = CreateVehicle('npolvic',450.96432495117, -975.97631835938, 25.510437011719, 89.37914276123,true,false)
	SetModelAsNoLongerNeeded('npolvic')

	SetVehicleOnGroundProperly(personalvehicle)

	local plate = GetVehicleNumberPlateText(personalvehicle)
	SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
	local id = NetworkGetNetworkIdFromEntity(personalvehicle)
	SetNetworkIdCanMigrate(id, true)
	Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
	TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
	SetEntityVisible(ped,true)			
	local VehicleProps = exports['srp-base']:FetchVehProps(personalvehicle)
	local name = 'polvic'
	TriggerEvent("keys:addNew",personalvehicle, plate)
	TriggerServerEvent('npolvicbuy', plate, name, VehicleProps)
end)
----npolvette
RegisterNetEvent("police:npolvettebuy2")
AddEventHandler("police:npolvettebuy2", function()
	local vehicle = veh
	local price = price		
	local veh = GetVehiclePedIsUsing(ped)
	local colors = table.pack(GetVehicleColours(veh))
	local extra_colors = table.pack(GetVehicleExtraColours(veh))

	local mods = {}
	for i = 0,24 do
		mods[i] = GetVehicleMod(veh,i)
	end
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))

	FreezeEntityPosition(ped,false)
	RequestModel('npolvette')
	while not HasModelLoaded('npolvette') do
		Citizen.Wait(0)
	end
	personalvehicle = CreateVehicle('npolvette',450.96432495117, -975.97631835938, 25.510437011719, 89.37914276123,true,false)
	SetModelAsNoLongerNeeded('npolvette')

	SetVehicleOnGroundProperly(personalvehicle)

	local plate = GetVehicleNumberPlateText(personalvehicle)
	SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
	local id = NetworkGetNetworkIdFromEntity(personalvehicle)
	SetNetworkIdCanMigrate(id, true)
	Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
	TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
	SetEntityVisible(ped,true)			
	local VehicleProps = exports['srp-base']:FetchVehProps(personalvehicle)
	local name = 'npolvette'
	TriggerEvent("keys:addNew",personalvehicle, plate)
	TriggerServerEvent('npolvettebuy', plate, name, VehicleProps)
end)
----mustangg
RegisterNetEvent("police:npolstangbuy2")
AddEventHandler("police:npolstangbuy2", function()
	local vehicle = veh
	local price = price		
	local veh = GetVehiclePedIsUsing(ped)
	local colors = table.pack(GetVehicleColours(veh))
	local extra_colors = table.pack(GetVehicleExtraColours(veh))

	local mods = {}
	for i = 0,24 do
		mods[i] = GetVehicleMod(veh,i)
	end
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))

	FreezeEntityPosition(ped,false)
	RequestModel('npolstang')
	while not HasModelLoaded('npolstang') do
		Citizen.Wait(0)
	end
	personalvehicle = CreateVehicle('npolstang',450.96432495117, -975.97631835938, 25.510437011719, 89.37914276123,true,false)
	SetModelAsNoLongerNeeded('npolstang')

	SetVehicleOnGroundProperly(personalvehicle)

	local plate = GetVehicleNumberPlateText(personalvehicle)
	SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
	local id = NetworkGetNetworkIdFromEntity(personalvehicle)
	SetNetworkIdCanMigrate(id, true)
	Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
	TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
	SetEntityVisible(ped,true)			
	local VehicleProps = exports['srp-base']:FetchVehProps(personalvehicle)
	local name = 'npolstang'
	TriggerEvent("keys:addNew",personalvehicle, plate)
	TriggerServerEvent('npolstangbuy', plate, name, VehicleProps)
end)
---- poltaurus
RegisterNetEvent("police:poltaurusbuy2")
AddEventHandler("police:poltaurusbuy2", function()
	local vehicle = veh
	local price = price		
	local veh = GetVehiclePedIsUsing(ped)
	local colors = table.pack(GetVehicleColours(veh))
	local extra_colors = table.pack(GetVehicleExtraColours(veh))

	local mods = {}
	for i = 0,24 do
		mods[i] = GetVehicleMod(veh,i)
	end
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))

	FreezeEntityPosition(ped,false)
	RequestModel('poltaurus')
	while not HasModelLoaded('poltaurus') do
		Citizen.Wait(0)
	end
	personalvehicle = CreateVehicle('poltaurus',450.96432495117, -975.97631835938, 25.510437011719, 89.37914276123,true,false)
	SetModelAsNoLongerNeeded('poltaurus')

	SetVehicleOnGroundProperly(personalvehicle)

	local plate = GetVehicleNumberPlateText(personalvehicle)
	SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
	local id = NetworkGetNetworkIdFromEntity(personalvehicle)
	SetNetworkIdCanMigrate(id, true)
	Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
	TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
	SetEntityVisible(ped,true)			
	local VehicleProps = exports['srp-base']:FetchVehProps(personalvehicle)
	local name = 'poltaurus'
	TriggerEvent("keys:addNew",personalvehicle, plate)
	TriggerServerEvent('poltaurusbuy', plate, name, VehicleProps)
end)
---- npolchal
RegisterNetEvent("police:npolchalbuy2")
AddEventHandler("police:npolchalbuy2", function()
	local vehicle = veh
	local price = price		
	local veh = GetVehiclePedIsUsing(ped)
	local colors = table.pack(GetVehicleColours(veh))
	local extra_colors = table.pack(GetVehicleExtraColours(veh))

	local mods = {}
	for i = 0,24 do
		mods[i] = GetVehicleMod(veh,i)
	end
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))

	FreezeEntityPosition(ped,false)
	RequestModel('npolchal')
	while not HasModelLoaded('npolchal') do
		Citizen.Wait(0)
	end
	personalvehicle = CreateVehicle('npolchal',450.96432495117, -975.97631835938, 25.510437011719, 89.37914276123,true,false)
	SetModelAsNoLongerNeeded('npolchal')

	SetVehicleOnGroundProperly(personalvehicle)

	local plate = GetVehicleNumberPlateText(personalvehicle)
	SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
	local id = NetworkGetNetworkIdFromEntity(personalvehicle)
	SetNetworkIdCanMigrate(id, true)
	Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
	TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
	SetEntityVisible(ped,true)			
	local VehicleProps = exports['srp-base']:FetchVehProps(personalvehicle)
	local name = 'npolchal'
	TriggerEvent("keys:addNew",personalvehicle, plate)
	TriggerServerEvent('npolchalbuy', plate, name, VehicleProps)
end)
AddEventHandler("srp-base:exportsReady", function()
	Wait(1)
	isExportReady = true
end)

