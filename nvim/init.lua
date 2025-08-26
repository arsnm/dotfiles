vim.opt.winborder = "double"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.cursorcolumn = false
vim.opt.signcolumn = "yes"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.termguicolors = false
vim.opt.undofile = true
vim.opt.incsearch = true

vim.o.wildmenu = false
vim.o.wildoptions = ""

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣'}

local map = vim.keymap.set
vim.g.mapleader = " "

map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>m', ':make<CR>')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
map({ 'n', 'v', 'x' }, '<leader>p', '"+p')

map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>')
map({ 'n', 'v', 'x' }, '<leader>U', ':sf #<CR>')

map('n', '<leader>nh', ':nohl<CR>')

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
map("n", "J", "mzJ`z", { desc = "Join the current line with the next" })

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')
map('n', 'G', 'Gzz')

-- map('n', ':', 'q:i')

map('n', '<leader>ll', function()
    vim.diagnostic.setloclist({ open = false })
    local window = vim.api.nvim_get_current_win()
    vim.cmd.lwindow() -- open+focus on loclist if it has entries, else close it
    vim.api.nvim_set_current_win(window)
end
)

map('n', '<leader>qf', function()
    vim.diagnostic.setqflist({ open = false })
    local window = vim.api.nvim_get_current_win()
    vim.cmd.cwindow() -- open+focus on qflist if it has entries, else close it
    vim.api.nvim_set_current_win(window)
end
)

require('plugins')

require('lspconfig')

require('colors')

vim.o.statusline = "%{%v:lua.require'statusline'.statusline()%}"
vim.o.tabline = "%!v:lua.require'statusline'.tabline()"

-- vim.provider
vim.g.python3_host_prog = vim.env.VENVS_PATH .. "/nvim/bin/python"

