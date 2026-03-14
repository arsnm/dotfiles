require("blink.cmp").setup({
    enabled = function() return vim.b.completion ~= false end,
    fuzzy = { implementation = "prefer_rust" },
    completion = {
        menu = { auto_show = true },
    },
    keymap = {
        ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
    cmdline = {
        keymap = { preset = "cmdline" }
    },
    snippets = { preset = 'luasnip' },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})

-- Toggle completion for the current buffer
vim.api.nvim_create_user_command("ToggleBufCompletion", function()
    vim.b.completion = not (vim.b.completion ~= false)
    print("Blink completion (buffer): " .. (vim.b.completion and "enabled" or "disabled"))
end, {})

