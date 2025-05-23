vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
-- enable indentation
vim.cmd([[ set breakindent ]])
-- ident by an additional 2 characters on wrapped lines, when line >= 40 characters, put 'showbreak' at start of line
vim.cmd([[ set breakindentopt=shift:4,min:120,sbr ]])
-- append '>>' to indent
vim.cmd([[ set showbreak=>>>  ]])
vim.cmd([[ set autoindent ]])
vim.opt.mousescroll = "ver:1,hor:0"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.cursorline = true

vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.api.nvim_create_autocmd("ExitPre", {
    group = vim.api.nvim_create_augroup("Exit", { clear = true }),
    command = "set guicursor=a:ver10",
    desc = "Set cursor back to beam when leaving Neovim."
})

vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))

vim.cmd([[
    "only for vim
    highlight Normal guibg=None
    highlight NonText guibg=None
    highlight NormalNC guibg=None
    highlight NormalFloat guibg=None
    highlight Pmenu guibg=None
    highlight PmenuSel guibg=None
    highlight PmenuSbar guibg=None
    highlight PmenuThumb guibg=None
    highlight WildMenu guibg=None
    highlight WinBar guibg=None
    highlight WinBarNC guibg=None
    highlight Terminal guibg=None
    highlight Question guibg=None
    highlight QuickFixLine guibg=None
    highlight Search guibg=None
    highlight SpecialKey guibg=None
    highlight SpellBad guibg=None
    highlight SpellCap guibg=None
    highlight SpecllLocal guibg=None
    highlight SpellRare guibg=None
    highlight Whitespace guibg=None

    highlight Menu guibg=None
    highlight Scrollbar guibg=None
    highlight Tooltip guibg=None
    highlight EndOfBuffer guibg=None
    highlight Folded guibg=None
    highlight ToolbarLine guibg=None
    highlight FoldColumn guibg=None
    highlight QuickmenuHelp guibg=None
    highlight FloatBorder guibg=None



    highlight NeoTreeNormal guibg=None
    highlight NeoTreeNormalNC guibg=None
    highlight TelescopeNormal guibg=None
    highlight WhichKeyFloat guibg=None ctermbg=None

    " which key"
    highlight WhichKeyGroup guibg=None ctermbg=None
]])
