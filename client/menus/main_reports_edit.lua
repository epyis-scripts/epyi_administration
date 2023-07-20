---main_reports_showContentThisFrame → Function to show the main/personnal menu content
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
			not _var.menu.cooldownStatus,
			function(_h, _a, Selected)
				if Selected then
					_var.menu.cooldownStatus = true
					Citizen.SetTimeout(2000, function()
						_var.menu.cooldownStatus = false
					end)
					_var.client.playerData = ESX.GetPlayerData()
					_var.reports.list[_var.reports.selectedReport].staff.taken = true
					_var.reports.list[_var.reports.selectedReport].staff.takerIdentifier =
						_var.client.playerData.identifier
					_var.reports.list[_var.reports.selectedReport].staff.takerSource = GetPlayerServerId(PlayerId())
					_var.reports.list[_var.reports.selectedReport].staff.takerGroup = playerGroup
					ESX.TriggerServerCallback(
						"epyi_administration:setReport",
						function(result)
							if result then
								ESX.ShowNotification((_U("notif_report_status_take", _var.reports.selectedReport)))
							else
								ESX.ShowNotification(_U("notif_report_editing_error"))
							end
						end,
						_var.client.playerData.identifier,
						_var.reports.selectedReport,
						_var.reports.list[_var.reports.selectedReport]
					)
					ESX.TriggerServerCallback("epyi_administration:getReports", function(reports)
						_var.reports.list = reports
					end, _var.client.playerData.identifier)
				end
			end
		)
	elseif _var.reports.list[_var.reports.selectedReport].staff.taken then
		RageUI.ButtonWithStyle(
			_U("main_reports_edit_leave"),
			_U("main_reports_report_desc", _var.reports.list[_var.reports.selectedReport].user.reason),
			{},
			not _var.menu.cooldownStatus
				and _var.reports.list[_var.reports.selectedReport].staff.takerIdentifier
					== _var.client.playerData.identifier,
			function(_h, _a, Selected)
				if Selected then
					_var.menu.cooldownStatus = true
					Citizen.SetTimeout(2000, function()
						_var.menu.cooldownStatus = false
					end)
					_var.client.playerData = ESX.GetPlayerData()
					_var.reports.list[_var.reports.selectedReport].staff.taken = false
					_var.reports.list[_var.reports.selectedReport].staff.takerIdentifier = nil
					_var.reports.list[_var.reports.selectedReport].staff.takerSource = nil
					_var.reports.list[_var.reports.selectedReport].staff.takerGroup = nil
					ESX.TriggerServerCallback(
						"epyi_administration:setReport",
						function(result)
							if result then
								ESX.ShowNotification((_U("notif_report_status_leave", _var.reports.selectedReport)))
							else
								ESX.ShowNotification(_U("notif_report_editing_error"))
							end
						end,
						_var.client.playerData.identifier,
						_var.reports.selectedReport,
						_var.reports.list[_var.reports.selectedReport]
					)
					ESX.TriggerServerCallback("epyi_administration:getReports", function(reports)
						_var.reports.list = reports
					end, _var.client.playerData.identifier)
				end
			end
		)
	end
	RageUI.ButtonWithStyle(
		_U("main_reports_edit_goto"),
		_U("main_reports_report_desc", _var.reports.list[_var.reports.selectedReport].user.reason),
		{ RightLabel = "→" },
		true,
		function(_h, _a, Selected)
			if Selected then
				local userPed =
					GetPlayerPed(GetPlayerFromServerId(_var.reports.list[_var.reports.selectedReport].user.source))
				local userPedCoords = GetEntityCoords(userPed)
				local staffPed = PlayerPedId()
				SetEntityCoords(staffPed, userPedCoords, false)
				ESX.ShowNotification(_U("notif_goto_success", _var.reports.list[_var.reports.selectedReport].user.name))
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_reports_edit_bring"),
		_U("main_reports_report_desc", _var.reports.list[_var.reports.selectedReport].user.reason),
		{ RightLabel = "→" },
		true,
		function(_h, _a, Selected)
			if Selected then
				local userPed =
					GetPlayerPed(GetPlayerFromServerId(_var.reports.list[_var.reports.selectedReport].user.source))
				local staffPed = PlayerPedId()
				local staffPedCoords = GetEntityCoords(staffPed)
				SetEntityCoords(userPed, staffPedCoords, false)
				ESX.ShowNotification(
					_U("notif_bring_success", _var.reports.list[_var.reports.selectedReport].user.name)
				)
			end
		end
	)
	RageUI.ButtonWithStyle(
		_U("main_reports_edit_delete"),
		_U("main_reports_edit_delete_desc"),
		{ RightLabel = "→", Color = { BackgroundColor = { 150, 50, 50, 20 } } },
		true,
		function(_h, _a, Selected)
			if Selected then
				_var.reports.list[_var.reports.selectedReport] = nil
				_var.client.playerData = ESX.GetPlayerData()
				ESX.TriggerServerCallback(
					"epyi_administration:setReport",
					function(result)
						if result then
							ESX.ShowNotification((_U("notif_report_delete_success", _var.reports.selectedReport)))
						else
							ESX.ShowNotification(_U("notif_report_editing_error"))
						end
					end,
					_var.client.playerData.identifier,
					_var.reports.selectedReport,
					_var.reports.list[_var.reports.selectedReport]
				)
			end
		end,
		RMenu:Get("epyi_administration", "main_reports")
	)
end