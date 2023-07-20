--report command
--command to create a report
ESX.RegisterCommand("report", "user", function(xPlayer, args, showError)
	local reason = ""
	for _, arg in pairs(args) do
		reason = reason .. " " .. arg
	end
	if reason == nil or reason == "" then
		reason = _U("command_report_no_reason")
	end
	xPlayer.showNotification(_U("command_report_success", reason))
end, false)
