AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
	local license = GetPlayerIdentifierByType(source, "license")
	local identifier = string.gsub(license, "license:", "")
	local _source = source
	local banData = {}
	deferrals.defer()
	deferrals.update(_U("deffer_ban_checker"))
	Citizen.Wait(0)
	TriggerEvent("esx_datastore:getDataStore", "epyi_admin_userdata", identifier, function(store)
		if store == nil then
			logToConsole("Player with identifier " .. identifier .. " is currently logging for the first time")
			deferrals.done()
			return
		end
		banData = store.get("ban_status") or {}
		if banData == {} then
			deferrals.done()
		end
		if banData.isBanned then
			if banData.banExpiration <= os.time() then
				local datastore = {
					isBanned = false,
					banDuration = nil,
					banExpiration = nil,
					banReason = nil,
				}
				TriggerEvent("esx_datastore:getDataStore", "epyi_admin_userdata", identifier, function(store)
					store.set("ban_status", datastore)
				end)
				deferrals.done()
				logToConsole(
					"Player with identifier "
						.. identifier
						.. " is currently logging in for the first time since his last ban."
				)
			else
				local reason = _U(
					"notif_ban_target",
					banData.banReason,
					banData.banDuration,
					os.date("Month: %m, Day: %d, Year: %Y", banData.expiration)
				)
				deferrals.done(reason)
				logToConsole("Player with identifier " .. identifier .. " tried to connect but he is banned")
			end
		else
			local datastore = {
				isBanned = false,
				banDuration = nil,
				banExpiration = nil,
				banReason = nil,
			}
			TriggerEvent("esx_datastore:getDataStore", "epyi_admin_userdata", identifier, function(store)
				store.set("ban_status", datastore)
			end)
			deferrals.done()
		end
	end)
end)
