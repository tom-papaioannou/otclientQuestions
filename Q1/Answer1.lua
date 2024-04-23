-- A1

local function releaseStorage(player)
    if player then -- Check if the player object still exists
        player:setStorageValue(1000, -1)
    end
end

function onLogout(player)
    if player then -- Check if the player object still exists
        if player:getStorageValue(1000) == 1 then
            addEvent(releaseStorage, 1000, player)
        end
    end
    return true
end
