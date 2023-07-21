---getPlayers → Get connected players
---@param identifier string
---@return table
ESX.RegisterServerCallback("epyi_administration:getPlayers", function(source, cb, identifier)
	xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	if not Config.Groups[xPlayer.getGroup()] or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_access"] then
		cb({})
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	local players = {}
	local xPlayers = ESX.GetExtendedPlayers()
	for _k, xPlayer in pairs(xPlayers) do
		players[xPlayer.identifier] = {
			identifier = xPlayer.identifier,
			source = xPlayer.source,
			name = xPlayer.getName(),
			group = xPlayer.getGroup(),
			job = xPlayer.getJob(),
			accounts = xPlayer.getAccounts(),
			coords = xPlayer.getCoords(),
			inventory = xPlayer.getInventory(),
		}
	end
	cb(players)
end)
