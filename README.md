# elevador
Elevador do Badland modificado para suportar multi coordenadas 

As coordenadas devem ser em vector3 
Caso você não saiba pegar as coordenadas em vector3 adicione esse comando na sua base

        RegisterCommand('vec',function(source,args,rawCommand)
            local user_id = vRP.getUserId(source)
            if vRP.hasPermission(user_id,"suaperm.permissao")then
                local x,y,z = vRPclient.getPosition(source)
                vRP.prompt(source,"Cordenadas:",'vector3('..tD(x)..", "..tD(y)..", "..tD(z)..")")
            end
        end)
    
Acess é para dizer se o blip vai aparecer ou não;
A permissão é por andar, por exemplo na policia, recrutas só podem acessar o 1º andar, altas pantentes podem ir até o resto;

só funciona em 3 coordenadas mas está bem facil de adaptar para suas necessecidades
