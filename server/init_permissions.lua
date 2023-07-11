---loadGroupPermissions → set group's permissions with the configuration
---@param group string
---@return void
local function setGroupPermissions(group)
	for k, v in pairs(Config.Groups[group].Access) do
		local values = { "allow", "deny" }
        for _,v in pairs (values) do ExecuteCommand(("remove_ace group.%s epyi_administration.%s %s"):format(group, k, v))end
		ExecuteCommand(("add_ace group.%s epyi_administration.%s %s"):format(group, k, v))
	end
end

-- Permissions initialization
-- init the permissions to add them to the ACE permission system
Citizen.CreateThread(function()
	for k, _ in pairs(Config.Groups) do
		setGroupPermissions(k)
	end
end)

RegisterCommand("check", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local idenfier = xPlayer.identifier
    print(idenfier)
    ExecuteCommand(('remove_principal identifier.%s group.admin'):format(idenfier))
    ExecuteCommand("remove_ace group.admin epyi_administration.mainmenu_open allow")
    ExecuteCommand("remove_ace group.admin epyi_administration.mainmenu_open deny")
    ExecuteCommand("add_ace group.admin epyi_administration.mainmenu_open allow")
    ExecuteCommand(('add_principal identifier.%s group.admin'):format(idenfier))
    if IsPlayerAceAllowed(source, "epyi_administration.mainmenu_open") then
		print("allowed")
	else
        print("not allowed")
    end
end, false)
