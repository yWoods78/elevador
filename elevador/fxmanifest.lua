fx_version 'adamant'
game 'gta5'

ui_page 'nui/main.html'

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}

files {
	'nui/*.html',
	'nui/*.js',
	'nui/*.css',
}