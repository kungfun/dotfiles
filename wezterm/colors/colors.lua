local wezterm = require('wezterm')
local helpers = require('utils/helpers')

local M = {}
M.colors = {
    "#ec363d",
    "#faeb36",
    "#00753e",
    "#487de7",
    "#ff00cc",
    "#ffffff",
}


M.get_color = function(window_id)
    local colors_cache = wezterm.GLOBAL.colors_cache

    local colors = {}
    local n = 0
    for _, c_color in pairs(colors_cache) do
        n = n + 1
        colors[n] = c_color
    end

    local unique_colors = helpers.unique_left(M.colors, colors)

    local color = helpers.get_random_entry(unique_colors)

    colors_cache[window_id] = color
    wezterm.GLOBAL.colors_cache = colors_cache

    return color
end

return M
