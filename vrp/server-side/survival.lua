local cfg = module("cfg/survival")
local lang = vRP.lang

-- api alteraldo por albino

function vRP.getHunger(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    return data.hunger
  end

  return 0
end

function vRP.getThirst(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    return data.thirst
  end

  return 0
end

function vRP.setHunger(user_id,value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.hunger = value
    if data.hunger < 100 then data.hunger = 100
    elseif data.hunger > 100 then data.hunger = 100 
    end

    -- update bar
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("conexao_hud:statusHunger", source, data.hunger) -- mexi aqui
    if data.hunger >= 100 then
    else
    end
  end
end

function vRP.setThirst(user_id, value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.thirst = value
    if data.thirst < 100 then data.thirst = 100
    elseif data.thirst > 100 then data.thirst = 100 
    end

    -- update bar
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("conexao_hud:statusThirst", source, data.thirst) -- mexi aqui
    if data.thirst >= 100 then
    else
    end
  end
end

function vRP.varyHunger(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    local was_starving = data.hunger >= 100
    data.hunger = data.hunger + variation
    local is_starving = data.hunger >= 100

    -- apply overflow as damage    -------- dasativando funcão de dano pq ja esta na nui
--    local overflow = data.hunger-100
--    if overflow > 0 then
--      vRPclient._varyHealth(vRP.getUserSource(user_id),-overflow*cfg.overflow_damage_factor)
--    end

    if data.hunger < 0 then data.hunger = 0
    elseif data.hunger > 100 then data.hunger = 100 
    end

    -- set progress bar data
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("conexao_hud:statusHunger", source, data.hunger) -- eu alterei isso aqui
    if was_starving and not is_starving then
    elseif not was_starving and is_starving then
    end
  end
end

function vRP.varyThirst(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    local was_thirsty = data.thirst >= 100
    data.thirst = data.thirst + variation
    local is_thirsty = data.thirst >= 100

    -- apply overflow as damage        -------------- desativando a função de dano caso use nation hud precisara ativar
  --  local overflow = data.thirst-100
  --  if overflow > 0 then
  --    vRPclient._varyHealth(vRP.getUserSource(user_id),-overflow*cfg.overflow_damage_factor)
  --  end

    if data.thirst < 0 then data.thirst = 0
    elseif data.thirst > 100 then data.thirst = 100 
    end

    -- set progress bar data
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("conexao_hud:statusThirst", source, data.thirst) -- alterado isso aqui
    if was_thirsty and not is_thirsty then
    elseif not was_thirsty and is_thirsty then
    end
  end
end

-- tunnel api (expose some functions to clients)

function tvRP.varyHunger(variation)
  local user_id = vRP.getUserId(source)
  if user_id then
    vRP.varyHunger(user_id,variation)
  end
end

function tvRP.varyThirst(variation)
  local user_id = vRP.getUserId(source)
  if user_id then
    vRP.varyThirst(user_id,variation)
  end
end

-- tasks  ---------- sistema de deixar fome rapido ou lento

-- -- hunger/thirst increase
-- function task_update()
--   local farm_status = exports.mark_fk:farmStatus()

--   for k,v in pairs(vRP.users) do

--     print(farm_status)

--     if farm_status then
--       print("Farm ativo")
--       vRP.varyHunger(v,cfg.hunger_per_minute_fk)
--       vRP.varyThirst(v,cfg.thirst_per_minute_fk)
      
--     else
      
--       print("Farm inativo")
--       vRP.varyHunger(v,cfg.hunger_per_minute)
--       vRP.varyThirst(v,cfg.thirst_per_minute)

--     end

--   end

--   SetTimeout(60000,task_update)
-- end

function task_update()
  for k, v in pairs(vRP.users) do
      local farm_status = exports.mark_fk:farmStatus() -- Agora verificamos corretamente o status do farm
      
      if farm_status then
          -- print("Farm ativo para o jogador:", k)
          vRP.varyHunger(v, cfg.hunger_per_minute_fk)
          vRP.varyThirst(v, cfg.thirst_per_minute_fk)
      else
          -- print("Farm inativo para o jogador:", k)
          vRP.varyHunger(v, cfg.hunger_per_minute)
          vRP.varyThirst(v, cfg.thirst_per_minute)
      end
  end

  SetTimeout(60000, task_update)
end


async(function()
  task_update()
end)

-- handlers

-- init values
AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
  local data = vRP.getUserDataTable(user_id)
  if data.hunger == nil then
    data.hunger = 0
    data.thirst = 0
  end
end)

-- add survival progress bars on spawn
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  local data = vRP.getUserDataTable(user_id)

  TriggerClientEvent("nation_hud:updateBasics",source, data.hunger, data.thirst)
  vRP.setHunger(user_id, data.hunger)
  vRP.setThirst(user_id, data.thirst)
end)


