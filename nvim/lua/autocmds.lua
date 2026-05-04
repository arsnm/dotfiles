-- Custom make commands for filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        if vim.fn.filereadable("Makefile") == 1 then
            return
        end
        vim.cmd("compiler cargo")
        vim.opt_local.makeprg = "cargo build"

        vim.api.nvim_buf_create_user_command(0, "Run" , function ()
            vim.cmd("vsplit | term cargo run")
        end, { desc = "Run the current Rust project" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function()
        if vim.fn.filereadable("Makefile") == 1 then
            return
        end
        vim.cmd("compiler typst")
        vim.opt_local.makeprg = "typst compile --root . %:S"

        -- Open the compiled PDF
        vim.api.nvim_buf_create_user_command(0, "Otypst", function ()
            local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"
            if vim.fn.filereadable(pdf_path) == 1 then
                if vim.fn.has("macunix") == 1 then
                    vim.fn.jobstart({ "open", pdf_path }, { detach = true })
                elseif vim.fn.has("linux") == 1 then 
                    vim.fn.jobstart({ "xdg-open", pdf_path }, { detach = true })
                end
                print("Opened PDF: " .. pdf_path)
            else
                print("PDF not found: " .. pdf_path)
            end
        end, { desc = "Open the compiled Typst PDF in the default PDF viewer" })

        -- Start to watch the file
        vim.api.nvim_buf_create_user_command(0, "Wtypst", function ()
            local file_path = vim.fn.expand("%:p")
            if vim.fn.filereadable(file_path) == 1 then
                local original_win = vim.api.nvim_get_current_win()
                vim.cmd("botright 20vsplit")
                vim.cmd("term typst watch --root . " .. file_path)
                print("Started watching: " .. file_path)
                -- return to original window
                vim.api.nvim_set_current_win(original_win)
            else
                print("File not found: " .. file_path)
            end
        end, { desc = "Start watching the current Typst file for changes" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        if vim.fn.filereadable("Makefile") == 1 then
            return
        end
        vim.cmd("compiler latex")
        vim.opt_local.makeprg = [[
            latexmk -pdflua -interaction=nonstopmode
            -auxdir=.aux -shell-escape -file-line-error -synctex=1 %:p"
        ]]
        vim.api.nvim_buf_create_user_command(0, "OpenTex", function ()
            local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"
            if vim.fn.filereadable(pdf_path) == 1 then
                vim.fn.jobstart({ "xdg-open", pdf_path }, { detach = true })
                print("Opened PDF: " .. pdf_path)
            else
                print("PDF not found: " .. pdf_path)
            end
        end, { desc = "Open the compiled Tex PDF in the default PDF viewer" })
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.hl.on_yank()
        vim.cmd("echo 'Yanked to register: ' . v:event.regname")
    end,
})
