---getUserData → Get a specific user data
---@param identifier string
---@param key string
---@return table
ESX.RegisterServerCallback("epyi_administration:getUserData", function(source, cb, identifier, key)
	TriggerEvent("esx_datastore:getDataStore", "epyi_admin_userdata", identifier, function(store)
		cb(store.get(key) or {})
	end)
end)

---setUserData → Set a specific user data
---@param identifier string
---@param key string
---@param value table
---@return boolean
ESX.RegisterServerCallback("epyi_administration:setUserData", function(source, cb, identifier, key, value)
	if key == nil or value == nil then
		cb(false)
		return
	end
	TriggerEvent("esx_datastore:getDataStore", "epyi_admin_userdata", identifier, function(store)
		store.set(key, value)
		cb(true)
	end)
end)
