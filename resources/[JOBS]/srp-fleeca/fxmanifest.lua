fx_version 'bodacious'
games { 'rdr3', 'gta5' }

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/button.png',
	'html/electronic.png',
	'html/gruppe622.png',
	'html/gruppe62.png',
	'html/lockpick.png',
	'html/thermite.png',
	'html/airlock.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}


client_scripts {
    'client/*.lua',
    'config.lua',
}

server_scripts {
    'server/*.lua',
    'config.lua',
}
