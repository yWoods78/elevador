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
vSERVER = {}
Tunnel.bindInterface(GetCurrentResourceName(),vSERVER)

function vSERVER.checkpermission(perm)
    local source = source
    local user_id = vRP.getUserId(source)
    if not perm or perm == "" then return true end
    if type(perm) == "table" then
        for i = 0,#perm do
            if vRP.hasPermission(user_id,perm[i]) then
                return true
            end
        end
        return false
    end
    if vRP.hasPermission(user_id,perm) then
        return true
    end
end