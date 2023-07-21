---getPlayers → Get connected players
---@param identifier string
---@return table
ESX.RegisterServerCallback("epyi_administration:getPlayers", function(source, cb, identifier)
	xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	if
		not Config.Groups[xPlayer.getGroup()] or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_access"]
	then
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

RegisterNetEvent("epyi_administration:addPlayerMoney")
AddEventHandler("epyi_administration:addPlayerMoney", function(target, type, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if
		not Config.Groups[xPlayer.getGroup()]
		or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_interact_managemoney"]
	then
		cb({})
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	local xTarget = ESX.GetPlayerFromId(target)
	if not xTarget or not amount or not type then
		xPlayer.showNotification(_U("notif_error"))
		return
	end
	xTarget.addAccountMoney(type, amount)
	xPlayer.showNotification(_U("notif_addmoney_success", amount))
end)

RegisterNetEvent("epyi_administration:removePlayerMoney")
AddEventHandler("epyi_administration:removePlayerMoney", function(target, type, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if
		not Config.Groups[xPlayer.getGroup()]
		or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_interact_managemoney"]
	then
		cb({})
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	local xTarget = ESX.GetPlayerFromId(target)
	if not xTarget or not amount or not type then
		xPlayer.showNotification(_U("notif_error"))
		return
	end
	if xTarget.getAccount(type).money < amount then
		xPlayer.showNotification(_U("notif_amount_too_much"))
		return
	end
	xPlayer.removeAccountMoney(type, amount)
	xPlayer.showNotification(_U("notif_removemoney_success", amount))
end)

RegisterNetEvent("epyi_administration:setPlayerMoney")
AddEventHandler("epyi_administration:setPlayerMoney", function(target, type, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if
		not Config.Groups[xPlayer.getGroup()]
		or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_interact_managemoney"]
	then
		cb({})
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	local xTarget = ESX.GetPlayerFromId(target)
	if not xTarget or not amount or not type then
		xPlayer.showNotification(_U("notif_error"))
		return
	end
	xTarget.setAccountMoney(type, tonumber(amount))
	xPlayer.showNotification(_U("notif_setmoney_success", amount))
end)
