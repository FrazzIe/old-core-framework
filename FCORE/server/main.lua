path = {
    main = "G:/Desktop/Servers/data",
    users = "G:/Desktop/Servers/data/users",
    bans = "G:/Desktop/Servers/data/bans",
}

Players = {}
Users = {}

local firstSpawn = {}

local log_files = {
    errors = "",
    commands = "",
    bans = "",
    chat = "",
}

local models = {1413662315,-781039234,1077785853,2021631368,1423699487,1068876755,2120901815,-106498753,131961260,-1806291497,1641152947,115168927,330231874,-1444213182,1809430156,1822107721,2064532783,-573920724,-782401935,808859815,-1106743555,-1606864033,1004114196,532905404,1699403886,-1656894598,1674107025,-88831029,-1244692252,951767867,1388848350,1090617681,379310561,-569505431,-1332260293,-840346158}
local defaultUser = {
    ["Identifiers"] = {},
    ["Power"] = {
        group = "user", 
        permissions = 0,
    },
    ["Money"] = {
        cash={2500,2500,2500},
        bank={0,0,0},
        dirtymoney={0,0,0},
    },
    ["Inventory"] = {
        normal={{},{},{}},
        car={{},{},{}},
    },
    ["Models"] = {
        normal = {
            {
                id = 1,
                model = models[math.random(1,tonumber(#models))],
                new = true,
                clothing = {drawables = {0,0,0,0,0,0,0,0,0,0,0,0},textures = {2,0,1,1,0,0,0,0,0,0,0,0},palette = {0,0,0,0,0,0,0,0,0,0,0,0}},
                props = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1}},
                overlays = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}},
            },
            {
                id = 2,
                model = models[math.random(1,tonumber(#models))],
                new = true,
                clothing = {drawables = {0,0,0,0,0,0,0,0,0,0,0,0},textures = {2,0,1,1,0,0,0,0,0,0,0,0},palette = {0,0,0,0,0,0,0,0,0,0,0,0}},
                props = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1}},
                overlays = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}},
            },
            {
                id = 3,
                model = models[math.random(1,tonumber(#models))],
                new = true,
                clothing = {drawables = {0,0,0,0,0,0,0,0,0,0,0,0},textures = {2,0,1,1,0,0,0,0,0,0,0,0},palette = {0,0,0,0,0,0,0,0,0,0,0,0}},
                props = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1}},
                overlays = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}},
            },
        },
        ems = {},
        cop = {},
    },
    ["Characters"] = {},
    ["Weapons"] = {{},{},{}},
    ["Garages"] = {
        {garages = {{id=1,cost=0,count=3},{id=2,cost=0,count=3},{id=3,cost=0,count=3},{id=4,cost=0,count=3}},vehicles = {}},
        {garages = {{id=1,cost=0,count=3},{id=2,cost=0,count=3},{id=3,cost=0,count=3},{id=4,cost=0,count=3}},vehicles = {}},
        {garages = {{id=1,cost=0,count=3},{id=2,cost=0,count=3},{id=3,cost=0,count=3},{id=4,cost=0,count=3}},vehicles = {}},
    },
    ["Extras"] = {
        gunlicense = {0,0,0},
        jobs = {1,1,1},
        coords = {
            {x = -1858.91, y = -348.509, z = 49.8377},
            {x = -1858.91, y = -348.509, z = 49.8377},
            {x = -1858.91, y = -348.509, z = 49.8377},
        },
        jailtime = 0,
        phonenumber = 0,
        online = true,
    },
}

function loadUser(identifier, source, new)
    Users[source] = createUser(source, loadData(identifier..".txt",path.users))

    TriggerEvent('f:loaded', source, Users[source])

    for k,v in pairs(commandSuggestions) do         
        TriggerClientEvent('chat:addSuggestion', source, "/" .. k, v.help, v.params)          
    end

    if(new)then
        TriggerEvent('f:irstload', source, Users[source])
    end

    TriggerClientEvent("f:pvp", source)
end

function checkUser(identifier, source)
    if file_exists(identifier..".txt",path.users) then
        loadUser(identifier, source, false)
    else
        defaultUser["Identifiers"].steam = getID("steam", source)
        defaultUser["Identifiers"].license = getID("license", source)
        defaultUser["Identifiers"].ip = GetPlayerEP(source)
		if file_exists("identifiers.txt", path.main) then
		    Players = loadData("identifiers.txt", path.main)
		end
        saveData(Players, "identifiers.txt", path.main)
        saveData(defaultUser, identifier..".txt", path.users)
        loadUser(identifier,source, true)
    end
