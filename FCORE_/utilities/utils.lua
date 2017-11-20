local extrablips = {
    {name="Prison", sprite=285, x=1679.049, y=2513.711, z=45.565},
}

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

function addBlip(item)
	item.blip = AddBlipForCoord(item.x, item.y, item.z)
	SetBlipSprite(item.blip, item.sprite)
	SetBlipColour(item.blip, item.colour)
	SetBlipAsShortRange(item.blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(item.name)
	EndTextCommandSetBlipName(item.blip)
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--Written by IllidanS4
--[[The MIT License (MIT)
Copyright (c) 2017 IllidanS4
Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
]]

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

Citizen.CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
    for _, item in pairs(extrablips) do
    	addBlip(item)
    end
	while true do
		Citizen.Wait(0)
		if not IsEntityDead(GetPlayerPed(-1)) then
	        if player_menu then
	            carshop_menu = false
	            garage_menu = false
	            gun_menu = false
	            item_menu = false
	            license_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            carrental_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif carshop_menu then
	        	player_menu = false
	            garage_menu = false
	            gun_menu = false
	            item_menu = false
	            license_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            carrental_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif garage_menu then
	        	player_menu = false
	            carshop_menu = false
	            gun_menu = false
	            item_menu = false
	            license_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            carrental_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif gun_menu then
	        	player_menu = false
	            carshop_menu = false
	            garage_menu = false
	            item_menu = false
	            license_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            carrental_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif item_menu then
	        	player_menu = false
	            carshop_menu = false
	            garage_menu = false
	            gun_menu = false
	            license_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            carrental_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif license_menu then
	        	player_menu = false
	            carshop_menu = false
	            garage_menu = false
	            gun_menu = false
	            item_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            carrental_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif customs_menu then
	        	player_menu = false
	            carshop_menu = false
	            garage_menu = false
	            gun_menu = false
	            item_menu = false
	            license_menu = false
	            sellgun_menu = false
	            carrental_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
		    elseif sellgun_menu then
	        	player_menu = false
	            carshop_menu = false
	            garage_menu = false
	            gun_menu = false
	            item_menu = false
	            license_menu = false
	            customs_menu = false
	            carrental_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif carrental_menu then
	        	player_menu = false
	            carshop_menu = false
	            garage_menu = false
	            gun_menu = false
	            item_menu = false
	            license_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            clothing_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif clothing_menu then
	        	player_menu = false
	            carshop_menu = false
	            garage_menu = false
	            gun_menu = false
	            item_menu = false
	            license_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            carrental_menu = false
	            tow_menu = false
	            Menu.DisplayCurMenu()
	        elseif tow_menu then
	        	player_menu = false
	            carshop_menu = false
	            garage_menu = false
	            gun_menu = false
	            item_menu = false
	            license_menu = false
	            customs_menu = false
	            sellgun_menu = false
	            clothing_menu = false
	            carrental_menu = false
	            Menu.DisplayCurMenu()
	        end
	    else
	        player_menu = false
	        carshop_menu = false
	        garage_menu = false
	        gun_menu = false
	        item_menu = false
	        license_menu = false
	        customs_menu = false
	        sellgun_menu = false
	        carrental_menu = false
	        clothing_menu = false
	        tow_menu = false    	
	    end
	end
end)

