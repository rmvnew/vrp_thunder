
local user_id = nil

-- DESABILITAR X NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
			if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) and GetVehicleClass(vehicle) == 8 then
				timeDistance = 4
                DisableControlAction(0, 345, true)
            end
		end
		Citizen.Wait(timeDistance)
    end
end)

---- rgbcar ----

RegisterNetEvent("rbgcar")
AddEventHandler("rbgcar",function()
    rgbColor()
end)

local r = 255
local g = 0
local b = 0
local rgbStatus = 1

function rgbColor()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
     if IsEntityAVehicle(vehicle) then      
        if rgbStatus == 1 then 
            g = g + 1  
            SetVehicleModColor_1(vehicle,r,g,b)
            SetVehicleModColor_2(vehicle,r,g,b)
            SetVehicleCustomPrimaryColour(vehicle,r,g,b)
            SetVehicleCustomSecondaryColour(vehicle,r,g,b)
            SetVehicleNeonLightEnabled(vehicle,0,true)
            SetVehicleNeonLightEnabled(vehicle,1,true)
            SetVehicleNeonLightEnabled(vehicle,2,true)
            SetVehicleNeonLightEnabled(vehicle,3,true)
            SetVehicleNeonLightsColour(vehicle,r,g,b)        
            if g == 255 then 
                rgbStatus = 2
            end 
        elseif rgbStatus == 2 then 
            r = r - 1     
            SetVehicleModColor_1(vehicle,r,g,b)
            SetVehicleModColor_2(vehicle,r,g,b)
            SetVehicleCustomPrimaryColour(vehicle,r,g,b)
            SetVehicleCustomSecondaryColour(vehicle,r,g,b)
            SetVehicleNeonLightEnabled(vehicle,0,true)
            SetVehicleNeonLightEnabled(vehicle,1,true)
            SetVehicleNeonLightEnabled(vehicle,2,true)
            SetVehicleNeonLightEnabled(vehicle,3,true)
            SetVehicleNeonLightsColour(vehicle,r,g,b)        
            if r < 130 then 
                b = b + 1
            end 
    
            if r == 0 then 
                rgbStatus = 3
            end 
        elseif rgbStatus == 3 then 
            b = b + 1  
            SetVehicleModColor_1(vehicle,r,g,b)
            SetVehicleModColor_2(vehicle,r,g,b)
            SetVehicleCustomPrimaryColour(vehicle,r,g,b)
            SetVehicleCustomSecondaryColour(vehicle,r,g,b)
            SetVehicleNeonLightEnabled(vehicle,0,true)
            SetVehicleNeonLightEnabled(vehicle,1,true)
            SetVehicleNeonLightEnabled(vehicle,2,true)
            SetVehicleNeonLightEnabled(vehicle,3,true)
            SetVehicleNeonLightsColour(vehicle,r,g,b)        
            if b == 255 then 
                rgbStatus = 4
            end
        elseif rgbStatus == 4 then 
            g = g - 1    
            SetVehicleModColor_1(vehicle,r,g,b)
            SetVehicleModColor_2(vehicle,r,g,b)
            SetVehicleCustomPrimaryColour(vehicle,r,g,b)
            SetVehicleCustomSecondaryColour(vehicle,r,g,b)
            SetVehicleNeonLightEnabled(vehicle,0,true)
            SetVehicleNeonLightEnabled(vehicle,1,true)
            SetVehicleNeonLightEnabled(vehicle,2,true)
            SetVehicleNeonLightEnabled(vehicle,3,true)
            SetVehicleNeonLightsColour(vehicle,r,g,b)        
            if g < 130 then 
                r = r + 1
            end
            if g == 0 then 
                rgbStatus = 5
            end
        elseif rgbStatus == 5 then 
            r = r + 1
            
            SetVehicleModColor_1(vehicle,r,g,b)
            SetVehicleModColor_2(vehicle,r,g,b)
            SetVehicleCustomPrimaryColour(vehicle,r,g,b)
            SetVehicleCustomSecondaryColour(vehicle,r,g,b)
            SetVehicleNeonLightEnabled(vehicle,0,true)
            SetVehicleNeonLightEnabled(vehicle,1,true)
            SetVehicleNeonLightEnabled(vehicle,2,true)
            SetVehicleNeonLightEnabled(vehicle,3,true)
            SetVehicleNeonLightsColour(vehicle,r,g,b)  
            if r == 255 then 
                rgbStatus = 6
            end
        elseif rgbStatus == 6 then 
            b = b - 1
            SetVehicleModColor_1(vehicle,r,g,b)
            SetVehicleModColor_2(vehicle,r,g,b)
            SetVehicleCustomPrimaryColour(vehicle,r,g,b)
            SetVehicleCustomSecondaryColour(vehicle,r,g,b)
            SetVehicleNeonLightEnabled(vehicle,0,true)
            SetVehicleNeonLightEnabled(vehicle,1,true)
            SetVehicleNeonLightEnabled(vehicle,2,true)
            SetVehicleNeonLightEnabled(vehicle,3,true)
            SetVehicleNeonLightsColour(vehicle,r,g,b)  

            if b < 130 then 
                g = g + 1
            end 

            if b == 0 then 
                rgbStatus = 1
            end
        end  
       
        Citizen.Wait(4)
        rgbColor()
    end    
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX TRUNKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
RegisterNetEvent("target:trunkin")
AddEventHandler("target:trunkin",function()
    local ped = PlayerPedId()

    if not inTrunk then
        local vehicle = vRP.vehList(11)
        if DoesEntityExist(vehicle) then
            local trunk = GetEntityBoneIndexByName(vehicle,"boot")
            if trunk ~= -1 then
                local coords = GetEntityCoords(ped)
                local coordsEnt = GetWorldPositionOfEntityBone(vehicle,trunk)
                local distance = #(coords - coordsEnt)
                if distance <= 3.0 then
                    timeDistance = 4
                    if GetVehicleDoorAngleRatio(vehicle,5) < 0.9 and GetVehicleDoorsLockedForPlayer(vehicle,PlayerId()) ~= 1 then
                        SetCarBootOpen(vehicle)
                        SetEntityVisible(ped,false,false)
                        Citizen.Wait(750)
                        AttachEntityToEntity(ped,vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
                        inTrunk = true
                        Citizen.Wait(500)
                        SetVehicleDoorShut(vehicle,5)
                    end
                end
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONTADOR DE SALARIO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		vTunnel.rCountSalario()
		Citizen.Wait(300*1000)
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR DE BANCO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegisterTunnel.seatPlayer(index)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)

    if IsEntityAVehicle(vehicle) and IsPedInAnyVehicle(ped) then
        if parseInt(index) <= 1 or index == nil then
            seat = -1
        elseif parseInt(index) == 2 then
            seat = 0
        elseif parseInt(index) == 3 then
            seat = 1
        elseif parseInt(index) == 4 then
            seat = 2
        elseif parseInt(index) == 5 then
            seat = 3
        elseif parseInt(index) == 6 then
            seat = 4
        elseif parseInt(index) == 7 then
            seat = 5
        elseif parseInt(index) >= 8 then
            seat = 6
        end

        if IsVehicleSeatFree(vehicle,seat) then
            SetPedIntoVehicle(ped,vehicle,seat)
        end
    end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOW
-----------------------------------------------------------------------------------------------------------------------------------------
local reboque = nil
local rebocado = nil
RegisterCommand("tow",function(source,args)
    local vehicle = GetPlayersLastVehicle()
    local vehicletow = IsVehicleModel(vehicle,GetHashKey("energyrepair"))

    if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
        rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
        if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
            TriggerServerEvent("trytow",VehToNet(vehicle),VehToNet(rebocado))
        end
    end
end)

RegisterNetEvent('synctow')
AddEventHandler('synctow',function(vehid,rebid)
    if NetworkDoesNetworkIdExist(vehid) and NetworkDoesNetworkIdExist(rebid) then
        local vehicle = NetToVeh(vehid)
        local rebocado = NetToVeh(rebid)
        if DoesEntityExist(vehicle) and DoesEntityExist(rebocado) then
            if reboque == nil then
                if vehicle ~= rebocado then
                    local min,max = GetModelDimensions(GetEntityModel(rebocado))
                    AttachEntityToEntity(rebocado,vehicle,GetEntityBoneIndexByName(vehicle,"energyrepair"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
                    reboque = rebocado
                end
            else
                AttachEntityToEntity(reboque,vehicle,20,-0.5,-13.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
                DetachEntity(reboque,false,false)
                PlaceObjectOnGroundProperly(reboque)
                reboque = nil
                rebocado = nil
            end
        end
    end
end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ COR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cor",function(source,args)
    if vTunnel.checkAttachs() then
        local tinta = parseInt(args[1])
        if tinta >= 0 then
            SetPedWeaponTintIndex(PlayerPedId(),GetSelectedPedWeapon(PlayerPedId()),tinta)
        else
            TriggerEvent("Notify","negado","Você precisa especificar uma pintura válida.",5)
        end
    end
end)

RegisterNetEvent('changeWeaponColor')
AddEventHandler('changeWeaponColor', function(cor) 
    local tinta = tonumber(cor)
    local ped = PlayerPedId()
    local arma = GetSelectedPedWeapon(ped)
    if tinta >= 0 then
        SetPedWeaponTintIndex(ped,arma,tinta)
    end
 
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- /FPS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
		TriggerEvent("Notify","sucesso","Otimização Habilitada", 3000)
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
		TriggerEvent("Notify","sucesso","Otimização Desabilitada", 3000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source,args)
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","sucesso","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Chassi:</b> "..parseInt(body/10).."%<br><b>Engine:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%", 8000)
	end
end)

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- SISTEMA DE PUXAR A ARMA
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local data = {		
	["peds"] = {
	  ["mp_m_freemode_01"] = { ["components"] = { [7] = { [1] = 3, [6] = 5, [8] = 2, [42] = 43, [110] = 111, [119] = 120 }, [8] = { [16] = 18 } } },
	  ["mp_f_freemode_01"] = { ["components"] = { [7] = { [1] = 3, [6] = 5, [8] = 2, [29] = 30, [81] = 82 }, [8] = { [9] = 10 } } },
	}
}

local default_weapon = GetHashKey(data.weapon)
local active = false
local ped = nil
local currentPedData = nil
local holstered = true
local in_arena = false

RegisterNetEvent("mirtin_survival:updateArena", function(boolean)
	in_arena = boolean
end)

local skins = {
	"mp_m_freemode_01",
	"mp_f_freemode_01",
}
 
local weapons = { 
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_PISTOL_MK2",
	"WEAPON_HATCHET",
	"WEAPON_KNIFE",
	"WEAPON_FLARE",
	"WEAPON_POOLCUE",
	"WEAPON_BATTLEAXE",
	"WEAPON_BAT",
	"WEAPON_BOTTLE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_CROWBAR",
	"WEAPON_GOLFCLUB",
	"WEAPON_DAGGER",
	"WEAPON_HAMMER",
	"WEAPON_WRENCH",
	"WEAPON_SWITCHBLADE",
	"WEAPON_KNUCKLE",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_SMG_MK2",
	"WEAPON_SMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_SAWNOFFSHOTGUN",
	"AMMO_PUMPSHOTGUN_MK2",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_STUNGUN",
	"WEAPON_FIREWORK",
	"WEAPON_SNOWBALL",
	"WEAPON_BZGAS"
}

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local time = 1000  -- Definir um valor padrão maior para economizar recursos
        
        if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) and CheckSkin(ped) then
            loadAnimDict("rcmjosh4")
            loadAnimDict("weapons@pistol@")
            
            if CheckWeapon(ped) then
                if holstered then
                    TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
                    Citizen.Wait(600)
                    ClearPedTasks(ped)
                    holstered = false
                end
                time = 200  -- Menor tempo de espera quando a arma está em uso
            elseif not holstered then
                TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
                Citizen.Wait(500)
                ClearPedTasks(ped)
                holstered = true
                time = 200  -- Menor tempo de espera quando a arma está sendo guardada
            end
        end
        
        Citizen.Wait(time)
    end
end)


function table_invert(t)
  local s={}
  for k,v in pairs(t) do
    s[v]=k
  end
  return s
end

function CheckSkin(ped)
	for i = 1, #skins do
		if GetHashKey(skins[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function DisableActions(ped)
	DisableControlAction(1, 37, true)
	DisablePlayerFiring(ped, true)
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

Citizen.CreateThread(function()
    local pedHashCache = nil
    local pedDataCache = nil

    while true do
        local ped = GetPlayerPed(-1)
        local ped_hash = GetEntityModel(ped)
        local enable = false
        
        -- Verificar se o hash do ped mudou
        if ped_hash ~= pedHashCache then
            pedHashCache = ped_hash
            pedDataCache = nil
            
            -- Atualizar dados do ped se necessário
            for pedName, data in pairs(data.peds) do
                if GetHashKey(pedName) == ped_hash then 
                    enable = data.enabled ~= nil and data.enabled or true
                    pedDataCache = data
                    break
                end
            end
        else
            -- Usar dados em cache
            enable = pedDataCache and (pedDataCache.enabled ~= nil and pedDataCache.enabled or true) or false
        end

        active = enable
        Citizen.Wait(5000)
    end
end)


local last_weapon = nil
Citizen.CreateThread(function()
    while true do
        if not in_arena and active then
            local ped = GetPlayerPed(-1) -- Certifique-se de obter o ped atual sempre
            local current_weapon = GetSelectedPedWeapon(ped)

            if current_weapon ~= last_weapon then
                local pedData = currentPedData
                if pedData then
                    for component, holsters in pairs(pedData.components) do
                        local holsterDrawable = GetPedDrawableVariation(ped, component)
                        local holsterTexture = GetPedTextureVariation(ped, component)

                        local emptyHolster = holsters[holsterDrawable]
                        if emptyHolster and current_weapon == default_weapon then
                            SetPedComponentVariation(ped, component, emptyHolster, holsterTexture, 0)
                        else
                            local filledHolster = table_invert(holsters)[holsterDrawable]
                            if filledHolster and current_weapon ~= default_weapon and last_weapon == default_weapon then
                                SetPedComponentVariation(ped, component, filledHolster, holsterTexture, 0)
                            end
                        end
                    end
                end
                last_weapon = current_weapon
            end
        end
        Citizen.Wait(500)
    end
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FIX LIMBO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local garagens = {
	{ 213.90,-809.08,31.01},
	{ 596.69,91.42,93.12},
	{ 275.41,-345.24,45.17},
	{ 56.08,-876.53,30.65},
	{ -348.95,-874.39,31.31},
	{ -340.64,266.31,85.67},
	{ -773.59,5597.57,33.60},
	{ 317.17,2622.99,44.45},
	{ 459.6,-986.55,25.7},
	{ -1184.93,-1509.98,4.64},
	{ -73.32,-2004.20,18.27}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)  -- Aguarda 1 segundo antes de executar o próximo ciclo
        
        local ped = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(ped))

        if z < -110 and IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if vehicle then
                vTunnel._deleteVeh(VehToNet(vehicle))
                teleportPlayerProxmityCoords(x, y, z)
                TriggerEvent("Notify", "negado", "Negado", "Você caiu no limbo com seu veículo e foi teleportado para a garagem mais próxima.", 7000)
            end
        end
    end
end)


local pedlist = {
    { ['x'] = -656.65, ['y'] = -858.77, ['z'] = 24.5, ['h'] = 353.72, ['hash2'] = "cs_tom" },
    { ['x'] = 77.38, ['y'] = -1387.68, ['z'] = 29.38, ['h'] = 178.121, ['hash2'] = "a_f_y_runner_01"},
    { ['x'] = 705.58, ['y'] = -965.82, ['z'] = 30.4, ['h'] = 277.11, ['hash2'] = "mp_m_bogdangoon"},
    { ['x'] = -438.68, ['y'] = -324.54, ['z'] = 34.92, ['h'] = 152.81, ['hash2'] = "s_m_m_doctor_01"},
    { ['x'] = -1632.1, ['y'] = -1015.49, ['z'] = 13.13, ['h'] = 319.81, ['hash2'] = "s_m_y_swat_01"},
    { ['x'] = 1138.28, ['y'] = -1537.85, ['z'] = 35.38, ['h'] = 319.81, ['hash2'] = "s_m_m_scientist_01"},
}

CreateThread(function()
    for _, v in ipairs(pedlist) do
        local model = GetHashKey(v.hash2)
        RequestModel(model)
        
        while not HasModelLoaded(model) do
            Wait(100)
        end
        
        local ped = CreatePed(4, model, v.x, v.y, v.z - 1, v.h, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)


function teleportPlayerProxmityCoords(x, y, z)
    local closestCoords = nil
    local closestDistance = math.huge -- Inicializa com um valor muito alto
    
    for _, v in ipairs(garagens) do
        local distance = Vdist2(v[1], v[2], v[3], x, y, z)
        if distance < closestDistance then
            closestDistance = distance
            closestCoords = { x = v[1], y = v[2], z = v[3] }
        end
    end
    
    if closestCoords then
        SetEntityCoords(PlayerPedId(), closestCoords.x, closestCoords.y, closestCoords.z)
    end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR VEICULO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
local empurrando = false

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local posped = GetEntityCoords(ped)
        local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0)
        local rayHandle = CastRayPointToPoint(posped.x, posped.y, posped.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
        local _, _, _, _, closestVehicle = GetRaycastResult(rayHandle)
        
        if closestVehicle and not IsPedInAnyVehicle(ped, false) then
            local vehicleCoords = GetEntityCoords(closestVehicle)
            local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
            local distance = GetDistanceBetweenCoords(vehicleCoords, posped, false)
            
            if distance < 6.0 then
                Vehicle.Coords = vehicleCoords
                Vehicle.Dimensions = dimension
                Vehicle.Vehicle = closestVehicle
                Vehicle.Distance = distance
                
                local forwardVector = GetEntityForwardVector(closestVehicle)
                local vehicleFront = vehicleCoords + forwardVector
                local vehicleRear = vehicleCoords - forwardVector
                
                Vehicle.IsInFront = GetDistanceBetweenCoords(vehicleFront, posped, true) < GetDistanceBetweenCoords(vehicleRear, posped, true)
            else
                Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
            end
        else
            Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
        end
        
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    local lerpCurrentAngle = 0.0
    while true do 
        local ped = PlayerPedId()
        local time = 1000
        
        if Vehicle.Vehicle then
            time = 5
            
            if IsControlPressed(0, 244) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) then
                NetworkRequestControlOfEntity(Vehicle.Vehicle)

                local attachPos = Vehicle.IsInFront and vector3(0.0, Vehicle.Dimensions.y * -1 + 0.1, Vehicle.Dimensions.z + 1.0) or vector3(0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z + 1.0)
                AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(ped, 6286), attachPos.x, attachPos.y, attachPos.z, 0.0, 0.0, Vehicle.IsInFront and 180.0 or 0.0, 0.0, false, false, true, false, true)
                
                if not empurrando then
                    empurrando = true
                    RequestAnimDict('missfinale_c2ig_11')
                    TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                end
                
                Citizen.Wait(200)
                
                while IsControlPressed(0, 244) do
                    Citizen.Wait(5)
                    
                    local speed = GetFrameTime() * 50
                    if IsDisabledControlPressed(0, 34) then
                        lerpCurrentAngle = lerpCurrentAngle + speed
                    elseif IsDisabledControlPressed(0, 9) then
                        lerpCurrentAngle = lerpCurrentAngle - speed
                    else
                        if math.abs(lerpCurrentAngle) > 0.02 then
                            lerpCurrentAngle = lerpCurrentAngle + (lerpCurrentAngle > 0 and -speed or speed)
                        else
                            lerpCurrentAngle = 0.0
                        end
                    end
                    
                    lerpCurrentAngle = math.clamp(lerpCurrentAngle, -15.0, 15.0)
                    SetVehicleSteeringAngle(Vehicle.Vehicle, lerpCurrentAngle)
                    SetVehicleForwardSpeed(Vehicle.Vehicle, Vehicle.IsInFront and -1.0 or 1.0)
                    
                    if HasEntityCollidedWithAnything(Vehicle.Vehicle) then
                        SetVehicleOnGroundProperly(Vehicle.Vehicle)
                    end
                end
                
                empurrando = false
                DetachEntity(ped, false, false)
                StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                FreezeEntityPosition(ped, false)
            end
        end
        
        Citizen.Wait(time)
    end  
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 150)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.01 + factor, 0.03, 0, 0, 0, 80)
end

