Cfg = {}
if GetConvar('voice_useNativeAudio', 'false') == 'true' then
	Cfg.voiceModes = {
		{4.0, "Shouting"}, -- Shout speech distance in gta distance units
		{10.0, "Normal"}, -- Normal speech distance in gta distance units
		{20.0, "Whisper"} -- Whisper speech distance in gta distance units
	}
else
	Cfg.voiceModes = {
		{4.0, "Shouting"}, -- Shout speech distance in gta distance units
		{10.0, "Normal"}, -- Normal speech distance in gta distance units
		{20.0, "Whisper"} -- Whisper speech distance in gta distance units
	}
end
function debug(message)
	if GetConvarInt('voice_debugMode', 0) == 1 then
		print(('[srp-voice:debug] %s'):format(message))
	end
end
