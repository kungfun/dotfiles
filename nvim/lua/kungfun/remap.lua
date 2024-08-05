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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf, lsp_fallback = true })
	end,
})

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({})<cr>", opts)
keymap("n", "<leader>fo", '<cmd>lua require("telescope.builtin").oldfiles({})<cr>', opts)
keymap("n", "<leader>fe", '<cmd>lua require("telescope.builtin").buffers({})<cr>', opts)
keymap("n", "<leader>fg", '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', opts)
keymap("n", "<leader>fd", "<cmd>TodoTelescope<cr>", opts)
keymap("n", "<leader>fu", "<cmd>Telescope undo<cr>", opts)

keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
-- keymap("n", "<leader>lA", vim.lsp.buf.range_code_action, opts)
keymap("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
keymap("n", "<leader>lf", vim.lsp.buf.format, opts)
-- keymap("n", "<leader>li", require("telescope.builtin").lsp_implementatopts, opts)
-- keymap("n", "<leader>lw", require("telescope.builtin").diagnostics, opts)
--

keymap("n", "<leader>nn", "<cmd>NoNeckPain<cr>", opts)
vim.cmd([[ autocmd VimResized * if (&columns > 80) | set columns=80 | endif ]])
