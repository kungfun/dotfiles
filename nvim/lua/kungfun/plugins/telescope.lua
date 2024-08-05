return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"folke/todo-comments.nvim",
			"debugloop/telescope-undo.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-_"] = actions.which_key,
						},
						n = {
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					undo = {
						use_delta = true,
						use_custom_command = nil,
						side_by_side = false,
						vim_diff_opts = {
							ctxlen = vim.o.scrolloff,
						},
						entry_format = "state #$ID, $STAT, $TIME",
						mappings = {
							i = {
								["<C-cr>"] = require("telescope-undo.actions").yank_additions,
								["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
								["<cr>"] = require("telescope-undo.actions").restore,
							},
						},
					},
				},
			})

			telescope.load_extension("live_grep_args")
			telescope.load_extension("undo")
			telescope.load_extension("fzf")
		end,
	},
}
