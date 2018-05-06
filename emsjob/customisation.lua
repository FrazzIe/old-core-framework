--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Paramedic Clothing                                                     --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--                                               Originally created by @MarkViolla                                              --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
emsskins = {}

if settings.force == "LifeMed" then
	--LifeMed
	emsskins = {
		's_m_m_paramedic_01',
	}
elseif settings.force == "Los Angeles EMS" then
	--Los Angeles EMS
	emsskins = {
		's_m_m_paramedic_01',
	}
elseif settings.force == "FDNY" then
	--FDNY
	emsskins = {
		's_m_m_paramedic_01',
	}
end

--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
cmenu = {show = 0, row = 0, field = 1}
text_in = 0
draw = {0,0,0}
prop = {0,0,1}
model_id = 1
bar = {x=0.628, y=0.436, x1=0.037,y1=0.014}
local currentmodel = 's_m_m_paramedic_01'
local paramedic_clothing_emplacement = {
    {name="Paramedic Clothing", id=73, x=269.6764831543, y=-1362.9470214844, z=24.537792205811},
}

incircle = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isParamedic) then
        	if(isInService) then
		        local pos = GetEntityCoords(GetPlayerPed(-1), true)
		        for k,v in ipairs(paramedic_clothing_emplacement) do
		            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
		            	DrawMarker(1, v.x, v.y, v.z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 155, 0, 155, 0, 0, 2, 0, 0, 0, 0)
		                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 2.0)then
		                    if (incircle == false) then
		                        DisplayHelpText("Press ~INPUT_CONTEXT~ to customise your paramedic.")
		                    end
		                    incircle = true
		                    if IsControlJustReleased(1, 51) then
		                    	if cmenu.show == 0 then
									PlaySound(-1, "FocusIn", "HintCamSounds", 0, 0, 1)
									startClothes()
								end
							end
		                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 2.0)then
		                    incircle = false
		                    if cmenu.show ~= 0 then
								local drawables = {
									head = GetPedDrawableVariation(GetPlayerPed(-1), 0),
									mask = GetPedDrawableVariation(GetPlayerPed(-1), 1),
									hair = GetPedDrawableVariation(GetPlayerPed(-1), 2),
									hand = GetPedDrawableVariation(GetPlayerPed(-1), 3),
									pants = GetPedDrawableVariation(GetPlayerPed(-1), 4),
									gloves = GetPedDrawableVariation(GetPlayerPed(-1), 5),
									shoes = GetPedDrawableVariation(GetPlayerPed(-1), 6),
									eyes = GetPedDrawableVariation(GetPlayerPed(-1), 7),
									accessories = GetPedDrawableVariation(GetPlayerPed(-1), 8),
									items = GetPedDrawableVariation(GetPlayerPed(-1), 9),
									decals = GetPedDrawableVariation(GetPlayerPed(-1), 10),
									shirts = GetPedDrawableVariation(GetPlayerPed(-1), 11),
									helmet = GetPedPropIndex(GetPlayerPed(-1), 0),
									glasses = GetPedPropIndex(GetPlayerPed(-1), 1),
									earrings = GetPedPropIndex(GetPlayerPed(-1), 2),
									beard = GetPedHeadOverlayValue(GetPlayerPed(-1), 1),
									eyebrow = GetPedHeadOverlayValue(GetPlayerPed(-1), 2),
									makeup = GetPedHeadOverlayValue(GetPlayerPed(-1), 4),
									lipstick = GetPedHeadOverlayValue(GetPlayerPed(-1), 8)
								}
								local textures = {
									head = GetPedTextureVariation(GetPlayerPed(-1), 0),
									mask = GetPedTextureVariation(GetPlayerPed(-1), 1),
									hair = GetPedTextureVariation(GetPlayerPed(-1), 2),
									hand = GetPedTextureVariation(GetPlayerPed(-1), 3),
									pants = GetPedTextureVariation(GetPlayerPed(-1), 4),
									gloves = GetPedTextureVariation(GetPlayerPed(-1), 5),
									shoes = GetPedTextureVariation(GetPlayerPed(-1), 6),
									eyes = GetPedTextureVariation(GetPlayerPed(-1), 7),
									accessories = GetPedTextureVariation(GetPlayerPed(-1), 8),
									items = GetPedTextureVariation(GetPlayerPed(-1), 9),
									decals = GetPedTextureVariation(GetPlayerPed(-1), 10),
									shirts = GetPedTextureVariation(GetPlayerPed(-1), 11),
									helmet = GetPedPropTextureIndex(GetPlayerPed(-1), 0),
									glasses = GetPedPropTextureIndex(GetPlayerPed(-1), 1),
									earrings = GetPedPropTextureIndex(GetPlayerPed(-1), 2)
								}
								TriggerServerEvent("paramedic:saveclothing", currentmodel, drawables, textures)	
							end
		                    cmenu.show = 0
							cmenu.row = 0
							cmenu.field = 0
		                end
		            end
		        end
		    end
		end
    end
end)

