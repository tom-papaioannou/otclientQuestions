-- A3

-- Make function name more specific
function removePlayerFromParty(playerId, playerName)
    -- Retrieve the player object
    local player = Player(playerId)
    
    -- Check if the player exists and is in a party
    if player and player:hasParty() then
        local party = player:getParty()
        
        -- Iterate through party members and remove the specified player
        -- Changed pairs() to ipairs() for iterating party members to maintain the order of iteration and consistency
        for _, member in ipairs(party:getMembers()) do
            if member:getName() == playerName then
                party:removeMember(member)
                print("Player " .. playerName .. " removed from the party.")
                return true
            end
        end
        
        -- Player not found in the party
        print("Player " .. playerName .. " is not in the party.")
        return false
    else
        -- Player not found or not in a party
        print("Player with ID " .. playerId .. " is not in a party.")
        return false
    end
end
