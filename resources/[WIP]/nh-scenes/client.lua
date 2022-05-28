local hidden = false
scenes = {}
local settingScene = false
local coords = {}
colors = {
    ["white"] = {255, 255, 255},
    ["red"] = {255, 0, 0},
    ["blue"] = {0, 0, 255},
    ["green"] = {0, 128, 0},
    ["yellow"] = {255, 255, 0},
    ["purple"] = {128, 0, 128},
}

RegisterNetEvent('nh-scenes:send', function(sent)
    scenes = sent
end)

RegisterCommand('+scenecreate', function()
    -- do nothing on keydown
end)

RegisterCommand('-scenecreate', function()
    if settingScene then settingScene = false return end
    local placement = SceneTarget()
    coords = {}
    settingScene = true

    while settingScene do
        Wait(5)
        DisableControlAction(0, 200, true)
        placement = SceneTarget()
        if placement ~= nil then
            DrawMarker(28, placement.x, placement.y, placement.z, 0, 0, 0, 0, 0, 0, 0.15, 0.15, 0.15, 93, 17, 100, 255, false, false)
        end
        if IsControlJustReleased(0, 202) then
            settingScene = false
            return
        end
    end

    if placement[1] == 0.0 or placement == nil or not placement then return end
    coords = placement

    local scene = exports["nh-keyboard"]:KeyboardInput({
        header = "Add Scene",
        rows = {
            {
                id = 0,
                txt = "Message"
            },
            {
                id = 1,
                txt = "Color {white, red, blue, green, yellow, purple}"
            },
            {
                id = 2,
                txt = "Distance {1.1 - 10.0}"
            },
        }
    })

    if scene[1].input == nil then return end
    local message = scene[1].input
    local color = scene[2].input

    local distance = tonumber(scene[3].input)
    if type(distance) ~= "number" or distance > 10.0 then distance = 10.0 end

    distance = distance + 0.0
    if distance < 1.1 then distance = 1.1 end

    if color == nil or string.lower(color) == nil or colors[string.lower(color)] == nil then color = "white" end
    local color = colors[string.lower(color)]

    TriggerServerEvent('nh-scenes:add', coords, message, color, distance)
end)

RegisterCommand('+scenehide', function()
    hidden = not hidden
    if hidden then
        print("Scenes Disabled")
    else
        print("Scenes Enabled")
    end
end)


RegisterCommand('+scenedelete', function()
    local scene = ClosestSceneLooking()
    if scene ~= nil then
        TriggerServerEvent('nh-scenes:delete', scene)
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(5)
        if #scenes > 0 then
            if not hidden then
                local closest = ClosestScene()
                if closest > 10.0 then
                    Wait(250)
                else
                    local plyCoords = GetEntityCoords(PlayerPedId())
                    for k, v in pairs(scenes) do
                        distance = Vdist(plyCoords, v.coords)
                        if distance <= v.distance then
                            DrawScene(v.coords, v.message, v.color, distance)
                        end
                    end
                end
            else
                Wait(250)
            end
        else
            Wait(250)
        end
    end
end)

TriggerServerEvent('nh-scenes:fetch')
RegisterKeyMapping('+scenecreate', '(scenes): Place Scene', "NONE", "NONE")
RegisterKeyMapping('+scenehide', '(scenes): Toggle Scenes', "NONE", "NONE")
RegisterKeyMapping('+scenedelete', '(scenes): Delete Scene', "NONE", "NONE")
