# 🏢 Elevador

## Descrição
Este é um sistema de elevador com suporte para múltiplas coordenadas em formato `vector3`. O sistema é projetado para funcionar em servidores de GTA V com o framework vRP, mas pode ser adaptado para outros contextos.

## 📝 Comandos
Para adquirir as coordenadas em formato `vector3`, você pode utilizar o seguinte comando:

```lua
RegisterCommand('vec', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "suaperm.permissao") then
        local x, y, z = vRPclient.getPosition(source)
        vRP.prompt(source, "Coordenadas:", 'vector3(' .. x .. ", " .. y .. ", " .. z .. ")")
    end
end)
```

## 💡 Funcionalidades
- **Acesso Controlado**: O sistema permite definir permissões de acesso para diferentes andares. Por exemplo, na polícia, recrutas podem acessar apenas o 1º andar, enquanto patentes superiores têm acesso aos demais andares.

- **Ajuste Automático**: O sistema de elevador é projetado para se ajustar automaticamente conforme novas coordenadas são adicionadas.

## 🌐 Suporte
Para qualquer suporte ou dúvidas adicionais, você pode entrar em contato conosco em nosso servidor Discord [aqui](https://discord.gg/aeGaqs4EbG).
