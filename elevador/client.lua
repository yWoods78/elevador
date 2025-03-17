
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local savedIndex = {}

local menuactive = false
function ToggleActionMenu(data)
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true,floors = data})
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

RegisterNUICallback("close",function(data,cb)
	ToggleActionMenu()
end)

RegisterNUICallback("floorSelected",function(data,cb)
	data.floor = tonumber(data.floor)
	if vSERVER.checkpermission(cfg.elevadores[savedIndex][data.floor].perm) then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			setcds(data.floor)
		end)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		for elevatorIndex,floors in pairs(cfg.elevadores) do
			for _,floorData in pairs(floors) do
				local ped = PlayerPedId()
				local pedcds = GetEntityCoords(ped)
				local distance = #(pedcds - floorData.coords)

				if distance <= 5 then
					sleep = 1
					if floorData.acess then
						DrawMarker(27, floorData.coords.x, floorData.coords.y, floorData.coords.z-1.0,0,0,0,0.0,0,0,0.7,0.7,0.5,255,0,0,255,0,0,0,1)
						if distance <= 2.3 then
							if IsControlJustPressed(0,38) then
								ToggleActionMenu(cfg.elevadores[elevatorIndex])
								savedIndex = elevatorIndex
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

function setcds(floor)
	local ped = PlayerPedId()
	SetEntityCoords(ped,cfg.elevadores[savedIndex][floor].coords.x,cfg.elevadores[savedIndex][floor].coords.y,cfg.elevadores[savedIndex][floor].coords.z,0,0,0,0)
	DoScreenFadeIn(1000)
end
