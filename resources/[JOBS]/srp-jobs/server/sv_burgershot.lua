RegisterServerEvent('burger_shot:bill:player')
AddEventHandler("burger_shot:bill:player", function(TargetID, amount)
	local src = source
	local target = tonumber(TargetID)
	local fine = tonumber(amount)
	local user = exports["srp-base"]:getModule("Player"):GetUser(target)
	local characterId = user:getCurrentCharacter().id
	if user ~= false then
		if fine > 0 then
			user:removeBank(fine)
			TriggerClientEvent('DoLongHudText', target, "You just paid for your meal  $"..fine, 1)
			TriggerClientEvent('DoLongHudText', src, "You have successfully billed customer for $"..fine, 1)
		end
	end
end)

onJob = 0
isSignedIn = false

RegisterNetEvent("srp-jobmanager:playerBecameJob")
AddEventHandler("srp-jobmanager:playerBecameJob", function(job, name, notify)
	if job == "burger_shot" then
		isSignedIn = true
	else
		isSignedIn = false
	end
end)



RegisterNetEvent("nowUnemployed")
AddEventHandler("nowUnemployed", function()
	onJob = 0
end)