local vehData = {}

vRP.prepare('sjr/selectAll', "SELECT * FROM 0r_mechanics")
vRP.prepare('sjr/selectUnique', 'SELECT * FROM 0r_mechanics WHERE plate = @plate AND model = @model')
vRP.prepare('sjr/updateVeh', "UPDATE 0r_mechanics SET data = @data WHERE plate = @plate AND model = @model")
vRP.prepare('sjr/insertVeh', "INSERT INTO 0r_mechanics (plate, data, model) VALUES (@plate, @data, @model)")

Citizen.CreateThread(function()
    local result = vRP.query('sjr/selectAll', {})
    if #result > 0 then
        for plate, data in pairs(result) do
            vehData[data.plate..":"..data.model] = json.decode(data.data)
        end
    end
end)

addElement = function(section, data)
    if not vehData[data.plate..":"..data.model] then
        vehData[data.plate..":"..data.model] = {}
    end

    if section == "fitment" then
        vehData[data.plate..":"..data.model][section] = data.fitment
    elseif data.mod == "Stock" then
        vehData[data.plate..":"..data.model][section] = nil
    else
        vehData[data.plate..":"..data.model][section] = data.mod
    end


    local output = vRP.query('sjr/selectUnique', { plate = data.plate, model = data.model})
    if #output > 0 then
        vRP.execute('sjr/updateVeh', { plate = data.plate, model = data.model, data = json.encode(vehData[data.plate..":"..data.model])})
    else
        vRP.execute('sjr/insertVeh', { plate = data.plate, model = data.model, data = json.encode(vehData[data.plate..":"..data.model])})
    end

    TriggerClientEvent("0r-mechanic:client:updateVehData", -1, vehData)
end

RegisterServerEvent("0r-mechanic:server:syncFitment", function(vehicleId, fitmentData)
    TriggerClientEvent("0r-mechanic:client:syncFitment", -1, vehicleId, fitmentData)
end)

RegisterServerEvent("0r-mechanic:server:useNitro", function(vehicleId)
    TriggerClientEvent("0r-mechanic:client:useNitro", -1, vehicleId)
end)

RegisterServerEvent("0r-mechanic:server:addElement", addElement)

RegisterServerEvent("tunning:syncApplyMods")
AddEventHandler("tunning:syncApplyMods",function(vehicle,vehicle_tuning)
    TriggerClientEvent("tunning:applyTunning",-1,vehicle, vehicle_tuning)
end)

RegisterServerEvent("tunning:applyTunning")
AddEventHandler("tunning:applyTunning",function(vehicle,vehname,plate)
	local user_id = vRP.getUserByRegistration(plate)
	local data = vRP.getSData("custom:u"..user_id.."veh_"..tostring(vehname))
	local custom = json.decode(data)
    if custom then
		TriggerClientEvent("tunning:applyTunning",-1,vehicle, custom)
    end
end)

Citizen.CreateThread(function()

    src.checkPermission = function(perm)
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            return vRP.hasPermission(user_id, perm)
        end
        return false
    end

    src.buyComponent = function(data, mods)
        local source = source
        local xPlayer = GetPlayer(source)

        if not xPlayer then
            return
        end
        if vRP.tryFullPayment(xPlayer,data.price) then
            local nuser_id = vRP.getUserByRegistration(data.plate)
            if nuser_id then
                vRP.setSData("custom:u" .. nuser_id .. "veh_" .. tostring(data.model),json.encode(mods))
            end
            return {status = true}
        end


        Notification(Config.Locale["dont_have_money"])
        return {status = false}
    end

    src.buyBasketData = function(data, mods)
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            local type = data[1]
            local basketData = data[2]
            local currentMechanic = data[3]
            local plate = data[4]
            local model = data[5]
            local totalPrice = 0
            if next(basketData) then
                for k,v in pairs(basketData) do
                    if v.component.price then
                        totalPrice += v.component.price
                    end
                end
            end


            if vRP.tryFullPayment(user_id,totalPrice) then
                local nuser_id = vRP.getUserByRegistration(plate)
                if nuser_id then
                    vRP.setSData("custom:u" .. nuser_id .. "veh_" .. tostring(model),json.encode(mods))
                end
                return {status = true}
            end
        


            Notification(Config.Locale["dont_have_money"])
            return {status = false}
        end
        return {status = false}
    end
    src.getVehData = function()
        return vehData
    end
end)






