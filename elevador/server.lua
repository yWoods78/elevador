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
    local title = {}
    for k,v in pairs(cfg.elevadores) do
        for k2,v2 in pairs(v) do
            if k == type then
                table.insert(elevadores,{slot = k2,title = type})
            end
        end
    end
    for k3,v3 in pairs(cfg.elevadores) do
        if k3 == type then
            table.insert(title,type)
        end
    end

    return elevadores,title
end
