Citizen.CreateThread(function()
	function checkVersion(err, responseText, headers)
		curVersion = LoadResourceFile(GetCurrentResourceName(), "version")
		if curVersion == nil then
			print(
				"^5epyi_administration ^4It looks like your ressource's version checker is broken. If you want to patch this, go download an official release of this script at -- > https://github.com/epyis-scripts/epyi_administration^0"
			)
			return
		end
		if responseText == nil then
			print(
				"^5epyi_administration ^4It looks like github is offline. The resource uses github to check if it's up to date. This does not prevent the resource from working.^0"
			)
			return
		end
		if curVersion:gsub("%s+", "") ~= responseText:gsub("%s+", "") then
			print(
				"^5epyi_administration ^4is not up to date. The latest release is "
					.. responseText
					.. " but you are on release "
					.. curVersion
					.. " → https://github.com/epyis-scripts/epyi_administration^0"
			)
		end
	end
	PerformHttpRequest(
		"https://raw.githubusercontent.com/epyis-scripts/epyi_administration/main/version",
		checkVersion,
		"GET"
	)
end)