function drawClothingTxt(x,y ,width,height,scale, text, r,g,b,a,font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function startClothes()
	isMenuOpen = true
	cmenu.show = 1
	cmenu.row = 1
	cmenu.field = 1
	text_in = 0
end

function ClothShop()
	HideHudAndRadarThisFrame()
	RequestStreamedTextureDict("shopui_title_lowendfashion2", true)
	DrawSprite("shopui_title_lowendfashion2", "shopui_title_lowendfashion2", 0.12,0.325, 0.22, 0.09, 0.0, 255, 255, 255, 255)
	if cmenu.show == 1 then
		if cmenu.row == 1 then DrawRect(0.12,0.388,0.22,0.035,127, 140, 140, 240) else DrawRect(0.12,0.388,0.22,0.035,40, 40, 40, 190) end
		if cmenu.row == 2 then DrawRect(0.12,0.423,0.22,0.035,127, 140, 140, 240) else DrawRect(0.12,0.423,0.22,0.035,40, 40, 40, 190) end
		if cmenu.row == 3 then DrawRect(0.12,0.458,0.22,0.035,127, 140, 140, 240) else DrawRect(0.12,0.458,0.22,0.035,40, 40, 40, 190) end
		if cmenu.row == 4 then DrawRect(0.12,0.493,0.22,0.035,127, 140, 140, 240) else DrawRect(0.12,0.493,0.22,0.035,40, 40, 40, 190) end
		drawClothingTxt(0.177, 0.381, 0.25, 0.03, 0.50,"Choose slot",255,255,255,255,6)
		drawClothingTxt(0.177, 0.415, 0.25, 0.03, 0.50,"Accessories",255,255,255,255,6) -- row_2 (+0.037)
		drawClothingTxt(0.177, 0.451, 0.25, 0.03, 0.50,"Player Model",255,255,255,255,6) -- row_2 (+0.037)
		drawClothingTxt(0.177, 0.489, 0.25, 0.03, 0.50,"Exit",255,255,255,255,6) -- row_2 (+0.037)
	elseif cmenu.show == 2 then
		-- debug_you_can_delete_it
		local drawstr = string.format("Slot: %d~n~Draw: %d~n~Tex: %d~n~Pal: %d",cmenu.field-1, draw[1],draw[2],draw[3])
		drawClothingTxt(0.28, 0.8, 0, 0, 0.50,drawstr,255,255,255,255,6)
		-- debug_end
		DrawRect(0.12,0.388,0.22,0.035,127, 140, 140, 240)
		DrawRect(0.12,0.423,0.22,0.035,40, 40, 40, 190)
		DrawRect(0.12,0.458,0.22,0.035,40, 40, 40, 190)
		DrawRect(0.12,0.493,0.22,0.035,40, 40, 40, 190)
		drawClothingTxt(0.177, 0.381, 0.25, 0.03, 0.50,"~b~Choose slot",255,255,255,255,6)
		drawClothingTxt(0.177, 0.415, 0.25, 0.03, 0.50,"Accessories",255,255,255,255,6) -- row_2 (+0.037)
		drawClothingTxt(0.177, 0.451, 0.25, 0.03, 0.50,"Player Model",255,255,255,255,6) -- row_2 (+0.037)
		drawClothingTxt(0.177, 0.489, 0.25, 0.03, 0.50,"Exit",255,255,255,255,6) -- row_2 (+0.037)
		---
		DrawRect(0.628,0.345,0.18,0.049,52, 73, 94, 255) -- title
		drawClothingTxt(0.674,0.342,0.175,0.035, 0.50,"Choose slot",255,255,255,255,7)
		--DrawRect(0.628,0.024,0.175,0.005,58,95,205,150) --blue bar
		if cmenu.row == 1 then DrawRect(0.628,0.390,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.390,0.18,0.035,40, 40, 40, 190) end --(+0.037)
		if cmenu.row == 2 then DrawRect(0.628,0.427,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.427,0.18,0.035,40, 40, 40, 190) end --(+0.037)
		if cmenu.row == 3 then DrawRect(0.628,0.464,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.464,0.18,0.035,40, 40, 40, 190) end --(+0.037)
		if cmenu.row == 4 then DrawRect(0.628,0.501,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.501,0.18,0.035,40, 40, 40, 190) end --(+0.037)
		--
		local draw_str = string.format("Slot: %d / 11", cmenu.field-1)
		drawClothingTxt(0.628,0.387,0.175,0.035, 0.50,draw_str,255,255,255,255,6)
		--
		if GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1) ~= 0 and GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1) ~= false then
			DrawRect(0.628,0.436,0.175,0.014,23,108, 183, 190) -- Backgorund of bar 1 -- (0.427 + 0.09 difference) -- BAR USES THIS Y VALUE
			local link = 0.138/(GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1)
			local new_x = (bar.x-0.069)+(link*draw[1])
			if new_x < 0.559 then new_x = 0.559 end  ---- USES THE X VALUE OF THE RECTANGLES (-0.069)
			if new_x > 0.697 then new_x = 0.697 end  ---- USES THE X VALUE OF THE RECTANGLES (+0.069)
			DrawRect(new_x,bar.y,bar.x1,bar.y1,0, 126, 255,255)    -- 1st small bar
			-- row_3
			DrawRect(0.628,0.473,0.175,0.014,23,108, 183, 190) -- Backgorund of bar 2  -- (0.464 + 0.09 difference)
			local link = 0.138/(GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmenu.field-1, draw[1])-1)
			local new_x = (bar.x-0.069)+(link*draw[2])
			if new_x < 0.559 then new_x = 0.559 end
			if new_x > 0.697 then new_x = 0.697 end
			DrawRect(new_x,bar.y+0.037,bar.x1,bar.y1,0, 126, 255,255)  -- 2nd small bar
			--
			DrawRect(0.628,0.510,0.175,0.014,23,108, 183, 190)  -- Backgorund of bar 3 -- (0.501 + 0.09 difference)
			local link = 0.138/2
			local new_x = (bar.x-0.069)+(link*draw[3])
			if new_x < 0.559 then new_x = 0.559 end
			if new_x > 0.697 then new_x = 0.697 end
			DrawRect(new_x,bar.y+0.074,bar.x1,bar.y1,0, 126, 255,255) -- 3rd small bar
			--
			if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					if cmenu.field > 1 then 
						cmenu.field = cmenu.field-1
						draw[1] = 0
						draw[2] = 0
					else 
						cmenu.field = 12
						draw[1] = 0
						draw[2] = 0
					end
				elseif cmenu.row == 2 then
					if draw[1] > 0 then draw[1] = draw[1]-1 else draw[1] = 0 end
					draw[2] = 0
					SetPedComponentVariation(GetPlayerPed(-1), cmenu.field-1, draw[1], draw[2], draw[3])
				elseif cmenu.row == 3 then
					if draw[2] > 0 then draw[2] = draw[2]-1 else draw[2] = 0 end
						SetPedComponentVariation(GetPlayerPed(-1), cmenu.field-1, draw[1], draw[2], draw[3])
				elseif cmenu.row == 4 then
					if draw[3] > 0 then draw[3] = draw[3]-1 end
				end
			end
			if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					if cmenu.field < 12 then 
						cmenu.field = cmenu.field+1 
						draw[1] = 0
						draw[2] = 0
					else 
						cmenu.field = 1
						draw[1] = 0
						draw[2] = 0
					end
				elseif cmenu.row == 2 then
					if draw[1] < GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1 then draw[1] = draw[1]+1 else draw[1] = GetNumberOfPedDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1 end
					draw[2] = 0
					SetPedComponentVariation(GetPlayerPed(-1), cmenu.field-1, draw[1], draw[2], draw[3])
				elseif cmenu.row == 3 then
					if draw[2] < GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmenu.field-1, draw[1])-1 then draw[2] = draw[2]+1 else draw[2] = GetNumberOfPedTextureVariations(GetPlayerPed(-1), cmenu.field-1, draw[1])-1 end
					SetPedComponentVariation(GetPlayerPed(-1), cmenu.field-1, draw[1], draw[2], draw[3])
				elseif cmenu.row == 4 then
					if draw[3] < 2 then draw[3] = draw[3]+1 end
				end
			end
		else
			drawClothingTxt(0.628,0.427,0.175,0.035, 0.50,"EMPTY SLOT",255,255,255,255,6)
			drawClothingTxt(0.628,0.464,0.175,0.035, 0.50,"EMPTY SLOT",255,255,255,255,6)
			drawClothingTxt(0.628,0.501,0.175,0.035, 0.50,"EMPTY SLOT",255,255,255,255,6)
			if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.field > 1 then 
					cmenu.field = cmenu.field-1
					draw[1] = 0
					draw[2] = 0
				else 
					cmenu.field = 12
					draw[1] = 0
					draw[2] = 0
				end
			end
			if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.field < 12 then 
					cmenu.field = cmenu.field+1
					draw[1] = 0
					draw[2] = 0
				else 
					cmenu.field = 1
					draw[1] = 0
					draw[2] = 0
				end
			end
		end
	elseif cmenu.show == 3 then
		-- debug_you_can_delete_it
		local drawstr = string.format("Slot: %d~n~Prop: %d~n~Var: %d",cmenu.field-1, prop[1],prop[2])
		drawClothingTxt(0.28, 0.8, 0, 0, 0.50,drawstr,255,255,255,255,6)
		-- debug_end
		DrawRect(0.12,0.388,0.22,0.035,40, 40, 40, 190)
		DrawRect(0.12,0.423,0.22,0.035,127, 140, 140, 240)
		DrawRect(0.12,0.458,0.22,0.035,40, 40, 40, 190)
		DrawRect(0.12,0.493,0.22,0.035,40, 40, 40, 190)
		drawClothingTxt(0.177, 0.381, 0.25, 0.03, 0.50,"Choose slot",255,255,255,255,6)
		drawClothingTxt(0.177, 0.415, 0.25, 0.03, 0.50,"~b~Accessories",255,255,255,255,6) -- row_2 (+0.037)
		drawClothingTxt(0.177, 0.451, 0.25, 0.03, 0.50,"Player Model",255,255,255,255,6) -- row_2 (+0.037)
		drawClothingTxt(0.177, 0.489, 0.25, 0.03, 0.50,"Exit",255,255,255,255,6) -- row_2 (+0.037)
		---
		DrawRect(0.628,0.345,0.18,0.049,52, 73, 94, 255) -- title
		drawClothingTxt(0.674,0.342,0.175,0.035, 0.50,"Accessories",255,255,255,255,7)
		if cmenu.row == 1 then DrawRect(0.628,0.390,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.390,0.18,0.035,40, 40, 40, 190) end
		if cmenu.row == 2 then DrawRect(0.628,0.427,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.427,0.18,0.035,40, 40, 40, 190) end
		if cmenu.row == 3 then DrawRect(0.628,0.464,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.464,0.18,0.035,40, 40, 40, 190) end
		local draw_str = string.format("Slot: %d / 7", cmenu.field-1)
		drawClothingTxt(0.628,0.387,0.175,0.035, 0.50,draw_str,255,255,255,255,6)
		--
		if GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1) ~= 0 and GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1) ~= false then
			DrawRect(0.628,0.436,0.175,0.014,23,108, 183, 190)
			local link = 0.138/(GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1)
			local new_x = (bar.x-0.069)+(link*prop[1])
			if new_x < 0.559 then new_x = 0.559 end
			if new_x > 0.697 then new_x = 0.697 end
			DrawRect(new_x,bar.y,bar.x1,bar.y1,0, 126, 255,255)
			-- row_3
			DrawRect(0.628,0.473,0.175,0.014,23,108, 183, 190) -- bar_main
			local link = 0.138/(GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmenu.field-1, prop[1])-1)
			local new_x = (bar.x-0.069)+(link*prop[2])
			if new_x < 0.559 then new_x = 0.559 end
			if new_x > 0.697 then new_x = 0.697 end
			DrawRect(new_x,bar.y+0.037,bar.x1,bar.y1,0, 126, 255,255)
			--
			if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					if cmenu.field > 1 then 
						cmenu.field = cmenu.field-1 
						prop[1] = 0
						prop[2] = 0
					else 
						cmenu.field = 8
						prop[1] = 0
						prop[2] = 0
					end
				elseif cmenu.row == 2 then
					if prop[1] > 0 then prop[1] = prop[1]-1 else prop[1] = 0 end
					prop[2] = 0
					SetPedPropIndex(GetPlayerPed(-1), cmenu.field-1, prop[1], prop[2], prop[3])
				elseif cmenu.row == 3 then
					if prop[2] > 0 then prop[2] = prop[2]-1 else prop[2] = 0 end
					SetPedPropIndex(GetPlayerPed(-1), cmenu.field-1, prop[1], prop[2], prop[3])
				end
			end
			if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					if cmenu.field < 8 then 
						cmenu.field = cmenu.field+1 
						prop[1] = 0
						prop[2] = 0
					else 
						cmenu.field = 1
						prop[1] = 0
						prop[2] = 0
					end
				elseif cmenu.row == 2 then
					if prop[1] < GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1 then prop[1] = prop[1]+1 else prop[1] = GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), cmenu.field-1)-1 end
					prop[2] = 0
					SetPedPropIndex(GetPlayerPed(-1), cmenu.field-1, prop[1], prop[2], prop[3])
				elseif cmenu.row == 3 then
					if prop[2] < GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmenu.field-1, prop[1])-1 then prop[2] = prop[2]+1 else prop[2] = GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), cmenu.field-1, prop[1])-1 end
					SetPedPropIndex(GetPlayerPed(-1), cmenu.field-1, prop[1], prop[2], prop[3])
				end
			end
		else
			drawClothingTxt(0.628,0.427,0.175,0.035, 0.50,"EMPTY SLOT",255,255,255,255,6)
			drawClothingTxt(0.628,0.464,0.175,0.035, 0.50,"EMPTY SLOT",255,255,255,255,6)
			if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.field > 1 then 
					cmenu.field = cmenu.field-1
					prop[1] = 0
					prop[2] = 0
				else 
					cmenu.field = 8
					prop[1] = 0
					prop[2] = 0
				end
			end
			if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.field < 8 then 
					cmenu.field = cmenu.field+1
					prop[1] = 0
					prop[2] = 0
				else 
					cmenu.field = 1
					prop[1] = 0
					prop[2] = 0
				end
			end
		end
	elseif cmenu.show == 4 then
		local drawstr = string.format("ID: %d~n~Name: %s",model_id, emsskins[model_id])
		drawClothingTxt(0.28, 0.8, 0, 0, 0.50,drawstr,255,255,255,255,6)
		DrawRect(0.12,0.388,0.22,0.035,40, 40, 40, 190)
		DrawRect(0.12,0.423,0.22,0.035,40, 40, 40, 190)
		DrawRect(0.12,0.458,0.22,0.035,127, 140, 140, 240)
		DrawRect(0.12,0.493,0.22,0.035,40, 40, 40, 190)
		drawClothingTxt(0.177, 0.381, 0.25, 0.03, 0.50,"Choose slot",255,255,255,255,6)
		drawClothingTxt(0.177, 0.415, 0.25, 0.03, 0.50,"Accessories",255,255,255,255,6) -- row_2 (+0.037)
		drawClothingTxt(0.177, 0.451, 0.25, 0.03, 0.50,"~b~Player Model",255,255,255,255,6) -- row_2 (+0.037)
		drawClothingTxt(0.177, 0.489, 0.25, 0.03, 0.50,"Exit",255,255,255,255,6) -- row_2 (+0.037)
		DrawRect(0.628,0.345,0.18,0.049,52, 73, 94, 255)
		drawClothingTxt(0.669,0.342,0.175,0.035, 0.50,"Player Model",255,255,255,255,7)

		if cmenu.row == 1 then DrawRect(0.628,0.390,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.390,0.18,0.035,40, 40, 40, 190) end
		if cmenu.row == 2 then DrawRect(0.628,0.427,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.427,0.18,0.035,40, 40, 40, 190) end
		if cmenu.row == 3 then DrawRect(0.628,0.464,0.18,0.035,127, 140, 140, 240) else DrawRect(0.628,0.464,0.18,0.035,40, 40, 40, 190) end
		local draw_str = string.format("Slot: < %d / "..#emsskins.." >", model_id)
		drawClothingTxt(0.628,0.387,0.175,0.035, 0.50,draw_str,255,255,255,255,6)
		draw_str = string.format("%s", emsskins[model_id])
		drawClothingTxt(0.628,0.387+0.037,0.175,0.035, 0.50,draw_str,255,255,255,255,6)
		drawClothingTxt(0.628,0.387+0.037*2,0.175,0.035, 0.50,"Exact Skin",255,255,255,255,6)
		if IsControlJustPressed(1, 189) or IsDisabledControlJustPressed(1, 189) then -- left
			if cmenu.row == 1 then
				if model_id > 1 then
					model_id=model_id-1
				else
					model_id = #emsskins
				end
			end
		end
		if IsControlJustPressed(1, 190) or IsDisabledControlJustPressed(1, 190) then -- right
			if cmenu.row == 1 then
				if model_id < #emsskins then
					model_id=model_id+1
				else
					model_id = 1
				end
			end
		end
		if IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
			if cmenu.row == 1 or cmenu.row == 2 then
				ChangeToSkin(emsskins[model_id])
			elseif cmenu.row == 3 then
				if text_in == 0 then
					text_in = 1
					DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
				end
			end
		end
	end
end

function ShowRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

changemodel = false
function ChangeToSkin(skin)
	changemodel = true
	for i = 1, #banned_skins do
		if	skin == banned_skins[i] then
			ShowRadarMessage("You cannot use a banned model!")
			changemodel = false
		end
	end
	if changemodel then
		currentmodel = skin
		local model = GetHashKey(skin)
		if IsModelInCdimage(model) and IsModelValid(model) then
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			SetPlayerModel(PlayerId(), model)
			if skin ~= "mp_f_freemode_01" and skin ~= "mp_m_freemode_01" then 
				SetPedRandomComponentVariation(GetPlayerPed(-1), true)
			elseif skin == "mp_m_freemode_01" then
	            SetPedComponentVariation(GetPlayerPed(-1), 11, 13, 3, 2)
	            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
	            SetPedComponentVariation(GetPlayerPed(-1), 4, 9, 3, 2)
	            SetPedComponentVariation(GetPlayerPed(-1), 3, 92, 0, 2)
	            SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)
			elseif skin == "mp_f_freemode_01" then
	            SetPedComponentVariation(GetPlayerPed(-1), 11, 9, 2, 2)
	            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
	            SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 3, 2)
	            SetPedComponentVariation(GetPlayerPed(-1), 3, 98, 0, 2)
	            SetPedComponentVariation(GetPlayerPed(-1), 6, 27, 0, 2)
			end
			SetModelAsNoLongerNeeded(model)
			GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
		else
			ShowRadarMessage("Model is not found!")
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if cmenu.show == 1 then
			ClothShop()
			if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
				if cmenu.row > 1 then cmenu.row = cmenu.row-1 else cmenu.row = 4 end
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
				if cmenu.row < 4 then cmenu.row = cmenu.row+1 else cmenu.row = 1 end
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			elseif IsControlJustPressed(1, 201) or IsDisabledControlJustPressed(1, 201) then -- Enter
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if cmenu.row == 1 then
					cmenu.show = 2
					cmenu.row = 1
				elseif cmenu.row == 2 then
					cmenu.show = 3
					cmenu.row = 1
				elseif cmenu.row == 3 then
					cmenu.show = 4
					cmenu.row = 1
				elseif cmenu.row == 4 then
					cmenu.show = 0
					cmenu.row = 0
					cmenu.field = 0
					local drawables = {
						head = GetPedDrawableVariation(GetPlayerPed(-1), 0),
						mask = GetPedDrawableVariation(GetPlayerPed(-1), 1),
						hair = GetPedDrawableVariation(GetPlayerPed(-1), 2),
						hand = GetPedDrawableVariation(GetPlayerPed(-1), 3),
						pants = GetPedDrawableVariation(GetPlayerPed(-1), 4),
						gloves = GetPedDrawableVariation(GetPlayerPed(-1), 5),
						shoes = GetPedDrawableVariation(GetPlayerPed(-1), 6),
						eyes = GetPedDrawableVariation(GetPlayerPed(-1), 7),
						accessories = GetPedDrawableVariation(GetPlayerPed(-1), 8),
						items = GetPedDrawableVariation(GetPlayerPed(-1), 9),
						decals = GetPedDrawableVariation(GetPlayerPed(-1), 10),
						shirts = GetPedDrawableVariation(GetPlayerPed(-1), 11),
						helmet = GetPedPropIndex(GetPlayerPed(-1), 0),
						glasses = GetPedPropIndex(GetPlayerPed(-1), 1),
						earrings = GetPedPropIndex(GetPlayerPed(-1), 2),
						beard = GetPedHeadOverlayValue(GetPlayerPed(-1), 1),
						eyebrow = GetPedHeadOverlayValue(GetPlayerPed(-1), 2),
						makeup = GetPedHeadOverlayValue(GetPlayerPed(-1), 4),
						lipstick = GetPedHeadOverlayValue(GetPlayerPed(-1), 8)
					}
					local textures = {
						head = GetPedTextureVariation(GetPlayerPed(-1), 0),
						mask = GetPedTextureVariation(GetPlayerPed(-1), 1),
						hair = GetPedTextureVariation(GetPlayerPed(-1), 2),
						hand = GetPedTextureVariation(GetPlayerPed(-1), 3),
						pants = GetPedTextureVariation(GetPlayerPed(-1), 4),
						gloves = GetPedTextureVariation(GetPlayerPed(-1), 5),
						shoes = GetPedTextureVariation(GetPlayerPed(-1), 6),
						eyes = GetPedTextureVariation(GetPlayerPed(-1), 7),
						accessories = GetPedTextureVariation(GetPlayerPed(-1), 8),
						items = GetPedTextureVariation(GetPlayerPed(-1), 9),
						decals = GetPedTextureVariation(GetPlayerPed(-1), 10),
						shirts = GetPedTextureVariation(GetPlayerPed(-1), 11),
						helmet = GetPedPropTextureIndex(GetPlayerPed(-1), 0),
						glasses = GetPedPropTextureIndex(GetPlayerPed(-1), 1),
						earrings = GetPedPropTextureIndex(GetPlayerPed(-1), 2)
					}
					TriggerServerEvent("paramedic:saveclothing", currentmodel, drawables, textures)				
				end
			end
		elseif cmenu.show == 2 then
			ClothShop()
			if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
				if cmenu.row > 1 then cmenu.row = cmenu.row-1 else cmenu.row = 4 end
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
				if cmenu.row < 4 then cmenu.row = cmenu.row+1 else cmenu.row = 1 end
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			elseif IsControlJustPressed(1, 202) or IsDisabledControlJustPressed(1, 202) then -- backspase
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				cmenu.show = 1
				cmenu.row = 1
				cmenu.field = 1
			end
		elseif cmenu.show == 3 then
			ClothShop()
			if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
				if cmenu.row > 1 then cmenu.row = cmenu.row-1 else cmenu.row = 3 end
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
				if cmenu.row < 3 then cmenu.row = cmenu.row+1 else cmenu.row = 1 end
				PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
			elseif IsControlJustPressed(1, 202) or IsDisabledControlJustPressed(1, 202) then -- backspase
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				cmenu.show = 1
				cmenu.row = 2
				cmenu.field = 1
			end
		elseif cmenu.show == 4 then
			if text_in == 1 then
				HideHudAndRadarThisFrame()
				if UpdateOnscreenKeyboard() == 3 then text_in = 0
				elseif UpdateOnscreenKeyboard() == 1 then 
					text_in = 0
					ChangeToSkin(GetOnscreenKeyboardResult())
				elseif UpdateOnscreenKeyboard() == 2 then text_in = 0 end
			else
				ClothShop()
				if IsControlJustPressed(1, 188) or IsDisabledControlJustPressed(1, 188) then -- up
					if cmenu.row > 1 then cmenu.row = cmenu.row-1 else cmenu.row = 3 end
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				elseif IsControlJustPressed(1, 187) or IsDisabledControlJustPressed(1, 187) then -- down
					if cmenu.row < 3 then cmenu.row = cmenu.row+1 else cmenu.row = 1 end
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				elseif IsControlJustPressed(1, 202) or IsDisabledControlJustPressed(1, 202) then -- backspase
					PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					cmenu.show = 1
					cmenu.row = 3
					cmenu.field = 1
				end
			end
		end
	end
