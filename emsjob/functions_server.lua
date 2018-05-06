--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--Set session var
RegisterServerEvent('paramedic:setService')
AddEventHandler('paramedic:setService', function (inService)
	TriggerEvent('f:getPlayer',source,function(Player)
		Player.setSessionVar('paramedicInService', inService)
	end)
end)
--==============================================================================================================================--
--Dragging
RegisterServerEvent('paramedic:dragRequest')
AddEventHandler('paramedic:dragRequest', function(t)
	TriggerClientEvent('paramedic:toggleDrag', t, source)
end)
--==============================================================================================================================--
--Force enter
RegisterServerEvent('paramedic:forceEnterAsk')
AddEventHandler('paramedic:forceEnterAsk', function(t, v)
	TriggerClientEvent('paramedic:forcedEnteringVeh', t, v)
end)
--Force exit
RegisterServerEvent('paramedic:confirmUnseat')
AddEventHandler('paramedic:confirmUnseat', function(t)
	TriggerClientEvent('paramedic:unseatme', t)
end)
--==============================================================================================================================--
--Save and Load Uniforms

RegisterServerEvent("paramedic:loadclothing")
AddEventHandler("paramedic:loadclothing", function()
	local source = tonumber(source)
	local data = uniforms[GetPlayerIdentifiers(source)[1]]
	if data ~= nil then
		if data.m == "mp_m_freemode_01" or data.m == "mp_f_freemode_01" then
			TriggerClientEvent("paramedic:changempmodel", source, data)
		else
			TriggerClientEvent("paramedic:changemodel", source, data)
		end
	else
		TriggerClientEvent("paramedic:nomodel", source)
	end
end)

RegisterServerEvent("paramedic:saveclothing")
AddEventHandler("paramedic:saveclothing",function(m, d, t)
	local source = tonumber(source)
	local data = {}
	data.m = m
	data.d1 = d.head
	data.d2 = d.mask
	data.d3 = d.hair
	data.d4 = d.hand
	data.d5 = d.pants
	data.d6 = d.gloves
	data.d7 = d.shoes
	data.d8 = d.eyes
	data.d9 = d.accessories
	data.d10 = d.items
	data.d11 = d.decals
	data.d12 = d.shirts
	data.a13 = d.helmet
	data.a14 = d.glasses
	data.a15 = d.earrings
	data.f16 = d.beard
	data.f17 = d.eyebrow
	data.f18 = d.makeup
	data.f19 = d.lipstick
	data.t1 = t.head
	data.t2 = t.mask
	data.t3 = t.hair
	data.t4 = t.hand
	data.t5 = t.pants
	data.t6 = t.gloves
	data.t7 = t.shoes
	data.t8 = t.eyes
	data.t9 = t.accessories
	data.t10 = t.items
	data.t11 = t.decals
	data.t12 = t.shirts
	data.ta13 = t.helmet
	data.ta14 = t.glasses
	data.ta15 = t.earrings
	uniforms[GetPlayerIdentifiers(source)[1]] = data
	saveUniforms()
end)
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--