-- Função auxiliar para limitar valores
function math.clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSME
-----------------------------------------------------------------------------------------------------------------------------------------
local showMe = {}
local flagged       = false
RegisterNetEvent("vrp_player:pressMe")
AddEventHandler("vrp_player:pressMe",function(source,text,v)
	local pedSource = GetPlayerFromServerId(source)
	if pedSource ~= -1 then
		blocks = {"font size=", "font size =", "<font", "size=", "<font size=", "<font size =", "width", "zoom", "transform: scale(", "transform:"}
		for i = 1,#blocks do 
			if string.match(string.lower(text),blocks[i]) then 
			  flagged = true 
			end
		end
		if flagged then 
			flagged = false
			return
		else
			flagged = false
			showMe[GetPlayerPed(pedSource)] = { text,v[1],v[2],v[3],v[4],v[5] }
		end

	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOWMEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        
        for k, v in pairs(showMe) do
            local entityCoords = GetEntityCoords(k)
            local distance = #(pedCoords - entityCoords)
            
            if distance <= 5.0 then
                timeDistance = 4
                
                if HasEntityClearLosToEntity(ped, k, 17) then
                    showMe3D(entityCoords.x, entityCoords.y, entityCoords.z + 0.3, string.upper(v[1]), v[3], v[4], v[5], v[6])
                end
            end
        end
        
        Citizen.Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRHEADSHOWMETIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local currentTime = GetGameTimer()
        
        for k, v in pairs(showMe) do
            if v[2] > 0 then
                v[2] = v[2] - 1
                if v[2] <= 0 then
                    showMe[k] = nil
                end
            end
        end
        
        -- Usar o tempo de espera em relação ao tempo atual
        Citizen.Wait(1000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWME3D
-----------------------------------------------------------------------------------------------------------------------------------------
function showMe3D(x,y,z,text,h,back,color,opacity)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 375) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ABRIR PORTAS DO VEICULO ]------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("portas",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		if parseInt(args[1]) == 5 then
			TriggerServerEvent("trytrunk",VehToNet(vehicle))
		else
			TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
		end
	end
end)

