-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("elevador",src)

function src.checkpermission(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,perm) then
        return true
    end
end

function src.elevs(type)
    local elevadores = {}
    for k,v in pairs(cfg.elevadores) do
        for k2,v2 in pairs(v) do
            if k == type then
                table.insert(elevadores,{slot = k2})
            end
        end
    end
    return elevadores
end