end)

RegisterNetEvent("paramedic:ped")
AddEventHandler("paramedic:ped", function(data)
    --SetPedHeadBlendData(GetPlayerPed(-1), tonumber(data.head), tonumber(data.head), 0, tonumber(data.head), tonumber(data.head), 0, 0.5, 0.5, 0.0, false)
    SetPedComponentVariation(GetPlayerPed(-1), 0, tonumber(data.d1), tonumber(data.t1), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(data.d2), tonumber(data.t2), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(data.d3), tonumber(data.t3), 1)
    SetPedComponentVariation(GetPlayerPed(-1), 3, tonumber(data.d4), tonumber(data.t4), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 4, tonumber(data.d5), tonumber(data.t5), 0)   
    SetPedComponentVariation(GetPlayerPed(-1), 5, tonumber(data.d6), tonumber(data.t6), 0)   
    --SetPedHairColor(GetPlayerPed(-1), tonumber(data.hair_txt), tonumber(data.hair_txt))
    SetPedComponentVariation(GetPlayerPed(-1), 6, tonumber(data.d7), tonumber(data.t7), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 7, tonumber(data.d8), tonumber(data.t8), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 8, tonumber(data.d9), tonumber(data.t9), 0)    
    SetPedComponentVariation(GetPlayerPed(-1), 9, tonumber(data.d10), tonumber(data.t10), 0) --
    SetPedComponentVariation(GetPlayerPed(-1), 10, tonumber(data.d11), tonumber(data.t11), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 11, tonumber(data.d12), tonumber(data.t12), 0)
    SetPedPropIndex(GetPlayerPed(-1), 0, tonumber(data.a13), tonumber(data.ta13), 0)
    SetPedPropIndex(GetPlayerPed(-1), 1, tonumber(data.a14), tonumber(data.ta14), 0)
    SetPedPropIndex(GetPlayerPed(-1), 2, tonumber(data.a15), tonumber(data.ta15), 0)
    SetPedHeadOverlay(GetPlayerPed(-1), 1, tonumber(data.f16), 25.11)
    SetPedHeadOverlay(GetPlayerPed(-1), 2, tonumber(data.f17), 25.11)
    SetPedHeadOverlay(GetPlayerPed(-1), 4, tonumber(data.f18), 25.11)
    SetPedHeadOverlay(GetPlayerPed(-1), 8, tonumber(data.f19), 25.11)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
end)

