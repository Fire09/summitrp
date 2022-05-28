---BURGERSHOT

RegisterNetEvent("hasSignedOnburger_shot")
AddEventHandler("hasSignedOnburger_shot", function()
	SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
	SetPoliceIgnorePlayer(PlayerPedId(),true)
end)


RegisterNetEvent('burger_shotduty')
AddEventHandler('burger_shotduty', function()
	TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Burger Shot ",
            txt = ""
        },
        {
            id = 2,
            header = "Clock In",
			txt = "Use this to clock in",
			params = {
                event = "attempt:duty:burger_shot"
            }
        },
		{
            id = 3,
            header = "Clock Out",
			txt = "Use this to clock out",
			params = {
                event = "police:noLongerCop"
            }
        },
    })
end)

RegisterNetEvent("attempt:duty:burger_shot")
AddEventHandler("attempt:duty:burger_shot", function()
	TriggerServerEvent("attemptdutyms")
end)

RegisterNetEvent("attempt:duty:burger_shot")
AddEventHandler("attempt:duty:burger_shot", function()
	TriggerServerEvent("attemptdutyms")
end)

----TUNERSHOP

RegisterNetEvent("hasSignedOntuner_shop")
AddEventHandler("hasSignedOntuner_shop", function()
	SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
	SetPoliceIgnorePlayer(PlayerPedId(),true)
end)


RegisterNetEvent('tuner_shopduty')
AddEventHandler('tuner_shopduty', function()
	TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Hayes Auto Body Shop ",
            txt = ""
        },
        {
            id = 2,
            header = "Clock In",
			txt = "Use this to clock in",
			params = {
                event = "attempt:duty:tuner_shop"
            }
        },
		{
            id = 3,
            header = "Clock Out",
			txt = "Use this to clock out",
			params = {
                event = "police:noLongerCop"
            }
        },
    })
end)

RegisterNetEvent("attempt:duty:tuner_shop")
AddEventHandler("attempt:duty:tuner_shop", function()
	TriggerServerEvent("attemptdutytuner")
end)