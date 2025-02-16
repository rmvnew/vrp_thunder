

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

-- original
-- function RegisterTunnel.checkVehicleStatus(mPlaca,mName)
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if user_id then
        
--         if mName == "hornet" or mName == "Hornet" then
--             TriggerClientEvent("Notify",source,"negado","Este veiculo nao pode ser desmanchado.", 5000)
--             return
--         end
        
--          if dc ~= nil then
--         TriggerClientEvent("Notify",source,"negado","Você não possui 1x Card para desmanchar esse veiculo.", 5000)
--             return
--         end
        
--         local nuser_id = vRP.getUserByRegistration(mPlaca)
--         if nuser_id then
--             local rows = vRP.query("vRP/get_veiculos_status", {user_id = nuser_id, veiculo = mName})
--             if rows[1] then
--                 if rows[1].status == 0 then
--                     desmanchando[mPlaca] = user_id
--                     exports["vrp"]:setBlockCommand(user_id, 40)
--                     return true
--                 else
--                     TriggerClientEvent("Notify",source,"negado","Este veiculo ja se encontra detido/retido.", 5000)
--                 end
--             end
--         else
--             TriggerClientEvent("Notify",source,"negado","Este veiculo nao possui nenhum proprietario.", 5000)
--         end
--     end
-- end

-- ##############################################

-- teste 01
-- function RegisterTunnel.checkVehicleStatus(mPlaca, mName)
--     local source = source
--     local user_id = vRP.getUserId(source)

--     print("DEBUG SERVER: Iniciando verificação do veículo -> Placa:", mPlaca, "Nome:", mName)

--     if user_id then
--         if mName == "hornet" or mName == "Hornet" then
--             TriggerClientEvent("Notify", source, "negado", "Este veículo não pode ser desmanchado.", 5000)
--             print("DEBUG SERVER: 🚨 Este veículo não pode ser desmanchado.")
--             return false
--         end

--         local nuser_id = vRP.getUserByRegistration(mPlaca)
--         print("DEBUG SERVER: Proprietário do veículo encontrado? ->", nuser_id)

--         if nuser_id then
--             local rows = vRP.query("vRP/get_veiculos_status", { user_id = nuser_id, veiculo = mName })
--             print("DEBUG SERVER: Resultado da query ->", json.encode(rows))

--             if rows[1] then
--                 if rows[1].status == 0 then
--                     print("DEBUG SERVER: ✅ Veículo pode ser desmanchado!")
--                     desmanchando[mPlaca] = user_id
--                     exports["vrp"]:setBlockCommand(user_id, 40)
--                     return true
--                 else
--                     TriggerClientEvent("Notify", source, "negado", "Este veículo já está detido/retido.", 5000)
--                     print("DEBUG SERVER: 🚨 Veículo já detido/retido.")
--                     return false
--                 end
--             end
--         else
--             TriggerClientEvent("Notify", source, "negado", "Este veículo não possui nenhum proprietário.", 5000)
--             print("DEBUG SERVER: 🚨 Veículo sem dono.")
--             return false
--         end
--     end

--     print("DEBUG SERVER: 🚨 `checkVehicleStatus` retornou NIL")
--     return false
-- end

-- teste 02

-- function RegisterTunnel.checkVehicleStatus(mPlaca, mName)
--     local source = source
--     local user_id = vRP.getUserId(source)

--     print("DEBUG SERVER: Verificando veículo -> Nome:", mName, " | Placa (ignorada):", mPlaca)

--     if user_id then
--         local nuser_id = vRP.getUserByRegistration(mPlaca)

--         if nuser_id then
--             -- Alterado para buscar pelo nome do veículo
--             local rows = vRP.query("vRP/get_veiculos_status", { user_id = nuser_id, veiculo = mName })
--             print("DEBUG SERVER: Resultado da query ->", json.encode(rows))

--             if rows[1] then
--                 if rows[1].status == 0 then
--                     print("DEBUG SERVER: ✅ Veículo pode ser desmanchado!")
--                     desmanchando[mPlaca] = user_id
--                     exports["vrp"]:setBlockCommand(user_id, 40)
--                     return true
--                 else
--                     TriggerClientEvent("Notify", source, "negado", "Este veículo já está detido/retido.", 5000)
--                     print("DEBUG SERVER: 🚨 Veículo já detido/retido.")
--                     return false
--                 end
--             end
--         else
--             TriggerClientEvent("Notify", source, "negado", "Este veículo não possui nenhum proprietário.", 5000)
--             print("DEBUG SERVER: 🚨 Veículo sem dono.")
--             return false
--         end
--     end

--     print("DEBUG SERVER: 🚨 `checkVehicleStatus` retornou NIL")
--     return false
-- end

