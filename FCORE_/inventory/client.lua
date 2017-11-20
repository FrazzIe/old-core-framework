--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                    Interactions/Inventory                                                    --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
player_menu = false                                                                                                             --
local inventory = {}  
--=ADMIN========================================================================================================================--
local deletegun = false                                                                                                         --
local deletegun2 = false                                                                                                        --
--=VEHICLE======================================================================================================================--
local lockcar2 = false                                                                                                          --  
local enginetoggled = false                                                                                                     --  
local lockspeed = false                                                                                                         --  
local lockspeed2 = false                                                                                                        --  
local doorDisplayNames = {"Front Left", "Front Right", "Back Left", "Back Right", "Hood", "Trunk", "Back", "Back2"}             --
local doorPosition = 1                                                                                                          --  
local doorState = {}                                                                                                            --  
local enableCruise = false                                                                                                      --  
local chatbool = false                                                                                                          --  
--CAR=SPEEDS====================================================================================================================--
local car_speeds = {
    {model="rmodm4gts", speed=2000},
    --Supers
    {model="gtr", speed=180},
    {model="lp6504", speed=180},
    {model="488gtb", speed=180},
    {model="911turbos", speed=175},
    {model="amv12", speed=170},
    {model="vc7", speed=160},
    {model="FTypeC", speed=160},
    {model="gallardo", speed=170},
    {model="hellcat", speed=180},
    {model="r8ppi", speed=175},
    --Sports
    {model="sti05", speed=160},
    {model="skyline", speed=165},
    {model="s8", speed=150},
    {model="rs4", speed=140},
    {model="m5", speed=140},
    {model="300c", speed=140},
    {model="mgt", speed=150},
    {model="300c", speed=140},
    {model="nsx", speed=150},
    {model="c63", speed=165},
    {model="evo10", speed=155},
    {model="brz", speed=135},
    {model="supra", speed=165},
    {model="mk7", speed=140},
    {model="evo9", speed=160},
    {model="subwrx", speed=155},
    {model="focusrs", speed=160},
    {model="gs350", speed=160},
    {model="ghibli", speed=160},
    {model="rs6om", speed=160},
    --Sedans
    {model="sel600", speed=130},
    {model="750il", speed=130},
    {model="camry", speed=120},
    {model="accord", speed=120},
    {model="560sel", speed=120},
    {model="towncar", speed=105},
    {model="crownvic", speed=110},
    {model="e36t", speed=130},
    {model="m5e34", speed=130},
    {model="b5s4", speed=140},
    {model="beetle", speed=130},
    {model="cooperworks", speed=130},
    {model="benzc32", speed=135},
    --SportsClassic
    {model="aust", speed=110},
    {model="tbird", speed=120},
    --Muscles
    {model="ss350", speed=130},
    {model="chevelle1970", speed=140},
    {model="rt440", speed=130},
    {model="gt500", speed=150},
    {model="turbo33", speed=150},
    {model="cuda", speed=140},
    {model="68mustang", speed=125},
    {model="boss302", speed=145},
    {model="fraptor", speed=135},
    {model="charger", speed=140},
    {model="magnum", speed=135},
    {model="cobra", speed=150},
    --SUVs
    {model="lx570", speed=125},
    {model="q7", speed=140},
    {model="vogue", speed=135},
    {model="yukonxl", speed=110},
    {model="silverado", speed=110},
    {model="escalade", speed=120},
    {model="rover", speed=130},
    --GTA DLC
    {model="coquette3", speed=150},
	{model="feltzer3", speed=150},
    {model="guardian", speed=150},
    {model="contender", speed=140},
    {model="trophytruck2", speed=140},
    {model="lurcher", speed=130},
    {model="btype", speed=140},
    {model="slamvan", speed=140},
    {model="slamvan2", speed=140},
    {model="slamvan3", speed=140},
    {model="minivan2", speed=120},
    {model="sabregt2", speed=140},
    {model="tornado5", speed=130},
    {model="virgo2", speed=130},
    {model="comet3", speed=160},
    {model="torero", speed=160},
    {model="osiris", speed=160},
    {model="elegy", speed=150},
    {model="sultanrs", speed=150},
    {model="specter2", speed=160},
    {model="tempesta", speed=170},
    {model="italigtb2", speed=170},
    {model="cheetah2", speed=180},
    {model="xa21", speed=180},
    {model="nero2", speed=190},
        --GTA Compacts
    {model="blista", speed=120},
    {model="brioso", speed=120},
    {model="dilettante", speed=120},
    {model="issi2", speed=130},
    {model="panto", speed=130},
    {model="prairie", speed=120},
    {model="rhapsody", speed=120},
	    --GTA Coupes
    {model="cogcabrio", speed=130},
    {model="exemplar", speed=130},
    {model="f620", speed=140},
    {model="felon", speed=130},
    {model="felon2", speed=140},
    {model="jackal", speed=140},
    {model="oracle", speed=130},
    {model="oracle2", speed=140},
    {model="sentinel", speed=130},
    {model="sentinel2", speed=140},
	{model="windsor", speed=130},
    {model="windsor2", speed=140},
    {model="zion", speed=130},
    {model="zion2", speed=140},
	{model="futo", speed=140},
	    --GTA Sports
    {model="ninef", speed=140},
    {model="ninef2", speed=145},
    {model="alpha", speed=130},
    {model="banshee", speed=130},
    {model="bestiagts", speed=130},
    {model="buffalo", speed=140},
    {model="buffalo2", speed=140},
    {model="carbonizzare", speed=140},
    {model="comet2", speed=150},
    {model="coquette", speed=150},
    {model="feltzer2", speed=150},
    {model="furoregt", speed=150},
    {model="fusilade", speed=140},
    {model="jester", speed=140},
    {model="jester2", speed=150},
    {model="lynx", speed=140},
    {model="massacro", speed=140},
    {model="massacro2", speed=150},
    {model="omnis", speed=150},
    {model="penumbra", speed=130},
    {model="tampa2", speed=130},
    {model="rapidgt", speed=140},
    {model="rapidgt2", speed=140},
    {model="schafter3", speed=130},
    {model="sultan", speed=140},
    {model="surano", speed=140},
    {model="tropos", speed=140},
    {model="verlierer2", speed=140},
    {model="kuruma", speed=140},
        --GTA Sports Classics
    {model="casco", speed=120},
    {model="coquette2", speed=130},
    {model="jb700", speed=130},
    {model="pigalle", speed=120},
    {model="stinger", speed=140},
    {model="stingergt", speed=150},
    {model="feltzer3", speed=150},
    {model="ztype", speed=130},
        --GTA Super
    {model="adder", speed=160},
    {model="banshee2", speed=150},
    {model="bullet", speed=150},
    {model="cheetah", speed=160},
    {model="entityxf", speed=160},
    {model="sheava", speed=150},
    {model="fmj", speed=160},
    {model="infernus", speed=140},
    {model="osiris", speed=150},
    {model="le7b", speed=150},
    {model="reaper", speed=140},
    {model="t20", speed=170},
    {model="turismor", speed=170},
    {model="tyrus", speed=170},
    {model="vacca", speed=160},
    {model="Voltic", speed=150},
    {model="prototipo", speed=170},
    {model="zentorno", speed=170},
	    --GTA Muscle
    {model="blade", speed=120},
    {model="buccaneer", speed=120},
    {model="chino", speed=120},
    {model="coquette3", speed=140},
    {model="dominator", speed=140},
    {model="dukes", speed=130},
    {model="gauntlet", speed=130},
    {model="hotknife", speed=140},
    {model="faction", speed=120},
    {model="nightshade", speed=120},
    {model="picador", speed=120},
    {model="sabregt", speed=130},
    {model="tampa", speed=120},
    {model="virgo", speed=120},
    {model="vigero", speed=130},
	    --GTA Offroad
    {model="bifta", speed=120},
    {model="blazer", speed=120},
    {model="brawler", speed=120},
    {model="sadler", speed=120},
    {model="dubsta3", speed=130},
    {model="rebel", speed=120},
    {model="sandking2", speed=130},
    {model="sandking", speed=130},
	{model="trophytruck", speed=140},
	    --GTA SUV
    {model="baller", speed=130},
    {model="cavalcade", speed=120},
    {model="granger", speed=120},
	{model="huntley", speed=120},
    {model="landstalker", speed=120},
    {model="radi", speed=120},
    {model="rocoto", speed=120},
    {model="seminole", speed=120},
    {model="xls", speed=140},
	    --GTA Vans
    {model="bison", speed=120},
    {model="bobcatxl", speed=125},
    {model="gburrito", speed=120},
    {model="journey", speed=115},
    {model="minivan", speed=120},
    {model="paradise", speed=125},
    {model="rumpo", speed=120},
    {model="surfer", speed=125},
	{model="youga", speed=125},
	    --GTA Sedans
    {model="asea", speed=120},
    {model="fugitive", speed=120},
    {model="asterope", speed=120},
    {model="glendale", speed=120},
    {model="ingot", speed=120},
    {model="intruder", speed=120},
    {model="premier", speed=130},
    {model="primo", speed=120},
    {model="primo2", speed=130},
    {model="schafter2", speed=130},
    {model="tailgater", speed=120},
    {model="warrener", speed=120},
    {model="washington", speed=130},
    {model="surge", speed=130},
    {model="superd", speed=130},
    {model="stretch", speed=120},
	    --Motorcycles
	{model="blazer", speed=120},
    {model="faggio2", speed=120},
    {model="sanchez", speed=120},
    {model="enduro", speed=130},
    {model="akuma", speed=150},
    {model="bagger", speed=130},
    {model="bati", speed=150},
    {model="bati2", speed=160},
    {model="bf400", speed=120},
    {model="carbonrs", speed=150},
    {model="cliffhanger", speed=120},
    {model="daemon", speed=120},
    {model="double", speed=120},
    {model="gargoyle", speed=120},
    {model="hakuchou", speed=150},
    {model="hexer", speed=120},
    {model="fatboy", speed=130},
    {model="innovation", speed=120},
    {model="lectro", speed=120},
    {model="nemesis", speed=140},
    {model="pcj", speed=120},
    {model="ruffian", speed=120},
    {model="knucklehead", speed=120},
    {model="vindicator", speed=150},
    {model="diablous2", speed=150},
	{model="blazer4", speed=150},
	{model="blazer", speed=150},
}
--=INVENTORY====================================================================================================================--
local invbool = false                                                                                                           --
local drunk = false                                                                                                             --
--=SETTINGS=====================================================================================================================--
local voip = "~b~Normal"                                                                                                        --
local voipposition = 2                                                                                                          --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Inventory Events                                                       --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterNetEvent("inventory:updateitems")
AddEventHandler("inventory:updateitems", function(inv)
    inventory = {}
    inventory = inv
    if curMenu == "inventory_menu" or curMenu == "item_menu" then
        InventoryMenu()
        --player_menu = false
    end
end)

