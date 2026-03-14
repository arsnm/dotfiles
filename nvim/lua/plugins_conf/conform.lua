require("conform").setup({
    formatters_by_ft = {
        python = { "black" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        java = { "clang-format" },
        rust = { "rustfmt" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        javascript = { "prettier" },
    },

    formatters = {
        prettier = {
            prepend_args = { "--tab-width", "4" },
        },
        ["clang-format"] = {
            prepend_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}" },
        }
    }
})

vim.keymap.set('n', '<leader>lf', function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
