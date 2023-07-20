-- Sql initialization
-- init the sql part of the script, automatically create tables if not exists and add default admin
Citizen.CreateThread(function()
	MySQL.insert(
		"INSERT INTO `datastore` (name, label, shared) SELECT 'epyi_admin_favorites', 'Favorites vehicles', 0 WHERE NOT EXISTS (SELECT 1 FROM `datastore` WHERE name = 'epyi_admin_favorites');",
		{}
	)
end)
