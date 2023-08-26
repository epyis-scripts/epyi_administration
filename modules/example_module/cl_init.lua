local module_name = "example_module"

modules.registerClientModule(module_name, {
    INFO = {
        name = module_name,
        version = "1.0.0"
    },
    EXECUTE = function()
        -- modules.executeInsideMenuThread("main/", function()
        --     RageUI.ButtonWithStyle("Example", "This an injected button example", {}, true, function(_h, _a, _s)
        --     end)
        -- end)
    end,
})