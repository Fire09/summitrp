RegisterServerEvent('meth:givemoney')
AddEventHandler('meth:givemoney', function()
local src = source
local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    user:addMoney(945)
end)