RegisterServerEvent("carRental:buy")
AddEventHandler("carRental:buy",function(title,car,data)
    local sourcePlayer = tonumber(source)
    local vt = nil
    for i = 1, #rental_cars do
        if rental_cars[i].title == title then
            vt = rental_cars[i].vehicles
            break
        end
    end
    if vt ~= nil then
        local correctprice = nil
        for i = 1, #vt do
            if vt[i].name == car.name then
                correctprice = vt[i].price
                break
            end
        end
        if correctprice ~= nil then
            if car.price == correctprice then
                TriggerEvent('f:getPlayer', source, function(user)
                    if (tonumber(user.getMoney()) >= tonumber(car.price)) then
                        user.removeMoney(correctprice)
                        TriggerClientEvent("carRental:bought", sourcePlayer, data)
                    else
                        TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
                    end
                end)
            else
                BanCheater("[ANTI-CHEAT] Cheatengine usage (Modifying Values)",sourcePlayer)
            end
        else
            TriggerEvent("f:log", "errors", "[ERROR - RENTALSHOP]::Vehicle price is NIL!")
            print("Vehicle price is nil...")
        end
    else
        TriggerEvent("f:log", "errors", "[ERROR - RENTALSHOP]::Vehicle table is NIL!")
        print("Vehicle table is nil...")
    end
end)

rental_cars = {
    {title = "Cars", vehicles = {
        {name = "Punto", price = 900},
        {name = "2017 Subaru BRZ t-S", price = 2500},
        {name = "2014 Lexus LX570", price = 5000},
        {name = "2002 Honda NSX", price = 2500},   
        {name = "2015 Mitsubishi Evo X", price = 2500},
        {name = "1990 MB 600SEL", price = 4500},
        {name = "1999 BMW 750iL E38", price = 4900},
        {name = "2016 VW Golf GTI", price = 3000},
        {name = "2003 BMW M5 E39", price = 4200},
        {name = "Alpha", price = 2000},
        {name = "Banshee", price = 3500},
        {name = "Buffalo", price = 4500},
        {name = "Buffalo S", price = 4700},
        {name = "Baller", price = 4000},
        {name = "Cavalcade", price = 3000},
        {name = "Grabger", price = 3500},
        {name = "Huntley S", price = 1450},
        {name = "Landstalker", price = 3800},
        {name = "Radius", price = 3200},
        {name = "Rocoto", price = 4500},
        {name = "Seminole", price = 3000},
        {name = "XLS", price = 5300},
        {name = "16 Porsche 911 TurboS", price = 25000},
        {name = "2004 Nissan GT-R R34", price = 20000},
        {name = "1998 Toyota Supra", price = 20000},
        {name = "2015 Nissan GTR R35", price = 30000}, 
    }},
    {title = "Motorcycles", vehicles = {
        {name = "Faggio", price = 550},
        {name = "Enduro", price = 700},
        {name = "ATV", price = 600},
    }},
}