---setPlayerGroup → set or change the staff group of a player
---@return void
RegisterServerEvent("epyi_administration:setPlayerGroup")
AddEventHandler("epyi_administration:setPlayerGroup", function(source, target, group)
    local xTarget = ESX.GetPlayerFromId(target)
    MySQL.scalar("SELECT `group` FROM `admin_permission` WHERE `identifier` = ?", {
        xTarget.identifier
    }, function(response)
        if response == nil then
            MySQL.insert('INSERT INTO `admin_permission` (`identifier`, `group`) VALUES (@identifier, @group) ', {
                ["@identifier"] = xTarget.identifier,
                ["@group"] = group
            }, function() end)
        else
            MySQL.update("UPDATE `admin_permission` SET `group` = @group WHERE `identifier` = @identifier", {
                ["@group"] = group,
                ["@identifier"] = xTarget.identifier
            }, function()end)
        end
    end)
end)

---getPlayerGroup → get the staff group of a player
---@return group_index
ESX.RegisterServerCallback("epyi_administration:getPlayerGroup", function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)
    MySQL.query("SELECT `group` FROM `admin_permission` WHERE `identifier` = @identifier", {
        ["@identifier"] = xTarget.identifier
    }, function(response)
        if response[1] ~= nil then
            cb(response[1]["group"])
        else
            cb(nil)
        end
    end)
end)

---removePlayerGroup → delete the staff group of a player
---@return void
RegisterServerEvent("epyi_administration:removePlayerGroup")
AddEventHandler("epyi_administration:removePlayerGroup", function(source, target)
    local xTarget = ESX.GetPlayerFromId(target)
    MySQL.Async.execute("DELETE FROM `admin_permission` WHERE `identifier` = @identifier",{
        ["@identifier"] = xTarget.identifier
    })
end)