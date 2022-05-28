-- cells
local inmate = 0

relogging = false
cellcoords = { 
	[1] =  { ['x'] = 1768.6706542969,['y'] = 2487.1000976562,['z'] = 45.597957611084,['h'] = 120, ['info'] = ' cell1' },
	[2] =  { ['x'] = 1766.2528076172,['y'] = 2490.6826171875,['z'] = 45.599788665771,['h'] = 120, ['info'] = ' cell2' },
	[3] =  { ['x'] = 1764.5369873047,['y'] = 2494.4250488281,['z'] = 45.602108001709,['h'] = 120, ['info'] = ' cell3' },
	[4] =  { ['x'] = 1762.5778808594,['y'] = 2498.1137695312,['z'] = 45.604259490967,['h'] = 120, ['info'] = ' cell4' },
	[5] =  { ['x'] = 1760.1296386719,['y'] = 2501.8461914062,['z'] = 45.606285095215,['h'] = 120, ['info'] = ' cell5' },
	[6] =  { ['x'] = 1759.7081298828,['y'] = 2501.1169433594,['z'] = 49.606163024902,['h'] = 120, ['info'] = ' cell6' },
	[7] =  { ['x'] = 1762.5393066406,['y'] = 2498.173828125,['z'] = 49.605278015137,['h'] = 120, ['info'] = ' cell7' },
	[8] =  { ['x'] = 1764.2510986328,['y'] = 2494.3842773438,['z'] = 49.605278015137,['h'] = 120, ['info'] = ' cell8' },
	[9] =  { ['x'] = 1765.6943359375,['y'] = 2490.4855957031,['z'] = 49.600463867188,['h'] = 120, ['info'] = ' cell9' },
	[10] =  { ['x'] = 1768.4675292969,['y'] = 2487.0739746094,['z'] = 49.601776123047,['h'] = 120, ['info'] = ' cell10' },
	[11] =  { ['x'] = 1750.2908935547,['y'] = 2477.3952636719,['z'] = 45.580032348633,['h'] = 300, ['info'] = ' cell11' },
	[12] =  { ['x'] = 1746.6781005859,['y'] = 2484.6391601562,['z'] = 45.58434677124,['h'] = 300, ['info'] = ' cell12' },
	[13] =  { ['x'] = 1744.2591552734,['y'] = 2488.1989746094,['z'] = 45.586212158203,['h'] = 300, ['info'] = ' cell13' },
	[14] =  { ['x'] = 1749.1517333984,['y'] = 2481.5146484375,['z'] = 45.582874298096,['h'] = 300, ['info'] = ' cell14' },
	[15] =  { ['x'] = 1742.3236083984,['y'] = 2491.8884277344,['z'] = 49.588268280029,['h'] = 300, ['info'] = ' cell15' },
	[16] =  { ['x'] = 1742.1611328125,['y'] = 2491.7690429688,['z'] = 45.588062286377,['h'] = 300, ['info'] = ' cell16' },
	[17] =  { ['x'] = 1744.7935791016,['y'] = 2488.2468261719,['z'] = 49.592796325684,['h'] = 300, ['info'] = ' cell17' },
	[18] =  { ['x'] = 1748.4877929688,['y'] = 2480.97265625,['z'] = 49.588687896729,['h'] = 300, ['info'] = ' cell18' },
	[19] =  { ['x'] = 1750.4221191406,['y'] = 2477.3449707031,['z'] = 49.586643218994,['h'] = 300, ['info'] = ' cell19' },
	[20] =  { ['x'] = 1750.4221191406,['y'] = 2477.3449707031,['z'] = 49.586643218994,['h'] = 300, ['info'] = ' cell20' },
    --]]
    }

-- repair weld

