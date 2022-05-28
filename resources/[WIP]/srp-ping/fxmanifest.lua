fx_version 'adamant'
games { 'gta5' }

client_scripts {
    'config.lua',
	'client/main.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
}
