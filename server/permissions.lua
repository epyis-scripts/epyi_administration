RegisterServerEvent("epyi_administration:setPlayerGroup")
AddEventHandler("epyi_administration:setPlayerGroup", function(identifier, group)
    MySQL.scalar("SELECT `group` FROM `admin_permission` WHERE `identifier` = ?", {
        identifier
    }, function(response)
        if response == nil then
            MySQL.insert('INSERT INTO `admin_permission` (`identifier`, `group`) VALUES (?, ?) ', {
                identifier,
                group
            }, function() end)
        else
            MySQL.update('UPDATE `admin_permission` SET `group` = ? WHERE `identifier` = ? ', {
                group,
                identifier
            }, function()end)
        end
    end)
end)

ESX.RegisterServerCallback("epyi_administration:getPlayerGroup", function(cb, identifier)
    MySQL.query('SELECT `group` FROM `admin_permission` WHERE `identifier` = ?', {
        identifier
    }, function(response)
        if response then
            cb(response.group)
        end
    end)
end)

RegisterServerEvent("epyi_administration:removePlayerGroup")
AddEventHandler("epyi_administration:removePlayerGroup", function(identifier)
    MySQL.Async.execute("DELETE FROM `admin_permission` WHERE `identifier` = @identifier",{
        ['@identifier'] =  identifier
    })
end)