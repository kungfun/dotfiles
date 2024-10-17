local wezterm = require('wezterm')
local M = {}

M.count = 1

M.round_robin = function(items)
    local keys = {}
    for key, _ in ipairs(items) do
        table.insert(keys, key)
    end
    local item_key = math.fmod(M.count, #items)
    local item = items[item_key]
    print(item_key)
    print(M.count)
    M.count = M.count + 1

    return item
end


M.get_random_entry = function(items)
    local keys = {}
    for key, _ in ipairs(items) do
        table.insert(keys, key)
    end
    local random_key = keys[math.random(#keys)]
    return items[random_key]
end

M.unique_left = function(array1, array2)
    local unique_table = {}
    -- Helper function to add items to the unique table
    for _, value1 in ipairs(array1) do
        local unique = true
        for _, value2 in ipairs(array2) do
            if wezterm.to_string(value1) == wezterm.to_string(value2) then
                unique = false
            end
        end
        if unique then
            unique_table[value1] = true -- Use the value as a key to ensure uniqueness
        end
    end

    -- Add items from both arrays

    local unique_list = {}
    for key, _ in pairs(unique_table) do
        table.insert(unique_list, key)
    end

    return unique_list
end


return M
