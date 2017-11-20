function drawSellTxt(text,font,centre,x,y,scale,r,g,b,a)
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

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Main Menu                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
gun_menu = false
sellgun_menu = false
ownedWeapons = {}

function MainGunMenu()
    Menu.SetupMenu("main_gun_menu","Los Santos Guns")
    Menu.Switch(nil,"main_gun_menu")
    Menu.addOption("main_gun_menu", function()
        if(Menu.Option("No license"))then
            guns("a")
        end
    end)
    Menu.addOption("main_gun_menu", function()
        if(Menu.Option("Level 1"))then
            guns("b")
        end
    end)
    Menu.addOption("main_gun_menu", function()
        if(Menu.Option("Level 2"))then
            guns("c")
        end
    end)
    Menu.addOption("main_gun_menu", function()
        if(Menu.Option("Level 3"))then
            guns("d")
        end
    end)
    Menu.addOption("main_gun_menu", function()
        if(Menu.Option("Level 4"))then
            guns("e")
        end
    end)
end

function SellGunMenu()
    Menu.SetupMenu("sell_gun_menu","Sell Weapons")
    Menu.Switch(nil,"sell_gun_menu")
    for k,v in pairs(ownedWeapons) do
        Menu.addOption("sell_gun_menu", function()
            if(Menu.GunBool(tostring(v.wn), gunsbool,"~g~$~w~"..v.sp,"~g~$~w~"..v.sp,function(cb)   gunsbool = cb end))then
                TriggerServerEvent("ws:sellweapon", v.w, v.sp)
            end
        end)
    end
end

RegisterNetEvent("ws:sold")
AddEventHandler("ws:sold", function()
    SellGunMenu()
end)

local gunsbool = false
function guns(cat)
    if cat ~= "f" then
        Menu.SetupMenu("guns_menu","Los Santos Guns")
        Menu.Switch("main_gun_menu","guns_menu")
    else
        Menu.SetupMenu("guns_menu","LS Blackmarket")
        Menu.Switch(nil,"guns_menu")
    end
    for ind, value in pairs(weapons[cat]) do
        Menu.addOption("guns_menu", function()
            if(Menu.GunBool(tostring(value[1]), gunsbool,"~g~$~w~"..value[3].price,"~g~$~w~"..value[3].price,function(cb)   gunsbool = cb end))then
                if gunsbool then
                    if value[2] == 1 then
                        buyweapon(value[3], cat)
                    else
                        buyillegalweapon(value[3], cat)
                    end
                else
                    if value[2] == 1 then
                        buyweapon(value[3], cat)
                    else
                        buyillegalweapon(value[3], cat)
                    end
                end
            end
        end)
    end
end

