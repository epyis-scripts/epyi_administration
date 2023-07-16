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
	admin = {
		Priority = 99,
		Label = "Admin",
		Color = "~r~",
		Access = {
			-- Main menu
			["mainmenu_open"] = true,

			-- Submenu → Personnal
			["submenu_personnal_access"] = true,
			["submenu_personnal_health_management"] = true,
			["submenu_personnal_godmode"] = true,
			["submenu_personnal_invisibility"] = true,
			["submenu_personnal_fastwalk"] = true,
			["submenu_personnal_fastswim"] = true,
			["submenu_personnal_superjump"] = true,
			["submenu_personnal_stayinvehicle"] = true,
			["submenu_personnal_seethrough"] = true,
			["submenu_personnal_shownames"] = true,

			-- Submenu → Players
			["submenu_players_access"] = true,

			-- Submenu → Vehicles
			["submenu_vehicles_access"] = true,
			["submenu_vehicles_current_access"] = true,
			["submenu_vehicles_favorites_access"] = true,
			["submenu_vehicles_spawn_access"] = true,
			["submenu_vehicles_repair"] = true,

			-- Submenu → Reports
			["submenu_reports_access"] = true,

			-- Submenu → Server
			["submenu_server_access"] = true,
		},
	},
}
