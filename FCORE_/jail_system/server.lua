RegisterServerEvent("js:jailuser")
AddEventHandler("js:jailuser",function(target, time, reason)
    print("Jailing ".. GetPlayerName(target).. " for ".. time .." secs - command entered by ".. GetPlayerName(source))
    TriggerEvent("js:setjailtime", tonumber(target), tonumber(time))
    TriggerClientEvent("pNotify:SendNotification", -1, {
        text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>".. GetPlayerName(target) .."</span> has been jailed. <br> Time: <span style='color:lime'>".. time .."</span> Seconds <br> Charges: <span style='color:lime'>".. reason .."</span>",
        type = "error",
        queue = "left",
        timeout = 10000,
        layout = "bottomRight"
    })
    TriggerClientEvent("pNotify:SendNotification", tonumber(target), {
        text = "Your weapons have been confiscated!",
        type = "error",
        queue = "left",
        timeout = 10000,
        layout = "bottomCenter"
    })
end)

TriggerEvent('es:addCommand', 'jail', function(source, args, user)

    local argument = args[2] -- player id
    local time = args[3]
    local reason = table.concat(args, " ", 4)
    local sourcePlayer = tonumber(source)
    local savedsource = tonumber(sourcePlayer)
    if argument == nil or type(tonumber(argument)) == "nil" or time == nil or type(tonumber(time)) == nil or reason == nil or type(tonumber(reason)) == nil then
    
        TriggerClientEvent("chatMessage", sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^1Example^7: /^3jail ^7[^3ID^7] [^3TIME^7] [^3REASON^7]")
        
    elseif user.getPermissions() >= 2 then
    
        if(GetPlayerName(tonumber(argument)) and tonumber(time) <= 4000)then
            TriggerEvent('f:getPlayer', tonumber(argument), function(target)
                if argument == savedsource then
                    TriggerClientEvent('chatMessage', sourcePlayer, "SYSTEM", { 247, 98, 31 }, "Use /jailme to jail yourself... idiot.")
                else
                    print("Jailing ".. GetPlayerName(tonumber(argument)).. " for ".. tonumber(time) .." secs - command entered by ".. GetPlayerName(sourcePlayer))
                    TriggerEvent("js:setjailtime", tonumber(argument), tonumber(time))
                    TriggerClientEvent("pNotify:SendNotification", -1, {
                        text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>".. GetPlayerName(tonumber(argument)) .."</span> has been jailed. <br> Time: <span style='color:lime'>".. tonumber(time) .."</span> Seconds <br> Charges: <span style='color:lime'>".. tostring(reason) .."</span>",
                        type = "error",
                        queue = "left",
                        timeout = 10000,
                        layout = "bottomRight"
                    })
                    TriggerClientEvent("pNotify:SendNotification", tonumber(argument), {
                        text = "Your weapons have been confiscated!",
                        type = "error",
                        queue = "left",
                        timeout = 10000,
                        layout = "bottomCenter"
                    })
                end
            end)
        else
            TriggerClientEvent('chatMessage', sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^3Incorrect Player ID or Time is greater than 4000 seconds!")
        end 

    else
            
         TriggerClientEvent("chatMessage", sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^3Civilians are not allowed to use /jail") 

    end
end)

TriggerEvent('es:addCommand', 'jailme', function(source, args, user)

    local time = args[2]
    local sourcePlayer = tonumber(source)
    local savedsource = tonumber(sourcePlayer)
    local reason = table.concat(args, " ", 3)
    if time == nil or type(tonumber(time)) == nil or reason == nil or type(tonumber(reason)) == nil then
    
        TriggerClientEvent("chatMessage", sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^1Example^7: /^3jailme ^7[^3TIME^7] [^3REASON^7]")
        
    elseif user.getPermissions() >= 2 then
 
        if(GetPlayerName(sourcePlayer) and tonumber(time) <= 4000)then
            TriggerEvent('f:getPlayer', source, function(target)
                print("Jailing ".. GetPlayerName(sourcePlayer) .. " for ".. tonumber(time) .." secs")
                TriggerEvent("js:setjailtime", sourcePlayer, tonumber(time))
                TriggerClientEvent("pNotify:SendNotification", -1, {
                    text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>".. GetPlayerName(sourcePlayer) .."</span> has been jailed. <br> Time: <span style='color:lime'>".. tonumber(time) .."</span> Seconds <br> Charges: <span style='color:lime'>".. tostring(reason) .."</span>",
                    type = "error",
                    queue = "left",
                    timeout = 10000,
                    layout = "bottomRight"
                })
                TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {
                        text = "Your weapons have been confiscated!",
                        type = "error",
                        queue = "left",
                        timeout = 10000,
                        layout = "bottomCenter"
                })
            end)
        else
            TriggerClientEvent('chatMessage', sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^3Time is greater than 4000 seconds!")
        end  

    else

        TriggerClientEvent("chatMessage", sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^3Civilians are not allowed to use /jailme")    
  
    end
end)

TriggerEvent('es:addCommand', 'unjail', function(source, args, user)

    local sourcePlayer = tonumber(source)
    local argument = args[2] -- player id
    if argument == nil or type(tonumber(argument)) == nil then
    
        TriggerClientEvent("chatMessage", sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^1Example^7: /^3unjail ^7[^3ID^7]")
        
    elseif user.getPermissions() >= 2 then
    
        if(GetPlayerName(tonumber(argument)))then
            TriggerEvent('f:getPlayer', tonumber(argument), function(target)
                print("Releasing ".. GetPlayerName(tonumber(argument)).. " - command entered by ".. GetPlayerName(sourcePlayer))
                TriggerEvent("js:removejailtime", tonumber(argument))
            end)
        else
            TriggerClientEvent('chatMessage', sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^3Incorrect Player ID")
        end      
        
    else

        TriggerClientEvent("chatMessage", sourcePlayer, "SYSTEM", { 247, 98, 31 }, "^3Civilians are not allowed to use /unjail")   
    
    end
end)

RegisterServerEvent("js:setjailtime")
AddEventHandler("js:setjailtime",function(argument , time)
    local argumentPlayer = tonumber(argument)
    TriggerEvent('f:getPlayer', argument, function(target)
        target.setJail(time)
        target.removeWeapons()
        TriggerClientEvent("js:jail", argumentPlayer , time)
    end)
end)

RegisterServerEvent("js:removejailtime")
AddEventHandler("js:removejailtime",function(argument)
    local argumentPlayer = tonumber(argument)
    TriggerEvent('f:getPlayer', argument, function(target)
        target.setJail(0)
        TriggerClientEvent("js:unjail", argumentPlayer)
    end)
end)

RegisterServerEvent("js:setjailtimeOnExit")
AddEventHandler("js:setjailtimeOnExit",function(jailtime)
    TriggerEvent('f:getPlayer', source, function(target)
        target.setJail(jailtime)
    end)
end)

RegisterServerEvent("js:updatetime")
AddEventHandler("js:updatetime",function(jailtime)
    TriggerEvent('f:getPlayer', source, function(target)
        target.setJail(jailtime)
    end)
end)

RegisterServerEvent("js:spawn")
AddEventHandler("js:spawn", function(source)
    local sourcePlayer = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
        local time = user.getJail()
        if tonumber(time) > 0 then
            local time2 = time
            user.setJail(time2)
            TriggerClientEvent("pNotify:SendNotification", -1, {
                text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>".. GetPlayerName(sourcePlayer) .."</span> has been rejailed. <br> Time increased from <span style='color:lime'>".. tonumber(time) .."</span> to <span style='color:lime'>".. tonumber(time2) .." seconds!",
                type = "error",
                queue = "left",
                timeout = 10000,
                layout = "bottomRight"
            })
            TriggerClientEvent("js:jail", sourcePlayer , time2)
        end
    end)
end)