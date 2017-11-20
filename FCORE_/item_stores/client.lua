local itembool = false
function itemshop(cat)
    if cat ~= "b" then
        Menu.SetupMenu("item_shop_menu","LS Mart")
        Menu.Switch(nil,"item_shop_menu")
    else
        Menu.SetupMenu("item_shop_menu","LS Blackmarket")
        Menu.Switch(nil,"item_shop_menu")
    end
    for ind, value in pairs(items[cat]) do
        Menu.addOption("item_shop_menu", function()
            if(Menu.Bool(tostring(value[1]), itembool,"~g~$~w~"..value[2].price,"~g~$~w~"..value[2].price,function(cb)   itembool = cb end))then
                if itembool then
                    buyitem(value[2], cat)
                else
                	buyitem(value[2], cat)
                end
            end
        end)
    end
end

items = {
    ["a"] = {
        {"Burger",{name="Burger", id=40, price=12}},
        {"Water",{name="Water", id=6, price=6}},
        {"Vodka",{name="Vodka", id=41, price=30}},
        {"Medkit",{name="Medkit", id=34, price=300}},
        {"Repair kit",{name="Repair kit", id=37, price=1000}},
    },
    ["b"] = {
        {"Medkit",{name="Cheap Medkit", id=35, price=150}},
        {"Repair kit",{name="Cheap Repair kit", id=38, price=500}},
        {"Lockpick",{name="Lockpick", id=36, price=100}},
        {"Body armour",{name="Body armour", id=39, price=1500}},
    }
}

function buyitem(item, cat)
    TriggerServerEvent("is:checkMoney", item, cat)
end

RegisterNetEvent("is:giveitem")
AddEventHandler("is:giveitem", function(item)
    TriggerEvent('inventory:addQty', item.id, 1)
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press E to open/close menu in the red marker
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
shop_emplacement = {
    {name="Item store", id=52, x=1961.1140136719, y=3741.4494628906,z=32.34375 },
    {name="Item store", id=52, x=1392.4129638672, y=3604.47265625, z=34.980926513672 },
    {name="Item store", id=52, x=546.98962402344, y=2670.3176269531, z=42.156539916992 },
    {name="Item store", id=52, x=2556.2534179688, y=382.876953125, z=108.62294769287 },
    {name="Item store", id=52, x=-1821.9542236328, y=792.40191650391, z=138.13920593262 },
    {name="Item store", id=52, x=128.1410369873, y=-1286.1120605469, z=29.281036376953 },
    {name="Item store", id=52, x=-1223.6690673828, y=-906.67517089844, z=12.326356887817 },
    {name="Item store", id=52, x=-708.19256591797, y=-914.65264892578, z=19.215591430664 },
    {name="Item store", id=52, x=26.419162750244, y=-1347.5804443359, z=29.497024536133 },
    {name="Item store", id=52, x=1135.67, y=-982.177, z=46.4158 },
    {name="Item store", id=52, x=-47.124, y=-1756.52, z=29.421 },
    {name="Item store", id=52, x=-1487.48, y=-378.918, z=40.1634},
    {name="Item store", id=52, x=374.208, y=328.134, z=103.566 },
    {name="Item store", id=52, x=2676.99, y=3281.37, z=55.2412 },
    {name="Item store", id=52, x=-2967.86, y=391.037, z=15.0433 },
}
shop_emplacement_grove = {
    {name="Blackmarket", id=52, colour=1, x=123.43384552002, y=-1977.0679931641, z=20.956592559814 },
    {name="Blackmarket", id=52, colour=1, x=-788.66925048828, y=325.89855957031, z=85.700386047363 },
}
item_menu = false
incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(shop_emplacement) do
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
        for k,v in ipairs(shop_emplacement) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 0.5001, 1555, 255, 255,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy items!")
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
						menuXOtherOption = 0.055 ---------------- X position of Bools, Arrays etc text            --
						menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                --
						menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons --
						menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down --
                    	itemshop("a")
                    	item_menu = not item_menu
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    item_menu = false
                end
            end
        end
        for k,v in ipairs(shop_emplacement_grove) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 2.0001, 2.0001, 0.5001, 1555, 10, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy items!")
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
						menuXOtherOption = 0.055 ---------------- X position of Bools, Arrays etc text            --
						menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                --
						menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons --
						menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down --
                    	itemshop("b")
                    	item_menu = not item_menu
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    item_menu = false
                end
            end
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Help messages
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------