modules = { list = {} }

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
end
