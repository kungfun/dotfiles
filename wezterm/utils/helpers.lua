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
    local random_key = keys[math.random(1, #keys)]
    return items[random_key]
end

return M
