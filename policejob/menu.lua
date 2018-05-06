--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Open Menu                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
cop_menu = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isCop) then
            if(isInService) then
		        if IsControlJustPressed(1, 19) then --- LEFTALT (Open)
		        	TriggerServerEvent('police:requestMission')
		            cop_menu = not cop_menu
		            MainMenu()
		        end
		        if cop_menu then
		        	menuX = 0.10
		        	car_menu = false
		        	heli_menu = false
		        	armoury_menu = false
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
function MainMenu()
    Menu.SetupMenu("cop_menu","Police menu")
    Menu.Switch(nil,"cop_menu")
    Menu.addOption("cop_menu", function()
        if(Menu.Option("Missions"))then
        	MissionMenu()
        end
    end)
    Menu.addOption("cop_menu", function()
        if(Menu.Option("Citizen"))then
        	cit()
        end
    end)
    Menu.addOption("cop_menu", function()
        if(Menu.Option("Vehicle"))then
        	Vehicle()
        end
    end)
    Menu.addOption("cop_menu", function()
        if(Menu.Option("Placeables"))then
        	Placeables()
        end
    end)
    Menu.addOption("cop_menu", function()
        if(Menu.Option("MDT Area"))then
        	Warrents()
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
    Menu.Switch("cop_menu","missions_menu")
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
--                                                          Sub Menus                                                           --
--                                                           Citizen                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local vehiclePosition = 1
local invPosition = 1
local wepPosition = 1
local licPosition = 1
function cit()
    Menu.SetupMenu("cop_menu_citizen","Citizen")
    Menu.Switch("cop_menu","cop_menu_citizen")
    Menu.addOption("cop_menu_citizen", function()
        if(Menu.Option("Cuff a player"))then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				TriggerServerEvent("police:cuffGranted", GetPlayerServerId(t))
			else
				Messages(1)
			end       	
        end
    end)
    Menu.addOption("cop_menu_citizen", function()
        if(Menu.Option("Drag a player"))then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				TriggerServerEvent("police:dragRequest", GetPlayerServerId(t))
			else
				Messages(1)
			end       	
        end
    end)
    Menu.addOption("cop_menu_citizen", function()
		if(Menu.StringArray("Vehicle:", {"< Force in >", "< Force Out >"}, vehiclePosition,function(cb) vehiclePosition = cb end)) then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				if vehiclePosition == 1 then
					local v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
					TriggerServerEvent("police:forceEnterAsk", GetPlayerServerId(t), v)
				elseif vehiclePosition == 2 then
					TriggerServerEvent("police:confirmUnseat", GetPlayerServerId(t))
				end
			else
				Messages(1)
			end                        
		end     	
    end)
    Menu.addOption("cop_menu_citizen", function()
		if(Menu.StringArray("Inventory:", {"< Search >", "< Seize >"}, invPosition,function(cb) invPosition = cb end)) then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				if invPosition == 1 then
					TriggerServerEvent("police:targetCheckInventory", GetPlayerServerId(t))
				elseif invPosition == 2 then
					TriggerServerEvent('police:targetSeizeInventory', GetPlayerServerId(t))
				end
			else
				Messages(1)
			end                        
		end     	
    end)
    Menu.addOption("cop_menu_citizen", function()
		if(Menu.StringArray("Weapons:", {"< Search >", "< Seize >"}, wepPosition,function(cb) wepPosition = cb end)) then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				if wepPosition == 1 then
					TriggerServerEvent("police:targetCheckGuns", GetPlayerServerId(t))
				elseif wepPosition == 2 then
					TriggerServerEvent("police:byebyeweapons", GetPlayerServerId(t))
				end
			else
				Messages(1)
			end                        
		end     	
    end)
    Menu.addOption("cop_menu_citizen", function()
		if(Menu.StringArray("Weapon license:", {"< Check >", "< Confiscate >"}, licPosition,function(cb) licPosition = cb end)) then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				if licPosition == 1 then
					TriggerServerEvent("police:targetCheckGunLicense", GetPlayerServerId(t))
				elseif licPosition == 2 then
					TriggerServerEvent("police:targetSeizeGunLicense", GetPlayerServerId(t))
				end
			else
				Messages(1)
			end                        
		end     	
    end)
    Menu.addOption("cop_menu_citizen", function()
        if(Menu.Option("Breathalyzer"))then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				local isBACActive = DecorGetBool(GetPlayerPed(t), "BAC_Active")
				if isBACActive then
					Notify("Subject tested <b style='color:red'>Positive</b> <br>Their blood-alcohol concentration is outside the legal limits")
				else
					Notify("Subject tested <b style='color:lime'>Negative</b> <br>Their blood-alcohol concentration is inside the legal limits")
				end
			else
				Messages(1)
			end       	
        end
    end)
    Menu.addOption("cop_menu_citizen", function()
        if(Menu.Option("Check for gun residue"))then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				isGSRactive = DecorGetBool(GetPlayerPed(t), "GSR_Active")
				if isGSRactive then
					Notify("Subject tested <b style='color:red'>Positive</b><br>They have discharged a firearm recently!")
				else
					Notify("Subject tested <b style='color:lime'>Negative</b><br>They haven't discharged a firearm recently!")
				end
			else
				Messages(1)
			end       	
        end
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Sub Menus                                                           --
--                                                           Vehicle                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local repairing = false
local ovehPosition = 1
local checkplate = false
function Vehicle()
    Menu.SetupMenu("cop_menu_vehicle","Vehicle")
    Menu.Switch("cop_menu","cop_menu_vehicle")
    Menu.addOption("cop_menu_vehicle", function()
        if(Menu.StringArray("Vehicle:", {"< Fix >", "< Clean >"}, ovehPosition,function(cb) ovehPosition = cb end)) then
        	if ovehPosition == 1 then
				if not repairing then
					if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
						local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
							if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
							    if exports.policejob:getIsInService() == true then
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
						Notify("You are not in a police vehicle!") 
					end
				else
					Notify("You cannot repair the vehicle as you are already repairing it!") 
				end
			elseif ovehPosition == 2 then
			    if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
			        local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
			        if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			            if exports.policejob:getIsInService() == true then
			                SetVehicleDirtLevel(veh, 0)
			            else
			                exports.pNotify:SendNotification({text = "You must be on duty!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
			            end
			        else
			            exports.pNotify:SendNotification({text = "You must be driving!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
			        end
			    else
			        exports.pNotify:SendNotification({text = "You are not in a police vehicle!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
			    end	
			end
        end
    end)

    Menu.addOption("cop_menu_vehicle", function()
    	if(Menu.Option("Check Plate"))then
			local pos = GetEntityCoords(GetPlayerPed(-1))
			local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

			local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
			local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
			if(DoesEntityExist(vehicleHandle)) then
				TriggerServerEvent("police:checkingPlate", GetVehicleNumberPlateText(vehicleHandle))
			else
				Messages(1)
			end 
        end
    end)
    Menu.addOption("cop_menu_vehicle", function()
        if(Menu.Bool("Speed gun", speedgun,function(cb)    speedgun = cb end)) then
   			TriggerEvent("police:speedgun")
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if speedgun then
	        if IsControlJustPressed(1, 244)then
	        	TriggerEvent("police:speedgun")
			end
		end
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Sub Menus                                                           --
--                                                          Placeables                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function Placeables()
    Menu.SetupMenu("cop_menu_placeables","Placeables")
    Menu.Switch("cop_menu","cop_menu_placeables")
    Menu.addOption("cop_menu_placeables", function()
        if(Menu.Option("Toggle spikes"))then
        	TriggerEvent("police:Deploy")
        end
    end)
    Menu.addOption("cop_menu_placeables", function()
        if(Menu.Option("Toggle Camera"))then
        	TriggerEvent("police:placeCam")
        end
    end)
    Menu.addOption("cop_menu_placeables", function()
        if(Menu.Option("Toggle Cones"))then
        	TriggerEvent("police:DeployC")
        end
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Sub Menus                                                           --
--                                                        Fines/Jailing                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local finepos = 1

function Warrents()
    Menu.SetupMenu("cop_menu_warrents","MDT Area")
    Menu.Switch("cop_menu","cop_menu_warrents")
    Menu.addOption("cop_menu_warrents", function()
		if(Menu.StringArray("Fine:", {"< Optional >", "< Not Optional >"}, finepos,function(cb) finepos = cb end)) then
			local t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 3) then
				local amount = -1
				if(amount == -1) then
					Notify("Enter fine amount!")
		            local finefill = AutoFillCharges()
		            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", finefill[3] , "", "", "", 1000)
					while (UpdateOnscreenKeyboard() == 0) do
						DisableAllControlActions(0);
						Wait(0);
					end
					if (GetOnscreenKeyboardResult()) then
						local res = tonumber(GetOnscreenKeyboardResult())
						if(res ~= nil and res ~= 0) then
							amount = res				
						end
					end
				end
				
				if(amount ~= -1) then
					if finepos == 1 then
						TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), amount)
					else
						TriggerServerEvent("police:finesForced", GetPlayerServerId(t), amount)
					end
				end
			else
				Messages(1)
			end                      
		end     	
    end)
    Menu.addOption("cop_menu_warrents", function()
        if(Menu.Option("Jail"))then
		    t, distance = GetClosestPlayer()
		    if(distance ~= -1 and distance < 3) then
		        local time = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
		        if(time == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
		            showLoadingPrompt("Enter a jail time..", 3)
		            local jailtimefill = AutoFillCharges()
		            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", jailtimefill[2] , "", "", "", 1000)
		            while (UpdateOnscreenKeyboard() == 0) do
		                  DisableAllControlActions(0);
		                Wait(0);
		            end
		            if (GetOnscreenKeyboardResult()) then
		                local option = tonumber(GetOnscreenKeyboardResult())
		                if(option ~= nil and option ~= 0) then
		                    N_0x10d373323e5b9c0d() -- remove promt
		                    time = ""..option
		                    customtime = true         
		                end
		            end
		        end
		        stopLoadingPrompt()
		        if time ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and customtime == true then
		            JailReason(t,time)
		        end
		    else
		        Messages(1)
		    end
        end
    end)
	Menu.addOption("cop_menu_warrents", function()
		if(Menu.Option("Charges"))then
			Charges()
		end
	end)
	Menu.addOption("cop_menu_warrents", function()
		if(Menu.Option("MDT"))then
			openGui()
		end
	end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                            Charges                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local charges = {
    {title="Felonies", items = {
        {charge="Grand Theft Auto", time=450, cost=5000},
        {charge="Poss. of Stolen Vehicle", time=350, cost=2500},
        {charge="Assault with a Deadly Weapon", time=450, cost=5000},
        {charge="Attempted Murder", time=750, cost=5000},
        {charge="1st Degree Murder", time=1200, cost=5000},
        {charge="2nd Degree Murder", time=900, cost=5000},
        {charge="Assault on an LEO", time=600, cost=5000},
        {charge="Assault and Battery", time=300, cost=5000},
        {charge="Attempted Bribery", time=240, cost=5000},
        {charge="Attempted Robbery", time=450, cost=5000},
        {charge="Armed Robbery", time=600, cost=5000},
        {charge="Unarmed Robbery", time=450, cost=5000},
        {charge="Illegal Brandishing a Firearm", time=240, cost=5000},
        {charge="Public Discharge of a Firearm", time=300, cost=5000},
        {charge="Poss. of an Illegal Firearm/Weapon", time=300, cost=5000},
        {charge="Poss. of Controlled Substance (Marijuana)", time=600, cost=10000},
        {charge="Damage to State Property", time=450, cost=5000},
        {charge="Poss. of Class A Narcotic w/ Intent to Sell", time=600, cost=15000},
        {charge="Disturbing the Peace", time=450, cost=5000},
        {charge="Driving Under the Influence", time=300, cost=5000},
        {charge="Felony Evading Law Enforcement", time=600, cost=5000},
        {charge="Hit and Run", time=450, cost=5000},
        {charge="Kidnapping", time=450, cost=5000},
        {charge="Attempted Kidnapping", time=240, cost=2500},
        {charge="Vehicular Manslaughter", time=750, cost=5000},
        {charge="Obstruction of Justice", time=600, cost=5000},
        {charge="Offenses Against Public Order", time=450, cost=5000},
        {charge="Human Trafficking", time=450, cost=5000},
        {charge="Rioting 1st Degree - Aggressive", time=450, cost=5000},
        {charge="Reckless Endangerment", time=600, cost=5000},
        {charge="Threat of Bodily Harm to an LEO", time=600, cost=5000},
        {charge="Tampering of Evidence", time=450, cost=5000},
        {charge="Money Laundering", time=300, cost=5000},
    }},
    {title="Misdemeanors", items = {
        {charge="Attempted Grand Theft Auto", time=240, cost=1500},
        {charge="Domestic Violence", time=240, cost=2500},
        {charge="Domestic Disturbance", time=240, cost=2500},
        {charge="Disorderly Conduct", time=350, cost=2500},
        {charge="Fleeing/Eluding Law Enforcement", time=240, cost=2500},
        {charge="False Identification", time=240, cost=2500},
        {charge="Gambling", time=240, cost=1500},
        {charge="Indecent Exposure", time=240, cost=1500},
        {charge="Identity Theft", time=240, cost=2500},
        {charge="Inciting A Riot", time=240, cost=2500},
        {charge="J Walking", time=120, cost=1500},
        {charge="Loitering", time=120, cost=1500},
        {charge="Prostitution", time=240, cost=2500},
        {charge="Reckless Driving", time=350, cost=2500},
        {charge="Rioting 2nd Degree - Being Part Of", time=240, cost=2500},
        {charge="Threats of Bodily Harm", time=240, cost=2500},
        {charge="Trespassing", time=240, cost=2500},
    }},
}

function Charges()
    Menu.SetupMenu("cop_menu_charges","Charges")
    Menu.Switch("cop_menu_warrents","cop_menu_charges")
	Menu.addOption("cop_menu_charges", function()
		if(Menu.Option("Add Charges"))then
			addCharges()
		end
	end)
	Menu.addOption("cop_menu_charges", function()
		if(Menu.Option("Review Charges"))then
			reviewCharges()
		end
	end)
	Menu.addOption("cop_menu_charges", function()
		if(Menu.Option("Apply Charges"))then
			applyCharges()
		end
	end)
	Menu.addOption("cop_menu_charges", function()
		if(Menu.Option("Clear Charges"))then
			clearCharges()
		end
	end)
end

function addCharges()
    Menu.SetupMenu("cop_menu_addcharges","Charges")
    Menu.Switch("cop_menu_charges","cop_menu_addcharges")
    for k,v in pairs(charges) do
		Menu.addOption("cop_menu_addcharges", function()
			if(Menu.Option(v.title))then
				subCharges(v.title,v.items)
			end
		end)
	end
end

function subCharges(title,items)
    Menu.SetupMenu("cop_menu_subcharges",title)
    Menu.Switch("cop_menu_addcharges","cop_menu_subcharges")
    for k,v in pairs(items) do
		Menu.addOption("cop_menu_subcharges", function()
			if(Menu.Option(v.charge))then
				local current_charge = {charge=v.charge, time=v.time, cost=v.cost},
		        showLoadingPrompt("Enter a jail time for charge..", 3)
		        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", v.time, "", "", "", 255)
		        while (UpdateOnscreenKeyboard() == 0) do
		            DisableAllControlActions(0);
		        	Wait(0);
		        end
		        if (GetOnscreenKeyboardResult()) then
		            local option = tonumber(GetOnscreenKeyboardResult())
		            if(tonumber(option) ~= nil)then
		                N_0x10d373323e5b9c0d() -- remove promt
		                current_charge.time = tonumber(option)
		            end
		        end
		        stopLoadingPrompt()

		        showLoadingPrompt("Enter fine amount for charge..", 3)
		        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", v.cost, "", "", "", 255)
		        while (UpdateOnscreenKeyboard() == 0) do
		            DisableAllControlActions(0);
		        	Wait(0);
		        end
		        if (GetOnscreenKeyboardResult()) then
		            local option = tonumber(GetOnscreenKeyboardResult())
		            if(tonumber(option) ~= nil)then
		                N_0x10d373323e5b9c0d() -- remove promt
		                current_charge.cost = tonumber(option)
		            end
		        end
		        stopLoadingPrompt()

				addCharge(current_charge)
			end
		end)
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

function JailReason(target,jailtime)
    local reason = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
    local id = tonumber(target)
    local time = tonumber(jailtime)
    if(reason == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        showLoadingPrompt("Enter a reason..", 3)
        local charges = AutoFillCharges()
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", charges[1].. " - "..GetPlayerName(PlayerId()), "", "", "", 1000)
        while (UpdateOnscreenKeyboard() == 0) do
              DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tostring(GetOnscreenKeyboardResult())
            if(res ~= nil and res ~= 0 and res ~= "") then
                N_0x10d373323e5b9c0d() -- remove promt
                reason = res         
            end
        end
    end
    stopLoadingPrompt()        
    if(reason ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        TriggerServerEvent("js:jailuser", GetPlayerServerId(id), time, reason)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsEntityDead(GetPlayerPed(-1)) then
            cop_menu = false
            car_menu = false
            heli_menu = false
            armoury_menu = false
            Citizen.Wait(5000)
        end
    end
end)