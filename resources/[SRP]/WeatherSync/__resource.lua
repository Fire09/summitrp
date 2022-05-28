resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script "@srp-errorlog/client/cl_errorlog.lua"

export "SetEnableSync"

server_scripts {
	"server/server.lua"
}

client_scripts {
	"client/client.lua"
}