RegisterNetEvent("paramedic:freemode")
AddEventHandler("paramedic:freemode", function(data)
    SetPedComponentVariation(GetPlayerPed(-1), 0, tonumber(data.d1), tonumber(data.t1), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(data.d2), tonumber(data.t2), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(data.d3), tonumber(data.t3), 1)
    SetPedComponentVariation(GetPlayerPed(-1), 3, tonumber(data.d4), tonumber(data.t4), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 4, tonumber(data.d5), tonumber(data.t5), 0)   
    SetPedComponentVariation(GetPlayerPed(-1), 5, tonumber(data.d6), tonumber(data.t6), 0)   
    SetPedComponentVariation(GetPlayerPed(-1), 6, tonumber(data.d7), tonumber(data.t7), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 7, tonumber(data.d8), tonumber(data.t8), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 8, tonumber(data.d9), tonumber(data.t9), 0)    
    SetPedComponentVariation(GetPlayerPed(-1), 9, tonumber(data.d10), tonumber(data.t10), 0) --
    SetPedComponentVariation(GetPlayerPed(-1), 10, tonumber(data.d11), tonumber(data.t11), 0)
    SetPedComponentVariation(GetPlayerPed(-1), 11, tonumber(data.d12), tonumber(data.t12), 0)
    SetPedPropIndex(GetPlayerPed(-1), 0, tonumber(data.a13), tonumber(data.ta13), 0)
    SetPedPropIndex(GetPlayerPed(-1), 1, tonumber(data.a14), tonumber(data.ta14), 0)
    SetPedPropIndex(GetPlayerPed(-1), 2, tonumber(data.a15), tonumber(data.ta15), 0)
    local mskin = GetHashKey("mp_m_freemode_01")
	local fskin = GetHashKey("mp_f_freemode_01")
	if GetEntityModel(GetPlayerPed(-1)) == mskin then

        SetPedComponentVariation(GetPlayerPed(-1), 11, 13, 3, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 9, 3, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 3, 92, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)

	elseif GetEntityModel(GetPlayerPed(-1)) == fskin then

        SetPedComponentVariation(GetPlayerPed(-1), 11, 9, 2, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 3, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 3, 98, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 6, 27, 0, 2)

	end
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
end)

