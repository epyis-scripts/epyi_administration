-- Sql initialization
-- init the sql part of the script, automatically create tables if not exists and add defaults admins
Citizen.CreateThread(function()
    MySQL.insert("CREATE TABLE IF NOT EXISTS admin_permission (`identifier` VARCHAR(99) PRIMARY KEY,`group` VARCHAR(99));", {}, function()
        if Config.InitialIdentifier ~= nil and Config.InitialIdentifier ~= "your-identifier-here" then
            MySQL.single("SELECT * FROM `admin_permission` WHERE `identifier` = @identifier LIMIT 1", {
                ["@identifier"] = Config.InitialIdentifier
            }, function(row)
                if not row then
                    local choosedGroup = nil
                    for k, v in pairs(Config.Groups) do
                        if choosedGroup == nil then
                            choosedGroup = k
                        elseif v.Priority > Config.Groups[choosedGroup].Priority then
                            choosedGroup = k
                        end
                    end
                    MySQL.insert("INSERT INTO `admin_permission` (`identifier`, `group`) VALUES (@identifier, @group)", {
                        ["@identifier"] = Config.InitialIdentifier,
                        ["@group"] = choosedGroup
                    }, function()end)
                end
            end)
        end
    end)
end)