repaircoords = {
    [1] = { ["x"] = 1753.8284912109, ["y"] = 2504.8176269531, ["z"] = 45.564975738525},
    [2] = { ["x"] = 1718.6436767578, ["y"] = 2502.1604003906, ["z"] = 45.564846038818},
    [3] = { ["x"] = 1631.4572753906, ["y"] = 2492.0971679688, ["z"] = 45.56485748291},
    [4] = { ["x"] = 1629.6904296875, ["y"] = 2526.970703125, ["z"] = 45.56485748291},
    [5] = { ["x"] = 1609.3913574219, ["y"] = 2566.1154785156, ["z"] = 45.56485748291},
    [6] = { ["x"] = 1628.7711181641, ["y"] = 2563.4670410156, ["z"] = 45.56485748291},
    [7] = { ["x"] = 1635.0708007813, ["y"] = 2556.4716796875, ["z"] = 45.56485748291},
    [8] = { ["x"] = 1651.6926269531, ["y"] = 2563.5822753906, ["z"] = 45.56485748291},
    [9] = { ["x"] = 1683.7580566406, ["y"] = 2554.1909179688, ["z"] = 45.564846038818},
    [10] = { ["x"] = 1718.64453125, ["y"] = 2528.6357421875, ["z"] = 45.564849853516},
    [11] = { ["x"] = 1686.2364501953, ["y"] = 2533.1533203125, ["z"] = 45.564861297607},
    [12] = { ["x"] = 1705.2362060547, ["y"] = 2482.1740722656, ["z"] = 45.564918518066}
}



eatenRecently = false
cleanedRecently = false
repairedRecently = false
local mycell = 1

cleancoords = {
-- dirty trays
    [1] =  { ['x'] = 1789.07,['y'] = 2550.47,['z'] = 45.68 },
    [2] =  { ['x'] = 1789.28,['y'] = 2545.07,['z'] = 45.68 },
    [3] =  { ['x'] = 1784.35,['y'] = 2545.45,['z'] = 45.68 },
    [4] =  { ['x'] = 1778.94,['y'] = 2545.58,['z'] = 45.68 },
    [5] =  { ['x'] = 1779.43,['y'] = 2548.09,['z'] = 45.68 },
    [6] =  { ['x'] = 1777.72,['y'] = 2554.5,['z'] = 45.68 },
    [7] =  { ['x'] = 1786.38,['y'] = 2565.15,['z'] = 45.68 },
    [8] =  { ['x'] = 1783.28,['y'] = 2564.0,['z'] = 45.68 },
    [9] =  { ['x'] = 1778.37,['y'] = 2565.08,['z'] = 45.68 },
    [10] =  { ['x'] = 1777.75,['y'] = 2560.08,['z'] = 45.68 },
    [11] =  { ['x'] = 1786.38,['y'] = 2560.39,['z'] = 45.68 },
}

foodTrays = {
    [1] = "prop_food_cb_tray_01",
    [2] = "prop_food_cb_tray_02",
    [3] = "prop_food_cb_tray_03",
    [4] = "prop_food_cb_tray_04",
    [5] = "prop_food_cb_tray_05",
    [6] = "prop_food_cb_tray_06",
    [7] = "prop_food_bs_tray_01",
    [8] = "prop_food_bs_tray_02",
    [9] = "prop_food_bs_tray_03",
    [10] = "prop_food_bs_tray_04",
    [11] = "prop_food_bs_tray_05",
    [12] = "prop_food_bs_tray_06",
    [13] = "prop_food_tray_01",
    [14] = "prop_food_tray_02",
    [15] = "prop_food_tray_03",
    [16] = "prop_food_tray_04",
    [17] = "prop_food_tray_05",
    [18] = "prop_food_tray_06"
}

eatTask = {
    ["x"] = 1783.91,
    ["y"] = 2545.77,
    ["z"] = 45.6
}

finishCleanTask = {
    ["x"] = 1782.98,
    ["y"] = 2560.88,
    ["z"] = 45.67
}

function deleteClosestTray()
--foodTrays

    local closestDist = 9999.9
    local ped = PlayerPedId()
    local closesttray
    local obj
    local curDist
    for i=1,#foodTrays do
        obj = GetClosestObjectOfType(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, 3.0, GetHashKey(foodTrays[i]), false, true ,true)
        curDist = #(GetEntityCoords(PlayerPedId(), 0) - GetEntityCoords(obj))
        if curDist < closestDist then
            closestDist = curDist
            closesttray = obj
        
        end
    end
    SetEntityVisible(closesttray, false)
 
end


imjailed = false
curTaskType = "None"
jobProcess = false
lockdown = false

secondOfDay = 19801
RegisterNetEvent('kTimeSync')
AddEventHandler("kTimeSync", function( data )
    secondOfDay = data
end)


RegisterNetEvent("jailbreak:reclaimitems")
AddEventHandler("jailbreak:reclaimitems", function()
    TriggerServerEvent("server-jail-item", 'ply-'..exports["isPed"]:isPed("cid"), false)
    TriggerEvent("DoLongHudText", "You have re-claimed your possessions.")
end)

