
---BURGERSHOT
RegisterServerEvent('attemptdutyms')
AddEventHandler('attemptdutyms', function(src)
	if src == nil or src == 0 then src = source end
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local jobs = exports["srp-base"]:getModule("JobManager")
	local job = 'burger_shot'
	jobs:SetJob(user, job, false, function()
		TriggerClientEvent("DoLongHudText", src, "Clocked In",1 )		
		TriggerClientEvent("hasSignedOnburger_shot", src)
	end)
end)


RegisterServerEvent("police:burger_shotOffDuty")
AddEventHandler("police:burger_shotOffDuty", function()
	local src = source
 	TriggerClientEvent("srp-jobmanager:playerBecameJob", src, "unemployed", "unemployed", true)
end)
--- tuner shop

RegisterServerEvent('attemptdutytuner')
AddEventHandler('attemptdutytuner', function(src)
	if src == nil or src == 0 then src = source end
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local jobs = exports["srp-base"]:getModule("JobManager")
	local job = 'tuner_shop'
	jobs:SetJob(user, job, false, function()
		TriggerClientEvent("DoLongHudText", src, "Clocked In",1 )		
		TriggerClientEvent("hasSignedOntuner_shop", src)
	end)
end)

RegisterServerEvent("police:burger_shotOffDuty")
AddEventHandler("police:burger_shotOffDuty", function()
	local src = source
 	TriggerClientEvent("srp-jobmanager:playerBecameJob", src, "unemployed", "unemployed", true)
end)