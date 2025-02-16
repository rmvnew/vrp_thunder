fx_version 'adamant'
game 'gta5'
lua54 'yes'

server_script 'token.lua'

ui_page "web-side/index.html"
loadscreen "loading/darkside.html"

server_scripts {
	"lib/utils.lua",
	"base.lua",
	"server-side/*",
	"modules/*"

}

client_scripts {
	"lib/utils.lua",
	"client-side/*"
}

files {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Tools.lua",
	"web-side/*",
	"loading/*",
	"loading/svgs/*.png",
	"loading/svgs/*.svg",
	"loading/vipers.webmdsA",
	"loading/video.js",
}

loadscreen "loading/index.html"              