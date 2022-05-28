local DISCORD_WEBHOOK = ""

RegisterServerEvent('send')
AddEventHandler('send', function(data)
    if(data.url == nil or data.url == "") then
        data.url = "https://lh3.googleusercontent.com/proxy/eyhom2MpG4JlnVWyxOKZfqssXjRxRE1eh9K3F45mwGnaxHFnNGsiSH35W3PQBdM0WzIZ7pwZOHP49s5eeN3K92p8jDMYY4M"
    end
    local connect = {
        {
            ["color"] = "255",
            ["title"] = "Bug Report",
            ["description"] = "Title: \n `"..data.title.."` \n Description: \n `"..data.description.."`",
	        ["footer"] = {
                ["text"] = "Made by SRP",
            },
            ["image"] = {
                ["url"] = data.url,
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = "Bug Reports",  avatar_url = "",embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

