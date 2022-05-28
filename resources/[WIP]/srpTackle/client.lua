

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedSprinting(PlayerPedId()) and IsControlJustReleased(0, 38) then --Change the key for tackling here.
			if IsPedInAnyVehicle(PlayerPedId()) then
			else
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				local Tackled = {}

				SetPedToRagdollWithFall(PlayerPedId(), 1000, 1500, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0) --how long the tackler will remain down.

				while IsPedRagdoll(PlayerPedId()) do
					Citizen.Wait(0)
					for Key, Value in ipairs(getTouchedPlayers()) do
						if not Tackled[Value] then
							Tackled[Value] = true
							TriggerServerEvent('Tackle:Server:TacklePlayer', GetPlayerServerId(Value), ForwardVector, GetPlayerName(PlayerId()))
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('Tackle:Client:TacklePlayer')
AddEventHandler('Tackle:Client:TacklePlayer',function(ForwardVector)
	SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0) --how long the person being tackled will remain down.
end)

function getPlayers()
    local players = {}

    for i = 0, 255 do
       if NetworkIsPlayerActive(i) then
            table.insert(players, i)
       end
    end

    return players
end

function getTouchedPlayers()
    local touchedPlayer = {}
    for Key, Value in ipairs(getPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(), GetPlayerPed(Value)) then
			table.insert(touchedPlayer, Value)
		end
    end
    return touchedPlayer
end