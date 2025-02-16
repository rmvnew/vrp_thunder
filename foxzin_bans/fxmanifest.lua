fx_version 'bodacious'
game 'gta5'

dependencies {
    'vrp'  
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua',
	'config/config_server.lua'
}
              
server_scripts { '@mysql-async/lib/MySQL.lua' }