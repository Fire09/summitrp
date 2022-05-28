RegisterServerEvent('gardening:sell')
AddEventHandler('gardening:sell', function()
local src = source
local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    user:addMoney(445,645)
end)

