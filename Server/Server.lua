function printDebug(...)
    if AntiLagSwitch.Debug then
        print("[DEBUG] " .. ...)
    end
end

function GetPlayerIndetifiers(source)
	local identifier = "no info"
	local license   = "no info"
	local liveid    = "no info"
	local xblid     = "no info"
	local discord   = "no info"
	local playerip = "no info"
	local name = GetPlayerName(source)

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			identifier = v
		elseif string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end
	
	return "**Player: **" .. GetPlayerName(source) .. "\n**License: **" .. license .. "\n**Discord: **" .. discord .. "\n**live: **" .. liveid .. "\n**XBL: **" .. xblid .. "\n**IP: **" .. playerip .. "\n **identifier: **" .. identifier
end

inCheckLoop = {}

function checkIsInLoop(source, firstTime)
    local firstTime = firstTime
    players = GetPlayers()
    for k, v in ipairs(players) do
        local token = GetPlayerToken(v, 0)
        if token == GetPlayerToken(source, 0) then
            printDebug("Checking..")
            if not firstTime then
                inCheckLoop[source] = false
            end
            TriggerClientEvent("mlrpAntiLagSwitch:check", source)
            Wait(1250)
            if not inCheckLoop[source] then
                -- If Lagswitch
                if AntiLagSwitch.ConsoleNotifyLog then
                    print("^0[^5AntiLagSwitch^0] ^1LagSwitch Detected: ^5" .. GetPlayerName(source) .. " ^0| ^1HWID: ^5" .. token .. "^0    ")
                end

                if AntiLagSwitch.DiscordNotify then
                    local Content = {
                        {
                            ["author"] = {
                                ["name"] = "ANTI LAG SWITCH",
                                ["icon_url"] = "https://cdn.discordapp.com/avatars/813300902836043797/fef40224ddb6cd22c868098d28b34f57.png?size=512"
                            },
                            ["color"] = "16711680",
                            ["description"] = "**Player Kicked**\n" .. GetPlayerIndetifiers(source) .. "\n**Reason: **" .. "Anti Lag Switch \n\nhttps://github.com/zImSkillz/",
                            ["footer"] = {
                                ["text"] = "Made By zImSkillz#0001",
                                ["icon_url"] = "https://cdn.discordapp.com/avatars/813300902836043797/fef40224ddb6cd22c868098d28b34f57.png?size=512"
                            }
                        }
                    }
                    PerformHttpRequest(AntiLagSwitch.DiscordWebhook, function(err, text, headers) end, "POST", json.encode({username = "Anti Lag Switch", embeds = Content}), {["Content-Type"] = "application/json"})
                end

                if AntiLagSwitch.KickOnDetect then
                    DropPlayer(source, 'You got kicked by our Anti Lag Switch!')
                end

                printDebug("LagSwitch: " .. source .. " | HWID: " .. token)
            else
                printDebug("No LagSwitch")
                Wait(1000)
                checkIsInLoop(source, false)
            end
        end
    end
end

RegisterNetEvent('mlrpAntiLagSwitch:clientAdded')
AddEventHandler('mlrpAntiLagSwitch:clientAdded', function()
    checkIsInLoop(source, true)
    printDebug("added player to loop")
end)

RegisterNetEvent('mlrpAntiLagSwitch:setStatus')
AddEventHandler('mlrpAntiLagSwitch:setStatus', function()
    inCheckLoop[source] = true
    printDebug("update heartbeat")
end)

--[[
- Created by zImSkillz
- Created at 12:43 GMT+1
- DD/MM/YYYY
- 19.12.2022
]]--