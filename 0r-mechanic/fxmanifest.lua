fx_version "cerulean"

game "gta5"

shared_script "config.lua"

client_scripts {
    "@vrp/lib/utils.lua",
    "editable_client.lua",
    "client.lua",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "editable_server.lua",
    "server.lua",
    -- "@oxmysql/lib/MySQL.lua", -- if you are using oxmysql
}

ui_page "ui/index.html"

files {
    "ui/img/*.png",
    "ui/img/*.gif",
    "ui/img/*.*",
    "ui/*.html",
    "ui/*.js",
    "ui/*.css",
    "ui/fonts/*.ttf",
    "ui/sounds/*.ogg",
    "data/*.meta",
    "stream/vehicle_paint_ramps.ytd"
}

data_file "CARCOLS_GEN9_FILE" "data/carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "data/carmodcols_gen9.meta"
data_file "FIVEM_LOVES_YOU_447B37BE29496FA0" "data/carmodcols.ymt"

lua54 'yes'