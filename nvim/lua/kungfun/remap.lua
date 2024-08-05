vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 5

local keymap = vim.keymap.set

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 250,
		})
	end,
})

-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])

-- close buffe
keymap("n", "<C-q>", "<cmd>bd<CR>", opts)

keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

keymap("n", "<C-S-j>", ":m .+1<CR>==", opts) -- move line up(n)
keymap("n", "<C-S-k>", ":m .-2<CR>==", opts) -- move line down(n)
keymap("v", "<C-S-j>", ":m '>+1<CR>gv=gv", opts) -- move line up(v)
keymap("v", "<C-S-k>", ":m '<-2<CR>gv=gv", opts) -- move line down(v)

keymap("v", "<leader>y", '"+y', opts)

keymap({ "n", "v" }, "<C-f>", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, {
	noremap = true,
	silent = true,
	desc = "Format file or range (in visual mode)",
})
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		require("conform").format({ bufnr = args.buf, lsp_fallback = true })
-- 	end,
-- })

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({})<cr>", opts)
keymap("n", "<leader>fo", '<cmd>lua require("telescope.builtin").oldfiles({})<cr>', opts)
keymap("n", "<leader>fe", '<cmd>lua require("telescope.builtin").buffers({})<cr>', opts)
keymap("n", "<leader>fg", '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', opts)
keymap("n", "<leader>fl", "<cmd>lua require('telescope.builtin').live_grep({ grep_open_files = true })<cr>", opts)
keymap("n", "<leader>fd", "<cmd>TodoTelescope<cr>", opts)
keymap("n", "<leader>fu", "<cmd>Telescope undo<cr>", opts)

keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
-- keymap("n", "<leader>lA", vim.lsp.buf.range_code_action, opts)
keymap("n", "<leader>li", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
keymap("n", "<leader>l[", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<cr>", opts)
keymap("n", "<leader>l]", "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<cr>", opts)
keymap("n", "<leader>ld", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
keymap("n", "<leader>la", "<cmd>lua require('telescope.builtin').()<cr>", opts)
-- keymap("n", "<leader>lw", require("telescope.builtin").diagnostics, opts)
--

keymap("n", "<C-n>", "<cmd>ZenMode<cr>", opts)
vim.api.nvim_set_hl(0, "ZenBg", { ctermbg = 0 })

-- Terminal Window
local Terminal = require("toggleterm.terminal").Terminal
local terminal = Terminal:new({
	direction = "float",
	-- hidden = true,
	float_opts = {
		border = "rounded",
		width = 80,
		height = 10,
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

function open_terminal()
	terminal:toggle()
end

keymap("n", "<leader>tt", "<cmd>lua open_terminal()<cr>", opts)

-- LazyGit
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

function open_lazygit()
	lazygit_terminal:toggle()
end

keymap("n", "<leader>gg", "<cmd>lua open_lazygit()<cr>", opts)
