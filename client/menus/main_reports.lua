---main_reports_showContentThisFrame → Function to show the main/reports menu content
---@param playerGroup string
---@return void
function main_reports_showContentThisFrame(playerGroup)
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
	_var.reports.count = 0
	_var.reports.countHiden = 0
	for _k, report in pairs(_var.reports.list) do
		_var.reports.count = _var.reports.count + 1
		if _var.menu.reportsFilterArray[_var.menu.reportsFilterArrayIndex] == _("main_reports_filter_waiting") then
			if report.staff.taken then
				_var.reports.countHiden = _var.reports.countHiden + 1
			end
		elseif _var.menu.reportsFilterArray[_var.menu.reportsFilterArrayIndex] == _("main_reports_filter_taken") then
			if not report.staff.taken then
				_var.reports.countHiden = _var.reports.countHiden + 1
			end
		elseif _var.menu.reportsFilterArray[_var.menu.reportsFilterArrayIndex] == _("main_reports_filter_taken_me") then
			if report.staff.takerIdentifier ~= _var.client.playerData.identifier then
				_var.reports.countHiden = _var.reports.countHiden + 1
			end
		end
	end
	if _var.reports.count > 0 then
		RageUI.List(
			_U("main_reports_filter"),
			_var.menu.reportsFilterArray,
			_var.menu.reportsFilterArrayIndex,
			_U("main_reports_filter_desc"),
			{},
			true,
			function(_h, Active, _s, Index)
				_var.menu.reportsFilterArrayIndex = Index
			end
		)
		RageUI.Separator(_U("main_reports_avalaible", _var.reports.count, _var.reports.countHiden))
	end
	for key, report in pairs(_var.reports.list) do
		local showThisReport = true
		if _var.menu.reportsFilterArray[_var.menu.reportsFilterArrayIndex] == _("main_reports_filter_waiting") then
			if report.staff.taken then
				showThisReport = false
				_var.reports.count = _var.reports.count - 1
			end
		elseif _var.menu.reportsFilterArray[_var.menu.reportsFilterArrayIndex] == _("main_reports_filter_taken") then
			if not report.staff.taken then
				showThisReport = false
				_var.reports.count = _var.reports.count - 1
			end
		elseif _var.menu.reportsFilterArray[_var.menu.reportsFilterArrayIndex] == _("main_reports_filter_taken_me") then
			if report.staff.takerIdentifier ~= _var.client.playerData.identifier then
				showThisReport = false
				_var.reports.count = _var.reports.count - 1
			end
		end
		if showThisReport then
			local group = _U("invalid")
			if Config.Groups[report.user.group] ~= nil then
				group = Config.Groups[report.user.group].Color .. Config.Groups[report.user.group].Label
			end
			RageUI.ButtonWithStyle(
				(report.staff.taken and _U("main_reports_edit_status_taken") or _U("main_reports_edit_status_waiting"))
					.. "~s~ - "
					.. _U("main_reports_edit_by", "~s~" .. report.user.name)
					.. " ["
					.. group
					.. "~s~]",
				_U("main_reports_report_desc", report.user.reason),
				{ RightLabel = "→" },
				true,
				function(_h, _a, Selected)
					if Selected then
						_var.reports.selectedReport = key
					end
				end,
				_var.menus.admin.objects.mainReportsEdit
			)
		end
	end
	if _var.reports.count == 0 then
		RageUI.Separator("")
		RageUI.Separator(_U("main_reports_no_report"))
		RageUI.Separator("")
	end
end
