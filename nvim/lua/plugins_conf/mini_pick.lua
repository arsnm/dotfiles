require("mini.pick").setup()

-- Makes the current match in the pick window use the "Visual" highlight group,
-- which is more visible.
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { link = "Visual" })

local map = vim.keymap.set

map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>b', ':Pick buffers<CR>')
map('n', '<leader>g', ':Pick grep_live<CR>')
