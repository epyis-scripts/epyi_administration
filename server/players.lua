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

RegisterNetEvent("epyi_administration:sendMessage")
AddEventHandler("epyi_administration:sendMessage", function(target, message)
	local xPlayer = ESX.GetPlayerFromId(source)
	if
		not Config.Groups[xPlayer.getGroup()]
		or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_interact_dm"]
	then
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	local xTarget = ESX.GetPlayerFromId(target)
	if not xTarget or not message then
		xPlayer.showNotification(_U("notif_error"))
		return
	end
	xTarget.showNotification(_U("notif_dm_from_staff", message))
	xPlayer.showNotification(_U("notif_dm_send_success", xTarget.getName()))
end)

RegisterNetEvent("epyi_administration:kickPlayer")
AddEventHandler("epyi_administration:kickPlayer", function(target, reason)
	local xPlayer = ESX.GetPlayerFromId(source)
	if
		not Config.Groups[xPlayer.getGroup()]
		or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_interact_kick"]
	then
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	local xTarget = ESX.GetPlayerFromId(target)
	if not xTarget or not reason then
		xPlayer.showNotification(_U("notif_error"))
		return
	end
	xPlayer.showNotification(_U("notif_kick_success", xTarget.getName()))
	logToConsole(
		"Player "
			.. xPlayer.getName()
			.. " (Identifier: "
			.. xPlayer.identifier
			.. ") has kicked "
			.. xTarget.getName()
			.. " (Identifier: "
			.. xTarget.identifier
			.. ") for the reason '"
			.. reason
			.. "'"
	)
	xTarget.kick(_U("notif_kick_target", reason))
end)

RegisterNetEvent("epyi_administration:banPlayer")
AddEventHandler("epyi_administration:banPlayer", function(target, reason, duration)
	local xPlayer = ESX.GetPlayerFromId(source)
	if
		not Config.Groups[xPlayer.getGroup()]
		or not Config.Groups[xPlayer.getGroup()].Access["submenu_players_interact_ban"]
	then
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	local xTarget = ESX.GetPlayerFromId(target)
	if not xTarget or not reason or not duration then
		xPlayer.showNotification(_U("notif_error"))
		return
	end
	xPlayer.showNotification(_U("notif_ban_success", xTarget.getName()))
	local expiration = os.time() + (duration * 86400)
	local datastore = {
		isBanned = true,
		banDuration = duration,
		banExpiration = expiration,
		banReason = reason,
	}
	TriggerEvent("esx_datastore:getDataStore", "epyi_admin_userdata", xTarget.identifier, function(store)
		store.set("ban_status", datastore)
	end)
	logToConsole(
		"Player "
			.. xPlayer.getName()
			.. " (Identifier: "
			.. xPlayer.identifier
			.. ") has banned "
			.. xTarget.getName()
			.. " (Identifier: "
			.. xTarget.identifier
			.. ") for the reason '"
			.. reason
			.. "' during "
			.. duration
			.. " days"
	)
	xTarget.kick(_U("notif_ban_target", reason, duration, os.date("Month: %m, Day: %d, Year: %Y", expiration)))
end)