RegisterKeyMapping('portas 5', 'Abrir Porta Malas', 'keyboard', 'PageUp')

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ABRE E FECHA OS VIDROS ]-------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterCommand("vidros",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent('target:vidros')
AddEventHandler('target:vidros', function()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if vidros then
					vidros = false
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				else
					vidros = true
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ABRIR CAPO DO VEICULO ]--------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('target:capo')
AddEventHandler('target:capo', function()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------
-----MORRER COM UM TIRO NA CABECA-----
----------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
--     local ped = PlayerPedId()
--     SetPedSuffersCriticalHits(ped, true)
    
--     while true do
--         Citizen.Wait(5000)  -- Ajuste o intervalo conforme necessário
--     end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinmenu")
AddEventHandler("skinmenu",function(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(),mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end)

local enableMessages = true
local timeout = 10 * 3000 * 120 -- de ms, para sec, para min
local messageTemplate = '<div style="display:flex;align-items:center;justify-content:center;padding:10px;margin:5px 0;background-image: linear-gradient(to right, rgba(89, 48, 192,0.8) 3%, rgba(89, 48, 192,0) 95%);border-radius: 5px;"><b>DIGITE /BOX PARA RECEBER PRÊMIOS E ITENS EXCLUSIVOS</b></div>'

Citizen.CreateThread(function()
    while true do
        if enableMessages then
            TriggerEvent('chat:addMessage', { template = messageTemplate })
        end
        Citizen.Wait(timeout)
    end
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE GRAU
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- local comecar = false
-- local dict = "rcmextreme2atv"
-- local anims = {
--     "idle_b",
--     "idle_c",
--     "idle_d",
--     "idle_e"
-- }

-- local function loadAnimDict(dict)
--     RequestAnimDict(dict)
--     while not HasAnimDictLoaded(dict) do
--         Citizen.Wait(0)
--     end
-- end

-- Citizen.CreateThread(function()
--     loadAnimDict(dict)

--     while true do
--         Citizen.Wait(1000) -- Define um tempo de espera padrão maior para reduzir a carga do loop
        
--         local ped = PlayerPedId()
--         local bike = GetVehiclePedIsIn(ped)
        
--         if comecar and IsPedOnAnyBike(ped) and GetEntitySpeed(bike) * 3.6 >= 5 then
--             if IsControlJustPressed(0, 174) or IsControlJustPressed(0, 108) then
--                 TaskPlayAnim(ped, dict, anims[1], 8.0, -8.0, -1, 32, 0, false, false, false)
--             elseif IsControlJustPressed(0, 175) or IsControlJustPressed(0, 107) then
--                 TaskPlayAnim(ped, dict, anims[2], 8.0, -8.0, -1, 32, 0, false, false, false)
--             elseif IsControlJustPressed(0, 173) or IsControlJustPressed(0, 110) then
--                 TaskPlayAnim(ped, dict, anims[3], 8.0, -8.0, -1, 32, 0, false, false, false)
--             elseif IsControlJustPressed(0, 27) or IsControlJustPressed(0, 111) then
--                 TaskPlayAnim(ped, dict, anims[4], 8.0, -8.0, -1, 32, 0, false, false, false)
--             end
--         end
--     end
-- end)

-- RegisterCommand("manobras", function()
--     comecar = not comecar
--     local message = comecar and "Você está preparado para fazer as manobras" or "Você parou de fazer manobras"
--     local messageType = comecar and "sucesso" or "negado"
--     TriggerEvent("Notify", messageType, "Aviso", message, 5000)
-- end)

-- function drawTxt(text, font, x, y, scale, r, g, b, a)
--     SetTextFont(font)
--     SetTextScale(scale, scale)
--     SetTextColour(r, g, b, a)
--     SetTextOutline()
--     SetTextCentre(true)
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(x, y)
-- end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VÁRIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local message = 0
local deitadoMaca = 0
cabeca = nil
peito = nil
calca = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmascara')
AddEventHandler('setmascara',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if modelo == nil then
			vRP._playAnim(true,{{"missfbi4","takeoff_mask"}},false)
			Citizen.Wait(1100)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Citizen.Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setblusa')
AddEventHandler('setblusa',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,8,parseInt(modelo),parseInt(cor),2)
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SET COLETE USER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setMochila")
AddEventHandler("setMochila",function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if modelo == nil then
			Citizen.Wait(1100)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,5,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Citizen.Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,5,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET COLETE USER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setColeteUser")
AddEventHandler("setColeteUser",function(modelo,cor)
    local ped = PlayerPedId()
    if not modelo then
        ClearPedTasks(ped)
        SetPedComponentVariation(ped,9,1,1,2)
    end
    if modelo then
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            vRP._playAnim(true,{{"oddjobs@basejump@ig_15","puton_parachute"}},false)
            Citizen.Wait(2500)
            ClearPedTasks(ped)
            SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
            vRP._playAnim(true,{{"oddjobs@basejump@ig_15","puton_parachute"}},false)
            Citizen.Wait(2500)
            ClearPedTasks(ped)
            SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE COLETE USER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("removeColeteUser")
AddEventHandler("removeColeteUser",function()
	local ped = PlayerPedId()
    ClearPedTasks(ped)
    SetPedComponentVariation(ped,9,0,0,2)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setjaqueta')
AddEventHandler('setjaqueta',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP._playAnim(false,{{"clothingshirt", "try_shirt_positive_d"}},true)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{{"clothingshirt", "try_shirt_positive_d"}},true)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{{"clothingshirt", "try_shirt_positive_d"}},true)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,11,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaos')
AddEventHandler('setmaos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP._playAnim(false,{{"clothingshirt", "try_shirt_positive_d"}},true)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,15,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{{"clothingshirt", "try_shirt_positive_d"}},true)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{{"clothingshirt", "try_shirt_positive_d"}},true)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,3,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaose')
AddEventHandler('setmaose',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			ClearPedProp(ped,6)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedPropIndex(ped,6,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedPropIndex(ped,6,parseInt(modelo),parseInt(cor),2)
		end	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMAOSD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setmaosd')
AddEventHandler('setmaosd',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			ClearPedProp(ped,7)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedPropIndex(ped,7,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedPropIndex(ped,7,parseInt(modelo),parseInt(cor),2)
		end	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCALCA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setcalca')
AddEventHandler('setcalca',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(false,{{"clothingtrousers", "try_trousers_neutral_c"}},true)
				Citizen.Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(false,{{"clothingtrousers", "try_trousers_neutral_c"}},true)
				Citizen.Wait(2500)
				ClearPedTasks(ped)
				SetPedComponentVariation(ped,4,15,0,2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{{"clothingtrousers", "try_trousers_neutral_c"}},true)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{{"clothingtrousers", "try_trousers_neutral_c"}},true)
			Citizen.Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,4,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETACESSORIOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setacessorios')
AddEventHandler('setacessorios',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			SetPedComponentVariation(ped,7,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,7,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSAPATOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setsapatos')
AddEventHandler('setsapatos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped) then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then

				vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
				Citizen.Wait(2200)
				SetPedComponentVariation(ped,6,34,0,2)
				Citizen.Wait(500)
				ClearPedTasks(ped)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
				Citizen.Wait(2200)
				SetPedComponentVariation(ped,6,35,0,2)
				Citizen.Wait(500)
				ClearPedTasks(ped)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
			Citizen.Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Citizen.Wait(500)
			ClearPedTasks(ped)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
			Citizen.Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Citizen.Wait(500)
			ClearPedTasks(ped)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setchapeu')
AddEventHandler('setchapeu',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP._playAnim(true,{{"veh@common@fp_helmet@","take_off_helmet_stand"}},false)
			Citizen.Wait(700)
			ClearPedProp(ped,0)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet"}},false)
			Citizen.Wait(1700)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet"}},false)
			Citizen.Wait(1700)
			SetPedPropIndex(ped,0,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setoculos')
AddEventHandler('setoculos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP._playAnim(true,{{"mini@ears_defenders","takeoff_earsdefenders_idle"}},false)
			Citizen.Wait(500)
			ClearPedTasks(ped)
			ClearPedProp(ped,1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Citizen.Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Citizen.Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped,1,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSTICKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setsticker')
AddEventHandler('setsticker',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if not modelo then
			vRP._playAnim(true,{{"mini@ears_defenders","takeoff_earsdefenders_idle"}},false)
			Citizen.Wait(500)
			ClearPedTasks(ped)
			ClearPedProp(ped,10)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Citizen.Wait(800)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,10,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps"}},false)
			Citizen.Wait(800)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,10,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /BVIDA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bvida', function(source, args, rawCommand)
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 and not IsEntityPlayingAnim(ped, "anim@heists@ornate_bank@grab_cash_heels","grab", 3)  then
        if not IsEntityPlayingAnim(ped, "oddjobs@shop_robbery@rob_till","loop", 3) then
            if not IsEntityPlayingAnim(ped, "amb@world_human_sunbathe@female@back@idle_a","idle_a", 3) then
                TriggerServerEvent('bvida')
            end
        end
    end
end)
--------------------------------------------------
-- MUDAR A COR DO TAB
--------------------------------------------------
-- Define a cor do HUD com um código hexadecimal de vermelho
ReplaceHudColour(116, 27) --27 vermelho 21 roxo

-- Obtém o PlayerPedId e o nome do jogador
local ped = PlayerPedId()
local nome = GetPlayerName(ped)

-- Adiciona uma entrada de texto ao HUD com o nome do servidor e o link do Discord
AddTextEntry('FE_THDR_GTAO', '~r~thunder City ~r~| ~s~ Discord.gg/9VZPu26h')

--------------------------------------------------
-- /p1
--------------------------------------------------
RegisterCommand("p1",function(source,args,rawCommand)
    if IsPedInAnyVehicle(PlayerPedId()) then
        TriggerServerEvent("logSit", "p1")
            SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId()), -1)
    end
end)
RegisterCommand("p2",function(source,args,rawCommand)
    if IsPedInAnyVehicle(PlayerPedId()) then
        TriggerServerEvent("logSit", "p2")
            SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId()), 0)
    end
end)
RegisterCommand("p3",function(source,args,rawCommand)
    if IsPedInAnyVehicle(PlayerPedId()) then
        TriggerServerEvent("logSit", "p3")
            SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId()), 1)
    end
end)

RegisterCommand("p4",function(source,args,rawCommand)
    if IsPedInAnyVehicle(PlayerPedId()) then
        TriggerServerEvent("logSit", "p4")
            SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId()), 2)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MODOS DE ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
-- Variável de controle para animações
local prisioneiro = false

-- Lista de comandos e animações
local animations = {
    ["homem"] = "move_m@confident",
    ["mulher"] = "move_f@heels@c",
    ["depressivo"] = "move_m@depressed@a",
    ["depressiva"] = "move_f@depressed@a",
    ["empresario"] = "move_m@business@a",
    ["determinado"] = "move_m@brave@a",
    ["descontraido"] = "move_m@casual@a",
    ["farto"] = "move_m@fat@a",
    ["estiloso"] = "move_m@hipster@a",
    ["ferido"] = "move_m@injured",
    ["nervoso"] = "move_m@hurry@a",
    ["desleixado"] = "move_m@hobo@a",
    ["infeliz"] = "move_m@sad@a",
    ["musculoso"] = "move_m@muscle@a",
    ["desligado"] = "move_m@shadyped@a",
    ["fadiga"] = "move_m@buzzed",
    ["apressado"] = "move_m@hurry_butch@a",
    ["descolado"] = "move_m@money",
    ["corridinha"] = "move_m@quick",
    ["piriguete"] = "move_f@maneater",
    ["petulante"] = "move_f@sassy",
    ["arrogante"] = "move_f@arrogant@a",
    ["bebado"] = "move_m@drunk@slightlydrunk",
    ["bebado2"] = "move_m@drunk@verydrunk",
    ["bebado3"] = "move_m@drunk@moderatedrunk",
    ["irritado"] = "move_m@fire",
    ["intimidado"] = "move_m@intimidation@cop@unarmed",
    ["poderosa"] = "move_f@handbag",
    ["chateado"] = "move_f@injured",
    ["estilosa"] = "move_f@posh@",
    ["sensual"] = "move_f@sexy@a"
}


local function loadAnimation(animSet)
    if not prisioneiro then
        vRP.loadAnimSet(animSet)
    end
end


for command, animSet in pairs(animations) do
    RegisterCommand(command, function()
        loadAnimation(animSet)
    end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPEC
-----------------------------------------------------------------------------------------------------------------------------------------

local spectating = false
local targetPlayer = nil

function toggleSpectate(target)
    local playerPed = PlayerPedId()
    if target then
        spectating = true
        targetPlayer = target
        local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

        if targetPed then
            NetworkSetInSpectatorMode(true, targetPed)
            SetEntityVisible(playerPed, false, 0)
            SetEntityInvincible(playerPed, true)
            ShowNotification("Você está agora no modo espectador.")
        else
            ShowNotification("Não foi possível encontrar o ped do jogador alvo.")
        end
    else
        spectating = false
        targetPlayer = nil
        NetworkSetInSpectatorMode(false, playerPed)
        SetEntityVisible(playerPed, true, 0)
        SetEntityInvincible(playerPed, false)
        ShowNotification("Você saiu do modo espectador.")
    end
end

RegisterNetEvent('toggleSpec')
AddEventHandler('toggleSpec', function(target)
    toggleSpectate(target)
end)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end





--[ PLATES ]-------------------------------------------------------------------------------------------------
--[ PLACAS ]-------------------------------------------------------------------------------------------------
local imageUrl = "https://cdn.discordapp.com/attachments/683792195530260608/764909905827463168/mercosul.png"

-- Função para substituir texturas de placas
local function updateLicensePlates()
    local textureDic = CreateRuntimeTxd('duiTxd')
    local object = CreateDui(imageUrl, 540, 300)
    local handle = GetDuiHandle(object)
    CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex", handle)
    AddReplaceTexture('vehshare', 'plate01', 'duiTxd', 'duiTex')
    AddReplaceTexture('vehshare', 'plate02', 'duiTxd', 'duiTex')
    AddReplaceTexture('vehshare', 'plate03', 'duiTxd', 'duiTex') 
    AddReplaceTexture('vehshare', 'plate04', 'duiTxd', 'duiTex')
    AddReplaceTexture('vehshare', 'plate05', 'duiTxd', 'duiTex')

    local object = CreateDui('https://i.imgur.com/Q3uw6V7.png', 540, 300)
    local handle = GetDuiHandle(object)
    CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex2", handle)
    AddReplaceTexture('vehshare', 'plate01_n', 'duiTxd', 'duiTex2')
    AddReplaceTexture('vehshare', 'plate02_n', 'duiTxd', 'duiTex2')
    AddReplaceTexture('vehshare', 'plate03_n', 'duiTxd', 'duiTex2') 
    AddReplaceTexture('vehshare', 'plate04_n', 'duiTxd', 'duiTex2')
    AddReplaceTexture('vehshare', 'plate05_n', 'duiTxd', 'duiTex2')
end

RegisterNetEvent("updateLicensePlates")
AddEventHandler("updateLicensePlates", function()
    updateLicensePlates()
end)





-----------------------------------------------------------------------------------------------------------------------------------------
-- sistema de texto
-----------------------------------------------------------------------------------------------------------------------------------------

local displayedTexts = {} -- Tabela para armazenar textos ativos no cliente

-- Função para desenhar o texto e o emoji na tela
local function drawText3DWithEmoji(x, y, z, emoji, text, color)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    
    -- Ajustar a escala do texto
    SetTextScale(0.35, 0.35)  -- Tamanho do emoji
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(color[1], color[2], color[3], color[4])
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(emoji)
    DrawText(_x, _y - 0.03) -- Mover o emoji um pouco para cima do texto

    -- Diminuir o tamanho do texto
    SetTextScale(0.27, 0.29)  -- Tamanho do texto
    SetTextColour(color[1], color[2], color[3], color[4])
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    DrawRect(_x, _y + 0.0125, 0.0, 0.0, 0.0, 75) -- Rect de fundo para melhor legibilidade
end

-- Evento para exibir o texto /me com emoji
RegisterNetEvent("vrp_player:showMeText")
AddEventHandler("vrp_player:showMeText", function(playerSource, text, emoji, color)
    -- Armazenar o texto, emoji e as informações do jogador
    displayedTexts[playerSource] = { emoji = emoji, text = text, color = color }
end)

-- Evento para remover o texto /me
RegisterNetEvent("vrp_player:removeMeText")
AddEventHandler("vrp_player:removeMeText", function(playerSource)
    displayedTexts[playerSource] = nil -- Remover o texto da tabela
end)

-- Loop contínuo para desenhar os textos e emojis fixos
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Intervalo padrão
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for playerSource, info in pairs(displayedTexts) do
            local targetPed = GetPlayerPed(GetPlayerFromServerId(playerSource))
            if targetPed and targetPed ~= -1 then
                local targetCoords = GetEntityCoords(targetPed)
                local distance = #(playerCoords - targetCoords)
                if distance <= 5.0 then -- Verifica se o jogador está próximo
                    drawText3DWithEmoji(targetCoords.x, targetCoords.y, targetCoords.z + 1.0, info.emoji, info.text, info.color)
                else
                    displayedTexts[playerSource] = nil -- Remove texto se o jogador estiver longe
                end
            else
                displayedTexts[playerSource] = nil -- Remove texto se o jogador não existir
            end
        end
    end
end)

-- Evento para exibir o texto para um jogador
RegisterNetEvent("textoplayer")
AddEventHandler("textoplayer", function(texto, emoji)
    local source = source -- Obtém o ID do jogador que acionou o evento
    TriggerEvent("vrp_player:showMeText", source, texto, emoji, {10, 250, 0, 255})
end)

RegisterNetEvent('me:foxzin')
AddEventHandler('me:foxzin', function()
    TriggerServerEvent("me:foxzinServer")  -- Chama o evento do servidor
end)

RegisterNetEvent('me:tirar')
AddEventHandler('me:tirar', function()
    TriggerServerEvent("me:tirarServer")  -- Chama o evento do servidor
end)


