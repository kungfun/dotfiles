local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
-- Lazy Git
local Terminal = require("toggleterm.terminal").Terminal
local lazygit_terminal = Terminal:new({
	cmd = "lazygit",
	direction = "float",
	-- hidden = true,
	float_opts = {
		border = "rounded",
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	-- function to run on closing the terminal
	on_close = function(term)
		vim.cmd("startinsert!")
	end,
})

local terminal = Terminal:new({
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
	-- function to run on closing the terminal
	on_close = function(term)
		vim.cmd("startinsert!")
	end,
})

function open_lazygit()
	lazygit_terminal:toggle()
end

function open_terminal()
	terminal:toggle()
end

local mappings = {

	{ "<leader>f", group = "Find" },
	{ "<leader>ff", '<cmd>lua require("telescope.builtin").find_files({})<cr>', desc = "Find Files" },
	{ "<leader>fo", '<cmd>lua require("telescope.builtin").oldfiles({})<cr>', desc = "Old Files" },
	{ "<leader>fe", '<cmd>lua require("telescope.builtin").buffers({})<cr>', desc = "Buffers" },
	{ "<leader>fg", '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', desc = "Grep" },
	{ "<leader>fd", "<cmd>TodoTelescope<cr>", desc = "Find ToDo's" },
	{ "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo History" },

	{ "<leader>x", group = "Trouble" },
	{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble Document" },
	{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble Quickfix" },
	{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble Workspace" },
	{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },

	{ "<leader>t", group = "Terminal" },
	{ "<leader>tt", "<cmd>lua open_terminal()<cr>", desc = "New Terminal" },

	{ "<leader>g", group = "Git" },
	{ "<leader>gg", "<cmd>lua open_lazygit()<cr>", desc = "Open Lazy Git" },

	{ "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
	{ "<leader>lA", vim.lsp.buf.range_code_action, desc = "Range Code Actions" },
	{ "<leader>ls", vim.lsp.buf.signature_help, desc = "Display Signature Information" },
	{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename all references" },
	{ "<leader>lf", vim.lsp.buf.format, desc = "Format" },
	{ "<leader>li", require("telescope.builtin").lsp_implementations, desc = "Implementation" },
	{ "<leader>lw", require("telescope.builtin").diagnostics, desc = "Diagnostics" },
}

which_key.add(mappings, opts)
