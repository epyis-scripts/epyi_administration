---getPlayerGroup → get the staff group of a player
---@return group
ESX.RegisterServerCallback("epyi_administration:getPlayerGroup", function(source, cb, target)
	local xTarget = ESX.GetPlayerFromId(target)
	local group = xTarget.getGroup()
	cb(group)
end)