RegisterNetEvent("inventory:addQty")
AddEventHandler("inventory:addQty",function(i,q)
    addQty(i,q)
end)

RegisterNetEvent("inventory:removeQty")
AddEventHandler("inventory:removeQty",function(i,q)
    removeQty(i,q)
end)

RegisterNetEvent("inventory:messages")
AddEventHandler("inventory:messages",function(message)
    DrawMissionText(message, 5000)
end)

RegisterNetEvent("phone:closed")
AddEventHandler("phone:closed",function()
    if GetEntityHealth(GetPlayerPed(-1)) == 0 then
    else
        player_menu = true
        MainMenu()
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                     Inventory Functions                                                      --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function removeQty(i,q)
    TriggerServerEvent("inventory:remove", tonumber(i),tonumber(q))
end

function addQty(i,q)
    TriggerServerEvent("inventory:add", tonumber(i),tonumber(q))
end

function getQuantity()
    local quantity = 0
    for i=1,#inventory do
        quantity = quantity + inventory[i].q
    end
    return quantity
end

function isFull()
    local quantity = 0
    for i=1,#inventory do
        quantity = quantity + inventory[i].q
    end
    if quantity == 100 then
        return true
    else
        return false
    end
end

function GetItemQuantity(item)
    local quantity = 0
    for i=1,#inventory do
        if inventory[i].id == tonumber(item) then
            quantity = inventory[i].q
        end
    end
    return quantity
end

function give(item)
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
        if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
            showLoadingPrompt("Enter quantity!", 3)
            DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
            while (UpdateOnscreenKeyboard() == 0) do
                  DisableAllControlActions(0);
                Wait(0);
            end
            if (GetOnscreenKeyboardResult()) then
                local option = tonumber(GetOnscreenKeyboardResult())
                if(option ~= nil and option ~= 0) then
                    amount = ""..option
                end
            end
        end
        stopLoadingPrompt()
        if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
            TriggerServerEvent("inventory:give", tonumber(item), tonumber(amount), GetPlayerServerId(t))
        end
        InventoryMenu()
    else
        Messages(5)
    end
end

function drop(item)
    local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
    if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        showLoadingPrompt("Enter quantity!", 3)
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local option = tonumber(GetOnscreenKeyboardResult())
            if(option ~= nil and option ~= 0) then
                amount = ""..option
            end
        end
    end
    stopLoadingPrompt()
    if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
        TriggerServerEvent("inventory:drop", tonumber(item), tonumber(amount))
    end
    InventoryMenu()
end

function use(val)
    local itemId = val[1]
    local canUse = val[2]
    if canUse ~= 0 then
        if canUse == 1 then
            drink(itemId)
        elseif canUse == 2 then
            eat(itemId)
        elseif canUse == 3 then --Medkit
            heal()
        elseif canUse == 4 then --Repair kit
            RepairVehicleCheck(itemId)
        elseif canUse == 5 then --Lockpick
            lockpick()
        elseif canUse == 6 then --Body armour
            armour()
        end
        removeQty(itemId,1)
    else
        Messages(4)
    end
    InventoryMenu()
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                     Inventory Use Functions                                                  --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function eat(item)
    local pid = PlayerPedId()
    RequestAnimDict("mp_player_inteat@burger")
    while (not HasAnimDictLoaded("mp_player_inteat@burger")) do Citizen.Wait(0) end
    TaskPlayAnim(pid, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 1.0, -1.0, 2000, 0, 1, true, true, true)
    TriggerEvent("fm:eat", 30)
end

function drink(item)
    local pid = PlayerPedId()
    RequestAnimDict("amb@world_human_drinking@coffee@male@idle_a")
    while (not HasAnimDictLoaded("amb@world_human_drinking@coffee@male@idle_a")) do Citizen.Wait(0) end
    TaskPlayAnim(pid, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 1.0, -1.0, 2000, 0, 1, true, true, true)
    if item == 25 then
        TriggerEvent("fm:drink", -5)
        addBAC(0.4)
        drunk = true
    elseif item == 27 then
        TriggerEvent("fm:drink", -5)
        addBAC(0.4)
        drunk = true
    elseif item == 41 then
        TriggerEvent("fm:drink", -5)
        addBAC(0.4)
        drunk = true
    else
        TriggerEvent("fm:drink", 30)
    end
end

function addBAC(amount)
    local BAC_Driving_Limit = 0.08
    local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
    local newBAC = currentBAC + amount
    DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC)
    if newBAC >= BAC_Driving_Limit then
        local isBACactive = DecorGetBool(GetPlayerPed(-1), "BAC_Active")
        if not isBACactive then
            DecorSetBool(GetPlayerPed(-1), "BAC_Active", true)  
        end
    end
