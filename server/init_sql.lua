-- Sql initialization
-- init the sql part of the script, automatically create tables if not exists and add default admin
Citizen.CreateThread(function()
	MySQL.insert(
		"CREATE TABLE IF NOT EXISTS `admin_data` (`id` int(11) NOT NULL AUTO_INCREMENT,`owner` varchar(60) NOT NULL,`type` varchar(99) DEFAULT NULL,`data` longtext DEFAULT NULL,PRIMARY KEY (`id`)) ENGINE=InnoDB;",
		{}
	)
end)
