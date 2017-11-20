function drawLicenseText(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
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

licenses = {
    {"Level 1", {name="Level 1", price=25000,level=1}},
    {"Level 2", {name="Level 2", price=150000,level=2}},
    {"Level 3", {name="Level 3", price=500000,level=3}},
    {"Level 4", {name="Level 4", price=1000000,level=4}}
}
license_menu = false
local licensebool = false
function license()
    Menu.SetupMenu("license_menu","LS Gun Licenses")
    Menu.Switch(nil,"license_menu")
    for ind, value in pairs(licenses) do
        Menu.addOption("license_menu", function()
            if(Menu.Bool(tostring(value[1]), licensebool,"~g~$~w~"..value[2].price,"~g~$~w~"..value[2].price,function(cb)   licensebool = cb end))then
                if licensebool then
                    buylicense(value[2])
                else
                    buylicense(value[2])
                end
            end
        end)
    end
end

function buylicense(item)
    TriggerServerEvent("license:checkMoney", item)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press E to open/close menu in the red marker
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
emplacement_license = {
    {name="Gun license", colour=5, id=434, x=12.699568748474, y=-1105.0811767578, z=29.797033309937},
    {name="Gun license", colour=5, id=434, x=819.67834472656, y=-2155.8120117188, z=29.619020462036},    
}
local incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(emplacement_license) do
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
        for k,v in ipairs(emplacement_license) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 177, 202, 223,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy a gun license!")
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
                        license_menu = not license_menu
                        license() -- Menu to draw
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                    license_menu = false
                end
            end
        end
    end
end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Help messages
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawR(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
    DrawRect(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if license_menu then
            if currentOption == 1 then
                DrawRect(0.75,0.62,0.315,0.09,40, 40, 40, 190)
                DrawRect(0.75,0.55,0.315,0.05,0, 82, 165, 255)
                drawLicenseText(1.145, 1.02, 1.0,1.0,0.8, "Allows you to purchase and use...", 255, 255, 255, 255, true)
                drawLicenseText(1.095, 1.07, 1.0,1.0,0.4, "Pistol, Pistol .50, SNS Pistol, Heavy Pistol, Revolver and weapons that don't require a license!", 255, 255, 255, 255, true)
            end
            if currentOption == 2 then
                DrawRect(0.75,0.62,0.315,0.09,40, 40, 40, 190)
                DrawRect(0.75,0.55,0.315,0.05,0, 82, 165, 255)
                drawLicenseText(1.145, 1.02, 1.0,1.0,0.8, "Allows you to purchase and use...", 255, 255, 255, 255, true)
                drawLicenseText(1.10, 1.07, 1.0,1.0,0.4, "Smoke Grenade, Pump Shotgun, Sawn-Off Shotgun, Bullpup Shotgun, Double-Barrel,", 255, 255, 255, 255, true)
                drawLicenseText(1.10, 1.09, 1.0,1.0,0.4, "Auto Shotgun,Pistol, Pistol .50, SNS Pistol, Heavy Pistol, Revolver and weapons that don't", 255, 255, 255, 255, true)
                drawLicenseText(1.10, 1.11, 1.0,1.0,0.4, "require a license!", 255, 255, 255, 255, true)
            end
            if currentOption == 3 then
                DrawRect(0.75,0.62,0.315,0.09,40, 40, 40, 190)
                DrawRect(0.75,0.55,0.315,0.05,0, 82, 165, 255)
                drawLicenseText(1.145, 1.02, 1.0,1.0,0.8, "Allows you to purchase and use...", 255, 255, 255, 255, true)
                drawLicenseText(1.097, 1.07, 1.0,1.0,0.4, "Micro SMG, SMG, Assault SMG, MG, Guesenburg, Smoke Grenade, Pump Shotgun, Sawn-Off", 255, 255, 255, 255, true)                
                drawLicenseText(1.097, 1.09, 1.0,1.0,0.4, "Shotgun, Bullpup Shotgun, Double-Barrel, Auto Shotgun,Pistol, Pistol .50, SNS Pistol, Heavy", 255, 255, 255, 255, true)
                drawLicenseText(1.097, 1.11, 1.0,1.0,0.4, "Pistol, Revolver and weapons that don't require a license!", 255, 255, 255, 255, true)
            end
            if currentOption == 4 then
                DrawRect(0.75,0.62,0.315,0.09,40, 40, 40, 190)
                DrawRect(0.75,0.55,0.315,0.05,0, 82, 165, 255)
                drawLicenseText(1.145, 1.02, 1.0,1.0,0.8, "Allows you to purchase and use...", 255, 255, 255, 255, true)
                drawLicenseText(1.097, 1.07, 1.0,1.0,0.4, "Assault Rifle, Carbine Rifle, Advanced Rifle, Special Carbine, Micro SMG, SMG, Assault SMG,", 255, 255, 255, 255, true)                
                drawLicenseText(1.097, 1.09, 1.0,1.0,0.4, "MG, Guesenburg, Smoke Grenade, Pump Shotgun, Sawn-Off Shotgun, Bullpup Shotgun,", 255, 255, 255, 255, true)
                drawLicenseText(1.097, 1.11, 1.0,1.0,0.4, "Double-Barrel, Auto Shotgun,Pistol, Pistol .50, SNS Pistol, Heavy Pistol, Revolver and", 255, 255, 255, 255, true)
                drawLicenseText(1.097, 1.13, 1.0,1.0,0.4, "weapons that don't require a license!", 255, 255, 255, 255, true)
            end
        end
    end
end)