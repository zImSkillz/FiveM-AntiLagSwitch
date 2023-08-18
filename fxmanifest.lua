--[[
				██╗  ██╗   ██╗██╗  ██╗ ██████╗ ███████╗
				██║  ╚██╗ ██╔╝╚██╗██╔╝██╔═══██╗██╔════╝
				██║   ╚████╔╝  ╚███╔╝ ██║   ██║███████╗
				██║    ╚██╔╝   ██╔██╗ ██║   ██║╚════██║
				███████╗██║   ██╔╝ ██╗╚██████╔╝███████║
				╚══════╝╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
					Developer: Schokifresse & zImSkillz#5637
						> Let's help against Lag Switcher
]]--

fx_version 'cerulean'
game 'gta5'

name "Anti-Lagswitch"
description "Kick Lag Switchers!"
author "Schokifresse & zImSkillz | from https://dsc.gg/lyxos/"

shared_scripts {
	'Config/Config.lua'
}

client_scripts {
	'Client/*.lua'
}

server_scripts {
	'Config/Log.lua'
	'Server/*.lua'
}
