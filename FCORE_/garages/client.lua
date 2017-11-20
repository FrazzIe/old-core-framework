--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Garages                                                            --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
user_vehicles = {}                                                                                                             --
user_garages = {}                                                                                                              --
out = {}                                                                                                                        --
local replacementgarage = {x=0.0,y=0.0,z=0.0,heading=0.0}
local currentgaragecost = nil                                                                                                   --
local slotprice = 10000                                                                                                         --
local garageposition = 1                                                                                                        --                                                                                               
local vehiclebool = false                                                                                                       --
local insurancebool = false                                                                                                     --
garage_menu = false                                                                                                             --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Configuration                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
insurance = {
  {name="2007 Toyota Camry V6",cost=4000},
  {name="2017 Honda Accord V6",cost=5000},
  {name="2017 Subaru BRZ t-S",cost=12500},
  {name="2014 Lexus LX570",cost=15000},
  {name="2015 Lexus GS350F",cost=20000},
  {name="2002 Honda NSX",cost=22500}, 
  {name="2015 Mitsubishi Evo X",cost=22500},
  {name="2006 Mitsubishi Evo IX",cost=24000},
  {name="2004 Subaru WRX STi",cost=25000},
  {name="2006 Subaru WRX STi",cost=26500},
  {name="2004 Nissan GT-R R34",cost=27000},
  {name="1998 Toyota Supra",cost=35000},
  {name="2015 Nissan GTR R35",cost=75000},
  {name="1986 MB 560SEL",cost=5000},
  {name="1995 BMW M3 E36T",cost=8000},
  {name="1995 BMW M5 E34",cost=8000},
  {name="1990 MB 600SEL",cost=8500},
  {name="1999 BMW 750iL E38",cost=8900},
  {name="2016 VW Golf GTI",cost=9000},
  {name="2006 VW Beetle Turbo",cost=9000},
  {name="2016 Mini CooperWorks",cost=9000},
  {name="2001 Audi S4",cost=9200},
  {name="2002 MB C32 AMG",cost=9200},
  {name="2003 BMW M5 E39",cost=9200},
  {name="2012 Range Rover SC",cost=10000},
  {name="2013 Audi RS4 Avant",cost=12000},
  {name="15 Range Rover Vouge",cost=13000},
  {name="2012 Audi Q7 V12",cost=16000}, 
  {name="1982 Porsche 911 Turbo",cost=17500}, 
  {name="2009 Audi RS6 Avant",cost=20000},
  {name="2013 Audi S8 FSI",cost=22500},
  {name="2012 MB C63 AMG",cost=24500},
  {name="1960 AustinHealey",cost=25000}, 
  {name="2016 Maserati GhibliS",cost=27500}, 
  {name="13 AM Vanquish",cost=35000}, 
  {name="16 Porsche 911 TurboS",cost=85000},
  {name="2013 Lambo LP570-4",cost=150000},        
  {name="16 Audi R8 V10",cost=200000},
  {name="2015 Ferrari 488GTB",cost=235000},       
  {name="2010 Lambo LP650-4",cost=250000},
  {name="1991 Lincoln TownCar",cost=2500},
  {name="2003 Ford CrownVic LX",cost=5000},
  {name="2003 GMC Yukon XL",cost=7500},
  {name="12 Chevy Silverado LTZ",cost=8500},
  {name="2013 Ford Explorer V6",cost=10000},
  {name="1968 Ford Mustang FB",cost=10000},
  {name="1969 Chevy Camaro SS",cost=11000},
  {name="1970 Dodge Challenger",cost=11000},
  {name="1970 Plymouth HemiCuda",cost=11000},
  {name="1970 Chevy Chevelle SS",cost=11000},
  {name="1967 Ford GT500",cost=11500},  
  {name="69 Ford MustangBOSS302",cost=12000},
  {name="Jeep TrailCat",cost=12500},
  {name="1954 Ford Thunderbird",cost=13500},
  {name="70 Dodge ChargerMagnum",cost=15000},
  {name="2014 Cadillac Escalade",cost=15000},
  {name="66 Shelby Cobra 427 SC",cost=17500},
  {name="15 Chrysler 300CSRT8",cost=20000},
  {name="16 Dodge Charger RT",cost=22500},
  {name="16 Ford Focus RS",cost=23500},
  {name="2015 Jaguar F-Type",cost=24000},
  {name="2013 Ford F150 Raptor",cost=25000},       
  {name="2016 Ford Mustang GT",cost=25500},
  {name="2015 Corvette C7-Z06",cost=29500},
  {name="15 Challenger Hellcat",cost=125000},
  {name="Coquette3",cost=11500},
  {name="Feltzer3",cost=15500},
  {name="Guardian",cost=18000},
  {name="Contender",cost=18500},
  {name="TrophyTruck2",cost=18500},
  {name="Lurcher",cost=19000},
  {name="Btype",cost=22500},
  {name="Slamvan",cost=22500},
  {name="Slamvan2",cost=22500},
  {name="Slamvan3",cost=22500},
  {name="Minivan2",cost=23500},
  {name="Sabre GT2",cost=24500},
  {name="Tornado5",cost=24500},
  {name="Virgo2",cost=24500},
  {name="Comet3",cost=29000},
  {name="Torero",cost=29500},
  {name="Osiris",cost=60000},
  {name="Elegy1",cost=65000},
  {name="SultanRS",cost=68500},
  {name="Specter",cost=75000},
  {name="Tempesta",cost=82000},
  {name="ItaliGTB2",cost=100000},
  {name="Cheetah2",cost=130000},
  {name="XA21",cost=150000},
  {name="Nero",cost=200000},
  {name="Blista",cost=1500},
  {name="Brioso R/A",cost=1550},
  {name="Dilettante",cost=2000},
  {name="Issi",cost=2000},
  {name="Panto",cost=2500},
  {name="Prairie",cost=2500},
  {name="Rhapsody",cost=2500},
  {name="Cognoscenti Cabrio",cost=12500},
  {name="Exemplar",cost=12500},
  {name="F620",cost=13000},
  {name="Felon",cost=13000},
  {name="Felon GT",cost=13500},
  {name="Jackal",cost=10500},
  {name="Oracle",cost=11000},
  {name="Oracle XS",cost=11500},
  {name="Sentinel",cost=11000},
  {name="Sentinel XS",cost=11500},
  {name="Windsor",cost=13500},
  {name="Windsor Drop",cost=14500},
  {name="Zion",cost=11000},
  {name="Zion Cabrio",cost=12500},
  {name="9F",cost=12000},
  {name="9F Cabrio",cost=13000},
  {name="Alpha",cost=12000},
  {name="Banshee",cost=13000},
  {name="Bestia GTS",cost=13500},
  {name="Buffalo",cost=9500},
  {name="Buffalo2",cost=9900},
  {name="Carbonizzare",cost=13500},
  {name="Comet",cost=14500},
  {name="Coquette",cost=15000},
  {name="Feltzer",cost=15000},
  {name="TrophyTruck",cost=14500},
  {name="Furore GT",cost=18500},
  {name="Fusilade",cost=17500},
  {name="Jester",cost=18500},
  {name="Jester Race",cost=20000},
  {name="Lynx",cost=20000},
  {name="Massacro",cost=20500},
  {name="Massacro Race",cost=22500},
  {name="Omnis",cost=24500},
  {name="Penumbra",cost=21500},
  {name="Drift Tampa",cost=26500},
  {name="Rapid GT",cost=29000},
  {name="Rapid GT Convertible",cost=29500},
  {name="Schafter V12",cost=30000},
  {name="Sultan",cost=20000},
  {name="Surano",cost=19000},
  {name="Tropos",cost=19500},
  {name="Verkierer",cost=22000},
  {name="Kuruma",cost=30000},
  {name="Casco",cost=14500},
  {name="Coquette Classic",cost=15500},
  {name="JB 700",cost=16000},
  {name="Pigalle",cost=15000},
  {name="Stinger",cost=14500},
  {name="Stinger GT",cost=16500},
  {name="Stirling GT",cost=14000},
  {name="Ztype",cost=19500},
  {name="Adder",cost=32000},
  {name="Banshee 900R",cost=29000},
  {name="Bullet",cost=29000},
  {name="Cheetah",cost=32000},
  {name="Entity XF",cost=33000},
  {name="ETR1",cost=29500},
  {name="FMJ",cost=28900},
  {name="Infernus",cost=32500},
  {name="Osiris",cost=35000},
  {name="RE-7B",cost=36000},
  {name="Reaper",cost=35000},
  {name="T20",cost=36500},
  {name="Turismo R",cost=38500},
  {name="Tyrus",cost=27500},
  {name="Vacca",cost=28500},
  {name="Voltic",cost=31000},
  {name="X80 Proto",cost=41000},
  {name="Zentorno",cost=45000},
  {name="Blade",cost=1800},
  {name="Buccaneer",cost=1900},
  {name="Chino",cost=2000},
  {name="Coquette BlackFin",cost=9000},
  {name="Dominator",cost=9500},
  {name="Dukes",cost=9500},
  {name="Gauntlet",cost=8900},
  {name="Hotknife",cost=10500},
  {name="Faction",cost=10000},
  {name="Nightshade",cost=12000},
  {name="Picador",cost=12000},
  {name="Sabre Turbo",cost=8500},
  {name="Tampa",cost=8500},
  {name="Virgo",cost=10500},
  {name="Vigero",cost=11000},
  {name="Bifta",cost=2800},
  {name="Blazer",cost=2900},
  {name="Brawler",cost=2500},
  {name="Sadler",cost=3900},
  {name="Dubsta 6x6",cost=9000},
  {name="Rebel",cost=7500},
  {name="Sandking",cost=9500},
  {name="Sandking XL",cost=12500},
  {name="Trophy Truck",cost=14500},
  {name="Baller",cost=3800},
  {name="Cavalcade",cost=4000},
  {name="Grabger",cost=4500},
  {name="Huntley S",cost=4800},
  {name="Landstalker",cost=5500},
  {name="Radius",cost=6500},
  {name="Rocoto",cost=7500},
  {name="Seminole",cost=8500},
  {name="XLS",cost=10000},
  {name="Bison",cost=2800},
  {name="Bobcat XL",cost=3000},
  {name="Gang Burrito",cost=3500},
  {name="Journey",cost=1500},
  {name="Minivan",cost=3500},
  {name="Paradise",cost=4500},
  {name="Rumpo",cost=3500},
  {name="Surfer",cost=4200},
  {name="Youga",cost=3800},
  {name="Asea",cost=1800},
  {name="Fugitive",cost=2900},
  {name="Asterope",cost=3430},
  {name="Glendale",cost=4000},
  {name="Ingot",cost=35000},
  {name="Intruder",cost=4200},
  {name="Premier",cost=3900},
  {name="Primo",cost=2500},
  {name="Primo Custom",cost=3000},
  {name="Schafter",cost=6500},
  {name="Tailgater",cost=6200},
  {name="Warrener",cost=8500},
  {name="Washington",cost=9500},
  {name="Surge",cost=9900},
  {name="Super Diamond",cost=12500},
  {name="Stretch",cost=15000},
  {name="Akuma",cost=900},
  {name="Bagger",cost=1500},
  {name="Bati 801",cost=1500},
  {name="Bati 801RR",cost=1500},
  {name="BF400",cost=3500},
  {name="Carbon RS",cost=4000},
  {name="Cliffhanger",cost=4500},
  {name="Daemon",cost=1500},
  {name="Double T",cost=1200},
  {name="Enduro",cost=4800},
  {name="Faggio",cost=350},
  {name="Gargoyle",cost=4200},
  {name="Hakuchou",cost=8200},
  {name="Hexer",cost=1600},
  {name="Innovation",cost=5000},
  {name="Lectro",cost=7000},
  {name="Nemesis",cost=1800},
  {name="PCJ-600",cost=900},
  {name="Ruffian",cost=900},
  {name="Sanchez",cost=400},
  {name="Sovereign",cost=6600},
  {name="Thrust",cost=7500},
  {name="Vader",cost=1900},
  {name="FCR",cost=1900},
  {name="Vindicator",cost=9000},
  {name="Diablous",cost=9000},
  {name="DUCATI RR",cost=4000},
  {name="Harley Fatboy",cost=4900},
  {name="Harley KnuckleHead",cost=6000},
  {name="Journey",cost=1500},
  {name="Jeep TrailCat",cost=12500},
  {name="Street ATV",cost=8500},
  {name="ATV",cost=390},
}

