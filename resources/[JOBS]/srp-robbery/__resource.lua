resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"


client_script "@srp-errorlog/client/cl_errorlog.lua"



client_script 'client/*.lua'
server_script 'server/*.lua'

server_export 'startRobbery'

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
