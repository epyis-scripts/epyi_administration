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
