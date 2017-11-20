RegisterServerEvent("garage:firstspawn")
AddEventHandler("garage:firstspawn",function(source)
    TriggerEvent('f:getPlayer', source, function(user)
        user.setState("~g~Stored")
    end)
end)

RegisterServerEvent("garage:reload")
AddEventHandler("garage:reload",function()
    local source = source
    TriggerEvent('f:getPlayer', source, function(user)
        user.setState("~g~Stored")
    end)
end)

RegisterServerEvent("garage:updatecars")
AddEventHandler("garage:updatecars",function(source)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local data = user.getCars()
        local gdata = user.getGarages()
        TriggerClientEvent("garage:updateVehicles", source, data, gdata)
    end)
end)

RegisterServerEvent("garage:stored")
AddEventHandler("garage:stored",function(data)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        user.addCar(data)
    end)
end)

RegisterServerEvent("garage:out")
AddEventHandler("garage:out",function(data, instance)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        user.addCar(data)
        user.setInstance(data.p, instance)
    end)
end)

RegisterServerEvent("garage:transfer")
AddEventHandler("garage:transfer",function(plate, gid)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        user.setGarage(plate,gid)
        GNotify(source,"Vehicle transferred!")
        TriggerClientEvent("garage:transfer", source)
    end)
end)

RegisterServerEvent("garage:buy")
AddEventHandler("garage:buy",function(cost, id, slots)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        if(user.getMoney() >= tonumber(cost))then
            user.addGarage(id,slots,cost)
            user.removeMoney(cost)
            GNotify(source,"Garage purchased!")
            TriggerClientEvent("garage:buy", source)
        else
            GNotify(source,"Insufficient funds!")
        end
    end)
end)

RegisterServerEvent("garage:buyslots")
AddEventHandler("garage:buyslots",function(cost, id, slots)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        if(user.getMoney() >= tonumber(cost))then
            user.addGarage(id,slots,cost)
            user.removeMoney(cost)
            GNotify(source,"Garage slots purchased!")
            TriggerClientEvent("garage:buy", source)
        else
            GNotify(source,"Insufficient funds!")
        end
    end)
end)

RegisterServerEvent("garage:insurance")
AddEventHandler("garage:insurance",function(plate,cost)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        if(user.getMoney() >= tonumber(cost))then
            user.setInsurance(plate)
            user.removeMoney(cost)
            GNotify(source,"Insurance purchased!")
            TriggerClientEvent("garage:insurance", source)
        else
            GNotify(source,"Insufficient funds!")
        end
    end)
end)

RegisterServerEvent("garage:sell")
AddEventHandler("garage:sell", function(plate,cost)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        user.removeCar(tostring(plate))
        user.addMoney(tonumber(cost))
        GNotify(source,"Vehicle sold!")
    end)
end)

RegisterServerEvent("garage:sellg")
AddEventHandler("garage:sellg", function(gid)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local data = user.getGarages()
        for i = 1, #data do 
            if data[i].id == gid then
                user.addMoney(data[i].cost)
            end
        end
        user.removeGarage(gid)
        GNotify(source,"Garage sold!")
        TriggerClientEvent("garage:transfer", source)
    end)
end)

function GNotify(source,message)
    TriggerClientEvent("pNotify:SendNotification", source, {text = message,type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
end