RegisterNetEvent("paramedic:nomodel")
AddEventHandler("paramedic:nomodel", function(data)
	local mskin = GetHashKey("mp_m_freemode_01")
	local fskin = GetHashKey("mp_f_freemode_01")
	if GetEntityModel(GetPlayerPed(-1)) == mskin then

        SetPedComponentVariation(GetPlayerPed(-1), 11, 13, 3, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 9, 3, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 3, 92, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 6, 25, 0, 2)

	elseif GetEntityModel(GetPlayerPed(-1)) == fskin then

        SetPedComponentVariation(GetPlayerPed(-1), 11, 9, 2, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 3, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 3, 98, 0, 2)
        SetPedComponentVariation(GetPlayerPed(-1), 6, 27, 0, 2)

	else
		local modelhashed = GetHashKey('s_m_m_paramedic_01')
		RequestModel(modelhashed)
		while not HasModelLoaded(modelhashed) do 
			RequestModel(modelhashed)
			Citizen.Wait(0)
		end		
		SetPlayerModel(PlayerId(), modelhashed)
		SetPedRandomComponentVariation(GetPlayerPed(-1), true)
		local a = "" -- nil doesnt work
		SetModelAsNoLongerNeeded(modelhashed)
	end
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
end)

RegisterNetEvent("paramedic:changemodel")
AddEventHandler("paramedic:changemodel",function(data)
    ChangeToSkin(data.m)
    currentmodel = data.m
    TriggerEvent("paramedic:ped", data)
end)

