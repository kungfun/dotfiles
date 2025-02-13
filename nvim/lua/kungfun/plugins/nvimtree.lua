return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
        require("nvim-tree").setup {
            disable_netrw = true,
            update_focused_file = {
                enable = true,
            },
        }
    end,
}
