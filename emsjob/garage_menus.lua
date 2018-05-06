local stationGarage = {
    {x=-237.292, y=6332.39, z=32.3463},
    {x=1842.64, y=3667.10, z=33.6801},
    {x=-657.582, y=293.92, z=81.4133},
    {x=-876.029, y=-300.418, z=39.6034},
    {x=1169.01, y=-1509.82, z=34.6926},
    {x=303.086, y=-1439.04, z=29.8019},
    {x=364.135, y=-591.145, z=28.6844},
    {x=-475.254, y=-352.322, z=34.3147},
}

local stationHeliGarage = {
    {x=-475.22604370117, y=5988.6201171875, z=31.336700439453},
    {x=313.30563354492, y=-1465.1845703125, z=46.509475708008},
    {x=299.50131225586, y=-1453.5455322266, z=46.509475708008},
    {x=352.01733398438, y=-588.12835693359, z=74.165634155273},
    {x=1770.2397460938, y=3239.8703613281, z=42.1227684021},
    {x=1216.7823486328, y=-1516.5510253906, z=34.700180053711},
}

car_menu = false
heli_menu = false
cars = {}

if settings.force == "LifeMed" then
	--LifeMed
	cars = {
	    {"Ambulance", {model="ambulance",type=""},{"ems probationary","ems paramedic","ems specialist","ems lieutenant","ems chief"}},
        {"Explorer", {model="police5",type=""},{"ems probationary","ems paramedic","ems specialist","ems lieutenant","ems chief"}},
	}
elseif settings.force == "Los Angeles EMS" then
	--Los Angeles EMS
	cars = {
	    {"Ambulance", {model="ambulance",type=""},{"ems probationary","ems paramedic","ems specialist","ems lieutenant","ems chief"}},
        {"Explorer", {model="police5",type=""},{"ems probationary","ems paramedic","ems specialist","ems lieutenant","ems chief"}},
	}
elseif settings.force == "FDNY" then
	--FDNY
	cars = {
	    {"Ambulance", {model="ambulance",type=""},{"ems probationary","ems paramedic","ems specialist","ems lieutenant","ems chief"}},
        {"Explorer", {model="police5",type=""},{"ems probationary","ems paramedic","ems specialist","ems lieutenant","ems chief"}},
	}
end

heli = {
    {settings.force.." Chopper",{model="polmav",type="helicopter"},{"ems probationary","ems paramedic","ems specialist","ems lieutenant","ems chief"}},
}

function isNearStationGarage()
    for i = 1, #stationGarage do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(1, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 155, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if(distance < 2) then
                return true
            elseif distance > 2 then
                car_menu = false
            end
        end
    end
end

function isNearStationHeliGarage()
    for i = 1, #stationHeliGarage do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(1, stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z-1, 0, 0, 0, 0, 0, 0, 9.0, 9.0, 1.0, 0, 155, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if(distance < 7) then
                return true
            elseif distance > 7 then
                heli_menu = false
            end
        end
    end
end

function carmenu()
    Menu.SetupMenu("car_menu","Paramedic garage")
    Menu.Switch(nil,"car_menu")
    for k,v in pairs(cars) do
    	for i = 1,#cars[k][3] do
	        if v[3][i] == rank then
	            Menu.addOption("car_menu", function()
	                if(Menu.Option(v[1]))then
	                    spawncar(v[2])
	                end
	            end)
	        end
	    end
    end
end

function helimenu()
    Menu.SetupMenu("heli_menu","Heli garage")
    Menu.Switch(nil,"heli_menu")
    for k,v in pairs(heli) do
    	for i = 1,#cars[k][3] do
	        if v[3][i] == rank then
	            Menu.addOption("heli_menu", function()
	                if(Menu.Option(v[1]))then
	                    spawncar(v[2])
	                end
	            end)
	        end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isParamedic) then
            if(isInService) then
                if(isNearStationGarage()) then
                    if(existingVeh ~= nil) then
                        drawTxt("Press ~g~E~s~ to store your vehicle.",0,1,0.5,0.8,0.6,255,255,255,255)
                    else
                        drawTxt("Press ~g~E~s~ to select your vehicle.",0,1,0.5,0.8,0.6,255,255,255,255)
                    end
        
                    if IsControlJustPressed(1, 38)  then
                        if(existingVeh ~= nil) then
                            SetEntityAsMissionEntity(existingVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
                            existingVeh = nil
                        else
                            carmenu() -- Menu to draw
                            car_menu = not car_menu                 
                        end
                    end     
                end
                if(isNearStationHeliGarage()) then
                    if(existingVeh ~= nil) then
                        drawTxt("Press ~g~E~s~ to store your chopper.",0,1,0.5,0.8,0.6,255,255,255,255)
                    else
                        drawTxt("Press ~g~E~s~ to select your chopper.",0,1,0.5,0.8,0.6,255,255,255,255)
                    end
        
                    if IsControlJustPressed(1, 38)  then
                        if(existingVeh ~= nil) then
                            SetEntityAsMissionEntity(existingVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
                            existingVeh = nil
                        else
                            helimenu()
                            heli_menu = not heli_menu                         
                        end
                    end
                end
            end
        end
        if car_menu then
            menuX = 0.75
            heli_menu = false
            ems_menu = false
            Menu.DisplayCurMenu()
        end
        if heli_menu then
            menuX = 0.75
            car_menu = false
            ems_menu = false
            Menu.DisplayCurMenu()
        end
    end
end)

function spawncar(car)
    local helicopter = true
    local tint = false
    if car.type == "helicopter" or car.type == "heli" then
        helicopter = true
    elseif car.type == "undercover" then
        tint = true
    end
    local carhashed = GetHashKey(car.model)
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    local plate = settings.force..math.random(1,999)
    RequestModel(carhashed)
    while not HasModelLoaded(carhashed) do
        Citizen.Wait(0)
    end
                            
    existingVeh = CreateVehicle(carhashed, plyCoords["x"], plyCoords["y"], plyCoords["z"], 90.0, true, false)
    local id = NetworkGetNetworkIdFromEntity(existingVeh)
    SetNetworkIdCanMigrate(id, true)
    SetVehicleMod(existingVeh, 11, 3)
    SetVehicleMod(existingVeh, 12, 3)
    SetVehicleMod(existingVeh, 13, 3)
    SetVehicleMod(existingVeh, 15, 3)
    SetVehicleNumberPlateText(existingVeh, plate)
    if tint then
        SetVehicleWindowTint(existingVeh, 1)
    elseif helicopter then
        SetVehicleLivery(existingVeh, 1)
    else
        SetVehicleWindowTint(existingVeh, 0)
    end
    SetVehicleDirtLevel(existingVeh, 0)
    TaskWarpPedIntoVehicle(ply, existingVeh, -1)
    car_menu = false
    heli_menu = false
end

function AddParamedicBlips()
    for _, item in pairs(stationGarage) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 50)
      SetBlipColour(item.blip, 2)
      SetBlipScale(item.blip, 0.6)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Garages")
      EndTextCommandSetBlipName(item.blip)
    end
    for _, item in pairs(stationHeliGarage) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 43)
      SetBlipColour(item.blip, 2)
      SetBlipScale(item.blip, 0.6)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Helipads")
      EndTextCommandSetBlipName(item.blip)
    end   
end

function RemoveParamedicBlips()
    for _, item in pairs(stationGarage) do
        RemoveBlip(item.blip)
    end
    for _, item in pairs(stationHeliGarage) do
        RemoveBlip(item.blip)
    end
end