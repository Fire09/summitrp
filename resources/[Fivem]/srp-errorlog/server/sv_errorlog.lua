RegisterServerEvent('error')
AddEventHandler('error',function(resource, args)

    sendToDiscord("```Error in "..resource..'```', args)
end)



function sendToDiscord(name, args, color)
    local connect = {
          {
              ["color"] = 16711680,
              ["title"] = "".. name .."",
              ["description"] = args,
              ["footer"] = {
                  ["text"] = "SRP",
              },
          }
      }
    PerformHttpRequest('', function(err, text, headers) end, 'POST', json.encode({username = "Error Log", embeds = connect, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
end
