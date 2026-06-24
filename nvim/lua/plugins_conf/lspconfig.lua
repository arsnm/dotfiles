vim.lsp.enable({ 'lua_ls', 'pyright', 'clangd', 'bashls', 'jdtls', 'rust_analyzer', 'tinymist' })

-- Close quickfix/location list command
vim.keymap.set('n', 'grq', '<cmd>silent! cclose<CR> | silent! lclose<CR>', {
    noremap = true,
    silent = true,
    desc = "Close quickfix/location list"
})

vim.lsp.config["tinymist"] = {
    settings = {
        formatterProseWrap = true,
        formatterPrintWidth = 80,
    }
}
