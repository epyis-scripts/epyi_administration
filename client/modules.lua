modules = { list = {}, menus = {}, injectors = {} }

---modules.registerClientModule
---@param name string
---@param data table
---@return void
modules.registerClientModule = function(name, data)
	if not name or not data or type(name) ~= "string" or type(data) ~= "table" then
		logToConsole("ERROR: An error occurred while registering a module")
		return
	end
	if modules.list[name] then
		logToConsole("ERROR: You are trying to use the same module twice")
		return
	end
	modules.list[name] = data
	modules.list[name].EXECUTE()
end

---modules.executeInsideMenuThread
---@param menuPath string
---@param instructions function
---@return void
modules.executeInsideMenuThread = function(menuPath, instructions)
	modules.injectors[#modules.injectors + 1] = {
		path = menuPath,
		inject = instructions,
	}
end
