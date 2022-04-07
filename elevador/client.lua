
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vSERVER = Tunnel.getInterface("elevador")

local elevador = {}
local slavo = {}
local teste = {}


local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true})
		TriggerEvent("hideHud")
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("showHud")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data ~= 'fechar' then
		if vSERVER.checkpermission(teste[data]) then
			DoScreenFadeOut(1000)
			ToggleActionMenu()
			SetTimeout(1400,function()
				setcds(slavo,data)
			end)
		end

	
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

RegisterNUICallback("QtdElev",function(data,cb)
	local agendados,title = vSERVER.elevs(slavo)
	if agendados then
		cb({ agendados = agendados,
			title = title
		})
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local sleep = 1000

		for k,v in pairs(cfg.elevadores) do
			for k2,v2 in pairs(v) do
				local ped = PlayerPedId()
				local pedcds = GetEntityCoords(ped)
				local distance = #(pedcds - v2[1])
				elevador[k2] = v2[1]
				teste[k2] = v2.perm

				if distance <= 5 then
					sleep = 5
					if v2.acess then
						DrawText3D(v2[1].x, v2[1].y, v2[1].z, "[~g~E~w~] Para ~g~ABRIR~w~ o elevador.")
						DrawMarker(30, v2[1].x, v2[1].y, v2[1].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,140,255,90,0,0,0,1)
						if distance <= 2.3 then
							if IsControlJustPressed(0,38) then
								ToggleActionMenu()
								slavo = k
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function check(type)
	for key, value in pairs(cfg.elevadores) do
		if key == type then
			return true
		end
	end
end

function setcds(type,data)
	local ped = PlayerPedId()
	for key, value in pairs(cfg.elevadores) do
		for k,v in pairs(value) do
			if key == type then
				elevador[k] = v[1]
				SetEntityCoords(ped,elevador[data].x,elevador[data].y,elevador[data].z,0,0,0,0)
				SetEntityHeading(ped,32.76)
				-- TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
				DoScreenFadeIn(1000)
			end
		end
	end
end