end

function heal()
    Citizen.CreateThread(function()
        Citizen.Wait(200)
        SetPedMaxHealth(GetPlayerPed(-1), 200)
        SetEntityHealth(GetPlayerPed(-1), 200)
        exports.pNotify:SendNotification({text = "Medkit used!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})        
    end)
end

function RepairVehicleCheck(id)
    TriggerServerEvent('repair:getMech',id)
end

RegisterNetEvent('repair:receiveMech')
AddEventHandler('repair:receiveMech',function(mechanic,id)
    local online = tonumber(mechanic)
    if online < 1 then
        RepairVehicle(id)
    else
        addQty(id,1)
        exports.pNotify:SendNotification({text = "These can only be used when there are no mechanics online! (Online: <span style='color:lime'>"..online.."</span>)",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
    end
end)

function RepairVehicle(id)
    Citizen.CreateThread(function()
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        veh = GetClosestVehicle(plyCoords["x"], plyCoords["y"], plyCoords["z"], 5.001, 0, 70)
        if veh ~= nil and veh ~= 0 then

            --ClearPedTasksImmediately(GetPlayerPed(-1))
            --TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_VEHICLE_MECHANIC", 0, true)  
            TaskPlayAnim(GetPlayerPed(-1),"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)     
            Citizen.Wait(20000)
            SetVehicleFixed(veh, 1)
            SetVehicleDeformationFixed(veh, 1)
            SetVehicleUndriveable(veh, 1)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            --  ShowNotification("~g~Vehicle is fully Repaired~r~Turn on Engine via Vehicle Menu Key:M or select")
            exports.pNotify:SendNotification({text = "Vehicle repaired!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
        else
            exports.pNotify:SendNotification({text = "No vehicle in range!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            addQty(tonumber(id),1)
        end
    end)
end

function lockpick()
    Citizen.CreateThread(function()
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        veh = GetClosestVehicle(plyCoords["x"], plyCoords["y"], plyCoords["z"], 5.001, 0, 70)
        if veh ~= nil and veh ~= 0 then
            TaskPlayAnim(GetPlayerPed(-1),"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)     
            Citizen.Wait(20000)
            local unlock = math.random(1,4)
            if unlock == 3 then
                SetVehicleDoorsLocked(veh, 1)
                exports.pNotify:SendNotification({text = "Vehicle unlocked!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
                 ClearPedTasksImmediately(GetPlayerPed(-1))
            else
                exports.pNotify:SendNotification({text = "Lockpick broke!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
                ClearPedTasksImmediately(GetPlayerPed(-1))
                StartVehicleAlarm(veh)
            end
        else
            exports.pNotify:SendNotification({text = "No vehicle in range!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            addQty(36,1)
        end
    end)
end

function armour()
    Citizen.CreateThread(function()
        Citizen.Wait(200)
        if GetPedArmour(GetPlayerPed(-1)) < 50 then
            SetPedArmour(GetPlayerPed(-1), 100)
            SetPedComponentVariation(GetPlayerPed(-1), 9, 1, 1, 0)
            exports.pNotify:SendNotification({text = "Body armour equipped!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
        else
            exports.pNotify:SendNotification({text = "You already have body armour equipped!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
            addQty(39,1)
        end
    end)
end

Citizen.CreateThread(function()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if drunk then
            drunk = false
            Citizen.Wait(5000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            SetTimecycleModifier("spectator5")
            SetPedMotionBlur(GetPlayerPed(-1), true)
            SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
            SetPedIsDrunk(GetPlayerPed(-1), true)
            DoScreenFadeIn(1000)            
            Citizen.Wait(50000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ClearTimecycleModifier()
            ResetScenarioTypesEnabled()
            ResetPedMovementClipset(GetPlayerPed(-1), 0)
            SetPedIsDrunk(GetPlayerPed(-1), false)
            SetPedMotionBlur(GetPlayerPed(-1), false)
        end
    end
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Messages                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function Messages(value)
    if value == 1 then
        Notify("You must be driving to use this!")
    elseif value == 2 then
        Notify("You must be in a car to use this!")
    elseif value == 3 then
        Notify("You cannot use this in a police car!")
    elseif value == 4 then
        Notify("This item cannot be used!")
    elseif value == 5 then
        Notify("There is no player near you!")
    end
end

function Notify(msg)
    exports.pNotify:SendNotification({text = msg,type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
    CancelEvent()
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Reset Menu                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local reset = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and reset then
            local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
            if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
                reset = false
                if enginetoggled then
                    SetVehicleEngineOn(veh,true,true,true)
                    SetVehicleUndriveable(veh, false)
                end
                enginetoggled = false
                if enableCruise then
                    lockspeed = true
                end
                if lockspeed2 then
                    lockspeed2 = false
                end
            else
                if enginetoggled then
                    enginetoggled = false
                end
                if lockspeed2 then
                    lockspeed2 = false
                end
            end
        elseif not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and not reset then
            reset = true
            carlockstatus = "~b~Unknown"
        end
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Open Menu                                                           --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 311) and carshop_menu == false and customs_menu == false and carrental_menu == false and engineon == true then --- K (Open)
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
                    GUI.maxVisOptions = 7
                    titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      
                    titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 
                    optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      
                    optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
                    menuX = 0.9 ----------------------------- X position of the menu 
                    menuXOption = 0.075 --------------------- X postiion of Menu.Option text                        --
                    menuXOtherOption = 0.050 ---------------- X position of Bools, Arrays etc text                  --
                    menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                      --
                    menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons        --
                    menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down        --                    
                else
                    GUI.maxVisOptions = 7
                    titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      
                    titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 
                    optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      
                    optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
                    menuX = 0.9 ----------------------------- X position of the menu                          
                    menuXOption = 0.075 --------------------- X postiion of Menu.Option text                  
                    menuXOtherOption = 0.055 ---------------- X position of Bools, Arrays etc text            
                    menuYModify = 0.6500 -------------------- Default: 0.1174   ------ Top bar                
                    menuYOptionDiv = 18.56 ------------------ Default: 3.56   ------ Distance between buttons 
                    menuYOptionAdd = 0.71 ------------------ Default: 0.142  ------ Move buttons up and down
                end
            else
                GUI.maxVisOptions = 7
                titleTextSize = {0.85, 0.65} ------------ {p1, Size}                                      
                titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                 
                optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      
                optionRectSize = {0.16, 0.035} ---------- {Width, Height}    
                menuX = 0.9 ----------------------------- X position of the menu                          
                menuXOption = 0.075 --------------------- X postiion of Menu.Option text                  
                menuXOtherOption = 0.055 ---------------- X position of Bools, Arrays etc text            
                menuYModify = 0.6500 -------------------- Default: 0.1174   ------ Top bar                
                menuYOptionDiv = 18.56 ------------------ Default: 3.56   ------ Distance between buttons 
                menuYOptionAdd = 0.71 ------------------ Default: 0.142  ------ Move buttons up and down
            end 
            if GetEntityHealth(GetPlayerPed(-1)) == 0 then
                TriggerEvent("phone:open")
                player_menu = false
            else
                player_menu = not player_menu
                MainMenu()
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
    Menu.SetupMenu("main_menu","Interactions")
    Menu.Switch(nil,"main_menu")
    if isAdmin then
        Menu.addOption("main_menu", function()
            if(Menu.Option("Admin"))then
                Admin()   
            end
        end)
    end
    Menu.addOption("main_menu", function()
        if(Menu.Option("Phone"))then
            TriggerEvent("phone:open")
            player_menu = false 
        end
    end)
    Menu.addOption("main_menu", function()
        if(Menu.Option("Inventory"))then
            InventoryMenu()   
        end
    end)
    Menu.addOption("main_menu", function()
        if(Menu.Option("Animations"))then
            animsMenu()   
        end
    end)
    Menu.addOption("main_menu", function()
        if(Menu.Option("Vehicle"))then
            VehMenu()   
        end
    end)
    Menu.addOption("main_menu", function()
        if(Menu.Option("Other"))then
            OtherMenu()   
        end
    end)
    Menu.addOption("main_menu", function()
        if(Menu.Option("Settings"))then
            SettingsMenu()   
        end
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Admin Menu                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function Admin()
    Menu.SetupMenu("admin_menu", "Admin Menu")
    Menu.Switch("main_menu","admin_menu")
    Menu.addOption("admin_menu", function()
        if(Menu.Option("Ban")) then
            BanMenu()   
        end
    end)
    Menu.addOption("admin_menu", function()
        if(Menu.Option("Kick")) then
            KickMenu()   
        end
    end)
    Menu.addOption("admin_menu", function()
        if(Menu.Bool("Delete gun", deletegun,"~r~ON","~g~OFF",function(cb)    deletegun = cb end)) then
            if deletegun then
                deletegun2 = true
            else
                deletegun2 = false
            end
        end
    end)
end

function KickMenu()
    Menu.SetupMenu("kick_menu", "Kick a player")
    Menu.Switch("admin_menu","kick_menu")
    for i = 0, 32 do
        if NetworkIsPlayerActive(i) then
            Menu.addOption("kick_menu", function()
                if(Menu.Option(GetPlayerName(i))) then
                    KickReason(i)   
                end
            end)
        end
    end
end

function KickReason(target)
    local kick = {
    id = target,
    reason = ""
    }
    Menu.SetupMenu("kick_reason", "Choose a reason")
    Menu.Switch("kick_menu","kick_reason")
    Menu.addOption("kick_reason", function()
        if(Menu.Option("RDM")) then
            kick.reason = "RDM"
            Kick(kick)
        end
    end)
    Menu.addOption("kick_reason", function()
        if(Menu.Option("VDM")) then
            kick.reason = "VDM"
            Kick(kick)
        end
    end)
    Menu.addOption("kick_reason", function()
        if(Menu.Option("FailRP")) then
            kick.reason = "FailRP"
            Kick(kick)
        end
    end)
    Menu.addOption("kick_reason", function()
        if(Menu.Option("Type reason")) then
            kick.reason = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
            Kick(kick)  
        end
    end)
end

function Kick(kick)
    local reason = tostring(kick.reason)
    local id = tonumber(kick.id)
    if(reason == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        showLoadingPrompt("Enter a reason..", 3)
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
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
        TriggerServerEvent("FAC:Kick", GetPlayerServerId(id), reason)
    end
    Admin()
end

function BanMenu()
    Menu.SetupMenu("ban_menu", "Ban a player")
    Menu.Switch("admin_menu","ban_menu")
    for i = 0, 32 do
        if NetworkIsPlayerActive(i) then
            Menu.addOption("ban_menu", function()
                if(Menu.Option(GetPlayerName(i))) then
                    BanTime(i)   
                end
            end)
        end
    end
end

function BanTime(target)
    local ban = {
    id = target,
    time = ""
    }
    Menu.SetupMenu("bantime_menu", "Choose a time")
    Menu.Switch("ban_menu","bantime_menu")
    Menu.addOption("bantime_menu", function()
        if(Menu.Option("10 minutes")) then
            ban.time = "10m"
            BanTime2(ban)
        end
    end)
    Menu.addOption("bantime_menu", function()
        if(Menu.Option("1 hour")) then
            ban.time = "1h"
            BanTime2(ban)
        end
    end)
    Menu.addOption("bantime_menu", function()
        if(Menu.Option("3 hours")) then
            ban.time = "3h"
            BanTime2(ban)
        end
    end)
    Menu.addOption("bantime_menu", function()
        if(Menu.Option("Type time")) then
            ban.time = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
            BanTime2(ban)
        end
    end)
end

function BanTime2(ban)
    customtime = false
    local time = tostring(ban.time)
    local id = tonumber(ban.id)
    if(time == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        showLoadingPrompt("Enter amount of time", 3)
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
        while (UpdateOnscreenKeyboard() == 0) do
              DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local option = tonumber(GetOnscreenKeyboardResult())
            if(option ~= nil and option ~= 0) then
                time = ""..option
                customtime = true            
            end
        end
    end
    stopLoadingPrompt()
    if(time ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and customtime == false) then
        BanReason(id,time)
    elseif time ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and customtime == true then
        BanTime3(id,time)
    end
end

function BanTime3(id,time)
    local time = tostring(time)
    local target = tonumber(id)
    local ban = {
    id = target,
    time = time,
    }
    Menu.SetupMenu("bantime2_menu", "Choose a time")
    Menu.Switch("bantime_menu","bantime2_menu")
    Menu.addOption("bantime2_menu", function()
        if(Menu.Option(time.." second(s)")) then
            ban.time = time
            BanReason2(ban)
        end
    end)
    Menu.addOption("bantime2_menu", function()
        if(Menu.Option(time.." minute(s)")) then
            ban.time = time.."m"
            BanReason2(ban)
        end
    end)
    Menu.addOption("bantime2_menu", function()
        if(Menu.Option(time.." hour(s)")) then
            ban.time = time.."h"
            BanReason2(ban)
        end
    end)
end

function BanReason(target,time)
    local ban = {
    id = target,
    time = time,
    reason = ""
    }
    Menu.SetupMenu("banreason_menu", "Choose a reason")
    Menu.Switch("bantime_menu","banreason_menu")
    Menu.addOption("banreason_menu", function()
        if(Menu.Option("RDM")) then
            ban.reason = "RDM"
            Ban(ban)
        end
    end)
    Menu.addOption("banreason_menu", function()
        if(Menu.Option("VDM")) then
            ban.reason = "VDM"
            Ban(ban)
        end
    end)
    Menu.addOption("banreason_menu", function()
        if(Menu.Option("FailRP")) then
            ban.reason = "FailRP"
            Ban(ban)
        end
    end)
    Menu.addOption("banreason_menu", function()
        if(Menu.Option("Type reason")) then
            ban.reason = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
            Ban(ban)
        end
    end)
end

function BanReason2(banr)
    local time = tostring(banr.time)
    local target = tonumber(banr.id)
    local ban = {
    id = target,
    time = time,
    reason = ""
    }
    Menu.SetupMenu("banreason2_menu", "Choose a reason")
    Menu.Switch("bantime2_menu","banreason2_menu")
    Menu.addOption("banreason2_menu", function()
        if(Menu.Option("RDM")) then
            ban.reason = "RDM"
            Ban(ban)
        end
    end)
    Menu.addOption("banreason2_menu", function()
        if(Menu.Option("VDM")) then
            ban.reason = "VDM"
            Ban(ban)
        end
    end)
    Menu.addOption("banreason2_menu", function()
        if(Menu.Option("FailRP")) then
            ban.reason = "FailRP"
            Ban(ban)
        end
    end)
    Menu.addOption("banreason2_menu", function()
        if(Menu.Option("Type reason")) then
            ban.reason = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
            Ban(ban)
        end
    end)
end

function Ban(ban)
    local reason = tostring(ban.reason)
    local id = tonumber(ban.id)
    local time = tostring(ban.time)
    if(reason == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        showLoadingPrompt("Enter a reason..", 3)
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
        while (UpdateOnscreenKeyboard() == 0) do
              DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tostring(GetOnscreenKeyboardResult())
            if(res ~= nil and res ~= 0 and res ~= "") then
                reason = res               
            end
        end
    end
    stopLoadingPrompt()        
    if(reason ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
        TriggerServerEvent("FAC:Ban", GetPlayerServerId(id), time, reason)
    end
    Admin()
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Admin Functions                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if deletegun2 then
            if IsPlayerFreeAiming(PlayerId()) then
                local entity = getEntity(PlayerId())
                if IsPedShooting(GetPlayerPed(-1)) then
                    SetEntityAsMissionEntity(entity, true, true)
                    DeleteEntity(entity)
                end
            end
        end
    end
end)

function getEntity(player) --Function To Get Entity Player Is Aiming At
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)
    return entity
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Vehicle Menu                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function VehMenu()
    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
        if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
            if exports.policejob:getIsInService() == true then
                Menu.SetupMenu("vehicle_menu","Vehicle Controls")
                Menu.Switch("main_menu","vehicle_menu")
                Menu.addOption("vehicle_menu", function()
                    if(Menu.Bool("Engine", enginetoggled,"~r~OFF","~g~ON",function(cb)    enginetoggled = cb end)) then
                        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                            if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                                if enginetoggled then
                                    SetVehicleEngineOn(v,false,true,true)
                                    SetVehicleUndriveable(v, true)
                                else
                                    SetVehicleEngineOn(veh,true,true,true)
                                    SetVehicleUndriveable(v, false)
                                end
                            else
                                player_menu = false
                            end
                        else
                            player_menu = false
                        end
                    end
                end)
                Menu.addOption("vehicle_menu", function()
                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                        if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                            if(Menu.StringArray("Door:", doorDisplayNames, doorPosition,function(cb) Citizen.Trace(cb) doorPosition = cb end)) then
                                if(doorState[doorPosition-1]) then
                                    SetVehicleDoorShut(v, doorPosition-1, false)
                                    doorState[doorPosition-1] = false
                                else
                                    SetVehicleDoorOpen(v, doorPosition-1, false, false)
                                    doorState[doorPosition-1] = true
                                end                            
                            end
                        else
                            player_menu = false
                        end
                    else
                        player_menu = false
                    end
                end)
                Menu.addOption("vehicle_menu", function()
                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                        if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                            if(Menu.Bool("Car lock status:", lockcar2,carlockstatus,carlockstatus,function(cb)    lockcar2 = cb end)) then
                                if lockcar2 then
                                    TriggerEvent("ls:altlock")
                                else
                                    TriggerEvent("ls:altlock")
                                end
                            end
                        else
                            player_menu = false
                        end
                    else
                        player_menu = false
                    end
                end)
                Menu.addOption("vehicle_menu", function()
                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                        if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                            if GetEntitySpeed(veh) > 0.45 and lockspeed2 == false then
                                if(Menu.Bool("Speed", lockspeed2,"~r~Locked","~g~Unlocked",function(cb)    lockspeed2 = cb end)) then
                                    if lockspeed2 then
                                        lockspeed = true
                                    else
                                        lockspeed = true
                                    end
                                end
                            elseif lockspeed2 == true then
                                if(Menu.Bool("Speed", lockspeed2,"~r~Locked","~g~Unlocked",function(cb)    lockspeed2 = cb end)) then
                                    if lockspeed2 then
                                        lockspeed = true
                                    else
                                        lockspeed = true
                                    end
                                end
                            end                                     
                        else
                            player_menu = false
                            Messages(1)
                        end
                    else
                        player_menu = false
                        Messages(2)
                    end
                end)
            elseif exports.emsjob:getIsInService() == true then
                Menu.SetupMenu("vehicle_menu","Vehicle Controls")
                Menu.Switch("main_menu","vehicle_menu")
                Menu.addOption("vehicle_menu", function()
                    if(Menu.Bool("Engine", enginetoggled,"~r~OFF","~g~ON",function(cb)    enginetoggled = cb end)) then
                        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                            if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                                if enginetoggled then
                                    SetVehicleEngineOn(v,false,true,true)
                                    SetVehicleUndriveable(v, true)
                                else
                                    SetVehicleEngineOn(veh,true,true,true)
                                    SetVehicleUndriveable(v, false)
                                end
                            else
                                player_menu = false
                            end
                        else
                            player_menu = false
                        end
                    end
                end)
                Menu.addOption("vehicle_menu", function()
                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                        if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                            if(Menu.StringArray("Door:", doorDisplayNames, doorPosition,function(cb) Citizen.Trace(cb) doorPosition = cb end)) then
                                if(doorState[doorPosition-1]) then
                                    SetVehicleDoorShut(v, doorPosition-1, false)
                                    doorState[doorPosition-1] = false
                                else
                                    SetVehicleDoorOpen(v, doorPosition-1, false, false)
                                    doorState[doorPosition-1] = true
                                end                            
                            end
                        else
                            player_menu = false
                        end
                    else
                        player_menu = false
                    end
                end)
                Menu.addOption("vehicle_menu", function()
                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                        if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                            if(Menu.Bool("Car lock status:", lockcar2,carlockstatus,carlockstatus,function(cb)    lockcar2 = cb end)) then
                                if lockcar2 then
                                    TriggerEvent("ls:altlock")
                                else
                                    TriggerEvent("ls:altlock")
                                end
                            end
                        else
                            player_menu = false
                        end
                    else
                        player_menu = false
                    end
                end)
                Menu.addOption("vehicle_menu", function()
                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                        if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                            if GetEntitySpeed(veh) > 0.45 and lockspeed2 == false then
                                if(Menu.Bool("Speed", lockspeed2,"~r~Locked","~g~Unlocked",function(cb)    lockspeed2 = cb end)) then
                                    if lockspeed2 then
                                        lockspeed = true
                                    else
                                        lockspeed = true
                                    end
                                end
                            elseif lockspeed2 == true then
                                if(Menu.Bool("Speed", lockspeed2,"~r~Locked","~g~Unlocked",function(cb)    lockspeed2 = cb end)) then
                                    if lockspeed2 then
                                        lockspeed = true
                                    else
                                        lockspeed = true
                                    end
                                end
                            end                                     
                        else
                            player_menu = false
                            Messages(1)
                        end
                    else
                        player_menu = false
                        Messages(2)
                    end
                end)
            else
                if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) == false then
                    Menu.SetupMenu("vehicle_menu","Vehicle Controls")
                    Menu.Switch("main_menu","vehicle_menu")
                    Menu.addOption("vehicle_menu", function()
                        if(Menu.Bool("Engine", enginetoggled,"~r~OFF","~g~ON",function(cb)    enginetoggled = cb end)) then
                            if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) == false then
                                if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                                    local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                                    if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                                        if enginetoggled then
                                            SetVehicleEngineOn(v,false,true,true)
                                            SetVehicleUndriveable(v, true)
                                        else
                                            SetVehicleEngineOn(veh,true,true,true)
                                            SetVehicleUndriveable(v, false)
                                        end
                                    else
                                        player_menu = false
                                    end
                                else
                                    player_menu = false
                                end
                            else
                                player_menu = false
                            end
                        end
                    end)
                    Menu.addOption("vehicle_menu", function()
                        if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) == false then
                            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                                local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                                if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                                    if(Menu.StringArray("Door:", doorDisplayNames, doorPosition,function(cb) Citizen.Trace(cb) doorPosition = cb end)) then

                                        if(doorState[doorPosition-1]) then
                                            SetVehicleDoorShut(v, doorPosition-1, false)
                                            doorState[doorPosition-1] = false
                                        else
                                            SetVehicleDoorOpen(v, doorPosition-1, false, false)
                                            doorState[doorPosition-1] = true
                                        end                            
                                    end
                                else
                                    player_menu = false
                                end
                            else
                                player_menu = false
                            end
                        else
                            player_menu = false
                        end
                    end)
                    Menu.addOption("vehicle_menu", function()
                        if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) == false then
                            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                                local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                                if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                                    if(Menu.Bool("Car lock status:", lockcar2,carlockstatus,carlockstatus,function(cb)    lockcar2 = cb end)) then
                                        if lockcar2 then
                                            TriggerEvent("ls:altlock")
                                        else
                                            TriggerEvent("ls:altlock")
                                        end
                                    end
                                else
                                    player_menu = false
                                end
                            else
                                player_menu = false
                            end
                        else
                            player_menu = false
                        end
                    end)
                    Menu.addOption("vehicle_menu", function()
                        if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) == false then
                            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                                local v = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                                if (GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1)) then
                                    if GetEntitySpeed(veh) > 0.45 and lockspeed2 == false then
                                        if(Menu.Bool("Speed", lockspeed2,"~r~Locked","~g~Unlocked",function(cb)    lockspeed2 = cb end)) then
                                            if lockspeed2 then
                                                lockspeed = true
                                            else
                                                lockspeed = true
                                            end
                                        end
                                    elseif lockspeed2 == true then
                                        if(Menu.Bool("Speed", lockspeed2,"~r~Locked","~g~Unlocked",function(cb)    lockspeed2 = cb end)) then
                                            if lockspeed2 then
                                                lockspeed = true
                                            else
                                                lockspeed = true
                                            end
                                        end
                                    end                                     
                                else
                                    player_menu = false
                                    Messages(1)
                                end
                            else
                                player_menu = false
                                Messages(2)
                            end
                        else
                            player_menu = false
                            Messages(3)
                        end
                    end)
                else
                    Messages(3)
                end
            end
        else
            Messages(1)
        end
    else
        Menu.SetupMenu("vehicle_menu","Vehicle Controls")
        Menu.Switch("main_menu","vehicle_menu")
        Menu.addOption("vehicle_menu", function()
            if(Menu.Bool("Car lock status:", lockcar2,carlockstatus,carlockstatus,function(cb)    lockcar2 = cb end)) then
                if lockcar2 then
                    TriggerEvent("ls:altlock")
                else
                    TriggerEvent("ls:altlock")
                end
            end
        end)
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Vehicle Functions                                                      --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(0)   
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local vehicleModel = GetEntityModel(vehicle)
        local speed = GetEntitySpeed(vehicle)
        local float Max = GetVehicleMaxSpeed(vehicleModel)
        if(ped)then
            if lockspeed then
                local inVehicle = IsPedSittingInAnyVehicle(ped)
                if (inVehicle) then
                    if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                        if enableCruise == false then
                        	enableCruise = true
                            SetEntityMaxSpeed(vehicle, speed)
                        else
                            SetEntityMaxSpeed(vehicle, Max)
                            enableCruise = false
                        end
                    else
                        Messages(1)
                    end
                end
                lockspeed = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
	    if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and enableCruise then
	        enableCruise = false
	    end
        if not enableCruise then
	        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
	            local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
	            if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
	                SetEntityMaxSpeed(veh, 180/2.236936)
	            else
	            	local car_found = false
	            	for k,v in pairs(car_speeds) do
	            		if GetEntityModel(veh) == GetHashKey(v.model) then
	            			SetEntityMaxSpeed(veh, v.speed/2.236936)
	            			car_found = true
	            		end
	            	end
	            	if not car_found then
	                	SetEntityMaxSpeed(veh, 115/2.236936)
	                end
	            end
	        end
        end
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                        Inventory Menu                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function InventoryMenu()
    Menu.SetupMenu("inventory_menu","Items: " .. getQuantity() .. "/" .. 100)
    Menu.Switch("main_menu","inventory_menu")
    for i = 1,#inventory do
        if (inventory[i].q > 0) then
            Menu.addOption("inventory_menu", function()
                if(Menu.Bool(tostring(inventory[i].n), invbool, tostring(inventory[i].q),tostring(inventory[i].q),function(cb)   invbool = cb end))then
                    if invbool then
                        local val = {inventory[i].id,inventory[i].cu,inventory[i].n}
                        ItemMenu(val)
                    else
                        local val = {inventory[i].id,inventory[i].cu,inventory[i].n}
                        ItemMenu(val)
                    end
                end
            end)
        end
    end--]]
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Item Menu                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function ItemMenu(val)
    local itemId = val[1]
    local canUse = val[2]
    local itemName = val[3]
    Menu.SetupMenu("item_menu",itemName.." options")
    Menu.Switch("inventory_menu","item_menu")
    Menu.addOption("item_menu", function()
        if(Menu.Option("Use "..itemName))then
            local tbl = {itemId, canUse}
            use(tbl)
        end
    end)
    Menu.addOption("item_menu", function()
        if(Menu.Option("Give "..itemName))then
            give(itemId)
        end
    end)
    Menu.addOption("item_menu", function()
        if(Menu.Option("Drop "..itemName))then
            drop(itemId)
        end
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                        Animations Menu                                                       --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function animsMenu()
    Menu.SetupMenu("animations_menu","Animations")
    Menu.Switch("main_menu","animations_menu")
    Menu.addOption("animations_menu", function()
        if(Menu.Option("Greetings"))then
            animsSub("Greet")
        end
    end)
    Menu.addOption("animations_menu", function()
        if(Menu.Option("Funny"))then
            animsSub("Humour")
        end
    end)
    Menu.addOption("animations_menu", function()
        if(Menu.Option("Job Related"))then
            animsSub("Job")
        end
    end)
    Menu.addOption("animations_menu", function()
        if(Menu.Option("Festive"))then
            animsSub("Festive")
        end
    end)
    Menu.addOption("animations_menu", function()
        if(Menu.Option("Other"))then
            animsSub("Other")
        end
    end)
end

local anims = {
    ["Festive"] = {
        {"Dance", 1, { lib = "amb@world_human_partying@female@partying_beer@base", anim = "base" }},
        {"Drink a Beer", 2, { anim = "WORLD_HUMAN_DRINKING" }},
        {"Air Guitar", 1, { lib = "anim@mp_player_intcelebrationfemale@air_guitar", anim = "air_guitar" }},
    },
    ["Greet"] = {
        {"Wave", 1, { lib = "gestures@m@standing@casual", anim = "gesture_hello" }},
        {"Shake Hands", 1, { lib = "mp_common", anim = "givetake1_a" }},
        {"High Five", 1, { lib = "mp_ped_interaction", anim = "highfive_guy_a" }},
        {"Military Salute", 1, { lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute" }},
        {"Hug", 1, { lib = "mp_ped_interaction", anim = "kisses_guy_a" }},
    },
    ["Job"] = {
        {"Fishing", 2, {anim = "world_human_stand_fishing" }},
        {"Farmer", 2, { anim = "world_human_gardener_plant"}},
        {"Take Notes", 2, { anim = "WORLD_HUMAN_CLIPBOARD" }},
        {"Wipe Down", 2, { anim = "world_human_maid_clean" }},
    },
    ["Humour"] = {
        {"Congratulate", 2, {anim = "WORLD_HUMAN_CHEERING" }},
        {"Super", 1, { lib = "anim@mp_player_intcelebrationmale@thumbs_up", anim = "thumbs_up" }},
        {"Calm Down", 1, { lib = "gestures@m@standing@casual", anim = "gesture_easy_now" }},
        {"Scared", 1, { lib = "amb@code_human_cower_stand@female@idle_a", anim = "idle_c" }},
        {"No Way", 1, { lib = "gestures@m@standing@casual", anim = "gesture_damn" }},
        {"Middle Fingers", 1, { lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter" }},
        {"Wank", 1, { lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01" }},
        {"Grab Privates", 1, { lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" }},
        {"Fake Suicide", 1, { lib = "mp_suicide", anim = "pistol" }},
    },
    ["Other"] = {
        {"Smoke", 2, { anim = "WORLD_HUMAN_SMOKING" }},
        {"Chair", 1, { lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle" }},
        {"Sit Picnic", 2, { anim = "WORLD_HUMAN_PICNIC" }},
        {"Lean", 2, { anim = "world_human_leaning" }},
        {"Spread Em", 1, { lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female" }},
        {"Take a Selfie", 2, { anim = "world_human_tourist_mobile" }},
	    {"Coffee", 2, {anim = "WORLD_HUMAN_AA_COFFEE"}},
	    {"Smoke", 2, {anim = "WORLD_HUMAN_AA_SMOKE"}},
	    {"Binoculars", 2, {anim = "WORLD_HUMAN_BINOCULARS"}},
	    {"Freeway Bum", 2, {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
	    {"Slumped", 2, {anim = "WORLD_HUMAN_BUM_SLUMPED"}},
	    {"Standing Bum", 2, {anim = "WORLD_HUMAN_BUM_STANDING"}},
	    {"Washing Bum", 2, {anim = "WORLD_HUMAN_BUM_WASH"}},
	    {"Car Park Attendant", 2, {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
	    {"Cheering", 2, {anim = "WORLD_HUMAN_CHEERING"}},
	    {"Clipboard", 2, {anim = "WORLD_HUMAN_CLIPBOARD"}},
	    {"Drilling", 2, {anim = "WORLD_HUMAN_CONST_DRILL"}},
	    {"Idling Cop", 2, {anim = "WORLD_HUMAN_COP_IDLES"}},
	    {"Drinking", 2, {anim = "WORLD_HUMAN_DRINKING"}},
	    {"Drug Dealer", 2, {anim = "WORLD_HUMAN_DRUG_DEALER"}},
	    {"Drug Dealer Hard", 2, {anim = "WORLD_HUMAN_DRUG_DEALER_HARD"}},
	    {"Film With Phone", 2, {anim = "WORLD_HUMAN_MOBILE_FILM_SHOCKING"}},
	    {"Leaf Blower", 2, {anim = "WORLD_HUMAN_GARDENER_LEAF_BLOWER"}},
	    {"Planting", 2, {anim = "WORLD_HUMAN_GARDENER_PLANT"}},
	    {"Golf Player", 2, {anim = "WORLD_HUMAN_GOLF_PLAYER"}},
	    {"Guard Patrol", 2, {anim = "WORLD_HUMAN_GUARD_PATROL"}},
	    {"Guard Standing", 2, {anim = "WORLD_HUMAN_GUARD_STAND"}},
	    {"Army Standing", 2, {anim = "WORLD_HUMAN_GUARD_STAND_ARMY"}},
	    {"Hammering", 2, {anim = "WORLD_HUMAN_HAMMERING"}},
	    {"Hang Out", 2, {anim = "WORLD_HUMAN_HANG_OUT_STREET"}},
	    {"Hiker Standing", 2, {anim = "WORLD_HUMAN_HIKER_STANDING"}},
	    {"Human Statue", 2, {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
	    {"Janitor", 2, {anim = "WORLD_HUMAN_JANITOR"}},
	    {"Jog On The Spot", 2, {anim = "WORLD_HUMAN_JOG_STANDING"}},
	    {"Lean", 2, {anim = "WORLD_HUMAN_LEANING"}},
	    {"Flex", 2, {anim = "WORLD_HUMAN_MUSCLE_FLEX"}},
	    {"Weights", 2, {anim = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"}},
	    {"Musician", 2, {anim = "WORLD_HUMAN_MUSICIAN"}},
	    {"Paparazzi", 2, {anim = "WORLD_HUMAN_PAPARAZZI"}},
	    {"Partying", 2, {anim = "WORLD_HUMAN_PARTYING"}},
	    {"Picnic", 2, {anim = "WORLD_HUMAN_PICNIC"}},
	    {"Low Class Prostitute", 2, {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
	    {"High Class Prostitute", 2, {anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS"}},
	    {"Push Ups", 2, {anim = "WORLD_HUMAN_PUSH_UPS"}},
	    {"Seat Ledge", 2, {anim = "WORLD_HUMAN_SEAT_LEDGE"}},
	    {"Shine Torch", 2, {anim = "WORLD_HUMAN_SECURITY_SHINE_TORCH"}},
	    {"Sit Ups", 2, {anim = "WORLD_HUMAN_SIT_UPS"}},
	    {"Smoking Pot", 2, {anim = "WORLD_HUMAN_SMOKING_POT"}},
	    {"Stand By Fire", 2, {anim = "WORLD_HUMAN_STAND_FIRE"}},
	    {"Fishing", 2, {anim = "WORLD_HUMAN_STAND_FISHING"}},
	    {"Impatient", 2, {anim = "WORLD_HUMAN_STAND_IMPATIENT"}},
	    {"Stand Using Mobile", 2, {anim = "WORLD_HUMAN_STAND_MOBILE"}},
	    {"Watch Stripper", 2, {anim = "WORLD_HUMAN_STRIP_WATCH_STAND"}},
	    {"Stupor", 2, {anim = "WORLD_HUMAN_STUPOR"}},
	    {"Sunbathe", 2, {anim = "WORLD_HUMAN_SUNBATHE"}},
	    {"Sunbathe On Back", 2, {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
	    {"Superhero", 2, {anim = "WORLD_HUMAN_SUPERHERO"}},
	    {"Swimming", 2, {anim = "WORLD_HUMAN_SWIMMING"}},
	    {"Tennis Player", 2, {anim = "WORLD_HUMAN_TENNIS_PLAYER"}},
	    {"Tourist With Map", 2, {anim = "WORLD_HUMAN_TOURIST_MAP"}},
	    {"Mobile", 2, {anim = "WORLD_HUMAN_TOURIST_MOBILE"}},
	    {"Welding", 2, {anim = "WORLD_HUMAN_WELDING"}},
	    {"Browse Shop Window", 2, {anim = "WORLD_HUMAN_WINDOW_SHOP_BROWSE"}},
	    {"Yoga", 2, {anim = "WORLD_HUMAN_YOGA"}},
	    {"ATM", 2, {anim = "PROP_HUMAN_ATM"}},
	    {"BBQ", 2, {anim = "PROP_HUMAN_BBQ"}},
	    {"Bench Press", 2, {anim = "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS"}},
    }
}
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                      Animation Functions                                                     --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function animsSub(cat)
    Citizen.Trace(cat)
    Menu.SetupMenu("animations_sub_menu","Animations")
    Menu.Switch("animations_menu","animations_sub_menu")
    for _, v in pairs(anims[cat]) do
        Menu.addOption("animations_sub_menu", function()
            if(Menu.Option(v[1]))then
                if v[2] == 1 then
                    animsAction(v[3])
                elseif v[2] == 2 then
                    animsActionScenario(v[3])
                end 
            end
        end)
    end
end

function animsAction(animObj)
    RequestAnimDict(animObj.lib)
    while not HasAnimDictLoaded(animObj.lib) do
        Citizen.Wait(0)
    end
    if HasAnimDictLoaded(animObj.lib) then
        TaskPlayAnim(GetPlayerPed(-1), animObj.lib , animObj.anim ,8.0, -8.0, -1, 0, 0, false, false, false)
    end
end

function animsActionScenario(animObj)
    local ped = GetPlayerPed(-1);

    if ped then
        local pos = GetEntityCoords(ped);
        local head = GetEntityHeading(ped);
        --TaskStartScenarioAtPosition(ped, animObj.anim, pos['x'], pos['y'], pos['z'] - 1, head, -1, false, false);
        TaskStartScenarioInPlace(ped, animObj.anim, 0, false)
        if IsControlJustPressed(1,188) then
        
        end
        Citizen.CreateThread(function()
            while IsPedUsingAnyScenario(ped) do
                Citizen.Wait(5)
                if IsPedUsingAnyScenario(ped) then
                    if IsControlJustPressed(1, 34) or IsControlJustPressed(1, 32) or IsControlJustPressed(1, 8) or IsControlJustPressed(1, 9) then
                        ClearPedTasks(ped)
                    end
                end
            end
        end)
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Other Menu                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function OtherMenu()
    Menu.SetupMenu("other_menu","Other")
    Menu.Switch("main_menu","other_menu")
    Menu.addOption("other_menu", function()
        if(Menu.Option("Money"))then
            MoneyMenu()   
        end
    end)
    Menu.addOption("other_menu", function()
        if(Menu.Option("Identity"))then
            IdentityMenu()   
        end
    end)
end

function MoneyMenu()
    Menu.SetupMenu("other_menu_money","Other")
    Menu.Switch("other_menu","other_menu_money")
    Menu.addOption("other_menu_money", function()
        if(Menu.Option("Give money"))then
            GiveMoney()   
        end
    end)
    Menu.addOption("other_menu_money", function()
        if(Menu.Option("Give dirty money"))then
            GiveDirty()   
        end
    end)
end

function IdentityMenu()
    Menu.SetupMenu("other_menu_id","Other")
    Menu.Switch("other_menu","other_menu_id")
    Menu.addOption("other_menu_id", function()
        if(Menu.Option("View ID"))then
            TriggerEvent("gcl:openMeIdentity")
        end
    end)
    Menu.addOption("other_menu_id", function()
        if(Menu.Option("Show ID"))then
            local t, distance = GetClosestPlayer()
            if(distance ~= -1 and distance < 3) then
                TriggerEvent("gcl:showItentity")
            else
                Messages(5)
            end 
        end
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                     Other Menu Functions                                                     --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function GiveMoney()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
        if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
            showLoadingPrompt("Enter amount!", 3)
            DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
            while (UpdateOnscreenKeyboard() == 0) do
                  DisableAllControlActions(0);
                Wait(0);
            end
            if (GetOnscreenKeyboardResult()) then
                local option = tonumber(GetOnscreenKeyboardResult())
                if(option ~= nil and option ~= 0) then
                    amount = ""..option
                end
            end
        end
        stopLoadingPrompt()
        if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
            TriggerServerEvent("interactions:givemoney", tonumber(amount), GetPlayerServerId(t))
        end
        MoneyMenu()
    else
        Messages(5)
    end
end

function GiveDirty()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
        if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
            showLoadingPrompt("Enter amount!", 3)
            DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
            while (UpdateOnscreenKeyboard() == 0) do
                  DisableAllControlActions(0);
                Wait(0);
            end
            if (GetOnscreenKeyboardResult()) then
                local option = tonumber(GetOnscreenKeyboardResult())
                if(option ~= nil and option ~= 0) then
                    amount = ""..option
                end
            end
        end
        stopLoadingPrompt()
        if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
            TriggerServerEvent("interactions:givedmoney", tonumber(amount), GetPlayerServerId(t))
        end
        MoneyMenu()
    else
        Messages(5)
    end
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Settings Menu                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function SettingsMenu()
    Menu.SetupMenu("settings_menu","Settings")
    Menu.Switch("main_menu","settings_menu")
    Menu.addOption("settings_menu", function()
        if(Menu.Bool("Chat:", chatbool, "~r~Disabled","~g~Enabled",function(cb)   chatbool = cb end))then
            if chatbool then
                DecorSetBool(GetPlayerPed(-1), "chat_disabled", true)
            else
                DecorSetBool(GetPlayerPed(-1), "chat_disabled", false)
            end
         end
    end)
    Menu.addOption("settings_menu", function()
        if(Menu.StringArray("Voice:", {"< Whisper >", "< Normal >", "< Shout >"}, voipposition,function(cb) voipposition = cb end)) then
            if voipposition == 1 then
                voip = "~g~Whisper"
                NetworkSetTalkerProximity(4.0)
            elseif voipposition == 2 then
                voip = "~b~Normal"
                NetworkSetTalkerProximity(15.0)
            elseif voipposition == 3 then
                voip = "~r~Shout"
                NetworkSetTalkerProximity(35.0)
            end
        end 
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                    Settings Menu Functions                                                   --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local function drawThisTxt(x,y ,width,height,scale, text, r,g,b,a,font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

AddEventHandler('onClientMapStart', function()
    NetworkSetTalkerProximity(15.0)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsPlayerTalking(PlayerId()) then
            drawThisTxt(0.283, 0.95, 0.25, 0.03, 0.50,"~g~You are talking ~w~| Voice : "..voip,255,255,255,255,6)
        else
            drawThisTxt(0.283, 0.95, 0.25, 0.03, 0.50,"Voice : "..voip,255,255,255,255,6)
        end
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Useful Functions                                                       --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function drawTxtpage(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

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

function DrawMissionText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                             END                                                              --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--TriggerServerEvent("inventory:reload")