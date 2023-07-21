---main_players_interact_showContentThisFrame → Function to show the main/players/interact menu content
---@param playerGroup string
---@return void
function main_players_interact_showContentThisFrame(playerGroup)
	Citizen.CreateThread(function()
		if _var.activeThreads.getPlayers then
			return
		end
		_var.activeThreads.getPlayers = true
		_var.client.playerData = ESX.GetPlayerData()
		ESX.TriggerServerCallback("epyi_administration:getPlayers", function(players)
			_var.players.list = players
			for _k, player in pairs(_var.players.list) do
				if player.identifier == _var.players.selected.identifier then
					_var.players.selected = player
				end
			end
		end, _var.client.playerData.identifier)
		Citizen.Wait(500)
		_var.activeThreads.getPlayers = false
	end)
	local player = _var.players.selected
	local playerAccounts = {}
	for _k, account in pairs(player.accounts) do
		playerAccounts[account.name] = account.money
	end
	local group = _U("invalid")
	if Config.Groups[player.group] ~= nil then
		group = Config.Groups[player.group].Color .. Config.Groups[player.group].Label
	end
	RageUI.Separator(
		_U(
			"main_players_interact_ooc_name",
			GetPlayerName(GetPlayerFromServerId(player.source)) .. " ~s~[" .. group .. "~s~]"
		)
	)
	RageUI.Separator(_U("main_players_interact_rp_name", player.name))
	RageUI.List(
		_U("main_players_interact_money_bank", playerAccounts["bank"]),
		_var.menu.accountsActionsArray,
		_var.menu.accountsActionsArrayIndex,
		_U("main_players_interact_money_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_players_interact_managemoney"] and not _var.menu.cooldownStatus,
		function(_h, _a, Selected, Index)
			_var.menu.accountsActionsArrayIndex = Index
			if Selected then
				Citizen.CreateThread(function()
					_var.menu.cooldownStatus = true
					local amount = textEntry(_U("textentry_amount"), "", 9)
					if amount == nil or amount == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if string.find(amount, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_add")
					then
						TriggerServerEvent(
							"epyi_administration:addPlayerMoney",
							player.source,
							"bank",
							tonumber(amount)
						)
					elseif
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_remove")
					then
						TriggerServerEvent(
							"epyi_administration:removePlayerMoney",
							player.source,
							"bank",
							tonumber(amount)
						)
					elseif
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_set")
					then
						TriggerServerEvent(
							"epyi_administration:setPlayerMoney",
							player.source,
							"bank",
							tonumber(amount)
						)
					end
					_var.menu.cooldownStatus = false
				end)
			end
		end
	)
	RageUI.List(
		_U("main_players_interact_money_cash", playerAccounts["money"]),
		_var.menu.accountsActionsArray,
		_var.menu.accountsActionsArrayIndex,
		_U("main_players_interact_money_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_players_interact_managemoney"] and not _var.menu.cooldownStatus,
		function(_h, _a, Selected, Index)
			_var.menu.accountsActionsArrayIndex = Index
			if Selected then
				Citizen.CreateThread(function()
					_var.menu.cooldownStatus = true
					local amount = textEntry(_U("textentry_amount"), "", 9)
					if amount == nil or amount == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if string.find(amount, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_add")
					then
						TriggerServerEvent(
							"epyi_administration:addPlayerMoney",
							player.source,
							"money",
							tonumber(amount)
						)
					elseif
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_remove")
					then
						TriggerServerEvent(
							"epyi_administration:removePlayerMoney",
							player.source,
							"money",
							tonumber(amount)
						)
					elseif
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_set")
					then
						TriggerServerEvent(
							"epyi_administration:setPlayerMoney",
							player.source,
							"money",
							tonumber(amount)
						)
					end
					_var.menu.cooldownStatus = false
				end)
			end
		end
	)
	RageUI.List(
		_U("main_players_interact_money_black", playerAccounts["black_money"]),
		_var.menu.accountsActionsArray,
		_var.menu.accountsActionsArrayIndex,
		_U("main_players_interact_money_desc"),
		{},
		Config.Groups[playerGroup].Access["submenu_players_interact_managemoney"] and not _var.menu.cooldownStatus,
		function(_h, _a, Selected, Index)
			_var.menu.accountsActionsArrayIndex = Index
			if Selected then
				Citizen.CreateThread(function()
					_var.menu.cooldownStatus = true
					local amount = textEntry(_U("textentry_amount"), "", 9)
					if amount == nil or amount == "" then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if string.find(amount, "[%c%p%s%z%a]") then
						ESX.ShowNotification(_U("textentry_number_invalid"))
						_var.menu.cooldownStatus = false
						return
					end
					if
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_add")
					then
						TriggerServerEvent(
							"epyi_administration:addPlayerMoney",
							player.source,
							"black_money",
							tonumber(amount)
						)
					elseif
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_remove")
					then
						TriggerServerEvent(
							"epyi_administration:removePlayerMoney",
							player.source,
							"black_money",
							tonumber(amount)
						)
					elseif
						_var.menu.accountsActionsArray[_var.menu.accountsActionsArrayIndex]
						== _("main_players_interact_money_action_set")
					then
						TriggerServerEvent(
							"epyi_administration:setPlayerMoney",
							player.source,
							"black_money",
							tonumber(amount)
						)
					end
					_var.menu.cooldownStatus = false
				end)
			end
		end
	)
end
