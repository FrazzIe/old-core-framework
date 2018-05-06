--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Open Menu                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
ems_menu = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isParamedic) then
            if(isInService) then
		        if IsControlJustPressed(1, 19) then --- LEFTALT (Open)
		        	TriggerServerEvent('paramedic:requestMission')
		            ems_menu = not ems_menu
		            MainMenu()
		        end
		        if ems_menu then
		        	menuX = 0.10
		        	car_menu = false
		        	heli_menu = false
		            Menu.DisplayCurMenu()
		        end
		    end
		end
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Main Menu                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local repairing = false
local ovehPosition = 1
local vehiclePosition = 1

function MainMenu()
    Menu.SetupMenu("ems_menu","Paramedic menu")
    Menu.Switch(nil,"ems_menu")
    Menu.addOption("ems_menu", function()
        if(Menu.Option("Missions"))then
        	MissionMenu()
        end
    end)
    Menu.addOption("ems_menu", function()
        if(Menu.Option("Revive"))then
        	if GetEntityHealth(GetPlayerPed(-1)) == 0 then
            	TriggerEvent("paramedic:heal", PlayerId())
            else
				local t, distance = GetClosestPlayer()
				if(distance ~= -1 and distance < 3) then
	                if GetEntityHealth(GetPlayerPed(t)) < 10 then
	                    TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
	                    Citizen.Wait(8000)
	                    ClearPedTasks(GetPlayerPed(-1));
	                    TriggerServerEvent("paramedic:revive", GetPlayerServerId(t))
	                end
				else
					Messages(1)
				end
			end
        end
    end)
    Menu.addOption("ems_menu", function()
        if(Menu.Option("Pronounce DOA"))then
        	if GetEntityHealth(GetPlayerPed(-1)) == 0 then
            	TriggerEvent("paramedic:heal", PlayerId())
            else
				local t, distance = GetClosestPlayer()
				if(distance ~= -1 and distance < 3) then
	                if GetEntityHealth(GetPlayerPed(t)) < 10 then
	                    TriggerServerEvent("paramedic:doa", GetPlayerServerId(t))
	                end
				else
					Messages(1)
				end
			end
        end
    end)
    Menu.addOption("ems_menu", function()
        if(Menu.Option("Drag a player"))then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				TriggerServerEvent("paramedic:dragRequest", GetPlayerServerId(t))
			else
				Messages(1)
			end
        end
    end)
    Menu.addOption("ems_menu", function()
		if(Menu.StringArray("Vehicle:", {"< Force in >", "< Force Out >"}, vehiclePosition,function(cb) vehiclePosition = cb end)) then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				if vehiclePosition == 1 then
					local v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
					TriggerServerEvent("paramedic:forceEnterAsk", GetPlayerServerId(t), v)
				elseif vehiclePosition == 2 then
					TriggerServerEvent("paramedic:confirmUnseat", GetPlayerServerId(t))
				end
			else
				Messages(1)
			end                        
		end     	
    end)
    Menu.addOption("ems_menu", function()
        if(Menu.StringArray("Vehicle:", {"< Fix >", "< Clean >"}, ovehPosition,function(cb) ovehPosition = cb end)) then
        	if ovehPosition == 1 then
				if not repairing then
					if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
						local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
							if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
							    if isInService == true then
							        if GetVehicleEngineHealth(veh) <= 920 then
							            repairing = true
							            TaskPlayAnim(GetPlayerPed(-1),"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)     
							            Citizen.Wait(20000)
							            SetVehicleFixed(veh, 1)
							            SetVehicleDeformationFixed(veh, 1)
							            SetVehicleUndriveable(veh, 1)
							            ClearPedTasksImmediately(GetPlayerPed(-1))
							            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
							            Notify("Vehicle repaired!")
							            repairing = false
							        else
							            Notify("You can only repair a vehicle that needs repaired!") 
							        end
							    else
							        Notify("You must be on duty!") 
							    end
							else
							    Notify("You must be driving!") 
							end
					else
						Notify("You are not in an emergency services vehicle!") 
					end
				else
					Notify("You cannot repair the vehicle as you are already repairing it!") 
				end
			elseif ovehPosition == 2 then
			    if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
			        local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
			        if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			            if isInService == true then
			                SetVehicleDirtLevel(veh, 0)
			            else
			                Notify("You must be on duty!")
			            end
			        else
			            Notify("You must be driving!") 
			        end
			    else
			        Notify("You are not in an emergency services vehicle!") 
			    end	
			end
        end
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Sub Menus                                                           --
--                                                          Missions                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
mission_list = {}
function MissionMenu()
    Menu.SetupMenu("missions_menu","Missions")
    Menu.Switch("ems_menu","missions_menu")
    for i,v in pairs(mission_list) do
    	if v.name ~= "Finish the mission" then
	        Menu.addOption("missions_menu", function()
	            if(Menu.Option(v.name))then
	                v.f(v.mission)
	            end
	        end)
	    else
	        Menu.addOption("missions_menu", function()
	            if(Menu.Option(v.name))then
	                v.f()
	            end
	        end)
	    end
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Messages                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function Messages(value)
	if value == 1 then
		Notify("Please get closer to the target!")
	end
end

function Notify(msg)
	exports.pNotify:SendNotification({text = msg,type = "error",timeout = 3000,layout = "centerRight",queue = "left"})
	CancelEvent()
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                   Get the closest player                                                     --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

function showLoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0xaba17d7ce615adbf("STRING") -- set type
        AddTextComponentString(showText) -- sets the text
        N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
    end)
end

function stopLoadingPrompt()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0x10d373323e5b9c0d()
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsEntityDead(GetPlayerPed(-1)) then
            car_menu = false
            heli_menu = false
            Citizen.Wait(5000)
        end
    end
end)