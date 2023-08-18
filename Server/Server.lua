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

local debugMessages = false

function debugPrint(msg)
	local msg = msg
	if debugMessages then
		print('[DEBUG:] "Anti-LagSwitch":', msg)
	end
end

local ping = {}

RegisterServerEvent("LyxosALS:GetPing")
AddEventHandler("LyxosALS:GetPing", function()
	local playerId = source
	
	debugPrint("Ping requested successfully!")
	
	if ping[tostring(playerId)] ~= 3 then
		ping[tostring(playerId)] = ping[tostring(playerId)] + 1
	end
end)

CreateThread(function()
	while true do
		for _, playerId in ipairs(GetPlayers()) do
			local playerId = playerId
			
			if ping[tostring(playerId)] == nil then
				ping[tostring(playerId)] = 15
			end
			
			local plyPed = GetPlayerPed(playerId)
			local plyCoords = GetEntityCoords(plyPed)
			local distance = #(plyCoords - vector3(0,0,0))
			local stringDistance = tostring(distance)
			
			if stringDistance ~= "inf" and stringDistance ~= "infinite" then
				if distance > 30 then
					if ping[tostring(playerId)] ~= 0 then
						ping[tostring(playerId)] = ping[tostring(playerId)] - 1
					end
						
					debugPrint("requesting ping..")
					
					TriggerClientEvent("LyxosALS:GetPing", playerId)
					
					if ping[tostring(playerId)] == 0 then
						debugPrint("Ping timeout, kicking..")
						DropPlayer(playerId, Lyxos.KickMessage)
						
						LyxosLog.Log(playerId)
					end
				end
			end
		end
		Wait(Lyxos.Timer or 1000)
	end
end)
