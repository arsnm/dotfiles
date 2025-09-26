local map = vim.keymap.set

vim.lsp.enable({ 'lua_ls', 'pyright', 'clangd', 'bashls' })
map('n', '<leader>lf', vim.lsp.buf.format)

