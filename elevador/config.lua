cfg = {}

--[[
    As coordenadas devem ser em vector3 {{
        Caso você não saiba pegar as coordenadas em vector3 adicione esse comando na sua base

        RegisterCommand('vec',function(source,args,rawCommand)
            local user_id = vRP.getUserId(source)
            if vRP.hasPermission(user_id,"suaperm.permissao")then
                local x,y,z = vRPclient.getPosition(source)
                vRP.prompt(source,"Cordenadas:",'vector3('..tD(x)..", "..tD(y)..", "..tD(z)..")")
            end
        end)
    }}
    Acess é para dizer se o blip vai aparecer ou não;
    A permissão é por andar, por exemplo na policia, recrutas só podem acessar o 1º andar, altas pantentes podem ir até o resto;
]]

cfg.elevadores = {
    ['hospital'] = {
        {vector3(319.44, -735.41, 29.32), acess = true, perm = 'admin.permissao'},
        {vector3(322.03, -727.39, 29.31), acess = true, perm = 'admin.permissao'},
        {vector3(336.33, -730.5, 29.32), acess = true, perm = 'policia.permissao'},
    },
    ['dp'] = {
        {vector3(357.63, -709.68, 29.27),acess = true,perm = 'admin.permissao'},
        {vector3(361.08, -703.14, 29.31), acess = true,perm = 'admin.permissao'},
        {vector3(355.63, -717.18, 29.27), acess = true,perm = 'admin.permissao'},
    },
}