-- Variables initialization
-- init some local variables
_var = {
	client = {},
	menu = {},
	activeThreads = {},
	vehicle = {},
}
_var.client.isStaffModeActivated = false
_var.client.staffGroup = nil
_var.client.playerData = {}
_var.client.userData = {}
_var.menu.isOpened = false
_var.menu.bannerTexture = nil
_var.menu.favritesActionsArrayIndex = 1
_var.menu.favritesActionsArray = {
	_("main_vehicles_favorites_interact_spawn"),
	_("main_vehicles_favorites_interact_delete"),
}
_var.activeThreads.getVehiclesFavorites = false
_var.vehicle.doorArrayIndex = 1
_var.vehicle.doorArray = {
	_("door_frontleft"),
	_("door_frontright"),
	_("door_backleft"),
	_("door_backright"),
	_("door_hood"),
	_("door_trunk"),
	_("door_all"),
}
_var.vehicle.paintColorsArrayIndexMain = 1
_var.vehicle.paintColorsArrayIndexSecondary = 1
_var.vehicle.paintColors = {
	{ "Chrome", 120 },
	{ "Black", 0 },
	{ "Carbon Black", 147 },
	{ "Graphite", 1 },
	{ "Anhracite Black", 11 },
	{ "Black Steel", 2 },
	{ "Dark Steel", 3 },
	{ "Silver", 4 },
	{ "Bluish Silver", 5 },
	{ "Rolled Steel", 6 },
	{ "Shadow Silver", 7 },
	{ "Stone Silver", 8 },
	{ "Midnight Silver", 9 },
	{ "Cast Iron Silver", 10 },
	{ "Red", 27 },
	{ "Torino Red", 28 },
	{ "Formula Red", 29 },
	{ "Lava Red", 150 },
	{ "Blaze Red", 30 },
	{ "Grace Red", 31 },
	{ "Garnet Red", 32 },
	{ "Sunset Red", 33 },
	{ "Cabernet Red", 34 },
	{ "Wine Red", 143 },
	{ "Candy Red", 35 },
	{ "Hot Pink", 135 },
	{ "Pfsiter Pink", 137 },
	{ "Salmon Pink", 136 },
	{ "Sunrise Orange", 36 },
	{ "Orange", 38 },
	{ "Bright Orange", 138 },
	{ "Gold", 99 },
	{ "Bronze", 90 },
	{ "Yellow", 88 },
	{ "Race Yellow", 89 },
	{ "Dew Yellow", 91 },
	{ "Dark Green", 49 },
	{ "Racing Green", 50 },
	{ "Sea Green", 51 },
	{ "Olive Green", 52 },
	{ "Bright Green", 53 },
	{ "Gasoline Green", 54 },
	{ "Lime Green", 92 },
	{ "Midnight Blue", 141 },
	{ "Galaxy Blue", 61 },
	{ "Dark Blue", 62 },
	{ "Saxon Blue", 63 },
	{ "Blue", 64 },
	{ "Mariner Blue", 65 },
	{ "Harbor Blue", 66 },
	{ "Diamond Blue", 67 },
	{ "Surf Blue", 68 },
	{ "Nautical Blue", 69 },
	{ "Racing Blue", 73 },
	{ "Ultra Blue", 70 },
	{ "Light Blue", 74 },
	{ "Chocolate Brown", 96 },
	{ "Bison Brown", 101 },
	{ "Creeen Brown", 95 },
	{ "Feltzer Brown", 94 },
	{ "Maple Brown", 97 },
	{ "Beechwood Brown", 103 },
	{ "Sienna Brown", 104 },
	{ "Saddle Brown", 98 },
	{ "Moss Brown", 100 },
	{ "Woodbeech Brown", 102 },
	{ "Straw Brown", 99 },
	{ "Sandy Brown", 105 },
	{ "Bleached Brown", 106 },
	{ "Schafter Purple", 71 },
	{ "Spinnaker Purple", 72 },
	{ "Midnight Purple", 142 },
	{ "Bright Purple", 145 },
	{ "Cream", 107 },
	{ "Ice White", 111 },
	{ "Frost White", 112 },
	{ "Black", 12 },
	{ "Gray", 13 },
	{ "Light Gray", 14 },
	{ "Ice White", 131 },
	{ "Blue", 83 },
	{ "Dark Blue", 82 },
	{ "Midnight Blue", 84 },
	{ "Midnight Purple", 149 },
	{ "Schafter Purple", 148 },
	{ "Red", 39 },
	{ "Dark Red", 40 },
	{ "Orange", 41 },
	{ "Yellow", 42 },
	{ "Lime Green", 55 },
	{ "Green", 128 },
	{ "Forest Green", 151 },
	{ "Foliage Green", 155 },
	{ "Olive Darb", 152 },
	{ "Dark Earth", 153 },
	{ "Desert Tan", 154 },
}
_var.vehicle.paintColorsArray = {}
for _, color in pairs(_var.vehicle.paintColors) do
	table.insert(_var.vehicle.paintColorsArray, color[1])
end
_var.vehicle.boostArrayIndex = 1
_var.vehicle.boostArray = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 }