weapons = {
    ["a"] = {
        {"Machete", 1, {name="Machete", price=2000,license=0,model="WEAPON_MACHETE"}},
        {"Golfclub", 1, {name="Golfclub", price=1000,license=0,model="WEAPON_GOLFCLUB"}},
        {"Knuckle dusters", 1, {name="Knuckle dusters", price=600,license=0,model="WEAPON_KNUCKLE"}},
        {"Knife", 1, {name="Knife", price=550,license=0,model="WEAPON_KNIFE"}},
        {"Dagger", 1, {name="Dagger", price=500,license=0,model="WEAPON_DAGGER"}},
        {"Switchblade", 1, {name="Switchblade", price=500,license=0,model="WEAPON_SWITCHBLADE"}},
        {"Crowbar", 1, {name="Crowbar", price=250,license=0,model="WEAPON_CROWBAR"}},
        {"Bat", 1, {name="Bat", price=250,license=0,model="WEAPON_BAT"}},
        {"Bottle", 1, {name="Bottle", price=50,license=0,model="WEAPON_BOTTLE"}},
        {"Hammer", 1, {name="Hammer", price=50,license=0,model="WEAPON_HAMMER"}},
        {"Flashlight", 1, {name="Flashlight", price=50,license=0,model="WEAPON_FLASHLIGHT"}},
    },
    ["b"] = {
        {"Pistol", 1, {name="Pistol",price=2500,license=1,model="WEAPON_Pistol"}},
        {"Pistol 50", 1, {name="Pistol 50",price=5000,license=1,model="WEAPON_PISTOL50"}},
        {"SNS Pistol", 1, {name="SNS Pistol",price=6500,license=1,model="WEAPON_SNSPistol"}},
        {"Heavy Pistol", 1, {name="Heavy Pistol",price=8000,license=1,model="WEAPON_HeavyPistol"}},
        {"Revolver", 1, {name="Revolver",price=9900,license=1,model="WEAPON_Revolver"}},
    },
    ["c"] = {
        {"Pump Shotgun", 1, {name="Pump Shotgun",price=15000,license=2,model="WEAPON_PumpShotgun"}},
        {"Sawn-off Shotgun", 1, {name="Sawn-off Shotgun",price=22000,license=2,model="WEAPON_SAWNOFFSHOTGUN"}},
        {"Bullpup Shotgun", 1, {name="Bullpup Shotgun",price=35000,license=2,model="WEAPON_BullpupShotgun"}},
        {"Auto Shotgun", 1, {name="Auto Shotgun",price=55000,license=2,model="WEAPON_Autoshotgun"}},
    },
    ["d"] = {
        {"MicroSMG", 1, {name="MicroSMG",price=65000,license=3,model="WEAPON_MicroSMG"}},
        {"SMG", 1, {name="SMG",price=69000,license=3,model="WEAPON_SMG"}},
        {"Assault SMG", 1, {name="Assault SMG",price=73000,license=3,model="WEAPON_AssaultSMG"}},
        {"MG", 1, {name="MG",price=88000,license=3,model="WEAPON_MG"}},
        {"Gusenberg", 1, {name="Gusenberg",price=95000,license=3,model="WEAPON_Gusenberg"}},
    },
    ["e"] = {
        {"Assault Rifle", 1, {name="Assault Rifle",price=100000,license=4,model="WEAPON_AssaultRifle"}},
        {"Carbine Rifle", 1, {name="Carbine Rifle",price=120000,license=4,model="WEAPON_CarbineRifle"}},
        {"Advanced Rifle", 1, {name="Advanced Rifle",price=130000,license=4,model="WEAPON_AdvancedRifle"}},
        {"Special Carbine", 1, {name="Special Carbine",price=150000,license=4,model="WEAPON_SpecialCarbine"}},
    },
    ["f"] = {
        {"Pistol", 2, {name="Pistol",price=6000,license=5,model="WEAPON_Pistol"}},
        {"Gusenberg", 2, {name="Gusenberg", price=120000,license=5,model="WEAPON_Gusenberg"}},
        {"Special Carbine", 2, {name="Special Carbine",price=200000,license=5,model="WEAPON_SpecialCarbine"}},
        {"AP Pistol", 2, {name="AP Pistol",price=50000,license=5,model="WEAPON_APPISTOL"}},
        {"Sawn-Off Shotgun", 2, {name="Sawn-Off Shotgun",price=30000,license=5,model="WEAPON_SAWNOFFSHOTGUN"}},
    }
}

function buyweapon(item, cat)
    TriggerServerEvent("ws:checkMoney", item, cat)
end

function buyillegalweapon(item, cat)
    TriggerServerEvent("ws:checkMoneyillegal", item, cat)
end

RegisterNetEvent("ws:giveweapon")
AddEventHandler("ws:giveweapon", function(item)
    Citizen.CreateThread(function()
        local weapon = GetHashKey(item.model)
        Wait(1000)
        local hash = GetHashKey(item.model)
        GiveWeaponToPed(GetPlayerPed(-1), weapon, 1000, 0, false)
    end)
end)

RegisterNetEvent("ws:giveweapon2")
AddEventHandler("ws:giveweapon2", function(weap)
    Citizen.CreateThread(function()
        local weapon = GetHashKey(weap)
        Wait(1000)
        local hash = GetHashKey(weap)
        GiveWeaponToPed(GetPlayerPed(-1), weapon, 1000, 0, false)
    end)
end)

