fx_version 'adamant'
games { 'gta5' }

client_script "client/main.lua"
server_script "server/main.lua"

files{
    'html/*'
}

ui_page('html/index.html')
