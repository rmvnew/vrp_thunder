function tvRP.varyHealth(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped)+variation)
	SetEntityHealth(ped,n)
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GETHEALTH ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getHealth()
	return GetEntityHealth(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SETHEALTH ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setHealth(health)
	print("1 - Life inicial: ",health)
	SetEntityHealth(PlayerPedId(),parseInt(health))
end

function tvRP.setHealthspawn(health)
	print("2 - Life inicial: ",health)
	local ped = PlayerPedId()
	SetPedMaxHealth(ped,400)
	SetEntityHealth(ped,parseInt(health))
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ SETFRIENDLYFIRE ]--------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setFriendlyFire(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(),flag,flag)
end

-- [ FOME & SEDE ] --

function tvRP.sedeFome()
	vRPserver.varyHunger(100)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(6000)
		if IsPlayerPlaying(PlayerId()) then
			local ped = PlayerPedId()
			local vthirst = 0.10
			local vhunger = 0.7

			if IsPedOnFoot(ped) then
				local factor = math.min(tvRP.getSpeed(),10)

				vthirst = vthirst+0.2*factor
				vhunger = vhunger+0.2*factor
			end

			if IsPedInMeleeCombat(ped) then
				vthirst = vthirst+10
				vhunger = vhunger+5
			end

			if IsPedHurt(ped) or IsPedInjured(ped) then
				vthirst = vthirst+3
				vhunger = vhunger+2
			end

			if vthirst > 0 then
				vRPserver.varyThirst(vthirst/12.0)
			end

			if vhunger > 0 then
				vRPserver.varyHunger(vhunger/12.0)
			end

		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ NOCAUTEVAR ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local nocauteado = false

-----------------------------------------------------------------------------------------------------------------------------------------
--[ ISINCOMA ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.isInComa()
	local ped = PlayerPedId()
	local nocauteado = false
	if GetEntityHealth(ped) == 0 then nocauteado = true end
	return nocauteado
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ NETWORKRESSURECTION ]----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.killGod()
	-- exports["pma-voice"]:toggleMute()
	nocauteado = false
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	NetworkResurrectLocalPlayer(x,y,z,true,true,false)
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,110)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
	TriggerEvent("nRevive")
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ NETWORKPRISON ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PrisionGod()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 1 then
		-- exports["pma-voice"]:toggleMute() 
		nocauteado = false
		ClearPedBloodDamage(ped)
		SetEntityInvincible(ped,false)
		SetEntityHealth(ped,110)
		ClearPedTasks(ped)
		ClearPedSecondaryTask(ped)
	end
end