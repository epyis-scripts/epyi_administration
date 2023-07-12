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
