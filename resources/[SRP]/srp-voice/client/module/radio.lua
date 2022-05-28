local isDead = false

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

--- event syncRadioData
--- syncs the current players on the radio to the client
---@param radioTable table the table of the current players on the radio
function syncRadioData(radioTable)
	radioData = radioTable
	for tgt, enabled in pairs(radioTable) do
		if tgt ~= playerServerId then
			toggleVoice(tgt, enabled, 'radio')
		end
	end
	playerTargets(radioData, callData)
end
RegisterNetEvent('srp-voice:syncRadioData', syncRadioData)

--- event setTalkingOnRadio
--- sets the players talking status, triggered when a player starts/stops talking.
---@param plySource number the players server id.
---@param enabled boolean whether the player is talking or not.
function setTalkingOnRadio(plySource, enabled)
	if plySource ~= playerServerId then
		toggleVoice(plySource, enabled, 'radio')
		radioData[plySource] = enabled
		playerTargets(radioData, callData)
		playMicClicks(enabled)
	end
end
RegisterNetEvent('srp-voice:setTalkingOnRadio', setTalkingOnRadio)

--- event addPlayerToRadio
--- adds a player onto the radio.
---@param plySource number the players server id to add to the radio.
function addPlayerToRadio(plySource)
	radioData[plySource] = false
	playerTargets(radioData, callData)
end
RegisterNetEvent('srp-voice:addPlayerToRadio', addPlayerToRadio)

--- event removePlayerFromRadio
--- removes the player (or self) from the radio
---@param plySource number the players server id to remove from the radio.
function removePlayerFromRadio(plySource)
	if plySource == playerServerId then
		for tgt, enabled in pairs(radioData) do
			if tgt ~= playerServerId then
				toggleVoice(tgt, false)
			end
		end
		radioData = {}
		playerTargets(radioData, callData)
	else
		radioData[plySource] = nil
		toggleVoice(plySource, false)
		playerTargets(radioData, callData)
	end
end
RegisterNetEvent('srp-voice:removePlayerFromRadio', removePlayerFromRadio)

--- function setRadioChannel
--- sets the local players current radio channel and updates the server
---@param channel number the channel to set the player to, or 0 to remove them.
function setRadioChannel(channel)
	if GetConvarInt('voice_enableRadios', 1) ~= 1 then return end
	TriggerServerEvent('srp-voice:setPlayerRadio', channel)
	voiceData.radio = channel
	if GetConvarInt('voice_enableUi', 1) == 1 then
		SendNUIMessage({
			radioChannel = channel,
			radioEnabled = voiceData.radioEnabled
		})
	end
end

--- exports setRadioChannel
--- sets the local players current radio channel and updates the server
---@param channel number the channel to set the player to, or 0 to remove them.
exports('setRadioChannel', setRadioChannel)

--- exports removePlayerFromRadio
--- sets the local players current radio channel and updates the server
exports('removePlayerFromRadio', function()
	setRadioChannel(0)
end)

--- exports addPlayerToRadio
--- sets the local players current radio channel and updates the server
---@param radio number the channel to set the player to, or 0 to remove them.
exports('addPlayerToRadio', function(radio)
	local radio = tonumber(radio)
	if radio then
		setRadioChannel(radio)
	end
end)

RegisterCommand('+radiotalk', function()
    -- since this is a shared resource (between my server and the public), probably don't want to try and use our export :P
    -- use fallback in this case.
    if isDead then
        return false
    end

    if not voiceData.radioPressed and voiceData.radioEnabled then
        if voiceData.radio > 0 then
            TriggerServerEvent('srp-voice:setTalkingOnRadio', true)
            voiceData.radioPressed = true
			playMicClicks(true)
            Citizen.CreateThread(function()
                TriggerEvent("srp-voice:radioActive", true)
				TriggerEvent('hud:voice:transmitting', true)
                while voiceData.radioPressed do
                    Citizen.Wait(0)
                    SetControlNormal(0, 249, 1.0)
                    SetControlNormal(1, 249, 1.0)
                    SetControlNormal(2, 249, 1.0)
                    if not HasAnimDictLoaded("random@arrests") then
                        RequestAnimDict("random@arrests");
                        while not HasAnimDictLoaded("random@arrests") do
                            Wait(5)
                        end
                    end
                    if (not IsEntityPlayingAnim(PlayerPedId(), "random@arrests","generic_radio_chatter", 3)) and not IsPedSittingInAnyVehicle(PlayerPedId()) then
                        TaskPlayAnim(PlayerPedId(),"random@arrests","generic_radio_chatter", 8.0, 0.0, -1, 49, 0, 0, 0, 0);
                    end
                end
                if (IsEntityPlayingAnim(PlayerPedId(), "random@arrests","generic_radio_chatter", 3)) and not voiceData.radioPressed then
                    StopAnimTask(PlayerPedId(), "random@arrests","generic_radio_chatter", -4.0);
                end
            end)
        end
    end
end, false)

RegisterCommand('-radiotalk', function()
	if voiceData.radio > 0 or voiceData.radioEnabled then
		voiceData.radioPressed = false
		TriggerEvent("srp-voice:radioActive", false)
		playMicClicks(false)
		TriggerServerEvent('srp-voice:setTalkingOnRadio', false)
		TriggerEvent('hud:voice:transmitting', false)
	end
end, false)
RegisterKeyMapping('+radiotalk', 'Talk over Radio', 'keyboard', GetConvar('voice_defaultRadio', 'LMENU'))

--- event syncRadio
--- syncs the players radio, only happens if the radio was set server side.
---@param radioChannel number the radio channel to set the player to.
function syncRadio(radioChannel)
	if GetConvarInt('voice_enableRadios', 1) ~= 1 then return end
	voiceData.radio = radioChannel
end
RegisterNetEvent('srp-voice:clSetPlayerRadio', syncRadio)
