return {
    {
        "folke/tokyonight.nvim",
        config = function()
            local theme = require("tokyonight")

            theme.setup({
                style = "night",
                transparent = true,
            })
        end,
    },
    { "projekt0n/github-nvim-theme" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavor = "mocha",
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.95,
                },
            })
        end,
    },
    {
        --colors = cyberdream,
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end,
    },
    "levouh/tint.nvim",
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = .5,
                height = 1,
                backdrop = 1,
            },
            plugins = {
                options = {
                    enabled = true,
                    laststatus = 3,
                }
            },
            wezterm = {
                enabled = true,
            }
        }
    },
    -- TODO: learn how to use
    "stevearc/dressing.nvim",
}
