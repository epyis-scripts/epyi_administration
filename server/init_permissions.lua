---loadGroupPermissions → set group's permissions with the configuration
---@param group string
---@return void
local function setGroupPermissions(group)
	for k, v in pairs(Config.Groups[group].Access) do
		ExecuteCommand(("add_ace group.%s admin_menu.%s %s"):format(group, k, v))
	end
end

-- Permissions initialization
-- init the permissions to add them to the ACE permission system
Citizen.CreateThread(function()
	for k, _ in pairs(Config.Groups) do
		setGroupPermissions(k)
	end
end)
