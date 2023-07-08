-- Key registering
-- register the key to open the administration menu
Keys.Register(Config.Keys.Menu, "-openAdminMenu", Translate("keys_menu_description"), function()
    openMenu()
end)

-- Key registering
-- register the key to use the noclip
Keys.Register(Config.Keys.NoClip, "-useAdminNoClip", Translate("keys_menu_noclip"), function()
    -- NoClip function
end)