Citizen.CreateThread(function()
    while true do
        playerCoords = GetEntityCoords(PlayerPedId())
        Citizen.Wait(1000)
    end
end)


function drink()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "mp_player_intdrink" ) 

    TaskPlayAnim( PlayerPedId(), "mp_player_intdrink", "loop_bottle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(5000)

    endanimation()
end

function endanimation()
    ClearPedSecondaryTask(PlayerPedId())
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



-- function DisplayHelpText(str)
--     SetTextComponentFormat("STRING")
--     AddTextComponentString(str)
--     DisplayHelpTextFromStringLabel(0, 0, 1, -1)
-- end

-- function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
--     SetTextFont(0)
--     SetTextProportional(0)
--     SetTextScale(scale, scale)
--     SetTextColour(r, g, b, a)
--     SetTextDropShadow(0, 0, 0, 0,255)
--     SetTextEdge(1, 0, 0, 0, 255)
--     SetTextDropShadow()
--     if(outline)then
--         SetTextOutline()
--     end
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(x - width/2, y - height/2 + 0.005)
-- end


Controlkey = {["generalUse"] = {38,"E"},["generalUseThird"] = {47,"G"} ,["housingMain"] = {74,"H"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
    Controlkey["generalUse"] = table["generalUse"]
    Controlkey["generalUseThird"] = table["generalUseThird"]
    Controlkey["housingMain"] = table["housingMain"]
end)

--------------------------------------
----- Below related To JailBreak -----
--------------------------------------
local jailbreak = false


local smokeTable = {}
local prisonerTable = {}
local copTable = {}

local smokeLocations = {
    {1709.9931640625,2691.6640625,45.572238922119},
    {1715.095703125,2688.6574707031,45.571224212646},
    {1703.8051757813,2689.1862792969,45.571407318115},
    {1721.8214111328,2685.5402832031,45.56489944458},
    {1697.8100585938,2683.208984375,45.564933776855},

    {1662.4675292969,2669.0375976563,45.564895629883},
    {1656.9019775391,2668.3435058594,45.564895629883},
    {1652.5489501953,2665.0114746094,45.564895629883},
    {1650.9392089844,2659.8876953125,45.564926147461},
    {1650.7983398438,2653.5249023438,45.564926147461},

    {1758.0987548828,2673.1220703125,45.564872741699},
    {1765.3293457031,2673.1318359375,45.564872741699},
    {1770.9254150391,2670.3132324219,45.564872741699},
    {1774.1247558594,2665.9516601563,45.564872741699},
    {1776.4498291016,2661.21875,45.564872741699},

    {1754.9405517578,2651.4887695313,45.564918518066},
    {1759.7680664063,2649.8244628906,45.584705352783},
    {1768.2872314453,2649.865234375,45.581718444824},
    {1718.4710693359,2649.6398925781,45.564933776855},
    {1714.5267333984,2625.9748535156,45.564888000488},
    {1708.4614257813,2624.4741210938,45.564888000488},

}

local SpawnLocations = {
    [1] = {["name"] = "prisoner", ["pos"] = {1776.3377685547,2666.0100097656,45.564937591553}},
    [2] = {["name"] = "prisoner", ["pos"] = {1772.5654296875,2675.6342773438,45.564918518066}},
    [3] = {["name"] = "prisoner", ["pos"] = {1762.251953125,2676.0573730469,45.564918518066}},
    [4] = {["name"] = "prisoner", ["pos"] = {1719.8916015625,2686.947265625,45.565704345703}},
    [5] = {["name"] = "prisoner", ["pos"] = {1711.4210205078,2693.9387207031,45.583290100098}},
    [6] = {["name"] = "prisoner", ["pos"] = {1701.1168212891,2687.2568359375,45.564990997314}},
    [7] = {["name"] = "prisoner", ["pos"] = {1663.0439453125,2671.5556640625,45.602420806885}},
    [8] = {["name"] = "prisoner", ["pos"] = {1652.5731201172,2667.578125,45.564937591553}},
    [9] = {["name"] = "prisoner", ["pos"] = {1651.0554199219,2656.02734375,45.564937591553}},

    [10] = {["name"] = "cop", ["pos"] = {1690.3841552734,2623.3342285156,45.564903259277}},
    [11] = {["name"] = "cop", ["pos"] = {1711.5394287109,2622.4599609375,45.564895629883}},
    [12] = {["name"] = "cop", ["pos"] = {1719.8424072266,2623.2243652344,45.564895629883}},
    [13] = {["name"] = "cop", ["pos"] = {1770.4345703125,2646.404296875,45.564914703369}},
    [14] = {["name"] = "cop", ["pos"] = {1753.9340820313,2649.5444335938,45.564918518066}},
}

local models = {
    ["prisoner"] = "S_M_Y_Prisoner_01",
    ["cop"] = "S_M_Y_Cop_01",
}


local missionState = {
    ["prisoner"] = "MISSION5",
    ["cop"] = "COP"
}

randomWeapon = {
[1] = "WEAPON_UNARMED",
[2] = "WEAPON_KNIFE",
[3] = "WEAPON_NIGHTSTICK",
[4] = "WEAPON_HAMMER",
[5] = "WEAPON_BAT",
[6] = "WEAPON_GOLFCLUB",
[7] = "WEAPON_CROWBAR",
[8] = "WEAPON_BOTTLE",
[9] = "WEAPON_DAGGER",
[10] = "WEAPON_KNUCKLE",
[11] = "WEAPON_HATCHET",
[12] = "WEAPON_MACHETE",
[13] = "WEAPON_SWITCHBLADE",
[14] = "WEAPON_REVOLVER",
[15] = "WEAPON_BATTLEAXE",
[16] = "WEAPON_POOLCUE",
[17] = "WEAPON_WRENCH"
}

randomWeaponCop = {
[1] = "WEAPON_PISTOL",
[2] = "WEAPON_COMBATPISTOL",
[3] = "WEAPON_APPISTOL",
[4] = "WEAPON_ASSAULTSMG",
[5] = "WEAPON_CARBINERIFLE",
[6] = "WEAPON_MG",
[7] = "WEAPON_PUMPSHOTGUN",
[8] = "WEAPON_ASSAULTSHOTGUN",
[9] = "WEAPON_STUNGUN",
[10] = "WEAPON_SNSPISTOL",
[11] = "WEAPON_SPECIALCARBINE",
[12] = "WEAPON_MARKSMANRIFLE"
}


RegisterNetEvent('ai:removePeds')
AddEventHandler('ai:removePeds', function(cops,prisoners)
   for i,v in ipairs(cops) do
        local ped = NetworkGetEntityFromNetworkId(v)

        DeletePed(ped)
   end
   for i,v in ipairs(prisoners) do
        local ped = NetworkGetEntityFromNetworkId(v)

        DeletePed(ped)
   end  
end)

RegisterNetEvent('ai:isJailBreak')
AddEventHandler('ai:isJailBreak', function()
    TriggerEvent("chatMessage", "DOC | Goverment | " , { 255, 0, 0 }, "There is currently a jailbreak at bolingbroke , stay clear of the area or you may end up arrested or shot.")
    imjailed = false
    jailbreak = true
    runEscape()
    Wait(140000)
    jailbreak = false
end)

function runEscape()
    Citizen.CreateThread(function()
      local timer = 0
      local teleported = false
      while jailbreak do 
        Wait(1)

          DrawMarkerRad(27,1643.5603027344,2585.4670410156,44.764853668213, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 255, 255, 0, 60, 0, 0, 2, 0, 0, 0, 0)
          DrawMarkerRad(27,1636.2059326172,2565.4235839844,44.76485748291, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 255, 255, 0, 60, 0, 0, 2, 0, 0, 0, 0)
          if #(vector3(1643.5603027344,2585.4670410156,45.564853668213) - GetEntityCoords(PlayerPedId())) < 1 then
            exports["srp-base"]:getModule("Util"):MissionText("Enter Court Yard", 500)
            if not teleported then
              teleported = true
              SetEntityCoords(PlayerPedId(),1636.2059326172,2565.4235839844,45.56485748291)
            end
          elseif #(vector3(1636.2059326172,2565.4235839844,45.56485748291) - GetEntityCoords(PlayerPedId())) < 1 then
            exports["srp-base"]:getModule("Util"):MissionText("Exit Court Yard", 500)
            if not teleported then
              teleported = true
              SetEntityCoords(PlayerPedId(),1643.5603027344,2585.4670410156,45.564853668213)
            end
          end


        if teleported then 
          timer = timer + 1 
          if timer > 900 then
            teleported = false
            timer = 0
          end
        end
      end
    end)
end

function DrawMarkerRad(markerType,x,y,z,arg1,arg2,arg3,arg4,arg5,arg6,sx,sy,sz,r,g,b,a,upDown,face,p19,rotate,texture,textureName,drawEnts)
    local dist = #(vector3(x,y,z) - GetEntityCoords(PlayerPedId()))
    if dist < 40 then
      local dist = math.floor(a - (dist * 10))
      if dist < 0 then dist = 0 end
      DrawMarker(markerType,x,y,z,arg1,arg2,arg3,arg4,arg5,arg6,sx,sy,sz,r,g,b,dist,upDown,face,p19,rotate,texture,textureName,drawEnts)
    end
end

RegisterNetEvent('ai:prisonBreak')
AddEventHandler('ai:prisonBreak', function()

    local rnd = math.random(1,99999)
    for i,v in ipairs(smokeLocations) do
        TriggerServerEvent("particle:StartParticleAtLocation",v[1],v[2],v[3],"smoke",rnd,0.0, 0.0, 0.0)
    end
    
    Wait(2000)
    spawnJailbreak("prisoner")
    TriggerServerEvent("ai:updatePrisoners",prisonerTable)
    spawnJailbreak("cop")
    TriggerServerEvent("ai:updateCops",copTable)
    TriggerEvent("particle:StopParticleClient",rnd)
end)
local hasMoved = false
RegisterNetEvent('jail:lockdown')
AddEventHandler('jail:lockdown', function(lockdownState)
    lockdown = lockdownState
    if lockdown and imjailed and not hasMoved then
        mycell = math.random(1,20)
        mycell = math.ceil(mycell)
        SetEntityCoords(PlayerPedId(), cellcoords[mycell].x,cellcoords[mycell].y,cellcoords[mycell].z) 
        TriggerEvent("chatMessage", "DOC | " , { 33, 118, 255 }, "You have been placed into lockdown due to a disturbance.")
        hasMoved = true
    elseif not lockdown and imjailed then
        hasMoved = false
        TriggerEvent("chatMessage", "DOC | " , { 33, 118, 255 }, "Lockdown has ended.")
    end
end)



function spawnJailbreak(spawnType)
    for i,v in pairs(SpawnLocations) do

        if v.name == spawnType then
            local max = 5
            if spawnType == prisoner then max = 6 end
            local amount = math.random(1,max)
            local model = models[spawnType]

             while not HasModelLoaded(model) do
                RequestModel(model)
                Wait(20)
            end
            for k=1,amount do
                Wait(200)

                local x = math.random(1,5)
                local ped = CreatePed(4, model, v.pos[1]+x,v.pos[2],v.pos[3], -1, true, false)
                DecorSetBool(ped, 'ScriptedPed', true)
                SetPedRelationshipGroupDefaultHash(ped,GetHashKey(missionState[spawnType]))
                SetPedRelationshipGroupHash(ped,GetHashKey(missionState[spawnType]))
                SetPedRandomComponentVariation(ped,false)
                SetPedDropsWeaponsWhenDead(ped,false)

                if spawnType == "cop" then
                    
                    SetPedAsCop(ped,true)
                    SetCanAttackFriendly(ped,false,true)

                    local rnd = math.random(1,16)
                    GiveWeaponToPed(ped,GetHashKey(randomWeaponCop[rnd]),300,false,true)
                    SetCurrentPedWeapon(ped,GetHashKey(randomWeaponCop[rnd]),true)
                    netid = NetworkGetNetworkIdFromEntity(ped)

                    copTable[#copTable+1]=netid
                else
                    SetPedFleeAttributes(ped,0,0)
                    SetPedCombatAttributes(ped,46,1)
                    SetPedCombatRange(ped,10)

                    local rnd = math.random(1,17)
                    GiveWeaponToPed(ped,GetHashKey(randomWeapon[rnd]),300,false,true)
                    SetCurrentPedWeapon(ped,GetHashKey(randomWeapon[rnd]),true)
                    netid = NetworkGetNetworkIdFromEntity(ped)

                    prisonerTable[#prisonerTable+1]=netid
                end
            end
        end
    end
end

--------------------------------------
----- Above related To JailBreak -----
--------------------------------------


RegisterNetEvent('beginJail2')
AddEventHandler('beginJail2', function(time,skipintake)
    TriggerEvent("beginJail",skipintake,tonumber(time))
end)

--{1696.5463867188,2577.4409179688,-69.394134521484},

function JailIntro(name,years,cid,date)
    if tonumber(years) > 40 then
        local cid = exports["isPed"]:isPed("cid")
        TriggerServerEvent("shops:jail:remove",cid)
    end
    DoScreenFadeOut(10)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'handcuff', 1.0)

    
    TriggerEvent("police:remmaskAccepted")
    TriggerServerEvent("request:vinewooddel")
    Citizen.Wait(1000)

    local timer = 0
    while timer ~= -1 do
        timer = timer + 1
        Citizen.Wait(1)

        SetEntityCoords(PlayerPedId(),473.02282714844,-1011.612121582, 26.2 - 0.7)
        if IsInteriorReady(GetInteriorAtCoords(473.02282714844,-1011.612121582,26.2 - 0.7)) or timer > 1000 then
            timer = -1
        end
    end



    SetEntityCoords(PlayerPedId(),473.02282714844,-1011.612121582,26.2 - 0.7)
    SetEntityHeading(PlayerPedId(), 179.95875549316)
    Citizen.Wait(1500) 
    DoScreenFadeIn(500)
    TriggerEvent("attachItemCONLOL","con1",name,years,cid,date)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)     
    SetEntityHeading(PlayerPedId(), 272.93203735352) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)  
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)         
    SetEntityHeading(PlayerPedId(), 93.155914306641) 


    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
     TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)       

    SetEntityHeading(PlayerPedId(),186.22499084473)

    Citizen.Wait(2000)
    DoScreenFadeOut(1100)   
    Citizen.Wait(2000)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'jaildoor', 1.0)

