RegisterServerEvent('e-blips:updateBlips')
AddEventHandler('e-blips:updateBlips', function(id, job, name)
    local src = source
    local data = {
        netId = id,
        job = job,
        callsign = name
    }
    TriggerClientEvent('e-blips:addHandler', source, data)
end)

RegisterNetEvent('e-blips:updateOfficer')
AddEventHandler('e-blips:updateOfficer', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(source)
    local char = user:getCurrentCharacter()
    print(char.id)
    exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
        print("CAKK SUGB",result[1].callsign,result[1].job,src)
        TriggerClientEvent('testssss', src,char.last_name,result[1].job,result[1].callsign)
    end)

    
end) 