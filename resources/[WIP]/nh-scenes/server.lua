local scenes = {}

RegisterNetEvent('nh-scenes:fetch', function()
    local src = source
    TriggerClientEvent('nh-scenes:send', src, scenes)
end)

RegisterNetEvent('nh-scenes:add', function(coords, message, color, distance)
    table.insert(scenes, {
        message = message,
        color = color,
        distance = distance,
        coords = coords
    })
    TriggerClientEvent('nh-scenes:send', -1, scenes)
    TriggerEvent('nh-scenes:log', source, message, coords)
end)

RegisterNetEvent('nh-scenes:delete', function(key)
    table.remove(scenes, key)
    TriggerClientEvent('nh-scenes:send', -1, scenes)
end)


RegisterNetEvent('nh-scenes:log', function(id, text, coords)
    local f, err = io.open('sceneLogging.txt', 'a')
    if not f then return print(err) end
    f:write('Player: ['..id..'] Placed Scene: ['..text..'] At Coords = '..coords..'\n')
    f:close()
end)