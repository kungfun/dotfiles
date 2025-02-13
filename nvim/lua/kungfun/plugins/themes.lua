return {
    {
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
                width = 0.6,
                height = 1,
            },
            plugins = {
                options = {
                    enabled = true,
                    laststatus = 3,
                },
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
