---main_reports_edit_showContentThisFrame → Function to show the main/reports/edit menu content
---@param playerGroup string
---@return void
function main_reports_edit_showContentThisFrame(playerGroup)
	local group = _U("invalid")
	if Config.Groups[_var.reports.list[_var.reports.selectedReport].user.group] ~= nil then
		group = Config.Groups[_var.reports.list[_var.reports.selectedReport].user.group].Color
			.. Config.Groups[_var.reports.list[_var.reports.selectedReport].user.group].Label
	end
	Citizen.CreateThread(function()
		if _var.activeThreads.getReports then
			return
		end
		_var.activeThreads.getReports = true
		_var.client.playerData = ESX.GetPlayerData()
		ESX.TriggerServerCallback("epyi_administration:getReports", function(reports)
			_var.reports.list = reports
		end, _var.client.playerData.identifier)
		Citizen.Wait(500)
		_var.activeThreads.getReports = false
	end)
	if _var.reports.list[_var.reports.selectedReport] == nil then
		RageUI.CloseAll()
		ESX.ShowNotification("notif_report_watching_deleted")
	end
	local targetisLower = true
	if
		Config.Groups[playerGroup] ~= nil
		and Config.Groups[_var.reports.list[_var.reports.selectedReport].user.group] ~= nil
		and Config.Groups[_var.reports.list[_var.reports.selectedReport].user.group].Priority
			> Config.Groups[playerGroup].Priority
	then
		targetisLower = false
	end
	RageUI.Separator("")
	RageUI.Separator(
		_U(
			"main_reports_edit_by",
			_var.reports.list[_var.reports.selectedReport].user.name
				.. "~s~ ["
				.. group
				.. "~s~] - "
				.. _U("main_reports_edit_by_id", _var.reports.list[_var.reports.selectedReport].user.source)
		)
	)
	RageUI.Separator(
		_U(
			"main_reports_edit_status",
			(
				_var.reports.list[_var.reports.selectedReport].staff.taken and _U("main_reports_edit_status_taken")
				or _U("main_reports_edit_status_waiting")
			)
		)
	)
	if _var.reports.list[_var.reports.selectedReport].staff.taken then
		if
			_var.reports.list[_var.reports.selectedReport].staff.takerIdentifier ~= nil
			and _var.reports.list[_var.reports.selectedReport].staff.takerSource ~= nil
		then
			local takerGroup = _U("invalid")
			if Config.Groups[_var.reports.list[_var.reports.selectedReport].staff.takerGroup] ~= nil then
				takerGroup = Config.Groups[_var.reports.list[_var.reports.selectedReport].staff.takerGroup].Color
					.. Config.Groups[_var.reports.list[_var.reports.selectedReport].staff.takerGroup].Label
			end
			RageUI.Separator(
				_U(
					"main_reports_edit_taker",
					GetPlayerName(
						GetPlayerFromServerId(_var.reports.list[_var.reports.selectedReport].staff.takerSource)
					)
						.. " ~s~["
						.. takerGroup
						.. "~s~] - "
						.. _U(
							"main_reports_edit_by_id",
							_var.reports.list[_var.reports.selectedReport].staff.takerSource
						)
				)
			)
		end
	else
		RageUI.Separator(_U("main_reports_edit_taker", _U("nobody")))
	end
	RageUI.Separator("")
	if not _var.reports.list[_var.reports.selectedReport].staff.taken then
		RageUI.ButtonWithStyle(
			_U("main_reports_edit_take"),
			_U("main_reports_report_desc", _var.reports.list[_var.reports.selectedReport].user.reason),
			{},
			not _var.menus.admin.cooldowns.items,
			function(_h, _a, Selected)
				if Selected then
					_var.menus.admin.cooldowns.items = true
					_var.client.playerData = ESX.GetPlayerData()
					local editedReport = _var.reports.list[_var.reports.selectedReport]
					editedReport.staff.taken = true
					editedReport.staff.takerIdentifier = _var.client.playerData.identifier
					editedReport.staff.takerSource = GetPlayerServerId(PlayerId())
					editedReport.staff.takerGroup = playerGroup
					ESX.TriggerServerCallback(
						"epyi_administration:setReport",
						function(result)
							if result then
								ESX.ShowNotification((_U("notif_report_status_take", _var.reports.selectedReport)))
								ESX.TriggerServerCallback("epyi_administration:getReports", function(reports)
									_var.reports.list = reports
									_var.menus.admin.cooldowns.items = false
								end, _var.client.playerData.identifier)
							else
								ESX.ShowNotification(_U("notif_report_editing_error"))
								_var.menus.admin.cooldowns.items = false
							end
						end,
						_var.client.playerData.identifier,
						_var.reports.selectedReport,
						editedReport
					)
				end
			end
		)
	elseif _var.reports.list[_var.reports.selectedReport].staff.taken then
		RageUI.ButtonWithStyle(
			_U("main_reports_edit_leave"),
			_U("main_reports_report_desc", _var.reports.list[_var.reports.selectedReport].user.reason),
			{},
			not _var.menus.admin.cooldowns.items
				and _var.reports.list[_var.reports.selectedReport].staff.takerIdentifier
					== _var.client.playerData.identifier,
			function(_h, _a, Selected)
				if Selected then
					_var.menus.admin.cooldowns.items = true
					_var.client.playerData = ESX.GetPlayerData()
					local editedReport = _var.reports.list[_var.reports.selectedReport]
					editedReport.staff.taken = false
					editedReport.staff.takerIdentifier = nil
					editedReport.staff.takerSource = nil
					editedReport.staff.takerGroup = nil
					ESX.TriggerServerCallback(
						"epyi_administration:setReport",
						function(result)
							if result then
								ESX.ShowNotification((_U("notif_report_status_leave", _var.reports.selectedReport)))
								ESX.TriggerServerCallback("epyi_administration:getReports", function(reports)
									_var.reports.list = reports
									_var.menus.admin.cooldowns.items = false
								end, _var.client.playerData.identifier)
							else
								ESX.ShowNotification(_U("notif_report_editing_error"))
								_var.menus.admin.cooldowns.items = false
							end
						end,
						_var.client.playerData.identifier,
						_var.reports.selectedReport,
						editedReport
					)
				end
			end
		)
	end
	RageUI.ButtonWithStyle(
		_U("main_reports_edit_goto"),
		_U("main_reports_report_desc", _var.reports.list[_var.reports.selectedReport].user.reason),
		{},
		not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected)
			if Selected then
				Citizen.CreateThread(function()
					_var.menus.admin.cooldowns.items = true
					ESX.TriggerServerCallback("epyi_administration:setCoords", function(result)
						if not result then
							_var.menus.admin.cooldowns.items = false
							return
						end
						ESX.ShowNotification(_U("notif_goto_success", _var.reports.list[_var.reports.selectedReport].user.name))
						_var.menus.admin.cooldowns.items = false
					end, GetPlayerServerId(PlayerId()), _var.reports.list[_var.reports.selectedReport].user.coords)
				end)
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_reports_edit_bring"),
		_U("main_reports_report_desc", _var.reports.list[_var.reports.selectedReport].user.reason),
		{},
		not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected)
			if Selected then
				Citizen.CreateThread(function()
					_var.menus.admin.cooldowns.items = true
					ESX.TriggerServerCallback("epyi_administration:setCoords", function(result)
						if not result then
							_var.menus.admin.cooldowns.items = false
							return
						end
						ESX.ShowNotification(_U("notif_bring_success", _var.reports.list[_var.reports.selectedReport].user.name))
						_var.menus.admin.cooldowns.items = false
					end, _var.reports.list[_var.reports.selectedReport].user.source, GetEntityCoords(PlayerPedId()))
				end)
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_reports_edit_advanced"),
		_U("main_reports_report_desc", _var.reports.list[_var.reports.selectedReport].user.reason),
		{},
		Config.Groups[playerGroup].Access["submenu_players_interact"]
			and (Config.Groups[playerGroup].Access["submenu_players_interact_highergroup"] and true or targetisLower) and not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected)
			if Selected then
				local canSkip = false
				_var.client.playerData = ESX.GetPlayerData()
				ESX.TriggerServerCallback("epyi_administration:getPlayers", function(players)
					_var.players.list = players
					for _k, player in pairs(_var.players.list) do
						if player.identifier == _var.reports.list[_var.reports.selectedReport].user.identifier then
							_var.players.selected = player
						end
					end
					canSkip = true
				end, _var.client.playerData.identifier)
				while not canSkip do
					Citizen.Wait(1)
				end
			end
		end,
		_var.menus.admin.objects.mainReportsEditAdvanced
	)
	RageUI.ButtonWithStyle(
		_U("main_reports_edit_delete"),
		_U("main_reports_edit_delete_desc"),
		{ Color = { BackgroundColor = { 150, 50, 50, 20 } } },
		not _var.menus.admin.cooldowns.items,
		function(_h, _a, Selected)
			if Selected then
				local canSkip = false
				_var.client.playerData = ESX.GetPlayerData()
				ESX.TriggerServerCallback(
					"epyi_administration:setReport",
					function(result)
						if result then
							ESX.ShowNotification((_U("notif_report_delete_success", _var.reports.selectedReport)))
							ESX.TriggerServerCallback("epyi_administration:getReports", function(reports)
								_var.reports.list = reports
								canSkip = true
							end, _var.client.playerData.identifier)
						else
							ESX.ShowNotification(_U("notif_report_editing_error"))
							canSkip = true
						end
					end,
					_var.client.playerData.identifier,
					_var.reports.selectedReport,
					nil
				)
				while not canSkip do
					Citizen.Wait(1)
				end
			end
		end,
		_var.menus.admin.objects.mainReports
	)
end
