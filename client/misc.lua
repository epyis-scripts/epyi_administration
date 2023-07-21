---revivePed → Revive a ped
---@param ped ped
---@return void
function revivePed(ped)
	local coords = GetEntityCoords(ped)
	DoScreenFadeOut(800)
	while not IsScreenFadedOut() do
		Wait(50)
	end
	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1),
	}
	SetEntityCoordsNoOffset(ped, formattedCoords.x, formattedCoords.y, formattedCoords.z, false, false, false)
	NetworkResurrectLocalPlayer(formattedCoords.x, formattedCoords.y, formattedCoords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
	TriggerEvent("esx_basicneeds:resetStatus")
	TriggerServerEvent("esx:onPlayerSpawn")
	TriggerEvent("esx:onPlayerSpawn")
	TriggerEvent("playerSpawned")
	ClearTimecycleModifier()
	SetPedMotionBlur(ped, false)
	ClearExtraTimecycleModifier()
	DoScreenFadeIn(800)
end

---stopAllThreads → Set all threads to disable mode
---@return void
function stopAllThreads()
	for k, _ in pairs(_threads) do
		_threads[k].disable()
	end
end

---leaveAllReports → Leave all reports taken by client
---@return void
function leaveAllReports()
	_var.client.playerData = ESX.GetPlayerData()
	ESX.TriggerServerCallback("epyi_administration:getReports", function(reports)
		_var.reports.list = reports
		for key, report in pairs(_var.reports.list) do
			if report.staff.takerIdentifier == _var.client.playerData.identifier then
				report.staff.taken = false
				report.staff.takerIdentifier = nil
				report.staff.takerSource = nil
				report.staff.takerGroup = nil
				ESX.TriggerServerCallback("epyi_administration:setReport", function(result)
					if not result then
						ESX.ShowNotification(_U("notif_report_editing_error"))
					end
				end, _var.client.playerData.identifier, key, _var.reports.list[key])
			end
		end
	end, _var.client.playerData.identifier)
end

---textEntry → Open a popup to write some text
---@param textEntry string
---@param inputText string
---@param maxLength integer
---@return string
function textEntry(textEntry, inputText, maxLength)
	AddTextEntry("FMMC_KEY_TIP1", textEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(1.0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		return result
	else
		Citizen.Wait(500)
		return nil
	end
end

---syncWeather → Set weather (used by the server to sync weather)
---@param weather string
---@param blackout boolean
---@return void
RegisterNetEvent("epyi_administration:syncWeather")
AddEventHandler("epyi_administration:syncWeather", function(weather, blackout, time)
	_var.menu.blackoutCheckbox = blackout
	SetArtificialLightsState(blackout)
	SetArtificialLightsStateAffectsVehicles(false)
	for key, weather in pairs(_var.menu.weatherArray) do
		if _var.menu.weatherArray[_var.menu.weatherArrayIndex] == weather then
			_var.menu.weatherArrayIndex = key
		end
	end
	SetWeatherTypeOverTime(weather, 0.0)
	ClearOverrideWeather()
	ClearWeatherTypePersist()
	SetWeatherTypePersist(weather)
	SetWeatherTypeNow(weather)
	SetWeatherTypeNowPersist(weather)
	NetworkOverrideClockTime(time, 0, 0)
end)
