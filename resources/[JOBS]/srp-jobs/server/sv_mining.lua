
RegisterServerEvent("mining-sell:items", function(pAmount, pItem)
  local pSrc = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(pSrc)

  if pAmount <= 0 then
    TriggerClientEvent("DoLongHudText", pSrc, "You dont have anything to sell", 2)
    return
  end

  if pItem == "goldbar" then
    Payment = math.random(60, 75)
  elseif pItem == "silver bar" then
    Payment = math.random(60, 75)
  elseif pItem == "copperbar" then
    Payment = math.random(60, 75)
  elseif pItem == "ironbar" then
    Payment = math.random(60, 75)
  end

  if Payment then
    TriggerClientEvent("inventory:removeItem", pSrc, pItem, pAmount)
    Citizen.Wait(100)
    user:addMoney(pAmount*Payment)
  end
end)
