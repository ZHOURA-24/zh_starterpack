fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'shared.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua',
	'@oxmysql/lib/MySQL.lua'
}

files {
	'shared/*.lua'
}
