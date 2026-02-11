-- Custom make commands for filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.cmd("compiler cargo")
        vim.opt_local.makeprg = "cargo build"

        vim.api.nvim_buf_create_user_command(0, "Run" , function ()
            vim.cmd("vsplit | term cargo run")
        end, { desc = "Run the current Rust project" })
    end,
})