RegisterNetEvent("ws:removeWeapons")
AddEventHandler("ws:removeWeapons", function()
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press E to open/close menu in the red marker
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
gun_emplacement = {
    {name="Ammunation", colour=1, id=110, x= -1117.81, y= 2698.16, z= 18.55},
    {name="Ammunation", colour=1, id=110, x= 1693.93, y= 3759.73, z= 34.7},
    {name="Ammunation", colour=1, id=110, x= 251.85, y= -49.87, z= 69.94},
    {name="Ammunation", colour=1, id=110, x= -1306.17, y= -394.16, z= 36.69},
    {name="Ammunation", colour=1, id=110, x= -662.22, y= -935.71, z= 21.82},
    {name="Ammunation", colour=1, id=110, x= -330.00, y= 6083.41, z= 31.45},
    {name="Ammunation", colour=1, id=110, x= 2567.91, y= 294.74, z= 108.73},
    {name="Ammunation", colour=1, id=110, x= -3171.67, y= 1087.66, z= 20.83},
    {name="Ammunation", colour=1, id=110, x= 842.40, y= -1033.12, z= 28.19},
    {name="Ammunation", colour=1, id=110, x= 21.70, y= -1107.41, z= 29.79},
    {name="Ammunation", colour=1, id=110, x= 810.15, y= -2156.88, z= 29.61},
}

gun_emplacement_grove = {
    {name="Grove St. Gun Shop", colour=4, id=110, x=7.7238087654114, y=-1894.3465576172, z=23.162649154663},
    {name="Grove St. Gun Shop", colour=4, id=110, x=-1000.4946899414, y=4848.3916015625, z=274.89318847656},
}

sellweapons = {
    {name="Sell weapons", colour=2, id=434, x=19.142578125, y=-1104.2302246094, z=29.79700088501},
    {name="Sell weapons", colour=2, id=434, x=846.16723632813, y=-1034.9733886719, z=28.245889663696}, 
    {name="Sell weapons", colour=2, id=434, x=813.94311523438, y=-2158.876953125, z=29.619020462036},
    {name="Sell weapons", colour=2, id=434, x=-666.05834960938, y=-933.73907470703, z=21.829214096069},
    {name="Sell weapons", colour=2, id=434, x=-1303.5306396484, y=-390.9504699707, z=36.695751190186},
    {name="Sell weapons", colour=2, id=434, x=254.81108093262, y=-46.906475067139, z=69.941078186035},
    {name="Sell weapons", colour=2, id=434, x=-3174.9465332031, y=1084.7476806641, z=20.838752746582},
    {name="Sell weapons", colour=2, id=434, x=-1121.7216796875, y=2697.1447753906, z=18.55415725708},
    {name="Sell weapons", colour=2, id=434, x=1689.8410644531, y=3758.0588378906, z=34.705303192139},
    {name="Sell weapons", colour=2, id=434, x=-334.26705932617, y=6082.1689453125, z=31.45475769043},
    {name="Sell weapons", colour=2, id=434, x=2571.7854003906, y=292.71542358398, z=108.73484802246},
}

local incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(gun_emplacement) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, 0.7)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(gun_emplacement) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy weapons!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 20
                        titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      --
                        titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 --
                        optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      --
                        optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
                        menuX = 0.75 ----------------------------- X position of the menu                          --
                        menuXOption = 0.075 --------------------- X postiion of Menu.Option text                  --
                        menuXOtherOption = 0.027 ---------------- X position of Bools, Arrays etc text            --
                        menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                --
                        menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons --
                        menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down --
                        gun_menu = not gun_menu
                        MainGunMenu()
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    gun_menu = false
                end
            end
        end
        for k,v in ipairs(gun_emplacement_grove) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 10, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy weapons!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 20
                        titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      --
                        titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 --
                        optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      --
                        optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
                        menuX = 0.75 ----------------------------- X position of the menu                          --
                        menuXOption = 0.075 --------------------- X postiion of Menu.Option text                  --
                        menuXOtherOption = 0.027 ---------------- X position of Bools, Arrays etc text            --
                        menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                --
                        menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons --
                        menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down --
                        gun_menu = not gun_menu
                        guns("f")
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    gun_menu = false
                end
            end
        end
        for k,v in ipairs(sellweapons) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.0001, 1555, 10, 100,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to sell weapons!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 20
                        titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      --
                        titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 --
                        optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      --
                        optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
                        menuX = 0.75 ----------------------------- X position of the menu                          --
                        menuXOption = 0.075 --------------------- X postiion of Menu.Option text                  --
                        menuXOtherOption = 0.027 ---------------- X position of Bools, Arrays etc text            --
                        menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                --
                        menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons --
                        menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down --
                        sellgun_menu = not sellgun_menu
                        SellGunMenu()
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    sellgun_menu = false
                end
            end
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Help messages
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
