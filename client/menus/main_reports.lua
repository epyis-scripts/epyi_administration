---main_reports_showContentThisFrame → Function to show the main/personnal menu content
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
	for key, report in pairs(_var.reports.list) do
		_var.reports.count = _var.reports.count + 1
		local group = _U("invalid")
		if Config.Groups[report.user.group] ~= nil then
			group = Config.Groups[report.user.group].Color .. Config.Groups[report.user.group].Label
		end
		RageUI.ButtonWithStyle(
			report.user.name .. " [" .. group .. "~s~]",
			_U("main_reports_report_desc", report.user.reason),
			{},
			true,
			function(_h, _a, _s) end
		)
	end
    if _var.reports.count == 0 then
        RageUI.Separator("")
        RageUI.Separator(_U("main_reports_no_report"))
        RageUI.Separator("")
    end
end
