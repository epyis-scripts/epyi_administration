-- Sql initialization
-- init the sql part of the script, automatically create tables if not exists and add defaults admins
Citizen.CreateThread(function()
    MySQL.insert("CREATE TABLE IF NOT EXISTS admin_permission (`identifier` VARCHAR(99) PRIMARY KEY,`group` VARCHAR(99));", {}, function()
        if Config.InitialIdentifier ~= nil and Config.InitialIdentifier ~= "your-identifier-here" then
            MySQL.single("SELECT * FROM `admin_permission` WHERE `identifier` = ? LIMIT 1", {
                Config.InitialIdentifier
            }, function(row)
                if not row then
                    local maxIndex = nil
                    for index, _ in pairs(Config.Groups) do
                        if maxIndex == nil or index > maxIndex then
                            maxIndex = index
                        end
                    end
                    MySQL.insert("INSERT INTO `admin_permission` (`identifier`, `group`) VALUES (?, ?)", {
                        Config.InitialIdentifier,
                        Config.Groups[maxIndex].Id
                    }, function()end)
                end
            end)
        end
    end)
end)