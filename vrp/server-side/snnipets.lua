local pressetHooks = {
    ["ENTRADA"] = { "https://discord.com/api/webhooks/1279012336035696711/uQ8Yx3_8QCF3hcp7PK4any1_Fs0ijMZC509gHTmazkTvw85pcZ3wTvBySXKBkvOor_Bl" },
    ["SAIDA"] = { "https://discord.com/api/webhooks/1279012740823777280/XDoHL7J29OfF4OXPVOWvbLvP9cBuybTPJzjYIVHMuW1hhlwFljcnw2wi-R4DJcJs44oH" },

    ["DROPAR"] = { "https://discord.com/api/webhooks/1279013011616563200/J4vSj9VAWXQYkJ8fmKS9RMygqB0Fks_p2gmbFjZjTmFenZNg9gESgUmFbAV_hCze8ab3" },
    ["ENVIAR"] = { "https://discord.com/api/webhooks/1279013220744433665/cWMKhX5iHYNz5bwczrbotcE2XRlvgo12hPUsJY_Tt-JNPFMVVegmY5xKIszwdyacYvE4" },
    ["EQUIPAR"] = { "https://discord.com/api/webhooks/1279013341842640918/W8BgFuN9KWAbE59uFJ669Z5rtqODk3j9FBRGcY6hqxqMAWxbQFuFrp3HjVZ76bvCAx-y" },
    ["GARMAS"] = { "https://discord.com/api/webhooks/1279014179671507007/F8xwPj1sefBnw2zxKM_yhUZyp49als7thFys7AJr7AWcw02reyg-4RRxJpguMCHnYQDQ" },
    ["SAQUEAR"] = { "https://discord.com/api/webhooks/1279014374438211584/tKiAm5onDy0G3_Ihoev5MqsF4qTIXu4SKdfjYhblCf_gjTmO_QaD6SCpuObh851UvlqN" },
    ["BAUCARRO"] = { "https://discord.com/api/webhooks/1279010420342001767/YWrYtXeKJAQvZmCNcOjW4PX8nwOTSC5iInmLcJ0_8o0jS85zqIJUxxJtSB8-vd8tZ-wa" },
    ["BAUCASAS"] = { "https://discord.com/api/webhooks/1279010668221300787/f-wBdMcgh32JU7tSYXXPE19rFfXNhuagqvUeUmXwU0jSqmFjTLnQTBstb1N6rThdC5S-" },
    ["CRASHS"] = { "https://discord.com/api/webhooks/1279014830954647562/E3UuXumFtRyVVw3QGn6srVVJ-8B4ZKyCFoP-Pfu8Snw9XFplZah45JWLXn4X2V3tOP1Q" },
    ["MORTE"] = { "https://discord.com/api/webhooks/1279007699987599391/wgO-UYC3Eb3k-jwmKzuOn9yHdZex_1ypjY3wlLUmMxQ4QTywyFmKKpbiUvLUnOOAGre7" },
    ["ROUBOGERAIS"] = { "https://discord.com/api/webhooks/1279015124803522663/5OiITw0CfaO6J-d-zGUp2SuszfjlPDDZPmY9jXnw2Ho4256ZJlHT0SVER32hzVz5P4is" },
    ["ROUBOAMMU"] = { "https://discord.com/api/webhooks/1279015124803522663/5OiITw0CfaO6J-d-zGUp2SuszfjlPDDZPmY9jXnw2Ho4256ZJlHT0SVER32hzVz5P4is" },
    ["ROUBOCAIXA"] = { "https://discord.com/api/webhooks/1279015124803522663/5OiITw0CfaO6J-d-zGUp2SuszfjlPDDZPmY9jXnw2Ho4256ZJlHT0SVER32hzVz5P4is" },
    ["ROUBOREGISTRADORA"] = { "https://discord.com/api/webhooks/1279015124803522663/5OiITw0CfaO6J-d-zGUp2SuszfjlPDDZPmY9jXnw2Ho4256ZJlHT0SVER32hzVz5P4is" },
    ["BANCODEPOSITAR"] = { "https://discord.com/api/webhooks/1279009257789849620/is8R53UlS-uy8u6BM3tP53AkhXZOsqEuJs-6vVuhaW19NI26O7kxh0dhB_3jnxSyrDMV" },
    ["BANCOSACAR"] = { "https://discord.com/api/webhooks/1279009257789849620/is8R53UlS-uy8u6BM3tP53AkhXZOsqEuJs-6vVuhaW19NI26O7kxh0dhB_3jnxSyrDMV" },
    ["BANCOENVIAR"] = { "https://discord.com/api/webhooks/1279009257789849620/is8R53UlS-uy8u6BM3tP53AkhXZOsqEuJs-6vVuhaW19NI26O7kxh0dhB_3jnxSyrDMV" },
    ["COMPRARVEICULO"] = { "https://discord.com/api/webhooks/1279015624013516882/zcukJ8ZxNuqrUKPyy845MVO39Sf5p6kkHREoFXc-GuPwKKX5JK7_P3Rm5O7H0x4nTxVk" },
    ["WL"] = { "https://discord.com/api/webhooks/1279015736919982101/dlJqVh-3DOCrnPbmpoOYnrjc_eTvj0eZlo-WqN-fZeFg2PJ3Xj0YazgvMMYsDFKs9Wtp" },
    ["IDS"] = { "https://discord.com/api/webhooks/1279015840750239764/Wnf8F5KJ1yBWgGqJyeJm6Fa4vWDZoralfmc0HhA1xYUnKiQbpy2K_z-iOcagppDSXMAC" },
    ["TPTO"] = { "https://discord.com/api/webhooks/1279015972488872028/9ZR_IU7covuob2cSDaL6Oom9jtkhAo94J5Jf2QhNq2chu67i7W5xio_10O_bE9HE8DQ4" },
    ["TPTOME"] = { "https://discord.com/api/webhooks/1279016097823199313/aztQMtnvmy3fZIXSCdXlkEfwQzP5C2examN72_Ijbaz100dVmNOOtMIg7AF7KqCiBCB5" },
    ["GOD"] = { "https://discord.com/api/webhooks/1279016216576397332/wVElMNtpohW3pDThEDV5ddCRckPwS_wBQ0iUO2fVBlBV49sXxkgvdWQ2aKqbDoy8UgNN" },
    ["GOID"] = { "https://discord.com/api/webhooks/1279016216576397332/wVElMNtpohW3pDThEDV5ddCRckPwS_wBQ0iUO2fVBlBV49sXxkgvdWQ2aKqbDoy8UgNN" },
    ["KICK"] = { "https://discord.com/api/webhooks/1279016360676036609/LX-_Jy87l3VNcD_Kp8MjajIJ38gMHHL-pg4M0Acq6jMkk-5JwxSXiK2KJVDZG85hp3oY" },
    ["BAN"] = { "https://discord.com/api/webhooks/1279016497775247360/2S3gpxF1WAyVV6go-IS8m-t2Woj-JNbZAEazLYNQXKS7X-k_-J0k5syiT1YBGy-ku32e" },
    ["PRENDERADM"] = { "https://discord.com/api/webhooks/1279016620320231526/pTHoquX7N1zBKfMAaVc2zBtx4uvQKF0nvYdWF-MF5z0eskY1SbrlyibavMboLdvduCP9" },
    ["AADM"] = { "https://discord.com/api/webhooks/1279016737064489002/06_2iprfQUKwA24wkKD7czPegM7D3zGFW0m-kAGGX4CjeGxSSekMCp3eQfbM-xUhtV2m" },
    ["KILL"] = { "https://discord.com/api/webhooks/1279016824847204406/ed1rv-0TjbSKZAAoOJ7F7BdnwL110Zt4Ws1NeQDwZF8TZMkpgOwbCXqfDFLCsGG75Ayg" },
    ["ITEM"] = { "https://discord.com/api/webhooks/1279016947631132682/4N7OWC9BzporC5aYx5gyrpIhulY2bVpDENeJXqj0yKD2vv7Z8zzCYioMqWXHiZVu6l4H" },
    ["TPWAY"] = { "https://discord.com/api/webhooks/1279017066321412190/r4Wo8mZiz8d6dVTmcYR7Ik3wWc62ykxdCjsY51Y8O0BPq3GObLBMutVnraXuU8iYy9wI" },
    -- ["ACEITARCHAMADOADMIN"] = { "https://discord.com/api/webhooks/1174968671895031838/veZIF29TTFV6dwV8flhUXWrsy61uSbGSAfXfAZj9Ue5RGqH1xdJ3O7A89U3E4MQ9dz4n" },
    ["GROUPADD"] = { "https://discord.com/api/webhooks/1279017258508877936/KXxM1sxOZrWdi0EIzW7BjxFJ0aIY81MjZqrIAfIV2PoJadvk3bEJptHEDVwO5OWaJdE-" },
    ["GROUPREM"] = { "https://discord.com/api/webhooks/1279017431360081980/ls1jAkhHZ_jf2w7smcXh61X5BdvDcPYjdVhdQ_CA4J4wIobt9_fQv_lRNecbWmoPgsaX" },
    ["SPAWNCAR"] = { "https://discord.com/api/webhooks/1279017559617699854/zkqmYkYTm9JecKWliTg_2-5sfGlUqmCjCa4girAgZAFgzxb2gdaKHy_oo5ujT657egjY" },
    ["MONEY"] = { "https://discord.com/api/webhooks/1279011917800669306/ajM5S7ciPpNQ6gxLEaoDYL7PCK7hTAM3bhy-5Dcu9aO3fs4vpzLL3_3Fp0dzY32dYYXv" },
    -- ["BATERPONTOBENNYS"] = { "XXX" },
    -- ["BATERPONTOPOLICIA"] = { "XXX" },
    -- ["BATERPONTOHOSPITAL"] = { "XXX" },
    ["BATERPONTOADMIN"] = { "https://discord.com/api/webhooks/1279017910056255508/g-gK4RHxOGXu9CFaq1DHaS-azb0f4mhwwArGXGexpbe6TEKcRiutiCpxppS0-xyPF9hu" },
    ["PRENDER"] = { "https://discord.com/api/webhooks/1279018015819563078/mSs_SNlZsIbq9AZkOWAClZZrf1uFXR1qMpCEYVHPwy63bm7-HqHS3LJ5wax8iaifVaCJ" },
    ["DESMANCHE"] = { "https://discord.com/api/webhooks/1279018213010837587/FhTjcaosCM6TYzkQN3MX3hZcpwnZHa3-cwcPeFp-bbvaiNn9DdKSzoudtVr-epUx9BDP" },
    ["COPYPRESET"] = { "https://discord.com/api/webhooks/1279018357907132511/AXSnvbmctIwRpbKjpNfYzxvWHXrwC5cuQxiCSh1TrXCcTKMmkGSqIHXRWSfU4ZeKsX2G" },
    ["SETPRESET"] = { "https://discord.com/api/webhooks/1279018357907132511/AXSnvbmctIwRpbKjpNfYzxvWHXrwC5cuQxiCSh1TrXCcTKMmkGSqIHXRWSfU4ZeKsX2G" },
    ["REVISTARADM"] = { "https://discord.com/api/webhooks/1279018511628242977/LP8spL90s4EZmjZGOrvlSTy1CMIXaMI7YGJyGVOh5z_RmF2jUn0oRVbbhv1_r0bPkxur" },
    -- ["VAULTADM"] = { "https://discord.com/api/webhooks/1174967143037677711/8Arz4sgOqngMFAODSjQryFJMs4Ne9PIg9nlTqkb-bdcjs6lqmwrZ9JjMCnTjYtmYvZFK" },
    -- ["HOUSEADMCHEST"] = { "https://discord.com/api/webhooks/1174967042256941078/zZKqPx4dz8VhEtOVLZZ3yJY-pJHKsWYhC69ZS-TLq3vQCP7N8yQ-VN6f7cnH6BD3B9v4" },
    ["FUEL"] = { "https://discord.com/api/webhooks/1174966967438946374/-IVpt3m3QNVD1HcDffQREEFKxfHt6pP3HoSe2agnALHBau_GI0U5wVq2XZWByUusov12" },
    -- ["LOCKPICK"] = { "https://discord.com/api/webhooks/1174966874564476970/hd51w4W8ABl83646ra-zcX5Cc8qdUyP8SIY1bcOxR4anTBTyUNByKYWTbF-RgLU8VcDc" },
    -- ["ADDCARRO"] = { "https://discord.com/api/webhooks/1174964226658410557/8ICmYfuswlta9232BYtELv8zej-qzk-jsSyFBnr03A4ozOzQCV-3BM4zwOLbUq4ezeUs" },
    -- ["RENOMEAR"] = { "https://discord.com/api/webhooks/1174964915048566794/cagJO3a9ZllhfhkJK8rhsJvryytH6AAJ8YHtzv6yFZP9Mf-Wl2OKtHD-Qq9W-MebSTtB" },
    -- ["CRAFT"] = { "https://discord.com/api/webhooks/1174966544602771486/I21QlefJfJH2BCvHifpNc9cTDP-51RdfueR1TZfpjmlkZT62YMwNL2wYYXbM5r8ChSVm" },
    -- ["KITPROMO"] = { "https://discord.com/api/webhooks/1174966448309936128/CY5tac4Pl2ov15Yjwi990Hlf_p2lw3Bcs9Qr4A0lcDJ5k7_9Tw04AnGlzxmRJO6TC5uH" },
    -- ["GETITEM"] = { "https://discord.com/api/webhooks/1149483032542203905/4m2_up2Ojb784IVKUBHdkAusnBhKrwPY_nnqmqX3NLUTCbytahF1VK9O01xSM0tUTPBv" },
    -- ["REMCARRO"] = { "https://discord.com/api/webhooks/1174966244261253140/QqWouYafDiM936IwYCY5HFn_FzdkJVtAEA_N3toRm9poqzkM5Sw9D7Akxsn6v17TyPE9" },
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD WEEBHOOK
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function vRP.sendLog(weebhook, mensagge)
    if weebhook and mensagge then
        if pressetHooks[weebhook] ~= nil then
            SendWebhookMessage(pressetHooks[weebhook][1],mensagge)
        else
            SendWebhookMessage(weebhook,mensagge)
        end
    end
end

function SendWebhookMessage(webhook,message)
    if webhook ~= "none" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESLOGAR DENTRO DA PROPRIEDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.atualizarPosicao(user_id,x,y,z)
    local data = vRP.getUserDataTable(user_id)
    if user_id then
        if data then
            data.position = { x = x, y = y, z = z }
        end
    end
end

function vRP.limparArmas(user_id)
    local data = vRP.getUserDataTable(user_id)
    if user_id then
        if data then
            data.weapons = {}
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTROS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function (reason)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        if reason == "Game crashed: gta-core-five.dll!CrashCommand (0x0)" then
            vRP._setBanned(user_id, true, "Usou comando para forjar o crash")
            vRP.sendLog("CRASHS", "O ID "..user_id.." utilizou o comando _crash.")
        end
    end
end)
