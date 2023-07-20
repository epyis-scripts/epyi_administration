--report command
--command to create a report
ESX.RegisterCommand("report", "user", function(xPlayer, args, showError)
	local reason = ""
	for _, arg in pairs(args) do
		if reason == "" then
			reason = arg
		else
			reason = reason .. " " .. arg
		end
	end
	if reason == nil or reason == "" then
		reason = _U("command_report_no_reason")
	end
	addReport(xPlayer, reason)
	xPlayer.showNotification(_U("command_report_success", reason))
end, false)

---addReport
---@param xPlayer player
---@param reason string
---@return void
function addReport(xPlayer, reason)
	local report = {
		user = {
			source = xPlayer.source,
			name = xPlayer.getName(),
			identifier = xPlayer.identifier,
            group = xPlayer.getGroup(),
			reason = reason,
		},
		staff = {
			taken = false,
			takerIdentifier = nil,
		},
	}
	table.insert(_var.reports.list, report)
end

---getReports → Get server reports
---@param identifier string
---@return table
ESX.RegisterServerCallback("epyi_administration:getReports", function(source, cb, identifier)
	xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	if not Config.Groups[xPlayer.getGroup()].Access["submenu_reports_access"] then
		cb({})
		xPlayer.kick(_U("insuficient_permissions"))
		return
	end
	cb(_var.reports.list)
end)
