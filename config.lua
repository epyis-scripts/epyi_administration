Config = {}
Config.Locale = GetConvar("epyi_administration:locale", "en")

Config.MenuStyle = {
	Margins = { left = 10, top = 10 }, -- [table] → Set the menu margins
	BannerStyle = {
		Color = { r = 150, g = 50, b = 50, a = 100 }, -- [table] → Set the banner color if no custom banner image is set
		UseGlareEffect = true, -- [boolean] → Use the glare effect or not
		UseInstructionalButtons = true, -- [boolean] → Use the instructionals buttons or not
		ImageUrl = nil, -- [nil/string] → Set a custom image url if you want (if set, it will disable the Color configuration)
		ImageSize = { Width = 512, Height = 128 }, -- [table] → Set the image (ImageUrl) size un pixels
	},
}

Config.Keys = { Menu = "F10", NoClip = "F3" } -- [table] → The the menu keys

Config.Groups = {
	admin = { -- If you change the admin group identifier, I recommand you to go to ESX Framework configuration and change the admin group too
		Priority = 99,
		Label = "Admin",
		Color = "~r~",
		Access = {
			["mainmenu_open"] = "allow",
			["submenu_personnal_access"] = "allow",
			["submenu_players_access"] = "allow",
			["submenu_vehicles_access"] = "allow",
			["submenu_reports_access"] = "allow",
			["submenu_server_access"] = "allow",
			["submenu_personnal_health_management"] = "allow",
			["submenu_personnal_godmode"] = "allow",
			["submenu_personnal_invisibility"] = "allow",
		},
	},
}

