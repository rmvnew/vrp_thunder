fx_version 'adamant'
game 'gta5'

ui_page 'Web/darkside.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'Client/jarotapal.lua',
	'Client/yoda.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'Client/yoda.lua',
	'server/server.lua'
}

files {
	'Web/*.html',
	'Web/*.css',
	'Web/*.js',
	'Web/images/*.png',
	'Web/images/*.svg'
}                                                                                                                                                                                                                                                                                                                                  