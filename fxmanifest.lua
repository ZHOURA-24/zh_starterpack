fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'config.lua',
	'shared.lua',
	'@ox_lib/init.lua',
	-- '@qb-garages/config.lua' -- Uncoment if use qb-garages
	-- '@esx_garages/config.lua' -- Uncoment if use esx_garages
	'@zh-garages/shared/config.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua',
	'@oxmysql/lib/MySQL.lua'
}
