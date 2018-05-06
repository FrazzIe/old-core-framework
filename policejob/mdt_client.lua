-- Settings
local guiEnabled = false
local hasOpened = false
local lstWarrants = {}
local lstMDT = {}

-- Open Gui and Focus NUI
function openGui()
  SetPlayerControl(PlayerId(), 0, 0)
  guiEnabled = true
  SetNuiFocus(true, true)
  SendNUIMessage({openWarrants = true})
  if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, false);
  end

  -- If this is the first time we've opened the phone, load all warrants
  if hasOpened == false then
    lstContacts = {}
    TriggerServerEvent('warrants:load', false)
    TriggerServerEvent('mdt:load', false)
    hasOpened = true
  end
end

-- Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false, false)
  SendNUIMessage({openWarrants = false})
  guiEnabled = false
  ClearPedTasks(GetPlayerPed(-1))
  Wait(250)
  SetPlayerControl(PlayerId(), 1, 0)
end

-- Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if guiEnabled then
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

-- Opens our warrants
RegisterNetEvent('warrantsGui')
AddEventHandler('warrantsGui', function()
  openGui()
  guiEnabled = true
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNetEvent('warrants:close')
AddEventHandler('warrants:close', function()
  closeGui()
end)

-- Warrants Callbacks
RegisterNUICallback('loadWarrants', function(data, cb)
  if (#lstWarrants == 0) then
    TriggerServerEvent('warrants:load', true)
  else
    SendNUIMessage({openSection = "warrants", list = lstWarrants})
  end
  cb('ok')
end)

RegisterNUICallback('warrantRead', function(data, cb)
  SendNUIMessage({openSection = "warrantRead", id = data.id, name = data.name, loc = data.loc, notes = data.notes})
  cb('ok')
end)

RegisterNUICallback('warrantDelete', function(data, cb)
  if rank == "chief of police" or rank == "asst. chief of police" or rank == "lieutenant" or rank == "captain" or rank == "sergeant" then
    TriggerServerEvent('warrants:remove', data.id, data.name)
  else
    TriggerEvent("customNotification", "You do not have permission to do this!")
  end
  cb('ok')
end)

RegisterNUICallback('newWarrant', function(data, cb)
  SendNUIMessage({openSection = "newWarrant", location = getLocation()})
  cb('ok')
end)

RegisterNUICallback('newWarrantSubmit', function(data, cb)
  TriggerEvent('warrants:new', data.name, data.loc, data.notes)
  cb('ok')
end)

-- MDT Callbacks
RegisterNUICallback('loadMDT', function(data, cb)
  if (#lstWarrants == 0) then
    TriggerServerEvent('mdt:load', true)
  else
    SendNUIMessage({openSection = "mdt", list = lstMDT})
  end
  cb('ok')
end)

RegisterNUICallback('mdtRead', function(data, cb)
  SendNUIMessage({openSection = "mdtRead", id = data.id, time = data.time, officer = data.officer, name = data.name, jailfine = data.jailfine, jailtime = data.jailtime, charges = data.charges, fineticketamount = data.fineticketamount})
  cb('ok')
end)

RegisterNUICallback('mdtDelete', function(data, cb)
  if rank == "chief of police" or rank == "asst. chief of police" or rank == "lieutenant" or rank == "captain" or rank == "sergeant" then
    TriggerServerEvent('mdt:remove', data.id, data.name, data.time)
  else
    TriggerEvent("customNotification", "You do not have permission to do this!")
  end
  cb('ok')
end)

RegisterNUICallback('newMDT', function(data, cb)
  SendNUIMessage({openSection = "newMDT"})
  cb('ok')
end)

RegisterNUICallback('newMDTSubmit', function(data, cb)
  TriggerEvent('mdt:new', data.officer, data.name, data.jailfine, data.jailtime, data.charges, data.fineticketamount)
  cb('ok')
end)

RegisterNUICallback('autofillMDT', function(data, cb)
  local charges = AutoFillCharges()
  SendNUIMessage({openSection = "autofillMDT", charges = charges[1], time = charges[2], cost = charges[3], officer = GetPlayerName(PlayerId()), offender = currentSuspect})
  cb('ok')
end)

-- Warrant Events
RegisterNetEvent('warrants:load')
AddEventHandler('warrants:load', function(warrants, openUI)
  openUI = openUI or false
  lstWarrants = {}
  if (#warrants ~= 0) then
    for k,v in pairs(warrants) do
      if v ~= nil then
        local warrant = {
          id = tonumber(v.id),
          name = v.name,
          loc = v.loc,
          notes = v.notes
        }
        table.insert(lstWarrants, warrant)
      end
    end
  end
  if openUI then
    SendNUIMessage({openSection = "warrants", list = lstWarrants})
  end
end)

RegisterNetEvent('warrants:new')
AddEventHandler('warrants:new', function(name, loc, notes)
  notes = notes or ''
  if(name ~= nil and loc ~= nil) then
    TriggerServerEvent('warrants:create', name, loc, notes)
  else
    TriggerEvent("customNotification", "You must fill in a name and last known location!")
  end
end)

RegisterNetEvent('warrants:newWarrant')
AddEventHandler('warrants:newWarrant', function(warrants, id, name, loc, notes)
  -- Only show if we are a cop
    lstWarrants = warrants
    local warrant_entry = {
        id = tonumber(id),
        name = name,
        loc = loc,
        notes = notes
    }
    table.insert(lstWarrants, warrant)

    SendNUIMessage({
        newWarrant = true,
        warrant = warrant_entry,
    })
    if isInService then
        PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
        TriggerEvent('customNotification', "New warrant has been posted")
    end
end)

RegisterNetEvent('warrants:delete')
AddEventHandler('warrants:delete', function(id)
  table.remove(lstWarrants, tonumber(id))
  for k,v in pairs(lstWarrants) do
    v.id = k
  end
end)

RegisterNetEvent('mdt:load')
AddEventHandler('mdt:load', function(mdt, openUI)
  openUI = openUI or false
  lstMDT = {}
  if (#mdt ~= 0) then
    for k,v in pairs(mdt) do
      if v ~= nil then
        local mdt = {
          id = tonumber(v.id),
          time = v.time,
          officer = v.officer,
          name = v.name,
          jailfine = v.jailfine,
          jailtime = v.jailtime,
          charges = v.charges,
          fineticketamount = v.fineticketamount,
        }
        table.insert(lstMDT, mdt)
      end
    end
  end
  if openUI then
    SendNUIMessage({openSection = "mdt", list = lstMDT})
  end
end)

RegisterNetEvent('mdt:new')
AddEventHandler('mdt:new', function(officer, offender, jailfine, jailtime, charges, fineamount)
  jailtime = jailtime or 0
  fineamount = fineamount or 0
  if(officer ~= nil and offender ~= nil and jailfine ~= nil and charges ~= nil) then
    TriggerServerEvent('mdt:create', officer, offender, jailfine, jailtime, charges, fineamount)
  else
    TriggerEvent("customNotification", "You must fill everything in!")
  end
end)

RegisterNetEvent('mdt:newMDT')
AddEventHandler('mdt:newMDT', function(mdt, id, time, officer, name, jailfine, jailtime, charges, fineticketamount)
  -- Only show if we are a cop
    lstMDT = mdt
    local mdt_entry = {
        id = tonumber(id),
        time = time,
        officer = officer,
        name = name,
        jailfine = jailfine,
        jailtime = jailtime,
        charges = charges,
        fineticketamount = fineticketamount,
    }
    table.insert(lstMDT, mdt_entry)

    SendNUIMessage({
        newMDT = true,
        mdt = mdt_entry,
    })
    if isInService then
        PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
        TriggerEvent('customNotification', "New Arrest Entry")
    end
end)

RegisterNetEvent('mdt:delete')
AddEventHandler('mdt:delete', function(id)
  table.remove(lstMDT, tonumber(id))
  for k,v in pairs(lstMDT) do
    v.id = k
  end
end)

function getLocation()
  local pos = GetEntityCoords(GetPlayerPed(-1),  true)
  local street = table.pack(GetStreetNameAtCoord(pos.x, pos.y, pos.z))
  local loc = string.format("%s", GetStreetNameFromHashKey(street[1]))

  if street[2] ~= 0 and street[2] ~= nil then
    loc = string.format("%s, nearby %s", GetStreetNameFromHashKey(street[1]), GetStreetNameFromHashKey(street[2]))
  end

  return loc
end

function tablefind(tab,el)
  for index, value in pairs(tab) do
    if value == el then
      return index
    end
  end
end

function tablefindKeyVal(tab,key,val)
  for index, value in pairs(tab) do
    if value ~= nil  and value[key] ~= nil and value[key] == val then
      return index
    end
  end
end

function AutoFillCharges()
  local charges = {}
  local time = 0
  local cost = 0
  for key, val in pairs(currentSuspectCharges) do            
      charges[#charges+1] = (" [" .. currentSuspectCharges[key].count .. "x] " .. key .. "")
      time = time + currentSuspectCharges[key].time
      cost = cost + currentSuspectCharges[key].cost
  end
  return {table.concat(charges),time,cost}
end

RegisterNetEvent('customNotification')
AddEventHandler('customNotification', function(msg)
    TriggerEvent("pNotify:SendNotification", { theme = "gta2", text = "".. msg .. "", layout = "centerRight", type = "info", timeout = 6000, animation = {open = "gta_effects_open", close = "gta_effects_close"} } )
end)