cfg = {}

--[[
    As coordenadas devem ser em vector3
    Acess é para dizer se o blip vai aparecer ou não;
    A permissão é por andar, por exemplo na policia, recrutas só podem acessar o 1º andar, altas pantentes podem ir até o resto;
    Você pode deixar sem permissão, assim qualquer um pode acessar, apenas definindo nil ou uma string vazia '';
    Também é possivel adicionar multiplas permissões, basta separar por virgula, exemplo: {"admin.permissao","admin.permissao2"};
    Name é o titulo do andar, cada andar pode ter um nome expecifico;
]]

cfg.elevadores = {
    ['HOSPITAL'] = {
        {coords = vector3(319.44, -735.41, 29.32), acess = true,name = 'terreo', perm = nil}, -- exemplo sem permissão
        {coords = vector3(322.03, -727.39, 29.31), acess = true,name = 'praça', perm = {'admin.permissao','admin.permissao2'}}, -- exemplo de multi permissões
        {coords = vector3(336.33, -730.5, 29.32), acess = true,name = 'garagem', perm = 'policia.permissao'}, -- exemplo de permissão unica
    },
    ['Policia'] = {
        {coords = vector3(357.63, -709.68, 29.27),acess = true,name = 'Arsenal',perm = 'admin.permissao'},
        {coords = vector3(361.08, -703.14, 29.31), acess = true,name = 'Garagem',perm = 'admin.permissao'},
        {coords = vector3(355.63, -717.18, 29.27), acess = true,name = 'Teto',perm = 'admin.permissao'},
    },
}
