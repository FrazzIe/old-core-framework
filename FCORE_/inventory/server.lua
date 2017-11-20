--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                    Interactions/Inventory                                                    --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Inventory Events                                                       --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterServerEvent("inventory:updateitems")
AddEventHandler("inventory:updateitems",function(source)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local inventory = user.getInventory()
        TriggerClientEvent("inventory:updateitems", source, inventory)
    end)
end)

RegisterServerEvent("inventory:reload")
AddEventHandler("inventory:reload",function()
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local inventory = user.getInventory()
        TriggerClientEvent("inventory:updateitems", source, inventory)
    end)
end)

RegisterServerEvent("inventory:add")
AddEventHandler("inventory:add",function(i,q)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local canGet = user.isAbleToReceive(q)
        if not canGet then
            TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
        else
            user.addQuantity(i,q)
        end
    end)
end)

RegisterServerEvent("inventory:remove")
AddEventHandler("inventory:remove",function(i,q)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local canDrop = user.isAbleToDrop(i,q)
        if canDrop then
            user.removeQuantity(i,q)
        else
            TriggerClientEvent("inventory:messages", source, "~r~You cannot remove this item")
        end
    end)
end)

RegisterServerEvent("inventory:give")
AddEventHandler("inventory:give",function(i,q,target)
    local source = tonumber(source)
    local canGive = false
    local canRecieve = false
    local To
    local From
    TriggerEvent('f:getPlayer', source, function(user)
        canGive = user.isAbleToGive(i,q)
        From = user
    end)
    TriggerEvent('f:getPlayer', tonumber(target), function(t)
        canRecieve = t.isAbleToReceive(q)
        To = t
    end)
    if canGive then
        if canRecieve then
            From.removeQuantity(i,q)
            To.addQuantity(i,q)
            local data = To.getItemData(i)
            TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = GetPlayerName(source).." has gave you "..q.." "..data.n.."",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You gave "..GetPlayerName(tonumber(target)).." "..q.." "..data.n.."",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})  
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = GetPlayerName(tonumber(target)).." can't hold anymore items!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})    
            TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = GetPlayerName(source).." attempted to give you something but your inventory was full!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})            
        end
    else
        TriggerClientEvent("pNotify:SendNotification", source, {text = "You cannot give something that you do not have!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})    
    end
end)

RegisterServerEvent("inventory:drop")
AddEventHandler("inventory:drop",function(i,q)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        canDrop = user.isAbleToDrop(i,q)
        if canDrop then
            local data = user.getItemData(i)
            user.removeQuantity(i,q)
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You have dropped "..q.." "..data.n.."",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You cannot drop this amount!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
        end
    end)
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                      Interaction Events                                                      --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterServerEvent("interactions:givemoney")
AddEventHandler("interactions:givemoney", function(amount, target)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        if user.getMoney() >= tonumber(amount) then
            user.removeMoney(amount)
            TriggerEvent('f:getPlayer', tonumber(target), function(user2) user2.addMoney(amount) end)
            TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = GetPlayerName(source).." has gave you <span style='color:lime'>$</span>"..amount.."!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You gave "..GetPlayerName(tonumber(target)).." <span style='color:lime'>$</span>"..amount.."!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})   
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You do not have enough money!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
        end
    end)
end)

RegisterServerEvent("interactions:givedmoney")
AddEventHandler("interactions:givedmoney", function(amount, target)
    local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        if user.getDirty() >= tonumber(amount) then
            user.removeDirtyMoney(amount)
            TriggerEvent('f:getPlayer', tonumber(target), function(user2) user2.addDirtyMoney(amount) end)
            TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = GetPlayerName(source).." has gave you <span style='color:lime'>$</span>"..amount.." of cash that appears to be dirty!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You gave "..GetPlayerName(tonumber(target)).." <span style='color:lime'>$</span>"..amount.." of dirty cash",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})  
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You do not have enough money!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
        end
    end)
end)

RegisterServerEvent('repair:getMech')
AddEventHandler('repair:getMech', function(id)
    local source = tonumber(source)
    getMechanicInService( function(mechanic) 
        TriggerClientEvent('repair:receiveMech',source,mechanic,tonumber(id))
    end)
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                     Interaction Functions                                                    --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function getMechanicInService(cb)
    TriggerEvent('f:getPlayers', function(players)
        local mechanic = 0
        for i,p in pairs(players) do
            if p.getSessionVar('MechanicInService') == true then
                mechanic = mechanic + 1
            end
        end
        cb(mechanic)
    end)
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Useful Functions                                                       --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          Lock System                                                         --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
local vehStorage = {}
local randomMsg = { "You have found the keys on the sun-shield",
                    "You found the keys in the glove box.",
                    "You found the keys on the passenger seat.",
                    "You found the keys on the floor.",
                    "The keys were already on the contact, you took them."}

RegisterServerEvent("ls:check")
AddEventHandler("ls:check",function(plate, vehicleId, isPlayerInside, notifParam)
    local source = tonumber(source)
    playerIdentifier = GetPlayerIdentifiers(source)[1]

    result = 0
    for i=1, #(vehStorage) do
        if vehStorage[i].plate == plate then
            result = result + 1
            if vehStorage[i].owner == playerIdentifier then
                TriggerClientEvent("ls:lock", source, vehStorage[i].lockStatus, vehStorage[i].id)
                break
            else
                TriggerClientEvent("ls:sendNotification", source, notifParam, "You don't have the key of this vehicle.", 0.5)
                break
            end
        end
    end

    if result == 0 and isPlayerInside then

        length = #(randomMsg)
        randomNbr = math.random(1, tonumber(length))
        TriggerClientEvent("ls:sendNotification", source, notifParam, randomMsg[randomNbr], 0.5)
        
        table.insert(vehStorage, {plate=plate, owner=playerIdentifier, lockStatus=0, id=vehicleId})
        TriggerClientEvent("ls:createMissionEntity", source, vehicleId)
        for i=1, #(vehStorage) do
            if vehStorage[i].plate == plate then
                if vehStorage[i].owner == playerIdentifier then
                    TriggerClientEvent("ls:lock", source, vehStorage[i].lockStatus, vehStorage[i].id)
                    break
                else
                    break
                end
            end
        end
    end
end)

RegisterServerEvent("ls:updateLockStatus")
AddEventHandler("ls:updateLockStatus", function(param, plate)
    for i=1, #(vehStorage) do
        if vehStorage[i].plate == plate then
            vehStorage[i].lockStatus = param
            if debugLog then print("(ls:updateLockStatus) : vehStorage["..i.."].lockStatus = "..param) end
            break
        end
    end
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                             END                                                              --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--