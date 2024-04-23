function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    
    -- Formatting the query string with the provided member count
    local formattedQuery = string.format(selectGuildQuery, memberCount)
    local resultId = db.storeQuery(formattedQuery)
    
    -- Check if resultId exists
    if resultId then
        -- Iterate through all the results returned from the query
        repeat
            local guildName = result.getDataString(resultId, "name")
            print(guildName)
        until not result.next(resultId)
        -- Freeing the result set after processing
        result.free(resultId)
    else
        -- Error handling
        print("No guilds found with less than " .. memberCount .. " members.")
    end
end
