fx_version 'cerulean'
game 'gta5'
--a
shared_scripts {
	'config.lua',
	'@qb-garages/config.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua',
	'@oxmysql/lib/MySQL.lua'
}

lua54 'yes'
