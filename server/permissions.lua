---getPlayerGroup → get the staff group of a player
---@return group
ESX.RegisterServerCallback("epyi_administration:getPlayerGroup", function(source, cb, target)
	local xTarget = ESX.GetPlayerFromId(target)
	local group = xTarget.getGroup()
	cb(group)
end)

---hasPermission → check if player has permission
---@return boolean
ESX.RegisterServerCallback("epyi_administration:hasPermission", function(source, cb, permission)
	if IsPlayerAceAllowed(source, "admin_menu." .. permission) then
		cb(true)
		return
	end
	cb(false)
end)