RegisterNetEvent("paramedic:changempmodel")
AddEventHandler("paramedic:changempmodel",function(data)
    ChangeToSkin(data.m)
    currentmodel = data.m
    TriggerEvent("paramedic:freemode", data)
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("clothes:ondeath")
AddEventHandler("clothes:ondeath",function()
    cmenu.show = 0
	cmenu.row = 0
	cmenu.field = 0
end)

banned_skins = {
	'a_c_chickenhawk',
	'a_c_chimp',
	'a_c_chop',
	'a_c_cormorant',
	'a_c_cow',
	'a_c_coyote',
	'a_c_crow',
	'a_c_deer',
	'a_c_fish',
	'a_c_hen',
	'a_c_husky',
	'a_c_mtlion',
	'a_c_pig',
	'a_c_pigeon',
	'a_c_rat',
	'a_c_retriever',
	'a_c_rhesus',
	'a_c_seagull',
	'a_c_sharktiger',
	'a_c_shepherd', --animals
	'a_f_m_beach_01',
	'a_f_m_bevhills_01',
	'a_f_m_bevhills_02',
	'a_f_m_bodybuild_01',
	'a_f_m_business_02',
	'a_f_m_downtown_01',
	'a_f_m_eastsa_01',
	'a_f_m_eastsa_02',
	'a_f_m_fatbla_01',
	'a_f_m_fatcult_01',
	'a_f_m_fatwhite_01',
	'a_f_m_ktown_01',
	'a_f_m_ktown_02',
	'a_f_m_prolhost_01',
	'a_f_m_salton_01',
	'a_f_m_skidrow_01',
	'a_f_m_soucentmc_01',
	'a_f_m_soucent_01',
	'a_f_m_soucent_02',
	'a_f_m_tourist_01',
	'a_f_m_trampbeac_01',
	'a_f_m_tramp_01',
	'a_f_o_genstreet_01',
	'a_f_o_indian_01',
	'a_f_o_ktown_01',
	'a_f_o_salton_01',
	'a_f_o_soucent_01',
	'a_f_o_soucent_02',
	'a_f_y_beach_01',
	'a_f_y_bevhills_01',
	'a_f_y_bevhills_02',
	'a_f_y_bevhills_03',
	'a_f_y_bevhills_04',
	'a_f_y_business_01',
	'a_f_y_business_02',
	'a_f_y_business_03',
	'a_f_y_business_04',
	'a_f_y_eastsa_01',
	'a_f_y_eastsa_02',
	'a_f_y_eastsa_03',
	'a_f_y_epsilon_01',
	'a_f_y_fitness_01',
	'a_f_y_fitness_02',
	'a_f_y_genhot_01',
	'a_f_y_golfer_01',
	'a_f_y_hiker_01',
	'a_f_y_hippie_01',
	'a_f_y_hipster_01',
	'a_f_y_hipster_02',
	'a_f_y_hipster_03',
	'a_f_y_hipster_04',
	'a_f_y_indian_01',
	'a_f_y_juggalo_01',
	'a_f_y_runner_01',
	'a_f_y_rurmeth_01',
	'a_f_y_scdressy_01',
	'a_f_y_skater_01',
	'a_f_y_soucent_01',
	'a_f_y_soucent_02',
	'a_f_y_soucent_03',
	'a_f_y_tennis_01',
	'a_f_y_topless_01',
	'a_f_y_tourist_01',
	'a_f_y_tourist_02',
	'a_f_y_vinewood_01',
	'a_f_y_vinewood_02',
	'a_f_y_vinewood_03',
	'a_f_y_vinewood_04',
	'a_f_y_yoga_01', -- females
	'a_m_m_acult_01',
	'a_m_m_afriamer_01',
	'a_m_m_beach_01',
	'a_m_m_beach_02',
	'a_m_m_bevhills_01',
	'a_m_m_bevhills_02',
	'a_m_m_business_01',
	'a_m_m_eastsa_01',
	'a_m_m_eastsa_02',
	'a_m_m_farmer_01',
	'a_m_m_fatlatin_01',
	'a_m_m_genfat_01',
	'a_m_m_genfat_02',
	'a_m_m_golfer_01',
	'a_m_m_hasjew_01',
	'a_m_m_hillbilly_01',
	'a_m_m_hillbilly_02',
	'a_m_m_indian_01',
	'a_m_m_ktown_01',
	'a_m_m_malibu_01',
	'a_m_m_mexcntry_01',
	'a_m_m_mexlabor_01',
	'a_m_m_og_boss_01',
	'a_m_m_paparazzi_01',
	'a_m_m_polynesian_01',
	'a_m_m_prolhost_01',
	'a_m_m_rurmeth_01',
	'a_m_m_salton_01',
	'a_m_m_salton_02',
	'a_m_m_salton_03',
	'a_m_m_salton_04',
	'a_m_m_skater_01',
	'a_m_m_skidrow_01',
	'a_m_m_socenlat_01',
	'a_m_m_soucent_01',
	'a_m_m_soucent_02',
	'a_m_m_soucent_03',
	'a_m_m_soucent_04',
	'a_m_m_stlat_02',
	'a_m_m_tennis_01',
	'a_m_m_tourist_01',
	'a_m_m_trampbeac_01',
	'a_m_m_tramp_01',
	'a_m_m_tranvest_01',
	'a_m_m_tranvest_02',
	'a_m_o_acult_01',
	'a_m_o_acult_02',
	'a_m_o_beach_01',
	'a_m_o_genstreet_01',
	'a_m_o_ktown_01',
	'a_m_o_salton_01',
	'a_m_o_soucent_01',
	'a_m_o_soucent_02',
	'a_m_o_soucent_03',
	'a_m_o_tramp_01',
	'a_m_y_acult_01',
	'a_m_y_acult_02',
	'a_m_y_beachvesp_01',
	'a_m_y_beachvesp_02',
	'a_m_y_beach_01',
	'a_m_y_beach_02',
	'a_m_y_beach_03',
	'a_m_y_bevhills_01',
	'a_m_y_bevhills_02',
	'a_m_y_breakdance_01',
	'a_m_y_busicas_01',
	'a_m_y_business_01',
	'a_m_y_business_02',
	'a_m_y_business_03',
	'a_m_y_cyclist_01',
	'a_m_y_dhill_01',
	'a_m_y_downtown_01',
	'a_m_y_eastsa_01',
	'a_m_y_eastsa_02',
	'a_m_y_epsilon_01',
	'a_m_y_epsilon_02',
	'a_m_y_gay_01',
	'a_m_y_gay_02',
	'a_m_y_genstreet_01',
	'a_m_y_genstreet_02',
	'a_m_y_golfer_01',
	'a_m_y_hasjew_01',
	'a_m_y_hiker_01',
	'a_m_y_hippy_01',
	'a_m_y_hipster_01',
	'a_m_y_hipster_02',
	'a_m_y_hipster_03',
	'a_m_y_indian_01',
	'a_m_y_jetski_01',
	'a_m_y_juggalo_01',
	'a_m_y_ktown_01',
	'a_m_y_ktown_02',
	'a_m_y_latino_01',
	'a_m_y_methhead_01',
	'a_m_y_mexthug_01',
	'a_m_y_motox_01',
	'a_m_y_motox_02',
	'a_m_y_musclbeac_01',
	'a_m_y_musclbeac_02',
	'a_m_y_polynesian_01',
	'a_m_y_roadcyc_01',
	'a_m_y_runner_01',
	'a_m_y_runner_02',
	'a_m_y_salton_01',
	'a_m_y_skater_01',
	'a_m_y_skater_02',
	'a_m_y_soucent_01',
	'a_m_y_soucent_02',
	'a_m_y_soucent_03',
	'a_m_y_soucent_04',
	'a_m_y_stbla_01',
	'a_m_y_stbla_02',
	'a_m_y_stlat_01',
	'a_m_y_stwhi_01',
	'a_m_y_stwhi_02',
	'a_m_y_sunbathe_01',
	'a_m_y_surfer_01',
	'a_m_y_vindouche_01',
	'a_m_y_vinewood_01',
	'a_m_y_vinewood_02',
	'a_m_y_vinewood_03',
	'a_m_y_vinewood_04',
	'a_m_y_yoga_01', --males
	'csb_abigail', --f
	'csb_anita', --f
	'csb_anton', --m
	'csb_ballasog', --m
	'csb_bride', --broken kinda
	'csb_burgerdrug', --m
	'csb_car3guy1', --m
	'csb_car3guy2', --m
	'csb_chef', --m
	'csb_chin_goon', --m
	'csb_cletus', --m
	'csb_cop', --m cop
	'csb_customer', --m
	'csb_denise_friend', --f
	'csb_fos_rep', --m
	'csb_g', --m
	'csb_groom', --m
	'csb_grove_str_dlr', --m
	'csb_hao', --m
	'csb_hugh', --m
	'csb_imran', --m
	'csb_janitor', --m
	'csb_maude', --f
	'csb_mweather', --m mayweather
	'csb_ortega', --m
	'csb_oscar', --m
	'csb_porndudes', --m
	'csb_prologuedriver', --m
	'csb_prolsec', --m security guard
	'csb_ramp_gang',  --m
	'csb_ramp_hic', --m
	'csb_ramp_hipster', --m
	'csb_ramp_marine', --m marine
	'csb_ramp_mex', --m
	'csb_reporter', --m
	'csb_roccopelosi', --m
	'csb_screen_writer', --f
	'csb_stripper_01', --f
	'csb_stripper_02', --f
	'csb_tonya', --f
	'csb_trafficwarden', --m jobs
	'cs_amandatownley', --f 
	'cs_andreas', --m dead fib agent
	'cs_ashley', --f
	'cs_bankman', --m
	'cs_barry', --m
	'cs_beverly', --m
	'cs_brad', --m
	'cs_bradcadaver', --m half invisible zombie?
	'cs_carbuyer', --m
	'cs_casey', --m prison guard
	'cs_chengsr', --m
	'cs_chrisformage', --m
	'cs_clay', --m
	'cs_dale', --m
	'cs_davenorton', --m
	'cs_debra', --f
	'cs_denise', --f
	'cs_devin', --m
	'cs_dom', --m
	'cs_dreyfuss', --m
	'cs_drfriedlander', --m
	'cs_fabien', --m
	'cs_fbisuit_01', --m fbi
	'cs_floyd', --m
	'cs_guadalope', --f
	'cs_gurk',  --f
	'cs_hunter', --m
	'cs_janet', --f
	'cs_jewelass', --f
	'cs_jimmyboston', --m
	'cs_jimmydisanto', --m
	'cs_joeminuteman', --m
	'cs_johnnyklebitz', --m
	'cs_josef', --m
	'cs_josh', --m
	'cs_lamardavis', --m invisbile body
	'cs_lazlow', --m
	'cs_lestercrest', --m
	'cs_lifeinvad_01', --m
	'cs_magenta', --f
	'cs_manuel', --m
	'cs_marnie', --f
	'cs_martinmadrazo', --m
	'cs_maryann', --f
	'cs_michelle', --f
	'cs_milton', --m
	'cs_molly', --f
	'cs_movpremf_01', --f
	'cs_movpremmale', --m
	'cs_mrk', --m
	'cs_mrsphillips', --f
	'cs_mrs_thornhill', --f
	'cs_natalia', --f
	'cs_nervousron', --m
	'cs_nigel', --m
	'cs_old_man1a', --m
	'cs_old_man2', --m
	'cs_omega', --m
	'cs_orleans', --m
	'cs_paper', --m
	'cs_patricia', --f
	'cs_priest', --m
	'cs_prolsec_02', --m
	'cs_russiandrunk', --m
	'cs_siemonyetarian', --m
	'cs_solomon', --m
	'cs_stevehains', --m
	'cs_stretch', --m
	'cs_tanisha', --f
	'cs_taocheng', --m
	'cs_taostranslator', --m
	'cs_tenniscoach', --m
	'cs_terry', --m
	'cs_tom', --m
	'cs_tomepsilon', --m
	'cs_tracydisanto', --f
	'cs_wade', --m
	'cs_zimbor', --m
	'g_f_y_ballas_01',
	'g_f_y_families_01',
	'g_f_y_lost_01',
	'g_f_y_vagos_01',
	'g_m_m_armboss_01',
	'g_m_m_armgoon_01',
	'g_m_m_armlieut_01',
	'g_m_m_chemwork_01',
	'g_m_m_chiboss_01',
	'g_m_m_chicold_01',
	'g_m_m_chigoon_01',
	'g_m_m_chigoon_02',
	'g_m_m_korboss_01',
	'g_m_m_mexboss_01',
	'g_m_m_mexboss_02',
	'g_m_y_armgoon_02',
	'g_m_y_azteca_01',
	'g_m_y_ballaeast_01',
	'g_m_y_ballaorig_01',
	'g_m_y_ballasout_01',
	'g_m_y_famca_01',
	'g_m_y_famdnf_01',
	'g_m_y_famfor_01',
	'g_m_y_korean_01',
	'g_m_y_korean_02',
	'g_m_y_korlieut_01',
	'g_m_y_lost_01',
	'g_m_y_lost_02',
	'g_m_y_lost_03',
	'g_m_y_mexgang_01',
	'g_m_y_mexgoon_01',
	'g_m_y_mexgoon_02',
	'g_m_y_mexgoon_03',
	'g_m_y_pologoon_01',
	'g_m_y_pologoon_02',
	'g_m_y_salvaboss_01',
	'g_m_y_salvagoon_01',
	'g_m_y_salvagoon_02',
	'g_m_y_salvagoon_03',
	'g_m_y_strpunk_01',
	'g_m_y_strpunk_02',
	'hc_driver', --m
	'hc_gunman', --m
	'hc_hacker', --m
	'ig_abigail', --f
	'ig_amandatownley', --f
	'ig_andreas', --m fib agent
	'ig_ashley', --f ------------------------------------------------------------------------------------------------- repeated
	'ig_ballasog', --m
	'ig_bankman', --m
	'ig_barry', --m
	'ig_bestmen', --m
	'ig_beverly', --m
	'ig_brad', --m
	'ig_bride', --f
	'ig_car3guy1', --m
	'ig_car3guy2', --m
	'ig_casey', --m prison guard?
	'ig_chef', --m
	'ig_chengsr', --m
	'ig_chrisformage', --m
	'ig_clay', --m
	'ig_claypain', --m
	'ig_cletus', --m
	'ig_dale', --m
	'ig_davenorton', --m
	'ig_denise', --f
	'ig_devin',
	'ig_dom',
	'ig_dreyfuss',
	'ig_drfriedlander',
	'ig_fabien',
	'ig_fbisuit_01',
	'ig_floyd',
	'ig_groom',
	'ig_hao',
	'ig_hunter',
	'ig_janet',
	'ig_jay_norris',
	'ig_jewelass',
	'ig_jimmyboston',
	'ig_jimmydisanto',
	'ig_joeminuteman',
	'ig_johnnyklebitz',
	'ig_josef',
	'ig_josh',
	'ig_kerrymcintosh',
	'ig_lamardavis',
	'ig_lazlow',
	'ig_lestercrest',
	'ig_lifeinvad_01',
	'ig_lifeinvad_02',
	'ig_magenta',
	'ig_manuel',
	'ig_marnie',
	'ig_maryann',
	'ig_maude',
	'ig_michelle',
	'ig_milton',
	'ig_molly',
	'ig_mrk',
	'ig_mrsphillips',
	'ig_mrs_thornhill',
	'ig_natalia',
	'ig_nervousron',
	'ig_nigel',
	'ig_old_man1a',
	'ig_old_man2',
	'ig_omega',
	'ig_oneil',
	'ig_orleans',
	'ig_ortega',
	'ig_paper',
	'ig_patricia',
	'ig_priest',
	'ig_prolsec_02',
	'ig_ramp_gang',
	'ig_ramp_hic',
	'ig_ramp_hipster',
	'ig_ramp_mex',
	'ig_roccopelosi',
	'ig_russiandrunk',
	'ig_screen_writer',
	'ig_siemonyetarian',
	'ig_solomon',
	'ig_stevehains',
	'ig_stretch',
	'ig_talina',
	'ig_tanisha',
	'ig_taocheng',
	'ig_taostranslator',
	'ig_taostranslator_p',
	'ig_tenniscoach',
	'ig_terry',
	'ig_tomepsilon',
	'ig_tonya',
	'ig_tracydisanto',
	'ig_trafficwarden',
	'ig_tylerdix',
	'ig_wade',
	'ig_zimbor', --------------------------------------------------------------- repeated?
	'mp_f_deadhooker',
	'mp_f_misty_01',
	'mp_f_stripperlite',
	'mp_g_m_pros_01',
	'mp_headtargets',
	'mp_m_claude_01',
	'mp_m_exarmy_01',
	'mp_m_famdd_01',
	'mp_m_fibsec_01',
	'mp_m_marston_01',
	'mp_m_niko_01',
	'mp_m_shopkeep_01',
	'mp_s_m_armoured_01',
	'player_one', ---
	'player_two',
	'player_zero',
	'slod_human',          --- didnt check,didnt use ~~crashes game/invalid
	'slod_large_quadped',
	'slod_small_quadped',
	'strm_peds_mpshare',
	'strm_peds_mptattrts',  ---
	's_f_m_fembarber',
	's_f_m_maid_01',
	's_f_m_shop_high',
	's_f_m_sweatshop_01',
	's_f_y_airhostess_01',
	's_f_y_bartender_01',
	's_f_y_baywatch_01',
	's_f_y_factory_01',
	's_f_y_hooker_01',
	's_f_y_hooker_02',
	's_f_y_hooker_03',
	's_f_y_migrant_01',
	's_f_y_movprem_01',
	's_f_y_scrubs_01', --ems
	's_f_y_shop_low',
	's_f_y_shop_mid',
	's_f_y_stripperlite',
	's_f_y_stripper_01',
	's_f_y_stripper_02',
	's_f_y_sweatshop_01',
	's_m_m_ammucountry',
	's_m_m_armoured_01', --prison guard
	's_m_m_armoured_02', --prison guard
	's_m_m_autoshop_01',
	's_m_m_autoshop_02',
	's_m_m_bouncer_01',
	's_m_m_chemsec_01', --security
	's_m_m_ciasec_01',
	's_m_m_cntrybar_01',
	's_m_m_dockwork_01',
	's_m_m_doctor_01',
	's_m_m_fiboffice_01', --fib 
	's_m_m_fiboffice_02',
	's_m_m_gaffer_01',
	's_m_m_gardener_01',
	's_m_m_gentransport',
	's_m_m_hairdress_01',
	's_m_m_highsec_01',
	's_m_m_highsec_02',
	's_m_m_janitor',
	's_m_m_lathandy_01',
	's_m_m_lifeinvad_01',
	's_m_m_linecook',
	's_m_m_lsmetro_01',
	's_m_m_mariachi_01',
	's_m_m_marine_01', --marine
	's_m_m_migrant_01',
	's_m_m_movalien_01', -- alien
	's_m_m_movprem_01',
	's_m_m_movspace_01',
	's_m_m_pilot_01',
	's_m_m_pilot_02',
	's_m_m_postal_01',
	's_m_m_postal_02',
	's_m_m_scientist_01',
	's_m_m_strperf_01',
	's_m_m_strpreach_01',
	's_m_m_strvend_01',
	's_m_m_trucker_01',
	's_m_m_ups_01',
	's_m_m_ups_02',
	's_m_o_busker_01',
	's_m_y_airworker',
	's_m_y_ammucity_01',
	's_m_y_armymech_01',
	's_m_y_autopsy_01',
	's_m_y_barman_01',
	's_m_y_baywatch_01',
	's_m_y_blackops_01', --black ops
	's_m_y_blackops_02', --black ops
	's_m_y_busboy_01',
	's_m_y_chef_01',
	's_m_y_clown_01',
	's_m_y_construct_01',
	's_m_y_construct_02',
	's_m_y_dealer_01',
	's_m_y_devinsec_01',
	's_m_y_dockwork_01',
	's_m_y_doorman_01', -- security guard
	's_m_y_dwservice_01',
	's_m_y_dwservice_02',
	's_m_y_factory_01',
	's_m_y_fireman_01', -- fireman
	's_m_y_garbage',
	's_m_y_grip_01',
	's_m_y_marine_01', --marine
	's_m_y_marine_02', --marine
	's_m_y_marine_03', --marine
	's_m_y_mime',
	's_m_y_pestcont_01',
	's_m_y_pilot_01',
	's_m_y_prismuscl_01',
	's_m_y_prisoner_01',
	's_m_y_robber_01',
	's_m_y_shop_mask',
	's_m_y_strvend_01',
	's_m_y_uscg_01',
	's_m_y_valet_01',
	's_m_y_waiter_01',
	's_m_y_winclean_01',
	's_m_y_xmech_01',
	's_m_y_xmech_02',
	'u_f_m_corpse_01',
	'u_f_m_miranda',
	'u_f_m_promourn_01',
	'u_f_o_moviestar',
	'u_f_o_prolhost_01',
	'u_f_y_bikerchic',
	'u_f_y_comjane',
	'u_f_y_corpse_01',
	'u_f_y_corpse_02', -- invisible broken
	'u_f_y_hotposh_01',
	'u_f_y_jewelass_01',
	'u_f_y_mistress',
	'u_f_y_poppymich',
	'u_f_y_princess',
	'u_f_y_spyactress',
	'u_m_m_aldinapoli',
	'u_m_m_bankman',
	'u_m_m_bikehire_01',
	'u_m_m_fibarchitect',
	'u_m_m_filmdirector',
	'u_m_m_glenstank_01',
	'u_m_m_griff_01',
	'u_m_m_jesus_01',
	'u_m_m_jewelsec_01',
	'u_m_m_jewelthief',
	'u_m_m_markfost',
	'u_m_m_partytarget',
	'u_m_m_prolsec_01', -- dead guy
	'u_m_m_promourn_01',
	'u_m_m_rivalpap',
	'u_m_m_spyactor',
	'u_m_m_willyfist',
	'u_m_o_finguru_01',
	'u_m_o_taphillbilly',
	'u_m_o_tramp_01',
	'u_m_y_abner',
	'u_m_y_antonb',
	'u_m_y_babyd',
	'u_m_y_baygor',
	'u_m_y_burgerdrug_01',
	'u_m_y_chip',
	'u_m_y_cyclist_01',
	'u_m_y_fibmugger_01',
	'u_m_y_guido_01',
	'u_m_y_gunvend_01',
	'u_m_y_hippie_01',
	'u_m_y_imporage',
	'u_m_y_justin',
	'u_m_y_mani',
	'u_m_y_militarybum',
	'u_m_y_paparazzi',
	'u_m_y_party_01',
	'u_m_y_pogo_01',
	'u_m_y_prisoner_01',
	'u_m_y_proldriver_01',
	'u_m_y_rsranger_01',
	'u_m_y_sbike',
	'u_m_y_staggrm_01',
	'u_m_y_tattoo_01',
	'u_m_y_zombie_01',
}