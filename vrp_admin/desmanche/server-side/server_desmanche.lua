

function RegisterTunnel.checkPermission(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if perm == nil or vRP.hasPermission(user_id, perm) then
            return true
        end
    end
end


local desmanchando = {}



function RegisterTunnel.checkVehicleStatus(mPlaca, mName)
    local source = source
    local user_id = vRP.getUserId(source)

    -- print("DEBUG SERVER: Verificando veículo -> Placa:", mPlaca, " | Nome (IGNORADO):", mName)

    if user_id then
        local nuser_id = vRP.getUserByRegistration(mPlaca)
        -- print("DEBUG SERVER: Proprietário do veículo encontrado? ->", nuser_id)

        if nuser_id then
            -- Alterado para buscar pela PLACA ao invés do NOME
            local rows = vRP.query("vRP/get_veiculos_status", { user_id = nuser_id, placa = mPlaca })
            -- print("DEBUG SERVER: Resultado da query ->", json.encode(rows))

            if rows[1] then
                if rows[1].status == 0 then
                    -- print("DEBUG SERVER: ✅ Veículo pode ser desmanchado!")
                    desmanchando[mPlaca] = user_id
                    exports["vrp"]:setBlockCommand(user_id, 40)
                    return true
                else
                    TriggerClientEvent("Notify", source, "negado", "Este veículo já está detido/retido.", 5000)
                    -- print("DEBUG SERVER: 🚨 Veículo já detido/retido.")
                    return false
                end
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Este veículo não possui nenhum proprietário.", 5000)
            -- print("DEBUG SERVER: 🚨 Veículo sem dono.")
            return false
        end
    end

    -- print("DEBUG SERVER: 🚨 `checkVehicleStatus` retornou NIL")
    return false
end





function RegisterTunnel.pagarDesmanche(mPlaca,mName,mPrice,mVeh)

    -- print(">>>  entrou")
    -- print("Preço: ",mPrice)

    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        -- print(">>>  entrou 2")
        
        local nuser_id = vRP.getUserByRegistration(mPlaca)
        
        if nuser_id then
            -- print(">>>  entrou 3")
            if mName == "hornet" or mName == "Hornet" then
                TriggerClientEvent("Notify",source,"negado","Este veiculo nao pode ser desmanchado.", 5000)
                return
            end
            
            if desmanchando[mPlaca] == user_id then
                -- print(">>>  entrou 4")
                -- print("Nome do carro: ",mName)



                exports["vrp"]:setBlockCommand(user_id, 0)
                -- vRP.execute("vRP/set_status",{ user_id = nuser_id, veiculo = mName, status = 2})

                -- vRP.execute("vRP/set_status", { user_id = nuser_id, placa = mPlaca, status = 2 })
                vRP.execute("vRP/set_status", { user_id = nuser_id, veiculo = mName, status = 2 })


                vRP.giveInventoryItem(user_id, "dinheirosujo", mPrice*0.15, true)
                vRP.giveInventoryItem(user_id, "pecas_de_carro", 6, true)

                exports['thunder_garages']:deleteVehicle(source, mVeh)
                vRP._stopAnim(false)
                desmanchando[mPlaca] = nil
                vRP.sendLog("DESMANCHE", "O ID: "..user_id.." desmanchou o veiculo do id "..nuser_id.." veiculo: "..mName.." placa: "..mPlaca.." e recebeu $ "..vRP.format(mPrice*0.15))
            else
                print(user_id, "Troxa dupando #DUPANDO")
            end
        else
            TriggerClientEvent("Notify",source,"negado","Este veiculo nao possui nenhum proprietario.", 5000)
        end
    end
end