end

RegisterServerEvent("f:irstjoin")
AddEventHandler("f:irstjoin", function()
    local source = tonumber(source)
    local id = getID("steam", source)
    local license = getID("license", source)
    local name = GetPlayerName(source)
    if id and license then
        local sc = string.sub(id, 1, 5)
        if sc == "steam" then
            local new = false
            getAccountAge(id, function(cb)
                if cb ~= false then
                    local week = tonumber(os.time()) - 604800
                    if cb > week then
                        print("[ANTI-CHEAT]::"..id.."("..name..") tried to connect but (account age < week)!")
                        TriggerClientEvent("f:kick", source, id.."("..name.."), you are not allowed to play on this server! (Account is less than one week old)")
                        new = true
                    end
                end
            end)
            if not new then
                local acban = false
                for k,v in pairs(bantable["Anticheat"]) do
                    if v.identifier == id or v.license == license then
                        TriggerClientEvent("f:kick", source, id.."("..name.."), you are banned! Reason: "..v.reason.." - http://gta5police.com/forums/")
                        print("[ANTI-CHEAT]::"..id.."("..name..") tried to connect but was previously banned!")
                        acban = true
                        break
                    end
                end
                if not acban then
                    local nban = false
                    for k,v in pairs(bantable["Normal"]) do
                        if v.identifier == id or v.license == license then
                            local currentTime = tonumber(os.time())
                            local showdate = os.date("*t", v.duration)
                            if currentTime > v.duration then
                                if file_exists("bans.txt",path.bans) then
                                    bantable = loadData("bans.txt",path.bans)
                                end
                                table.remove(bantable["Normal"], k)
                                saveData(bantable, "bans.txt", path.bans)
                                print("[BANS]::Unbanning "..name..", identifier:"..id.."("..name..")")
                                break
                            else
                                print("[BANS]::"..id.."("..name..") tried to connect but was previously banned!")
                                TriggerClientEvent("f:kick", source, id.."("..name.."), you are banned! Expires: "..showdate.month.."/"..showdate.day.."/"..showdate.year.." at "..showdate.hour..":"..showdate.min..":"..showdate.sec.." Reason: "..v.reason.." - http://gta5police.com/forums/")
                                nban = true
                                break
                            end
                        end
                    end
                    if not nban then
                        if whitelist_active then
                            if whitelist[identifier] then
                                if whitelist[identifier].steamname ~= GetPlayerName(source) then
                                    whitelist[identifier].steamname = GetPlayerName(source)
                                    saveData(whitelist, "whitelist.txt", path.main)
                                end             
                                checkUser(string.gsub(id, "steam:", ""), source)
                            else
                                TriggerClientEvent("f:kick", source, name.." you must be whitelisted to play on this server, join one of our public servers... www.gta5police.com")
                            end
                        else
                            checkUser(string.gsub(id, "steam:", ""), source)
                        end
                    end
                end
            end
        else
            TriggerClientEvent("f:kick", source, "You are not signed into steam!")
        end
    else
        TriggerClientEvent("f:kick", source, name.." we couldn't get an identifier? are you signed into steam?")
    end
end)

RegisterServerEvent('f:spawn')
AddEventHandler('f:spawn', function()
    local source = tonumber(source)
    if(firstSpawn[source] == nil)then
        Citizen.CreateThread(function()
            while Users[source] == nil do Citizen.Wait(0) end
            TriggerEvent("f:irstspawn", source, Users[source])

            firstSpawn[source] = true
            return
        end)
    end
end)

RegisterServerEvent("f:kick")
AddEventHandler("f:kick", function(reason)
    DropPlayer(source, reason)
end)

AddEventHandler('f:getPlayers', function(cb)
    cb(Users)
end)

AddEventHandler('f:getAllPlayers', function(cb)
    local All = {}
    for k,v in pairs(Players) do
        local u = loadData(v..".txt",path.users)
        table.insert(All, u)
    end
    cb(All)
end)

AddEventHandler("f:getPlayerFile", function(identifier, cb)
    if file_exists(identifier..".txt",path.users) then
        cb(loadData(identifier..".txt",path.users))
    else
        cb(nil)
    end
end)

AddEventHandler("f:getPlayer", function(user, cb)
    if(Users)then
        if(Users[user])then
            cb(Users[user])
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)

AddEventHandler("f:getdir", function(cb)
    cb(path.main)
end)