end
DoScreenFadeIn(1500)
SwappingCharacters = false
outofrange = false
minutes = 0
function GroupRank(groupid)
  local rank = 0
  local mypasses = exports["isPed"]:isPed("passes")
  for i=1, #mypasses do
    if mypasses[i]["pass_type"] == groupid then

      rank = mypasses[i]["rank"]
    end 
  end
  return rank
end

function RoleplayStats()

    local totalroleplay = 0

    if exports["srp-inventory"]:hasEnoughOfItem("shitlockpick",1,false) then
        totalroleplay = totalroleplay + 10
    end

    if exports["srp-inventory"]:hasEnoughOfItem("jailfood",1,false) then
        totalroleplay = totalroleplay + 10
    end

    if exports["srp-inventory"]:hasEnoughOfItem("methbag",1,false) then
        totalroleplay = totalroleplay + 15
    end

    if exports["srp-inventory"]:hasEnoughOfItem("assphone",1,false) then
        totalroleplay = totalroleplay + 15
        if math.random(10) < 3 then
             TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'pager', 0.4)
        end
    end

    if exports["srp-inventory"]:hasEnoughOfItem("slushy",1,false) then
        totalroleplay = totalroleplay + 10
    end

    if math.random(70) < totalroleplay then
        TriggerEvent("DoLongHudText","All that roleplay adds up!")
        Wait(1000)
        TriggerServerEvent("jail:cuttime")
    end