claimspots = {
    {x=119.04019927979,y=-1069.9571533203,z=29.192367553711},
    {x=132.35586547852,y=-1070.0307617188,z=29.212236404419},
    {x=136.11077880859,y=-1081.8492431641,z=29.19366645813},
    {x=121.38340759277,y=-1081.7225341797,z=29.193054199219},
    {x=154.58160400391,y=-1081.8524169922,z=29.192380905151},
}

emplacement_garage = {
    {name="Public Garage", colour=1, sprite=357, x=211.12405395508,y=-799.40057373047,z=30.903099060059,id=1,gname="Park [1]",cost=0,heading=0.0,maxslots=5}, -- Public Park
    {name="Public Garage", colour=1, sprite=357, x=-443.00497436523,y=185.29835510254,z=75.203712463379,id=2,gname="North LS [2]",cost=0,heading=0.0,maxslots=5}, -- Public Upper City
    {name="Public Garage", colour=1, sprite=357, x=1232.4792480469,y=2708.3212890625,z=38.005790710449,id=3,gname="Sandy [3]",cost=0,heading=0.0,maxslots=5}, -- Public Sandy
    {name="Public Garage", colour=1, sprite=357, x=117.96788024902,y=6599.45703125,z=32.013603210449,id=4,gname="Paleto [4]",cost=0,heading=-90.0,maxslots=5}, -- Public Paleto
    {name="Personal Garage", colour=3, sprite=357, x=947.13641357422,y=-1697.9788818359,z=30.085023880005,id=5,gname="Industrial [5]",cost=120000,heading=-95.0,maxslots=10}, -- Personal
    {name="Personal Garage", colour=3, sprite=357, x=520.40753173828,y=168.9965057373,z=99.372108459473,id=6,gname="Apartment Complex [6]",cost=80000,heading=-110.0,maxslots=6}, -- Personal
    {name="Personal Garage", colour=3, sprite=357, x=-676.56494140625,y=904.18371582031,z=230.58193969727,id=7,gname="Hills [7]",cost=1500000,heading=-45.0,maxslots=12}, -- Personal
    {name="Personal Garage", colour=3, sprite=357, x=258.68347167969,y=2589.7287597656,z=44.954097747803,id=8,gname="Autoshop Garage [8]",cost=100000,heading=10.0,maxslots=8}, -- Personal
    {name="Personal Garage", colour=3, sprite=357, x=-226.0922088623,y=6436.400390625,z=31.197317123413,id=9,gname="Residential [9]",cost=50000,heading=225.0,maxslots=4}, -- Personal
    {name="Personal Garage", colour=3, sprite=357, x=-833.24926757813,y=-392.95385742188,z=31.325246810913,id=10,gname="Weazel [10]",cost=150000,heading=225.0,maxslots=12}, -- Personal
    {name="Personal Garage", colour=3, sprite=357, x=-30.303638458252,y=2.1268248558044,z=71.200004577637,id=11,gname="Small Garage [11]",cost=50000,heading=150.0,maxslots=4}, -- Personal
    {name="Personal Garage", colour=3, sprite=357, x=-84.019691467285,y=-820.99694824219,z=36.028030395508,id=12,gname="Maze Tower [12]",cost=250000,heading=-365.0,maxslots=32}, -- Personal
}

