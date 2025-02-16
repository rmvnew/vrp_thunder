shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version   'bodacious'
lua54        'yes'
game         'gta5'

ui_page_preload "yes"
ui_page "web-side/index.html"

client_scripts {
    "@vrp/lib/utils.lua",
    "client-side/*"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server-side/config.lua",
    "server-side/*"
}

files {
    "web-side/*",
    "web-side/alert.png"
}                                                                                    