local wezterm = require("wezterm")
-- local helpers = require("utils/helpers")

local M = {}

M.get_font = function()
    local font_families = {
        "JetBrainsMono Nerd Font Mono",
        "Monaspace Neon",
        "Monaspace Argon",
        "Monaspace Radon",
        "Monaspace Krypton",
        "Monaspace Xenon",
    }
    -- local font_family = helpers.get_random_entry(font_families)
    local font_family = font_families[1]
    return wezterm.font_with_fallback({ { family = font_family } })
end

return M
