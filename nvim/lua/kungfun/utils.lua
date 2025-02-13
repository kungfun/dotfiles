local function spread(template)
    local result = {}

    -- Copy the contents of the template table
    for key, value in pairs(template) do
        result[key] = value
    end

    return function(table)
        -- Merge the new table into the result
        for key, value in pairs(table) do
            result[key] = value
        end
        return result
    end
end