emplacement_insurance = {
    {name="Buy Insurance", colour=69, sprite=498, x=-32.958335876465,y=-1111.619140625,z=26.422338485718},
}

emplacement_selling = {
    {name="Sell vehicles", colour=1, sprite=225, x=-44.919033050537,y=-1082.6441650391,z=26.685247421265},
}

emplacement_claim = {    
    {name="Claim Insurance", colour=3, sprite=467, x=150.1743927002,y=-1040.1678466797,z=29.374069213867},
}

emplacement_garage_options = {    
    {name="Modify garages", colour=3, sprite=78, x=-55.156490325928,y=-1089.9210205078,z=26.322859191895},
}
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                            Events                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterNetEvent("garage:updateVehicles")
AddEventHandler("garage:updateVehicles", function(data, gdata)
    user_vehicles = data
    user_garages = gdata
end)

RegisterNetEvent("garage:insurance")
AddEventHandler("garage:insurance",function()
    garage_menu = false
end)

RegisterNetEvent("garage:buy")
AddEventHandler("garage:buy",function()
    garage_menu = false
end)

RegisterNetEvent("garage:transfer")
AddEventHandler("garage:transfer",function()
    garage_menu = false
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Open Menus                                                          --
--                                                          Draw Blips                                                          --
--                                                         Draw Markers                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(emplacement_garage) do
        addBlip(item)
    end
    for _, item in pairs(emplacement_insurance) do
        addBlip(item)
    end
    for _, item in pairs(emplacement_selling) do
        addBlip(item)
    end
    for _, item in pairs(emplacement_claim) do
        addBlip(item)
    end
    for _, item in pairs(emplacement_garage_options) do
        addBlip(item)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(emplacement_garage) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 3.5)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to open the garage!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
                        GUI.maxVisOptions = 10; titleTextSize = {0.85, 0.65}; titleRectSize = {0.16, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.16, 0.035}; menuX = 0.75; menuXOption = 0.075; menuXOtherOption = 0.055; menuYModify = 0.3000; menuYOptionDiv = 8.56; menuYOptionAdd = 0.36
                        currentgarage = emplacement_garage[k]
                        garageposition = 1
                        garage_menu = not garage_menu
                        garage() -- Menu to draw
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 3.5)then
                    incircle = false
                    garage_menu = false
                end
            end
        end
        for k,v in ipairs(emplacement_insurance) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy an insurance!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
                        GUI.maxVisOptions = 20; titleTextSize = {0.85, 0.80}; titleRectSize = {0.23, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.23, 0.035}; menuX = 0.745; menuXOption = 0.11; menuXOtherOption = 0.06; menuYModify = 0.1500; menuYOptionDiv = 4.285; menuYOptionAdd = 0.21;
                        garage_menu = not garage_menu
                        insuranceMenu() -- Menu to draw
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    garage_menu = false
                end
            end
        end
        for k,v in ipairs(emplacement_claim) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to claim insurance!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 10; titleTextSize = {0.85, 0.65}; titleRectSize = {0.16, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.16, 0.035}; menuX = 0.75; menuXOption = 0.075; menuXOtherOption = 0.055; menuYModify = 0.3000; menuYOptionDiv = 8.56; menuYOptionAdd = 0.36
                        garage_menu = not garage_menu
                        claimMenu()
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    garage_menu = false
                end
            end
        end
        for k,v in ipairs(emplacement_garage_options) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 3.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to modify your garages!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then -- INPUT_CELLPHONE_DOWN
                        GUI.maxVisOptions = 20; titleTextSize = {0.85, 0.80}; titleRectSize = {0.23, 0.085}; optionTextSize = {0.5, 0.5}; optionRectSize = {0.23, 0.035}; menuX = 0.745; menuXOption = 0.11; menuXOtherOption = 0.06; menuYModify = 0.1500; menuYOptionDiv = 4.285; menuYOptionAdd = 0.21;
                        garage_menu = not garage_menu
                        GarageOptions()
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 3.0)then
                    incircle = false
                    garage_menu = false
                end
            end
        end
        for k,v in ipairs(emplacement_selling) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 3.5001, 3.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 3.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to sell your car for half the purchase price!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) and IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then -- INPUT_CELLPHONE_DOWN
                        currentgarage = emplacement_selling[k]
                        local veh = GetClosestVehicle(currentgarage.x, currentgarage.y, currentgarage.z, 3.000, 0, 70)
                        if DoesEntityExist(veh) then
                            local stored = false
                            local plate = GetVehicleNumberPlateText(veh)
                            for i = 1, #user_vehicles do
                                if tostring(plate) == tostring(user_vehicles[i].p) or veh == tonumber(user_vehicles[i].instance) then
                                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                                    stored = true
                                    TriggerServerEvent("garage:sell", user_vehicles[i].p, user_vehicles[i].c)
                                end
                            end
                            if not stored then
                                exports.pNotify:SendNotification({text = "This is not your vehicle!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                            end
                        else
                            exports.pNotify:SendNotification({text = "You aren't a vehicle, idiot!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        end
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 3.0)then
                    incircle = false
                end
            end
        end
    end
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Garage Menu                                                         --
--                                                      Buy/Store/Retrieve                                                      --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function garage()
    local t = true
    for i = 1, #user_garages do
        if user_garages[i].id == currentgarage.id then
            t = false
        end
    end
    if t then
        currentgaragecost = currentgarage.cost
        menuXOtherOption = 0.027
        Menu.SetupMenu("buy_menu","Buy Garage")
        Menu.Switch(nil,"buy_menu")
        Menu.addOption("buy_menu", function()
            if(Menu.GarageBool(currentgarage.gname, vehiclebool, "~g~$~w~"..currentgaragecost,"~g~$~w~"..currentgaragecost,function(cb)   vehiclebool = cb end))then
                TriggerServerEvent("garage:buy", currentgaragecost, currentgarage.id, garageposition)
            end
        end)
        Menu.addOption("buy_menu", function()
            local slots = {}
            for i = 1, currentgarage.maxslots do
                table.insert(slots, ""..i)
            end
            if(Menu.GarageArray("Slots:", slots, garageposition,function(cb) garageposition = cb end)) then
                currentgaragecost = currentgarage.cost + slotprice * (garageposition - 1)         
            end         
        end)
    else
        menuXOtherOption = 0.055
        Menu.SetupMenu("garage_menu","Garage")
        Menu.Switch(nil,"garage_menu")
        Menu.addOption("garage_menu", function()
            if(Menu.Option("Retrieve a vehicle"))then
                GetVehicles()
            end
        end)
        Menu.addOption("garage_menu", function()
            if(Menu.Option("Store a vehicle"))then
                StoreVehicle()
            end
        end)
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Garage Menu                                                         --
--                                                           Retrieve                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function getCarQ()
    local count = 0
    for i=1,#user_vehicles do
        if user_vehicles[i].cg == currentgarage.id then
            count = count + 1
        end
    end
    return count
end

function getGarageQ()
    for i=1,#user_garages do
        if user_garages[i].id == currentgarage.id then
            return user_garages[i].count
        end
    end
    return "gay"
end

function GetVehicles()
    Menu.SetupMenu("vehicle_list","Cars: " .. getCarQ() .. "/" .. getGarageQ())
    Menu.Switch("garage_menu","vehicle_list")
    for i = 1,#user_vehicles do
        if (user_vehicles[i] ~= nil) then
            if user_vehicles[i].cg == currentgarage.id then
                Menu.addOption("vehicle_list", function()
                    if(Menu.Bool(tostring(user_vehicles[i].n), vehiclebool, tostring(user_vehicles[i].s),tostring(user_vehicles[i].s),function(cb)   vehiclebool = cb end))then
                        if user_vehicles[i].s ~= "~r~Missing" and user_vehicles[i].s ~= "~r~Impounded" then
                            garage_menu = false
                            SpawnVehicle(user_vehicles[i])
                        else
                            exports.pNotify:SendNotification({text = "This vehicle is not in the garage", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                        end
                    end
                end)
            end
        end
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                        Insurance Menu                                                        --
--                                                        Buy Insurance                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function insuranceMenu()
    Menu.SetupMenu("insurance_menu","Insurance")
    Menu.Switch(nil,"insurance_menu")
    for i = 1,#user_vehicles do
        if (user_vehicles[i] ~= nil) then
            local cn = tostring(user_vehicles[i].n)
            local cost = getInsuranceCost(cn)
            if user_vehicles[i].ins == "false" or user_vehicles[i].ins == 0 or user_vehicles[i].ins == "0" then
                Menu.addOption("insurance_menu", function()
                    if(Menu.CarBool(tostring(user_vehicles[i].n), insurancebool, "~g~$~w~"..cost,"~g~$~w~"..cost,function(cb)   insurancebool = cb end))then
                        TriggerServerEvent("garage:insurance", user_vehicles[i].p, cost)
                    end
                end)
            elseif user_vehicles[i].ins == "true" then
                Menu.addOption("insurance_menu", function()
                    if(Menu.CarBool(tostring(user_vehicles[i].n), insurancebool, "~g~Insured","~g~Insured",function(cb)   insurancebool = cb end))then
                    end
                end)
            else
                Citizen.Trace("This is an error: "..user_vehicles[i].ins.." report it to an admin!")
            end
        end
    end
end

function getInsuranceCost(car)
    for i = 1, #insurance do
        if car == insurance[i].name then
            return insurance[i].cost
        end
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Claim Menu                                                          --
--                                               Get your car back if its insured                                               --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function claimMenu()
    Menu.SetupMenu("claim_menu","Insurance Claims")
    Menu.Switch(nil,"claim_menu")
    for i = 1,#user_vehicles do
        if (user_vehicles[i] ~= nil) then
            if user_vehicles[i].ins == "true" and user_vehicles[i].s == "~r~Missing" and user_vehicles[i].s ~= "~r~Impounded" then

                Menu.addOption("claim_menu", function()
                    if(Menu.Bool(tostring(user_vehicles[i].n), vehiclebool, "~g~Claim", "~g~Claim",function(cb)   vehiclebool = cb end))then
                        local instance = user_vehicles[i].instance
                        Citizen.Trace("CURRENT instance == "..instance)
                        local count = math.random(1,5)
                        for b = 1, #claimspots do
                            if b == count then
                                replacementgarage.x = claimspots[count].x
                                replacementgarage.y = claimspots[count].y
                                replacementgarage.z = claimspots[count].z
                                replacementgarage.heading = 0.0
                            end
                        end
                        local isAreaCrowded = GetClosestVehicle(replacementgarage.x, replacementgarage.y, replacementgarage.z, 3.000, 0, 70)
                        if DoesEntityExist(isAreaCrowded) then
                            exports.pNotify:SendNotification({text = "Try again, the spawn location is occupied!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                        else
                            for a = 1, #out do
                                if out[a] == instance then
                                    table.remove(out, a)
                                    SpawnReplacement(user_vehicles[i])
                                    while DoesEntityExist(instance) do
                                        local pos = GetPlayerCoords(PlayerPedId, 0)
                                        SetEntityCoords(instance, pos.x, pos.y, pos.z-2.0)
                                        SetEntityAsMissionEntity(instance, true, true)
                                        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(tonumber(instance)))
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Modify Menu                                                         --
--                                                       Buy more storage                                                       --
--                                                        Transfer Cars                                                         --
--                                                         Sell garages                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function GarageOptions()
    Menu.SetupMenu("garage_options_menu","Modify Garages")
    Menu.Switch(nil,"garage_options_menu")
    for i = 1,#user_garages do
        if (user_garages[i] ~= nil) then
            Menu.addOption("garage_options_menu", function()
                local a = user_garages[i].id
                if(Menu.Option(emplacement_garage[a].gname))then
                    subGarageOptions(user_garages[i])
                end
            end)
        end
    end
end

function subGarageOptions(garage)
    local currentgaragecost = 10000
    Menu.SetupMenu("subgarage_options_menu",emplacement_garage[garage.id].gname)
    Menu.Switch("garage_options_menu","subgarage_options_menu")
    currentOption = 0
    Menu.addOption("subgarage_options_menu", function()
        if(Menu.Option("Transfer a car to this garage"))then
            transferVehicle(garage)
        end
    end)
    if garage.id > 4 then
        Menu.addOption("subgarage_options_menu", function()
            if(Menu.Option("Sell garage"))then
                TriggerServerEvent("garage:sellg", garage.id)
            end
        end)
    end
    if garage.count ~= emplacement_garage[garage.id].maxslots then
        Menu.addOption("subgarage_options_menu", function()
            if(Menu.GarageBool("Upgrade storage", vehiclebool, "~g~$~w~"..currentgaragecost,"~g~$~w~"..currentgaragecost,function(cb)   vehiclebool = cb end))then
                TriggerServerEvent("garage:buyslots", currentgaragecost, garage.id, (garageposition + garage.count))
            end
        end)
        Menu.addOption("subgarage_options_menu", function()
            local slots = {}
            for a = (garage.count + 1), emplacement_garage[garage.id].maxslots do
                table.insert(slots, ""..a)
            end
            if(Menu.GarageArray("Increase slots from "..garage.count.." to:", slots, garageposition,function(cb) garageposition = cb end)) then
                currentgaragecost = slotprice * garageposition       
            end         
        end)
    end
end

function transferVehicle(garage)
    Menu.SetupMenu("vehicletransfer_menu",emplacement_garage[garage.id].gname)
    Menu.Switch("subgarage_options_menu","vehicletransfer_menu")
    for i = 1, #user_vehicles do
        Menu.addOption("vehicletransfer_menu", function()
            if(Menu.TransferBool(user_vehicles[i].n, vehiclebool, emplacement_garage[user_vehicles[i].cg].gname,emplacement_garage[user_vehicles[i].cg].gname,function(cb)   vehiclebool = cb end))then
                local count = 0
                for a = 1,#user_vehicles do
                    if user_vehicles[a].cg == garage.id then
                        count = count + 1
                    end
                end
                local actualslots = garage.count
                if count <= actualslots and user_vehicles[i].cg == garage.id then
                    exports.pNotify:SendNotification({text = "You cannot transfer a vehicle to the same garage", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                elseif count < actualslots and user_vehicles[i].cg ~= garage.id then
                    if user_vehicles[i].s == "~g~Stored" then
                        TriggerServerEvent("garage:transfer", user_vehicles[i].p, garage.id)
                    else
                        exports.pNotify:SendNotification({text = "Your car must be stored to transfer it!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                    end
                else
                    exports.pNotify:SendNotification({text = "This garage is full!", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
                end
            end
        end)       
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Garage Functions                                                       --
--                                                        Store/Retrieve                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function StoreVehicle()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local veh = GetClosestVehicle(currentgarage.x, currentgarage.y, currentgarage.z, 3.000, 0, 70)
        if DoesEntityExist(veh) then
            for i = 1, #out do
                if out[i] == veh then
                    table.remove(out, i)
                end
            end
            SetEntityAsMissionEntity(veh, true, true)
            local turbo
            local tiresmoke
            local xenon
            local neon0
            local neon1
            local neon2
            local neon3
            local bulletproof
            local variation
            local plate = GetVehicleNumberPlateText(veh)
            local colors = table.pack(GetVehicleColours(veh))
            local extra_colors = table.pack(GetVehicleExtraColours(veh))
            local neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
            local smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
            if IsToggleModOn(veh,18) then
                turbo = "on"
            else
                turbo = "off"
            end
            if IsToggleModOn(veh,20) then
                tiresmoke = "on"
            else
                tiresmoke = "off"
            end
            if IsToggleModOn(veh,22) then
                xenon = "on"
            else
                xenon = "off"
            end
            if IsVehicleNeonLightEnabled(veh,0) then
                neon0 = "on"
            else
                neon0 = "off"
            end
            if IsVehicleNeonLightEnabled(veh,1) then
                neon1 = "on"
            else
                neon1 = "off"
            end
            if IsVehicleNeonLightEnabled(veh,2) then
                neon2 = "on"
            else
                neon2 = "off"
            end
            if IsVehicleNeonLightEnabled(veh,3) then
                neon3 = "on"
            else
                neon3 = "off"
            end
            if GetVehicleTyresCanBurst(veh) then
                bulletproof = "off"
            else
                bulletproof = "on"
            end
            if GetVehicleModVariation(veh,23) then
                variation = "on"
            else
                variation = "off"
            end
            local stored = false
            for i = 1, #user_vehicles do
                if tostring(plate) == tostring(user_vehicles[i].p) then
                    local count = 0
                    for a = 1,#user_vehicles do
                        if user_vehicles[a].cg == currentgarage.id then
                            count = count + 1
                        end
                    end
                    local actualslots
                    for b = 1,#user_garages do
                        if user_garages[b].id == currentgarage.id then
                            actualslots = user_garages[b].count
                        end
                    end
                    if count <= actualslots and user_vehicles[i].cg == currentgarage.id then
                        local data = {
                            n="no", -- Name
                            m=GetEntityModel(veh), -- Model
                            instance=veh, -- Current vehicle instance
                            cg=currentgarage.id,
                            p=GetVehicleNumberPlateText(veh), -- Plate
                            s="~g~Stored", -- State
                            cp=colors[1], -- Colour Primary
                            cs=colors[2], -- Colour Secondary
                            pc=extra_colors[1], -- Pearlescent Colour
                            wc=extra_colors[2], -- Wheel Colour
                            pi=GetVehicleNumberPlateTextIndex(veh), -- Colour of license plate
                            nc={neoncolor[1],neoncolor[2],neoncolor[3]}, -- Neon Colours
                            wt=GetVehicleWindowTint(veh), -- Window Tint
                            wht=GetVehicleWheelType(veh), -- Wheel type
                            m0=GetVehicleMod(veh, 0), -- Vehicle Mod 0
                            m1=GetVehicleMod(veh, 1), -- Vehicle Mod 1
                            m2=GetVehicleMod(veh, 2), -- Vehicle Mod 2
                            m3=GetVehicleMod(veh, 3), -- Vehicle Mod 3
                            m4=GetVehicleMod(veh, 4), -- Vehicle Mod 4
                            m5=GetVehicleMod(veh, 5), -- Vehicle Mod 5
                            m6=GetVehicleMod(veh, 6), -- Vehicle Mod 6
                            m7=GetVehicleMod(veh, 7), -- Vehicle Mod 7
                            m8=GetVehicleMod(veh, 8), -- Vehicle Mod 8
                            m9=GetVehicleMod(veh, 9), -- Vehicle Mod 9
                            m10=GetVehicleMod(veh, 10), -- Vehicle Mod 10
                            m11=GetVehicleMod(veh, 11), -- Vehicle Mod 11
                            m12=GetVehicleMod(veh, 12), -- Vehicle Mod 12
                            m13=GetVehicleMod(veh, 13), -- Vehicle Mod 13
                            m14=GetVehicleMod(veh, 14), -- Vehicle Mod 14
                            m15=GetVehicleMod(veh, 15), -- Vehicle Mod 15
                            m16=GetVehicleMod(veh, 16), -- Vehicle Mod 16
                            t=turbo, -- Turbo
                            xl=xenon, -- Xenon Lights
                            ts=tiresmoke, -- Tyre Smoke
                            m23=GetVehicleMod(veh, 23), -- Vehicle Mod 23
                            m24=GetVehicleMod(veh, 24), -- Vehicle Mod 24
                            n0=neon0, -- Neon 0
                            n1=neon1, -- Neon 1
                            n2=neon2, -- Neon 2
                            n3=neon3, -- Neon 3
                            bp=bulletproof, -- Bulletproof tyres
                            sc={smokecolor[1],smokecolor[2],smokecolor[3]}, -- Tyre smoke colour
                            cw=variation, -- Custom Wheels
                        }
                        TriggerServerEvent("garage:stored", data)
                        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                        exports.pNotify:SendNotification({text = "Vehicle stored", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        garage_menu = false
                        stored = true
                    elseif count < actualslots and user_vehicles[i].cg ~= currentgarage.id then
                        local data = {
                            n="no", -- Name
                            m=GetEntityModel(veh), -- Model
                            instance=veh, -- Current vehicle instance
                            cg=currentgarage.id,
                            p=GetVehicleNumberPlateText(veh), -- Plate
                            s="~g~Stored", -- State
                            cp=colors[1], -- Colour Primary
                            cs=colors[2], -- Colour Secondary
                            pc=extra_colors[1], -- Pearlescent Colour
                            wc=extra_colors[2], -- Wheel Colour
                            pi=GetVehicleNumberPlateTextIndex(veh), -- Colour of license plate
                            nc={neoncolor[1],neoncolor[2],neoncolor[3]}, -- Neon Colours
                            wt=GetVehicleWindowTint(veh), -- Window Tint
                            wht=GetVehicleWheelType(veh), -- Wheel type
                            m0=GetVehicleMod(veh, 0), -- Vehicle Mod 0
                            m1=GetVehicleMod(veh, 1), -- Vehicle Mod 1
                            m2=GetVehicleMod(veh, 2), -- Vehicle Mod 2
                            m3=GetVehicleMod(veh, 3), -- Vehicle Mod 3
                            m4=GetVehicleMod(veh, 4), -- Vehicle Mod 4
                            m5=GetVehicleMod(veh, 5), -- Vehicle Mod 5
                            m6=GetVehicleMod(veh, 6), -- Vehicle Mod 6
                            m7=GetVehicleMod(veh, 7), -- Vehicle Mod 7
                            m8=GetVehicleMod(veh, 8), -- Vehicle Mod 8
                            m9=GetVehicleMod(veh, 9), -- Vehicle Mod 9
                            m10=GetVehicleMod(veh, 10), -- Vehicle Mod 10
                            m11=GetVehicleMod(veh, 11), -- Vehicle Mod 11
                            m12=GetVehicleMod(veh, 12), -- Vehicle Mod 12
                            m13=GetVehicleMod(veh, 13), -- Vehicle Mod 13
                            m14=GetVehicleMod(veh, 14), -- Vehicle Mod 14
                            m15=GetVehicleMod(veh, 15), -- Vehicle Mod 15
                            m16=GetVehicleMod(veh, 16), -- Vehicle Mod 16
                            t=turbo, -- Turbo
                            xl=xenon, -- Xenon Lights
                            ts=tiresmoke, -- Tyre Smoke
                            m23=GetVehicleMod(veh, 23), -- Vehicle Mod 23
                            m24=GetVehicleMod(veh, 24), -- Vehicle Mod 24
                            n0=neon0, -- Neon 0
                            n1=neon1, -- Neon 1
                            n2=neon2, -- Neon 2
                            n3=neon3, -- Neon 3
                            bp=bulletproof, -- Bulletproof tyres
                            sc={smokecolor[1],smokecolor[2],smokecolor[3]}, -- Tyre smoke colour
                            cw=variation, -- Custom Wheels
                        }
                        TriggerServerEvent("garage:stored", data)
                        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                        exports.pNotify:SendNotification({text = "Vehicle stored", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        garage_menu = false
                        stored = true
                    else
                        garage_menu = false
                        stored = true
                        exports.pNotify:SendNotification({text = "This garage is full!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                    end
                end
            end
            if not stored then
                exports.pNotify:SendNotification({text = "This is not your vehicle!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                garage_menu = false
            end
        else
            exports.pNotify:SendNotification({text = "No veh!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
            garage_menu = false
        end
    end)
end

function SpawnVehicle(data)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local isAreaCrowded = GetClosestVehicle(currentgarage.x, currentgarage.y, currentgarage.z, 3.000, 0, 70)
        if DoesEntityExist(isAreaCrowded) then
            exports.pNotify:SendNotification({text = "The area is crowded", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
        else
            RequestModel(data.m)
            while not HasModelLoaded(data.m) do
                Citizen.Wait(0)
            end
            veh = CreateVehicle(data.m, currentgarage.x, currentgarage.y, currentgarage.z, currentgarage.heading, true, false)
            table.insert(out, veh)
            SetVehicleNumberPlateText(veh, data.p)
            SetVehicleOnGroundProperly(veh)
            SetVehicleHasBeenOwnedByPlayer(veh,true)
            local id = NetworkGetNetworkIdFromEntity(veh)
            SetNetworkIdCanMigrate(id, true)
            SetNetworkIdExistsOnAllMachines(id, true)
            SetVehicleColours(veh, data.cp, data.cs)
            SetVehicleExtraColours(veh, tonumber(data.pc), tonumber(data.wc))
            SetVehicleNumberPlateTextIndex(veh,plateindex)
            SetVehicleNeonLightsColour(veh,tonumber(data.nc[1]),tonumber(data.nc[2]),tonumber(data.nc[3]))
            SetVehicleTyreSmokeColor(veh,tonumber(data.sc[1]),tonumber(data.sc[2]),tonumber(data.sc[3]))
            SetVehicleModKit(veh,0)
            SetVehicleMod(veh, 0, tonumber(data.m0))
            SetVehicleMod(veh, 1, tonumber(data.m1))
            SetVehicleMod(veh, 2, tonumber(data.m2))
            SetVehicleMod(veh, 3, tonumber(data.m3))
            SetVehicleMod(veh, 4, tonumber(data.m4))
            SetVehicleMod(veh, 5, tonumber(data.m5))
            SetVehicleMod(veh, 6, tonumber(data.m6))
            SetVehicleMod(veh, 7, tonumber(data.m7))
            SetVehicleMod(veh, 8, tonumber(data.m8))
            SetVehicleMod(veh, 9, tonumber(data.m9))
            SetVehicleMod(veh, 10, tonumber(data.m10))
            SetVehicleMod(veh, 11, tonumber(data.m11))
            SetVehicleMod(veh, 12, tonumber(data.m12))
            SetVehicleMod(veh, 13, tonumber(data.m13))
            SetVehicleMod(veh, 14, tonumber(data.m14))
            SetVehicleMod(veh, 15, tonumber(data.m15))
            SetVehicleMod(veh, 16, tonumber(data.m16))
            if data.t == "on" then
                ToggleVehicleMod(veh, 18, true)
            else
                ToggleVehicleMod(veh, 18, false)
            end
            if data.ts == "on" then
                ToggleVehicleMod(veh, 20, true)
            else
                    ToggleVehicleMod(veh, 20, false)
            end
            if data.xl == "on" then
                ToggleVehicleMod(veh, 22, true)
            else
                ToggleVehicleMod(veh, 22, false)
            end
            SetVehicleWheelType(veh, tonumber(data.wht))
            SetVehicleMod(veh, 23, tonumber(data.m23))
            SetVehicleMod(veh, 24, tonumber(data.m24))
            if data.cw == "on" then
                SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), true)-- Vehicle Mod 23
                SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), true)-- Vehicle Mod 24
            end
            if data.n0 == "on" then
                SetVehicleNeonLightEnabled(veh,0, true)
            else
                SetVehicleNeonLightEnabled(veh,0, false)
            end
            if data.n1 == "on" then
                SetVehicleNeonLightEnabled(veh,1, true)
            else
                SetVehicleNeonLightEnabled(veh,1, false)
            end
            if data.n2 == "on" then
                SetVehicleNeonLightEnabled(veh,2, true)
            else
                SetVehicleNeonLightEnabled(veh,2, false)
            end
            if data.n3 == "on" then
                SetVehicleNeonLightEnabled(veh,3, true)
            else
                SetVehicleNeonLightEnabled(veh,3, false)
            end
            if data.bp == "on" then
                SetVehicleTyresCanBurst(veh, false)
            else
                SetVehicleTyresCanBurst(veh, true)
            end
            SetVehicleWindowTint(veh,tonumber(data.wt))
            TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
            SetEntityInvincible(veh, false)
            data.s = "~r~Missing" -- Vehicle State
            local instance = veh -- Current vehicle instance
            TriggerServerEvent("garage:out", data, instance)
        end
    end)
end

function SpawnReplacement(data)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        RequestModel(data.m)
        while not HasModelLoaded(data.m) do
           Citizen.Wait(0)
        end
        veh = CreateVehicle(data.m, replacementgarage.x, replacementgarage.y, replacementgarage.z, replacementgarage.heading, true, false)
        table.insert(out, veh)
        SetVehicleNumberPlateText(veh, data.p)
        SetVehicleOnGroundProperly(veh)
        SetVehicleHasBeenOwnedByPlayer(veh,true)
        local id = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(id, true)
        SetNetworkIdExistsOnAllMachines(id, true)
        SetVehicleColours(veh, data.cp, data.cs)
        SetVehicleExtraColours(veh, tonumber(data.pc), tonumber(data.wc))
        SetVehicleNumberPlateTextIndex(veh,plateindex)
        SetVehicleNeonLightsColour(veh,tonumber(data.nc[1]),tonumber(data.nc[2]),tonumber(data.nc[3]))
        SetVehicleTyreSmokeColor(veh,tonumber(data.sc[1]),tonumber(data.sc[2]),tonumber(data.sc[3]))
        SetVehicleModKit(veh,0)
        SetVehicleMod(veh, 0, tonumber(data.m0))
        SetVehicleMod(veh, 1, tonumber(data.m1))
        SetVehicleMod(veh, 2, tonumber(data.m2))
        SetVehicleMod(veh, 3, tonumber(data.m3))
        SetVehicleMod(veh, 4, tonumber(data.m4))
        SetVehicleMod(veh, 5, tonumber(data.m5))
        SetVehicleMod(veh, 6, tonumber(data.m6))
        SetVehicleMod(veh, 7, tonumber(data.m7))
        SetVehicleMod(veh, 8, tonumber(data.m8))
        SetVehicleMod(veh, 9, tonumber(data.m9))
        SetVehicleMod(veh, 10, tonumber(data.m10))
        SetVehicleMod(veh, 11, tonumber(data.m11))
        SetVehicleMod(veh, 12, tonumber(data.m12))
        SetVehicleMod(veh, 13, tonumber(data.m13))
        SetVehicleMod(veh, 14, tonumber(data.m14))
        SetVehicleMod(veh, 15, tonumber(data.m15))
        SetVehicleMod(veh, 16, tonumber(data.m16))
        if data.t == "on" then
            ToggleVehicleMod(veh, 18, true)
        else
            ToggleVehicleMod(veh, 18, false)
        end
        if data.ts == "on" then
            ToggleVehicleMod(veh, 20, true)
        else
            ToggleVehicleMod(veh, 20, false)
        end
        if data.xl == "on" then
            ToggleVehicleMod(veh, 22, true)
        else
            ToggleVehicleMod(veh, 22, false)
        end
        SetVehicleWheelType(veh, tonumber(data.wht))
        SetVehicleMod(veh, 23, tonumber(data.m23))
        SetVehicleMod(veh, 24, tonumber(data.m24))
        if data.cw == "on" then
            SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), true)-- Vehicle Mod 23
            SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), true)-- Vehicle Mod 24
        end
        if data.n0 == "on" then
            SetVehicleNeonLightEnabled(veh,0, true)
        else
            SetVehicleNeonLightEnabled(veh,0, false)
        end
        if data.n1 == "on" then
            SetVehicleNeonLightEnabled(veh,1, true)
        else
            SetVehicleNeonLightEnabled(veh,1, false)
        end
        if data.n2 == "on" then
            SetVehicleNeonLightEnabled(veh,2, true)
        else
            SetVehicleNeonLightEnabled(veh,2, false)
        end
        if data.n3 == "on" then
            SetVehicleNeonLightEnabled(veh,3, true)
        else
            SetVehicleNeonLightEnabled(veh,3, false)
        end
        if data.bp == "on" then
            SetVehicleTyresCanBurst(veh, false)
        else
            SetVehicleTyresCanBurst(veh, true)
        end
        SetVehicleWindowTint(veh,tonumber(data.wt))
        TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
        SetEntityInvincible(veh, false)
        garage_menu = false
        data.s = "~r~Missing" -- Vehicle State
        local instance = veh -- Current vehicle instance
        TriggerServerEvent("garage:out", data, instance)
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Basic Functions                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

function reload()
    TriggerServerEvent("garage:reload")
end

reload()