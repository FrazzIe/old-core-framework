armoury_menu = false

local armoury = {
    {name="Armoury", id=175, x=452.28164672852, y=-980.19580078125, z=30.689605712891}, -- Mission row
    {name="Armoury", id=175, x=-450.52, y=6011.33, z=31.72}, -- Paleto Bay
    {name="Armoury", id=175, x=1852.49, y=3691.61, z=34.27}, -- Sandy Shores
    {name="Armoury", id=175, x=-1078.54, y=-857.00, z=5.04}, -- San Andreas Ave
    {name="Armoury", id=175, x=-566.57, y=-132.83, z=37.96}, -- Rockford Hills
}

local guns = {
    {"Stun gun", {m="WEAPON_STUNGUN", a=nil}},
    {"Pistol .50", {m="WEAPON_PISTOL50", a=350}},
    {"Knife", {m="WEAPON_KNIFE", a=nil}},
    {"Flare", {m="WEAPON_FLARE", a=20}},
    {"Flashlight", {m="WEAPON_FLASHLIGHT", a=nil}},
    {"Nightstick", {m="WEAPON_NIGHTSTICK", a=nil}},
    {"Pumpshotgun", {m="WEAPON_PUMPSHOTGUN", a=350}},
    {"Carbine Rifle", {m="WEAPON_CARBINERIFLE", a=200}},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if(isInService) then
        	local pos = GetEntityCoords(GetPlayerPed(-1), true)
        	for k,v in ipairs(armoury) do
            	if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                	DrawMarker(1, v.x, v.y, v.z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
                	if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    	if not armoury_menu then
                        	drawTxt("Press ~g~E~s~ to open the Armoury",0,1,0.5,0.8,0.6,255,255,255,255)
                        else
                        	drawTxt("Press ~g~E~s~ to close the Armoury",0,1,0.5,0.8,0.6,255,255,255,255)
                        end
                    	if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                            Armoury()
                            armoury_menu = not armoury_menu
                    	end
                    elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                        armoury_menu = false
                    end
            	end
        	end
    	end
        if armoury_menu then
            menuX = 0.75
            car_menu = false
            cop_menu = false
            heli_menu = false
            Menu.DisplayCurMenu()
        end
    end
end)

local armourPosition = 1
function Armoury()
    Menu.SetupMenu("armoury_menu","Armoury")
    Menu.Switch(nil,"armoury_menu")
    for ind, value in pairs(guns) do
        Menu.addOption("armoury_menu", function()
            if(Menu.Option(value[1]))then
                equipGun(value[2])
            end
        end)
    end
    Menu.addOption("armoury_menu", function()
        if(Menu.StringArray("Armour:", {"< Put on >", "< Take off >"}, armourPosition,function(cb) armourPosition = cb end)) then
            if armourPosition == 1 then
                SetPedArmour(GetPlayerPed(-1), 100)
            elseif armourPosition == 2 then
                SetPedArmour(GetPlayerPed(-1), 0)
            end
        end         
    end)  
end

function equipGun(gun)
    if gun.a == nil then
        GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(gun.m), true, true)
    else
        GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(gun.m), gun.a, true, true)
    end
end

function ArmouryBlips()
    for _, item in pairs(armoury) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, 39)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
end

function RemoveArmouryBlips()
    for _, item in pairs(armoury) do
        RemoveBlip(item.blip)
    end
end