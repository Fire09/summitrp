resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page('html/index.html')
client_script "@srp-errorlog/client/cl_errorlog.lua"

client_script "@srp-infinity/client/cl_lib.lua"
server_script "@srp-infinity/server/sv_lib.lua"

files {
	"html/index.html",
	"html/sounds/panic.mp3",
	"html/sounds/metaldetected.mp3",
}

client_script 'client.lua'
server_script 'server.lua'