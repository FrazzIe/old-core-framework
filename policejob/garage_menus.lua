local stationGarage = {
    {x=452.115966796875, y=-1018.10681152344, z=28.4786586761475}, -- Mission row
    {x=-457.88, y=6024.79, z=31.34}, -- Paleto Bay
    {x=1866.84, y=3697.15, z=33.60}, -- Sandy Shores
    {x=-1068.95, y=-859.73, z=4.87}, -- San Andreas Ave
    {x=-570.28, y=-145.50, z=37.79}, -- Rockford Hills
}

local stationHeliGarage = {
    {x=449.150207519531, y=-981.246459960938, z=43.6916275024414}, -- Mission row
    {x=-475.33, y=5988.55, z=31.34}, -- Paleto Bay
    {x=1889.5676269531, y=3705.4157714844, z=32.930965423584}, -- Sandy Shores
    {x=-1051.86, y=-855.40, z=4.87}, -- San Andreas Ave
}

car_menu = false
heli_menu = false
cars = {}

if settings.force == "AST" then
    --AST
    cars = {
        {"AST Charger", {model="police1",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST Tahoe", {model="sheriff2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST Explorer", {model="police3",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST Taurus", {model="police4",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST CVPI", {model="police7",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST Impala", {model="police8",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST Explorer", {model="police5",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST F350 Plow", {model="police",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST Raptor", {model="pranger",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST Explorer", {model="police5",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"AST Charger", {model="sheriff",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Snowmobile", {model="blazer",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
    }
elseif settings.force == "LAPD" then
    --LAPD
    cars = {
        {"Marked Charger", {model="police2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked Explorer", {model="police5",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked Taurus", {model="police4",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked K9 Tahoe", {model="police6",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked CVPI", {model="police7",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked Impala", {model="police8",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"State Charger", {model="statecharger",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"State Tahoe", {model="statetahoe",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"State CVPI", {model="statecvpi",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"State F350", {model="statef350",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"A.L charger", {model="polcharger",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Unmarked Charger", {model="fbi",type="undercover"},{"sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Unmarked Tahoe", {model="fbi2",type="undercover"},{"sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Mustang", {model="polgt500",type=""},{"chief of police"}},
    }
elseif settings.force == "NYPD" then
    --NYPD
    cars = {
        {"Marked Charger", {model="police2",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked Explorer", {model="police3",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked Taurus", {model="police4",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked K9 Tahoe", {model="police6",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked CVPI", {model="police7",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Marked Impala", {model="police8",type=""},{"cadet","officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"State Charger", {model="statecharger",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"State Tahoe", {model="statetahoe",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"State CVPI", {model="statecvpi",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"State F350", {model="statef350",type=""},{"officer i","officer ii","sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Unmarked Charger", {model="fbi",type="undercover"},{"sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Unmarked Tahoe", {model="fbi2",type="undercover"},{"sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
        {"Mustang", {model="polgt500",type=""},{"chief of police"}},
    }
end

heli = {
    {settings.force.." Chopper",{model="polmav",type="helicopter"},{"sergeant","lieutenant","captain","asst. chief of police","chief of police"}},
}

function isNearStationGarage()
    for i = 1, #stationGarage do
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance < 30) then
            DrawMarker(1, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
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
            DrawMarker(1, stationHeliGarage[i].x, stationHeliGarage[i].y, stationHeliGarage[i].z-1, 0, 0, 0, 0, 0, 0, 9.0, 9.0, 2.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
            if(distance < 7) then
                return true
            elseif distance > 7 then
                heli_menu = false
            end
        end
    end
end

function carmenu()
    Menu.SetupMenu("car_menu","Police garage")
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
        if(isCop) then
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
            cop_menu = false
            armoury_menu = false
            Menu.DisplayCurMenu()
        end
        if heli_menu then
            menuX = 0.75
            car_menu = false
            cop_menu = false
            armoury_menu = false
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
    SetVehicleTyresCanBurst(existingVeh, false)
    SetVehicleNumberPlateText(existingVeh, plate)
    if tint then
        SetVehicleWindowTint(existingVeh, 1)
    elseif helicopter then
        SetVehicleLivery(existingVeh, 0)
    else
        SetVehicleWindowTint(existingVeh, 0)
    end
    SetVehicleDirtLevel(existingVeh, 0)
    TaskWarpPedIntoVehicle(ply, existingVeh, -1)
    car_menu = false
    heli_menu = false
end

function GarageBlips()
    for _, item in pairs(stationGarage) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 50)
      SetBlipColour(item.blip, 18)
      SetBlipScale(item.blip, 0.6)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Police Garages")
      EndTextCommandSetBlipName(item.blip)
    end
    for _, item in pairs(stationHeliGarage) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 43)
      SetBlipColour(item.blip, 18)
      SetBlipScale(item.blip, 0.6)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Helipads")
      EndTextCommandSetBlipName(item.blip)
    end
end

function RemoveGarageBlips()
    for _, item in pairs(stationGarage) do
        RemoveBlip(item.blip)
    end
    for _, item in pairs(stationHeliGarage) do
        RemoveBlip(item.blip)
    end
end