function RegisterTunnel.checkVehicleStatus(mPlaca, mName)
    local source = source
    local user_id = vRP.getUserId(source)

    print("DEBUG SERVER: Verificando veículo -> Placa:", mPlaca, " | Nome (IGNORADO):", mName)

    if user_id then
        local nuser_id = vRP.getUserByRegistration(mPlaca)
        print("DEBUG SERVER: Proprietário do veículo encontrado? ->", nuser_id)

        if nuser_id then
            -- Alterado para buscar pela PLACA ao invés do NOME
            local rows = vRP.query("vRP/get_veiculos_status", { user_id = nuser_id, placa = mPlaca })
            print("DEBUG SERVER: Resultado da query ->", json.encode(rows))

            if rows[1] then
                if rows[1].status == 0 then
                    print("DEBUG SERVER: ✅ Veículo pode ser desmanchado!")
                    desmanchando[mPlaca] = user_id
                    exports["vrp"]:setBlockCommand(user_id, 40)
                    return true
                else
                    TriggerClientEvent("Notify", source, "negado", "Este veículo já está detido/retido.", 5000)
                    print("DEBUG SERVER: 🚨 Veículo já detido/retido.")
                    return false
                end
            end
        else
            TriggerClientEvent("Notify", source, "negado", "Este veículo não possui nenhum proprietário.", 5000)
            print("DEBUG SERVER: 🚨 Veículo sem dono.")
            return false
        end
    end

    print("DEBUG SERVER: 🚨 `checkVehicleStatus` retornou NIL")
    return false
end





function RegisterTunnel.pagarDesmanche(mPlaca,mName,mPrice,mVeh)

    print(">>>  entrou")
    print("Preço: ",mPrice)

    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        print(">>>  entrou 2")
        
        local nuser_id = vRP.getUserByRegistration(mPlaca)
        
        if nuser_id then
            print(">>>  entrou 3")
            if mName == "hornet" or mName == "Hornet" then
                TriggerClientEvent("Notify",source,"negado","Este veiculo nao pode ser desmanchado.", 5000)
                return
            end
            
            if desmanchando[mPlaca] == user_id then
                print(">>>  entrou 4")
                print("Nome do carro: ",mName)



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


-- function RegisterTunnel.pagarDesmanche(mPlaca, mName, mPrice, mVeh)
--     local source = source
--     local user_id = vRP.getUserId(source)

--     print("DEBUG SERVER: Tentando pagar desmanche para Placa:", mPlaca, " | Preço:", mPrice)

--     if user_id then
--         local nuser_id = vRP.getUserByRegistration(mPlaca)
--         print("DEBUG SERVER: Proprietário do veículo ->", nuser_id)

--         if nuser_id then
--             if desmanchando[mPlaca] == user_id then
--                 print("DEBUG SERVER: ✅ Iniciando pagamento e exclusão do veículo.")

--                 exports["vrp"]:setBlockCommand(user_id, 0)
--                 vRP.execute("vRP/set_status", { user_id = nuser_id, placa = mPlaca, status = 2 })
--                 vRP.giveInventoryItem(user_id, "dinheirosujo", mPrice * 0.15, true)

--                 exports['thunder_garages']:deleteVehicle(source, mVeh)
--                 vRP._stopAnim(false)

--                 desmanchando[mPlaca] = nil
--                 vRP.sendLog("DESMANCHE", "O ID: "..user_id.." desmanchou o veículo do ID "..nuser_id.." placa: "..mPlaca.." e recebeu $ "..vRP.format(mPrice * 0.15))
--             else
--                 print("DEBUG SERVER: 🚨 ERRO! ID do jogador não bate com o do desmanche.")
--             end
--         else
--             TriggerClientEvent("Notify", source, "negado", "Este veículo não possui nenhum proprietário.", 5000)
--             print("DEBUG SERVER: 🚨 Veículo sem proprietário.")
--         end
--     end
-- end


-- local itensDesmanche = {
--     ["molas"] = 1,
-- }

-- function RegisterTunnel.checkItensD()
--     local source = source
--     local user_id = vRP.getUserId(source)
--     if user_id then
--         local mensagem = ""
--         local status = true

--         for k,v in pairs(itensDesmanche) do
--             if vRP.getInventoryItemAmount(user_id, k) < v then
--                 status = false
--                 --mensagem = mensagem .. "Você não possui "..vRP.getItemName(k).." na quantidade de "..v..".<br>"
--                 TriggerClientEvent("Notify",source,"negado","Você não possui "..vRP.getItemName(k).." na quantidade de "..v..".<br>.", 5000)
--             end

--             if status then
--                 vRP.tryGetInventoryItem(user_id, k, v) 
--             end
--         end

--          if mensagem ~= "" then
--              TriggerClientEvent("Notify",source,"negado",mensagem, 5)
--          end

--          return status
--     end
--end
 