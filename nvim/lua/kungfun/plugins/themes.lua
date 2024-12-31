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
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 0.8,
                height = 1,
            },
            plugins = {
                options = {
                    enabled = true,
                    laststatus = 3,
                },
            },
            wezterm = {
                enabled = true,
            },
        },
    },
    {
        "levouh/tint.nvim",
        config = function()
            require("tint").setup()
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup({})
        end,
    },
    -- TODO: learn how to use
    "stevearc/dressing.nvim",
}