AddEventHandler("f:setdata", function(user, k, v, cb)
    if(Users[user])then
        if(Users[user].get(k))then

            if(k ~= "money") then
                Users[user].set(k, v)
                saveData(saveUser, string.gsub(Users[user].getIdentifier(), "steam:", "")..".txt",path.users)
            end
            cb("Player data edited.", true)
        else
            cb("Column does not exist!", false)
        end
    else
        cb("User could not be found!", false)
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = tonumber(source)
    if(Users[src]) or Users[src] ~= nil then
        if Users[src].CharcterID ~= 0 or Users[src].CharcterID ~= nil then
            Users[src].setLastCoords()
        end
        local user = Users[src]
        local saveUser = {
            ["Identifiers"] = user.getIdentifiers(),
            ["Power"] = {
                group = user.getGroup(), 
                permissions = user.getPermissions(),
            },
            ["Money"] = {
                cash=user.getAllMoney(),
                bank=user.getAllBank(),
                dirtymoney=user.getAllDirty(),
            },
            ["Inventory"] = {
                normal=user.getInventories(),
            },
            ["Models"] = {
                normal = user.getModels(),
                ems = {},
                cop = {},
            },
            ["Characters"] = user.getCharacters(),
            ["Weapons"] = user.getAllWeapons(),
            ["Garages"] = user.getAllCars(),
            ["Extras"] = {
                gunlicense = user.getGunlicenses(),
                jobs = user.getJobs(),
                coords = user.getLastCoords(),
                jailtime = user.getJail(),
                phonenumber = user.getPhoneNumber(),
                online = false,
            },
        }
        saveData(saveUser, string.gsub(user.getIdentifier(), "steam:", "")..".txt",path.users)
        print("\n[FCORE]::"..GetPlayerName(src).."'s data has been saved || Disconnected: ("..reason..")\n")
        Users[src] = nil
    end
end)

AddEventHandler('rconCommand', function(commandName, args)
    if commandName:lower() == 'alterdata' then
        if #args > 1 then
            RconPrint("alterdata [data]\n")
            CancelEvent()
            return
        end
        local data = "return table = ".. table.concat(args, 1)..""
        alterdata(_G[data]())
        CancelEvent()
    elseif commandName:lower() == 'ban' then
        if #args < 5 then
            RconPrint("ban [userid] [time] [s:m:h] [banner] [reason]\n")
            CancelEvent()
            return
        end
        if GetPlayerName(tonumber(args[1])) == nil then
            RconPrint("User not found\n")
            CancelEvent()
            return
        end
        if tonumber(args[2]) == nil then
            RconPrint("Invalid time!\n")
            CancelEvent()
            return
        end
        if tostring(args[3]) == nil or string.len(args[3]) >= 2 then
            RconPrint("time must be (s),(m) or (h)")
            CancelEvent()
            return
        end
        if tostring(args[3]) ~= "s" and tostring(args[3]) ~= "m" and tostring(args[3]) ~= "h" then
            RconPrint("time must be (s),(m) or (h)")
            CancelEvent()
            return           
        elseif tostring(args[3]) == "m" or tostring(args[3]) == "h" then
            args[2] = args[2]..args[3]
        end
        if tostring(args[4]) == "" then
            args[4] = "Console"
        end
        BanUserConsole(tonumber(args[1]),tostring(args[2]),table.concat(args, " ", 5),args[4])
        CancelEvent()
    elseif commandName:lower() == 'kick' then
        if #args < 3 then
            RconPrint("kick [userid] [kicker] [reason]\n")
            CancelEvent()
            return
        end
        if GetPlayerName(tonumber(args[1])) == nil then
            RconPrint("User not found\n")
            CancelEvent()
            return
        end
        if tostring(args[2]) == "" then
            args[2] = "Console"
        end
        KickUserConsole(tonumber(args[1]),table.concat(args, " ", 3),args[2])
        CancelEvent()
    elseif commandName:lower() == 'whiteadd' then
        if #args < 2 then
            RconPrint("whiteadd [steam hex] [name]\n")
            CancelEvent()
            return
        end
        if string.sub(tostring(args[1]), 1, 5) ~= "steam" then
            args[1] = "steam:"..args[1]
        end
        addWhitelist(args[1]:lower(),table.concat(args, " ", 2))
        CancelEvent()
    elseif commandName:lower() == 'whiterem' then
        if #args ~= 1 then
            RconPrint("whiterem [steam hex]\n")
            CancelEvent()
            return
        end
        if string.sub(tostring(args[1]), 1, 5) ~= "steam" then
            args[1] = "steam:"..args[1]
        end
        remWhitelist(args[1]:lower())
        CancelEvent()
    end
end)

