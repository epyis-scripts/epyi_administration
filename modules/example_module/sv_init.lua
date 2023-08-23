local module_name = "example_module"

modules.registerServerModule(module_name, {
    INFO = {
        name = module_name,
        version = "1.0.0"
    },
    EXECUTE = function()
        -- body
    end,
})