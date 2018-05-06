local isDead = false
local isKO = false
local spawnlocation = {x=1151.279296875,y=-1529.92565917969,z=35.3715476989746}
DecorRegister("isDead", 2)
DecorSetBool(GetPlayerPed(-1), "isDead", false) 

secondsRemaining = -1
--[[
################################
            THREADS
################################
--]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
    	local playerPed = GetPlayerPed(-1)
    	local playerID = PlayerId()
    	local currentPos = GetEntityCoords(playerPed, true)
    	local previousPos

    	isDead = IsEntityDead(playerPed)
    
    	if isKO and previousPos ~= currentPos then
    		isKO = false
    	end

   	    if (GetEntityHealth(playerPed) < 120 and not isDead and not isKO) then
            if (IsPedInMeleeCombat(playerPed)) then
                SetPlayerKO(playerID, playerPed)
            end
        end

        previousPos = currentPos
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if IsEntityDead(PlayerPedId())then
			StartScreenEffect("DeathFailOut", 0, 0)
			ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)

			local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

			if HasScaleformMovieLoaded(scaleform) then
				Citizen.Wait(0)

				PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
				BeginTextComponent("STRING")
				AddTextComponentString("~r~You are in a coma")
				EndTextComponent()
				PopScaleformMovieFunctionVoid()

                Citizen.Wait(500)

                timer = true
                DecorSetBool(GetPlayerPed(-1), "isDead", true) 
                while IsEntityDead(PlayerPedId()) do
                    if timer then
                        timer = false
                        secondsRemaining = 300
                    end
					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
			 		Citizen.Wait(0)
                end
                DecorSetBool(GetPlayerPed(-1), "isDead", false)
                secondsRemaining = -1
                StopScreenEffect("DeathFailOut")
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if(secondsRemaining > 0)then
            secondsRemaining = secondsRemaining - 1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if secondsRemaining > 0 then
            drawRespawnTxt("~g~"..secondsRemaining.."~w~ seconds until you can respawn!",7,1.0,0.5,0.75,0.6,255,255,255,255)
        elseif secondsRemaining == 0 then
            drawRespawnTxt("Press~b~ X ~w~to ~g~respawn~w~!",7,1.0,0.5,0.75,0.6,255,255,255,255)
            if (IsControlJustReleased(1, 73)) then
                if activeMedics < 1 then
                    TriggerEvent('paramedic:respawn')
                    exports.pNotify:SendNotification({text = "<div align='center'><b style='color:red'>Alert</b><br>No paramedics are online! <br> You have been respawned and will keep all your money, items and guns!</div>",type = "error",queue = "left",timeout = 8000,layout = "bottomCenter"}) 
                else
                    TriggerServerEvent('paramedic:respawn_rip')
                    exports.pNotify:SendNotification({text = "<div align='center'><b style='color:red'>Alert</b><br>Paramedics are online! <br> You have been respawned and will lose all your money, items and guns!</div>",type = "error",queue = "left",timeout = 8000,layout = "bottomCenter"}) 
                end
            end
        end
    end
end)
--[[
################################
            EVENTS
################################
--]]

-- Triggered when player died by environment
AddEventHandler('baseevents:onPlayerDied', function(playerId, reasonID)
    TriggerEvent('es_em:playerInComa')
    SendNotification('You are in a coma')
end)

-- Triggered when player died by an another player
AddEventHandler('baseevents:onPlayerKilled', function(playerId, playerKill, reasonID)
    TriggerEvent('es_em:playerInComa')
    
    SendNotification('You are in a coma')
end)

RegisterNetEvent('paramedic:respawnCheck')
AddEventHandler('paramedic:respawnCheck', function()
    TriggerServerEvent('paramedic:respawn')
end)

RegisterNetEvent('paramedic:respawn')
AddEventHandler('paramedic:respawn', function()
    secondsRemaining = -1
    SetEntityHealth(GetPlayerPed(-1), GetPedMaxHealth(GetPlayerPed(-1)))
    SetEntityInvincible(GetPlayerPed(-1), false)
    DisablePlayerFiring(PlayerId(), false)
    ClearPedBloodDamage(GetPlayerPed(-1))
	NetworkResurrectLocalPlayer(spawnlocation.x, spawnlocation.y, spawnlocation.z, true, true, false)
    local bars = exports.FCORE_:getBars()
    if bars[1] < 21 or bars[2] < 40 then
        TriggerEvent('fm:drink', 40)
        TriggerEvent('fm:eat', 40)
    end
end)

function SetPlayerKO(playerID, playerPed)
  isKO = true
  SendNotification('YOU GOT KNOCKED THE FUCK OUT')
  SetPedToRagdoll(playerPed, 6000, 6000, 0, 0, 0, 0)
end

function SendNotification(message)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(message)
  DrawNotification(false, false)
end

function GetStringReason(reasonID)
  local reasonString = 'Killed'

  if reasonID == 0 or reasonID == 56 or reasonID == 1 or reasonID == 2 then
    reasonIDString = 'Molested'
  elseif reasonID == 3 then
    reasonIDString = 'Stabbed'
  elseif reasonID == 4 or reasonID == 6 or reasonID == 18 or reasonID == 51 then
    reasonIDString = 'Exploded'
  elseif reasonID == 5 or reasonID == 19 then
    reasonIDString = 'Burned'
  elseif reasonID == 7 or reasonID == 9 then
    reasonIDString = 'Gunshot'
  elseif reasonID == 49 or reasonID == 50 then
    reasonString = 'Crushed'
  end

  return reasonString
end

function drawRespawnTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end