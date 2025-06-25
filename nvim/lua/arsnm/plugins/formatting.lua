return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                ocaml = { "ocamlformat" },
                lua = { "stylua" },
                python = { "isort"", "black" },
            },
            formatters = {
                stylua = {
                    command = "stylua",
                    args = {
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        "4",
                        "-",
                    },
                    stdin = true,
                },
                ocamlformat = {
                    command = "ocamlformat",
                    args = {
                        "--name",
                        vim.api.nvim_buf_get_name(0),
                        "--impl",
                        "-",
                        "--margin",
                        "80",
                        "--indent",
                        "4",
                    },
                    stdin = true,
                },
                clang_format = {
                    command = "clang-format",
                    args = {
                        "--style",
                        "{BasedOnStyle: llvm, IndentWidth: 4, TabWidth:4, UseTab: Never}",
                    },
                    stdin = true,
                },
            },
            -- format_on_save = {
            --     lsp_fallback = true,
            --     async = false,
            --     timeout_ms = 1000,
            -- },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
