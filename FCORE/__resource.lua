ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/pdown.ttf',
	'html/bank-icon.png'
}

client_scripts {
	'client/main.lua',
}
server_scripts {
	'server/main.lua',
	'server/user.lua',
	'server/commands.lua',
	'server/groups.lua',
	'server/bans.lua'
}

server_exports {
	'getPlayer',
	'addAdminCommand',
	'addCommand',
	'addGroupCommand',
	'addACECommand',
	'log'
}