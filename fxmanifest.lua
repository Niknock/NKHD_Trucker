fx_version 'cerulean'
game 'gta5'

author 'Niknock HD'
description 'NKHD Trucker'

version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
    'update.lua'
}

shared_scripts {
    '@es_extended/imports.lua'
}

ui_page 'trucker_menu.html'

files {
    'trucker_menu.html'
}
