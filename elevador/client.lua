
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
	local elevadores = vSERVER.elevs(slavo)
	if elevadores then
		cb({ elevadores = elevadores})
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
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
					sleep = 1
					if v2.acess then
						DrawMarker(27, v2[1].x, v2[1].y, v2[1].z-1.0,0,0,0,0.0,0,0,0.7,0.7,0.5,255,0,0,255,0,0,0,1)
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