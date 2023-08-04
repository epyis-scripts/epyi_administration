---changeWeatherOrBlackout
---@param weather string
---@param blackout boolean
---@return void
RegisterNetEvent("epyi_administration:changeWeatherOrBlackout")
AddEventHandler("epyi_administration:changeWeatherOrBlackout", function(weather, blackout, time)
	_var.weather = weather
	_var.blackout = blackout
	_var.time = tonumber(time)
	TriggerClientEvent("epyi_administration:syncWeather", -1, _var.weather, _var.blackout, _var.time)
end)

-- Thread to sync the weather on player loggin
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for key, identifier in pairs(_var.syncedWeatherBlackoutPlayers) do
			local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
			if not xPlayer then
				table.remove(_var.syncedWeatherBlackoutPlayers, key)
				logToConsole("Disable weather/time sync for player with identifier: " .. identifier)
			end
		end
		local xPlayers = ESX.GetExtendedPlayers()
		for _k, xPlayer in pairs(xPlayers) do
			local isSynced = false
			for __k, __identifier in pairs(_var.syncedWeatherBlackoutPlayers) do
				if __identifier == xPlayer.identifier then
					isSynced = true
				end
			end
			if not isSynced then
				table.insert(_var.syncedWeatherBlackoutPlayers, xPlayer.identifier)
				TriggerClientEvent(
					"epyi_administration:syncWeather",
					xPlayer.source,
					_var.weather,
					_var.blackout,
					_var.time
				)
				logToConsole("Enable weather/time sync for player with identifier: " .. xPlayer.identifier)
			end
		end
	end
end)