function savePlayerData()
    SetTimeout(60000, function()
        for k,v in pairs(Users)do
            if Users[k] ~= nil then
                if v.get('haveChanged') == true then
                    v.setLastCoords()
                    local saveUser = {
                        ["Identifiers"] = v.getIdentifiers(),
                        ["Power"] = {
                            group = v.getGroup(), 
                            permissions = v.getPermissions(),
                        },
                        ["Money"] = {
                            cash=v.getAllMoney(),
                            bank=v.getAllBank(),
                            dirtymoney=v.getAllDirty(),
                        },
                        ["Inventory"] = {
                            normal=v.getInventories(),
                        },
                        ["Models"] = {
                            normal = v.getModels(),
                            ems = {},
                            cop = {},
                        },
                        ["Characters"] = v.getCharacters(),
                        ["Weapons"] = v.getAllWeapons(),
                        ["Garages"] = v.getAllCars(),
                        ["Extras"] = {
                            gunlicense = v.getGunlicenses(),
                            jobs = v.getJobs(),
                            coords = v.getLastCoords(),
                            jailtime = v.getJail(),
                            phonenumber = v.getPhoneNumber(),
                            online = true,
                        },
                    }
                    saveData(saveUser, string.gsub(v.getIdentifier(), "steam:", "")..".txt",path.users)
                    v.set('haveChanged', 0)
                end
            end
        end
        savePlayerData()
    end)
end
savePlayerData()


function alterData(data)
    for k,v in pairs(Players) do
        local u = loadData(v..".txt",path.users)
        table.insert(u, data)
        saveData(u, v..".txt",path.users)
    end
end--]]
--[[
function alterData(data)
    for k,v in pairs(Players) do
        local u = loadData(v..".txt",path.users)
        u["Extras"].online = false
        saveData(u, v..".txt",path.users)
    end
end
--]]

function saveData(t, filename, filepath)
    local path = filepath .. "/" .. filename
    local file = io.open(path, "w")

    if file then
        local contents = json.encode(t)
        file:write(contents)
        io.close(file)
        return true
    else
        return false
    end
end

function loadData(filename, filepath)
    local path = filepath .. "/" .. filename
    local contents = ""
    local myTable = {}
    local file = io.open(path, "r")

    if file then
        -- read all contents of file into a string
        local contents = file:read("*a")
        myTable = json.decode(contents);
        io.close(file)
        return myTable
    end
    return nil
end

function file_exists(filename, filepath)
    local path = filepath .. "/" .. filename
    local f=io.open(path,"r")
    if f~=nil then
        io.close(f)
        return true 
    else 
        return false
    end
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function getID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        end
    end
    return nil
end

RegisterServerEvent("f:log")
AddEventHandler("f:log",function(t, info)
    log(t, info)
end)

function log(t, info)
    if t == "errors" then logs = log_files.errors elseif t == "commands" then logs = log_files.commands elseif t == "bans" then logs = log_files.bans elseif t == "chat" then logs = log_files.chat end
    local time = '[' .. os.date('%H') .. ':' .. os.date('%M')  .. ']'
    logs = logs .. time .. info .. "\n"
    SaveResourceFile(GetCurrentResourceName(), "logs/" .. t .. "/" .. string.gsub(os.date('%x'), '(/)', '-') .. '.txt', logs, -1)
end

function initlog()
    log_files.errors = LoadResourceFile(GetCurrentResourceName(), "logs/errors/" .. string.gsub(os.date('%x'), '(/)', '-') .. '.txt') or '//Error logs for ' .. string.gsub(os.date('%x'), '(/)', '-') .. '\n'
    log_files.commands = LoadResourceFile(GetCurrentResourceName(), "logs/commands/" .. string.gsub(os.date('%x'), '(/)', '-') .. '.txt') or '//Command logs for ' .. string.gsub(os.date('%x'), '(/)', '-') .. '\n'
    log_files.bans = LoadResourceFile(GetCurrentResourceName(), "logs/bans/" .. string.gsub(os.date('%x'), '(/)', '-') .. '.txt') or '//Ban logs for ' .. string.gsub(os.date('%x'), '(/)', '-') .. '\n'..string.gsub(os.date('%x'), '(/)', '-')..'Display Name | Identifier | License | Duration | Reason | Banned By \n'
    log_files.chat = LoadResourceFile(GetCurrentResourceName(), "logs/chat/" .. string.gsub(os.date('%x'), '(/)', '-') .. '.txt') or '//Chat logs for ' .. string.gsub(os.date('%x'), '(/)', '-') .. '\n'
end

initlog()

if file_exists("identifiers.txt", path.main) then
    Players = loadData("identifiers.txt", path.main)
end