end

function InmateHasAll()
    if exports["srp-inventory"]:hasEnoughOfItem("slushy",1,false)
        and
        exports["srp-inventory"]:hasEnoughOfItem("-1810795771",1,false)
        and
        exports["srp-inventory"]:hasEnoughOfItem("methbag",1,false)
        and
        exports["srp-inventory"]:hasEnoughOfItem("assphone",1,false)
        and
        exports["srp-inventory"]:hasEnoughOfItem("slushy",1,false)
    then
        return true
    else
        return false
    end
end

function InmateAnim()
    if ( DoesEntityExist( inmate ) and not IsEntityDead( inmate ) ) then 
        loadAnimDict( "random@mugging4" )
        TaskPlayAnim( inmate, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end

function InmateDelete()
    if DoesEntityExist(inmate) then 
        SetPedAsNoLongerNeeded(inmate)
        DeletePed(inmate)
    end
end
function InmateCreate()
    local hashKey = -1313105063
    local pedType = 5
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end
    inmate = CreatePed(pedType, hashKey, 1642.08, 2522.16, 45.57, 43.62, false, false)
    DecorSetBool(inmate, 'ScriptedPed', true)
end

function InmatePedSettings()
    DecorSetBool(inmate, 'ScriptedPed', true)
    SetEntityInvincible(inmate,true)
    ClearPedTasks(inmate)
    ClearPedSecondaryTask(inmate)
    TaskSetBlockingOfNonTemporaryEvents(inmate, true)
    SetPedFleeAttributes(inmate, 0, 0)
    SetPedCombatAttributes(inmate, 17, 1)
    SetPedSeeingRange(inmate, 0.0)
    SetPedHearingRange(inmate, 0.0)
    SetPedAlertness(inmate, 0)
    SetPedKeepTask(inmate, true)
end

RegisterNetEvent('beginJail')
AddEventHandler('beginJail', function(skipintake,time,name,cid,date)
    TriggerServerEvent('server-jail-item', 'ply-'..exports["isPed"]:isPed("cid"), true)
    imjailed = false
    local playerPed = PlayerPedId()
    local mycid = exports["isPed"]:isPed("cid")

    local gang = exports["isPed"]:isPed("gang")
    if gang == 4 then
        TriggerServerEvent("wipeweed")
    end    

    TriggerEvent("DensityModifierEnable",false)
    mycell = math.random(1,20)
    minutes = tonumber(time)


    if not skipintake then
        JailIntro(name,time,mycid,date)
    end
    FreezeEntityPosition(playerPed, false)
    
    
    TriggerEvent("shop:createMeth")

    minCalc = 15000

    DoScreenFadeOut(1)
    if mycell == nil then
        mycell = 1
    end
    
    SetEntityCoords(playerPed, cellcoords[mycell].x,cellcoords[mycell].y,cellcoords[mycell].z ) 

    TriggerServerEvent("updateJailTime",minutes)
 
    InmateDelete()
    InmateCreate()
    InmatePedSettings()
    InmateAnim()
    local jailluck = math.random(100)
    if minutes > 60 then
        jailluck = jailluck - math.ceil(minutes/10)
    end


    Citizen.Wait(500)
    TriggerEvent("doors:resetTimer")
    FreezeEntityPosition(playerPed, false)
    DoScreenFadeIn(1500)
    TriggerEvent("falseCuffs")  

    
    imjailed = true
    RemoveAllPedWeapons(playerPed)
    TriggerEvent("attachWeapons")
    TriggerEvent("DoLongHudText", "You have been jailed. You can pick up your shit when you leave.")
    TriggerEvent("inhotel",false)
    while imjailed do
        Citizen.Wait(1)
        if minCalc == 0 then
            playerPed = PlayerPedId()
            minCalc = 15000
            RoleplayStats()
            Citizen.Wait(1000)
            TriggerServerEvent("checkJailTime",false)
        end

        if (#(GetEntityCoords(playerPed) - vector3(cellcoords[mycell].x,cellcoords[mycell].y,cellcoords[mycell].z)) > 340) then
            SetEntityCoords(playerPed, cellcoords[mycell].x,cellcoords[mycell].y,cellcoords[mycell].z) 
        end

        minCalc = minCalc - 1
    end
    if relogging then
        return
    end

    RemoveBlip(Blip)
    TriggerEvent("DensityModifierEnable",true)

end)


RegisterNetEvent('swappingCharsLoop')
AddEventHandler('swappingCharsLoop', function()
    TransitionToBlurred(500)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    TriggerEvent("srp-base:clearStates")
    imjailed = false
    TriggerEvent("srp-base:spawnInitialized")
    Citizen.Wait(1000)
	DoScreenFadeIn(1500)
end)

RegisterNetEvent('TimeRemaining')
AddEventHandler('TimeRemaining', function(TimeRemaining, release)

    local playerPed = GetPlayerPed(-1)

    local TimeR = TimeRemaining

    if TimeR <= 0 and release then 
       imjailed = false
        TriggerEvent("DoLongHudText", "You are free!.",1)
        TriggerServerEvent("server:currentpasses")
        SetEntityCoords(playerPed, 1841.89, 2594.42,46.02)
       
    else

    local minutes = TimeR
    TriggerEvent("chatMessage", "DOC | " , { 33, 118, 255 }, "You have " .. minutes .. " month(s) remaining")
    end
end)

RegisterNetEvent("check:time")
AddEventHandler("check:time", function()
    TriggerServerEvent("checkJailTime",true)
end)

RegisterNetEvent('endJailTime')
AddEventHandler('endJailTime', function()
    imjailed = false
    TriggerEvent("DoLongHudText", "You are free!.",1)
    TriggerServerEvent("server:currentpasses")
    SetEntityCoords(GetPlayerPed(-1), 1841.89, 2594.42,46.02)
end)


RegisterNetEvent('beginJail3')
AddEventHandler('beginJail3', function(time)
    TriggerEvent("beginJailMobster",tonumber(time))
end)

RegisterNetEvent('beginJailMobster')
AddEventHandler('beginJailMobster', function(time)
    imjailedmobster = true
    minutes = tonumber(time)
    TriggerEvent("DensityModifierEnable",false)
    minutes = tonumber(minutes) >= 120 and 120 or tonumber(minutes)
    TriggerEvent("DoLongHudText", "You were dumped here.. weird.",1)
    minCalc = 60
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), 143.79208374023,-2201.6572265625,4.6880202293396) 
    TriggerServerEvent("updateJailTimeMobster",minutes)
    TriggerEvent("falseCuffs")  


        while imjailedmobster do
            Citizen.Wait(1000)
            RemoveAllPedWeapons(PlayerPedId())
            TriggerEvent("attachWeapons")
            if minCalc < 1 then
                
                minCalc = 60
                minutes = minutes - 1
                TriggerEvent("DoLongHudText", "You have " .. minutes .. " minutes remaining",1)
                TriggerServerEvent("updateJailTimeMobster",minutes)
            end

            if (#(GetEntityCoords(PlayerPedId(), 0) - vector3(143.79208374023,-2201.6572265625,4.6880202293396)) > 5) then
                SetEntityCoords(PlayerPedId(), 143.79208374023,-2201.6572265625,4.6880202293396) 
            end

            if minutes < 2 then
                imjailedmobster = false
            end

            minCalc = minCalc - 1
        end

        TriggerServerEvent("updateJailTimeMobster",0)
        TriggerEvent("DoLongHudText", "You were dumped here.. weird.",1)
        SetEntityCoords(PlayerPedId(), 164.2027130127,-1721.9739990234,29.291980743408)

        TriggerEvent("DensityModifierEnable",true)
end)

lifeCellCoords = {
    {-3.5171592235565,-670.67626953125,16.130613327026}, 
    {-5.1028943061829,-676.06817626953,16.130613327026}, 
    {0.22147338092327,-659.54638671875,16.130613327026}, 
    {11.018131256104,-662.85894775391,16.130613327026}, 
    {4.3471856117249,-679.97094726563,16.130613327026}, 
}

selectedCell = 0

RegisterNetEvent('beginJail4')
AddEventHandler('beginJail4', function(imjailedLife)
    TriggerEvent("beginJailLife",imjailedLife)
end)

RegisterNetEvent('beginJailLife')
AddEventHandler('beginJailLife', function(imjailedLife)
    local rnd = math.random(1,5)
    selectedCell = rnd
    TriggerEvent("DensityModifierEnable",false)
    TriggerEvent("DoLongHudText", "You are on Life Sentence.",1)
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(),lifeCellCoords[selectedCell][1],lifeCellCoords[selectedCell][2],lifeCellCoords[selectedCell][3]) 
    TriggerEvent("falseCuffs")  
    DoScreenFadeIn(1500)
    if imjailedLife then
        while imjailedLife do
            Citizen.Wait(1000)
            RemoveAllPedWeapons(PlayerPedId())
            TriggerEvent("attachWeapons")

            if #(GetEntityCoords(PlayerPedId()) - vector3(1.8283240795135,-672.43591308594,16.130613327026)) > 100 then
                SetEntityCoords(PlayerPedId(), lifeCellCoords[selectedCell][1],lifeCellCoords[selectedCell][2],lifeCellCoords[selectedCell][3]) 
            end

            if selectedCell == 0 then break end
        end
    else
        selectedCell = 0
    end

    TriggerEvent("DoLongHudText", "You were removed from High Sec.",1)
    SetEntityCoords(PlayerPedId(), -1.1144685745239,-679.89410400391,16.130630493164)

    TriggerEvent("DensityModifierEnable",true)
end)

