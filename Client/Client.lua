AddEventHandler('onClientMapStart', function()
	Citizen.Wait(1250)
    TriggerServerEvent("mlrpAntiLagSwitch:clientAdded")
end)

RegisterNetEvent('mlrpAntiLagSwitch:check')
AddEventHandler('mlrpAntiLagSwitch:check', function()
    TriggerServerEvent("mlrpAntiLagSwitch:setStatus")
end)

--[[
- Created by zImSkillz
- Created at 12:43 GMT+1
- DD/MM/YYYY
- 19.12.2022
]]--