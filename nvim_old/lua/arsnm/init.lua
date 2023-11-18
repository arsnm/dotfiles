require ("arsnm.remap")
require ("arsnm.packer")

-- hybrid line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- identation and tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- open help pages on a right vertical split
vim.api.nvim_command('autocmd! FileType help wincmd L')
