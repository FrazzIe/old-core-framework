warrants = {}
mdt = {}

if file_exists("warrants.txt", main) then
    warrants = loadData("warrants.txt", main)
end

if file_exists("mdt.txt", main) then
    mdt = loadData("mdt.txt", main)
end

RegisterServerEvent("warrants:load")
AddEventHandler("warrants:load", function(openUI)
    if file_exists("warrants.txt", main) then
        warrants = loadData("warrants.txt", main)
    end
    TriggerClientEvent("warrants:load", source, warrants, openUI)
end)

RegisterServerEvent("warrants:create")
AddEventHandler("warrants:create", function(name, loc, notes)
    if file_exists("warrants.txt", main) then
        warrants = loadData("warrants.txt", main)
    end
	local id = #warrants+1
	warrants[id] = {id = id, name = name, loc = loc, notes = notes}
	saveData(warrants, "warrants.txt", main)
	TriggerClientEvent("warrants:newWarrant", -1, warrants, id, name, loc, notes)
end)

RegisterServerEvent("warrants:remove")
AddEventHandler("warrants:remove", function(id, name)
    if file_exists("warrants.txt", main) then
        warrants = loadData("warrants.txt", main)
    end
  	for k,v in pairs(warrants) do
      if v.name == name then
        table.remove(warrants, k)
        break
      end
    end
    for k,v in pairs(warrants) do
        v.id = k
    end
	saveData(warrants, "warrants.txt", main)
	TriggerClientEvent("warrants:delete", -1, id)
end)

RegisterServerEvent("mdt:load")
AddEventHandler("mdt:load", function(openUI)
    if file_exists("mdt.txt", main) then
        mdt = loadData("mdt.txt", main)
    end
    TriggerClientEvent("mdt:load", source, mdt, openUI)
end)

RegisterServerEvent("mdt:create")
AddEventHandler("mdt:create", function(officer, offender, jailfine, jailtime, charges, fineamount)
    if file_exists("mdt.txt", main) then
        mdt = loadData("mdt.txt", main)
    end
    local id = #mdt+1
    local showdate = os.date("*t", os.time())
    local time = ""..showdate.month.."/"..showdate.day.."/"..showdate.year.." at "..showdate.hour..":"..showdate.min..":"..showdate.sec..""
    mdt[id] = {id = id, time = time, officer = officer, name = offender, jailfine = jailfine, jailtime = jailtime, charges = charges, fineticketamount = fineamount}
    saveData(mdt, "mdt.txt", main)
    TriggerClientEvent("mdt:newMDT", -1, mdt, id, time, officer, offender, jailfine, jailtime, charges, fineamount)
end)

RegisterServerEvent("mdt:remove")
AddEventHandler("mdt:remove", function(id, name, time)
    if file_exists("mdt.txt", main) then
        mdt = loadData("mdt.txt", main)
    end
    for k,v in pairs(mdt) do
      if v.name == name and v.time == time then
        table.remove(mdt, k)
        break
      end
    end
    for k,v in pairs(mdt) do
        v.id = k
    end
    saveData(mdt, "mdt.txt", main)
    TriggerClientEvent("mdt:delete", -1, id)
end)

function loadMDT()
    SetTimeout(600000, function()
        if file_exists("mdt.txt", main) then
            mdt = loadData("mdt.txt", main)
        end
        if file_exists("warrants.txt", main) then
            warrants = loadData("warrants.txt", main)
        end
        loadMDT()
    end)
end
loadMDT()