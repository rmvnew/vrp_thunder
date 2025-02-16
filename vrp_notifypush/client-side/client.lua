-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

DLGRP = {}
DLGRP = Tunnel.getInterface("vrp_notifypush")

-----------------------------------------------------------------------------------------------------------------------------------------
-- Variaveis
-----------------------------------------------------------------------------------------------------------------------------------------

local DENY_NOTIFYS_CONTENT_CREATOR = {
	['limpezavhe'] = true,
	['staff'] = true,
	['adm-id'] = true,
	['dm-staff'] = true
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY-HISTORIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notify",function(source,args)
	--if DLGRP.checkPermissionPolicia() then 
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showAll" })
	--end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("notify","Abrir as notificações","keyboard","f3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
local maxNotifys = 5
local notifys = {}

RegisterNetEvent("Notify")
AddEventHandler("Notify",function(type, mensagem, timer, send, cod, loc, criminal, type2)
	if #notifys >= maxNotifys then return end

        table.insert(notifys, type)
        SetTimeout(5000, function()
            for i, notify in ipairs(notifys) do
                if notify == type then
                    table.remove(notifys, i)
                    break
                end
            end
        end)

	if LocalPlayer.state.in_arena_event then
		return
	end
	
	if not mensagem or not type then
		return
	end
	if LocalPlayer.state['content-creator'] and DENY_NOTIFYS_CONTENT_CREATOR[type] then 
		return
	end

	local idGenerated = 0
	mensagem = mensagem:gsub("<bold>", "")
	if mensagem then
		idGenerated = string.sub(mensagem, 1, 10)
	else
		idGenerated = string.sub(criminal, 1, 10)
	end
	idGenerated = idGenerated .. type .. string.sub(mensagem, 1, 5) .. GetGameTimer()

	local notifyID = string.gsub(idGenerated, "%s+", "")
	notifyID = string.gsub(notifyID, "%W", "")
	local data = {
			["type"] = type,
			["time"] = timer,
			["message"] = mensagem,
			["name"] = send,
			["cod"] = cod,
			["loc2"] = loc,
			["criminal"] = criminal,
			["id"] = notifyID,
		}
		
		if(type == "pizza" or type == "anunciohp" or type == "anuncioeb" or type == "qru" or type == "chamadoemergencia" or type == "qth" or type == "festinha" or type == "Caixa Eletronico" or type == "AmmuNation" or type == "Lojinha" or type == "Central" or type == "Açougue" or type == "Galinheiro" or type == "Paleto") then
			data.loc = GetStreetNameFromHashKey(GetStreetNameAtCoord(loc.x,loc.y,loc.z))
			local zone = GetZoneAtCoords(loc.x,loc.y,loc.z)
			if zone == 1321 then return end
			
			if data.type == "qru" then -- CHECK PROXIMITY
				local plyCoords = GetEntityCoords(PlayerPedId())
				if #(plyCoords - vec3(data.loc2.x,data.loc2.y,data.loc2.z)) > 2500 then
					return
				end
			end

			SendNUIMessage({ action = "notify", data = data, config = type  })
			createQruBlips(data)
		else
			if type == "perimetro" then
				data.loc = GetStreetNameFromHashKey(GetStreetNameAtCoord(loc.x,loc.y,loc.z))
				createPerimetroBlips(data)
			end
			SendNUIMessage({ action = "notify", data = data, config = type, type2 = type2  })
			--PlaySoundFrontend(-1,"Event_Message_Purple","GTAO_FM_Events_Soundset",false)
		end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE-BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function createPerimetroBlips(data)
	local blip = AddBlipForRadius(data.loc2.x,data.loc2.y,data.loc2.z, 200.0)
	local blip2 = AddBlipForCoord(data.loc2.x,data.loc2.y,data.loc2.z)
	SetBlipSprite(blip2, 161)
	SetBlipScale(blip2, 1.0)
	SetBlipAlpha(blip2, 80)
	SetBlipColour(blip2, 3)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('PERIMETRO FECHADO')
	EndTextCommandSetBlipName(blip2)
	SetBlipColour(blip, 1)
    SetBlipAlpha(blip,80)
	SetTimeout(80 * 1000,function()
		RemoveBlip(blip)
		RemoveBlip(blip2)
	end)
end

function createQruBlips(data)
	if data.type == "qth" then return end
	local blip = AddBlipForCoord(data.loc2.x,data.loc2.y,data.loc2.z)
	if data.type == "qru" then
		SetBlipSprite(blip, 304)
		SetBlipColour(blip, 5)
	elseif data.type == "festinha" then
		SetBlipSprite(blip,614)
		SetBlipColour(blip,5)
	elseif data.type == "chamadoemergencia" then
		SetBlipSprite(blip,84)
		SetBlipColour(blip,8)
	elseif data.type == "pizza" then
		SetBlipSprite(blip,764)
		SetBlipColour(blip,5)
	elseif data.type == "anunciohp" then
		SetBlipSprite(blip,96)
		SetBlipColour(blip,8)
	else
		SetBlipSprite(blip,304)
		SetBlipColour(blip,5)
	end

	SetBlipAsShortRange(blip,true)
	SetBlipScale(blip,0.8)
	BeginTextCommandSetBlipName("STRING")
	if data.type == "festinha" then
		AddTextComponentString("Festinha 🥳")
	elseif data.type == "pizza" then
		AddTextComponentString("Recrutamento")
	elseif data.type == "chamadoemergencia" then
		AddTextComponentString("CE-Cidadão Desacordado")
	elseif data.type == "anunciohp" then
		AddTextComponentString("Anuncio HP")
	else
		AddTextComponentString(data.criminal)
	end
	EndTextCommandSetBlipName(blip)
	SetTimeout(60 * 1000,function()
		RemoveBlip(blip)
	end)

	if parseInt(data.code) == 13 then
		PlaySoundFrontend(-1,"Enter_Area","DLC_Lowrider_Relay_Race_Sounds")
		Citizen.Wait(500)
		PlaySoundFrontend(-1,"Enter_Area","DLC_Lowrider_Relay_Race_Sounds")
		Citizen.Wait(500)
		PlaySoundFrontend(-1,"Enter_Area","DLC_Lowrider_Relay_Race_Sounds")
	elseif parseInt(data.code) == 10 then
		PlaySoundFrontend(-1,"Lose_1st","GTAO_FM_Events_Soundset",false)
	elseif parseInt(data.code) == 32 then
		PlaySoundFrontend(-1,"CHALLENGE_UNLOCKED","HUD_AWARDS",false)
	elseif parseInt(data.code) == 38 then
		PlaySoundFrontend(-1,"Beep_Red","DLC_HEIST_HACKING_SNAKE_SOUNDS",false)
	elseif parseInt(data.code) == 50 then
		PlaySoundFrontend(-1,"OOB_Cancel","GTAO_FM_Events_Soundset",false)
	elseif parseInt(data.code) == 72 then
		PlaySoundFrontend(-1,"MP_IDLE_TIMER","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
	else
		PlaySoundFrontend(-1,"Event_Message_Purple","GTAO_FM_Events_Soundset",false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- InputText
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("InputText")
AddEventHandler("InputText",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "inputText" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyRemove")
AddEventHandler("NotifyRemove",function(id)
	SendNUIMessage({ action = "NotifyRemove", id = id })
end)


RegisterNetEvent("syncNotify", function(data)
	config = data
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function()
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setWay",function(data)
	if data.x then
		SetNewWaypoint(data.x+0.0001,data.y+0.0001)
		SendNUIMessage({ action = "hideAll" })
	end
end)
RegisterNUICallback("setWay2",function(data)
	if data.x then
		SetNewWaypoint(data.x+0.0001,data.y+0.0001)
		SendNUIMessage({ action = "hideAll" })
		TriggerEvent("Notify","sucesso","Localização marcada em seu mapa")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("removeNotify",function(data)
	DLGRP.removeNotify( data.id )
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("phoneCall",function(data)
	SendNUIMessage({ action = "hideAll" })
	TriggerEvent("gcPhone:callNotifyPush",data.phone)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURN-TEXT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("returnText",function(data)
	SetNuiFocus(false,false)
	DLGRP.swalAnuncio(data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY-EDIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciar",function(source,args)
	if DLGRP.checkPermissionStaff() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "config" })
	else
		TriggerEvent("Notify","negado","Você não tem permissão para executar esse comando.")
	end
end)
RegisterCommand("logs",function(source,args)
	if DLGRP.checkPermissionStaff() then 
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "logs"})
	else
		TriggerEvent("Notify","negado","Você não tem permissão para executar esse comando.")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- saveCfg
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saveCfg",function(data)
	if DLGRP.checkPermissionOwner() then 
	DLGRP.saveCfg(data)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendNotify",function(data, cb)
	DLGRP.sendNotify(data.type, data.text, data.perms)
	cb(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
-- AddStateBagChangeHandler('notifyConfig', 'global', function(_bagName, _key, _value) -- New handler
--     config = _value
-- 	print("Notify Config Updated")
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEW NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("previewNotify",function(data)
	TriggerEvent("Notify",data.mec, data.text.."<br><br>Mecanico(a): Nome Mecanico ", 10000, _, _, { x = 1, y = 2, z = 3 }, _)
end)



