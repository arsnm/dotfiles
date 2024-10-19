return {
    "lervag/vimtex",
    config = function()
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            callback = 1,
            aux_dir = ".aux/",
            out_dir = "",
            continuous = 1,
            executable = "latexmk",
            options = {
                "-shell-escape",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-aux-directory=.aux",
            },
        }

        local os_name = vim.loop.os_uname().sysname

        -- macos setup : use sioyek
        if os_name == "Darwin" then
            vim.g.vimtex_view_method = "sioyek"
            vim.g.vimtex_view_sioyek_options =
                "--reuse-window --forward-search-file @pdf --forward-search-line @line @tex"
        -- linux setup : use zathura
        elseif os_name == "Linux" then
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_view_zathura_options =
                '--synctex-forward @line:0:@tex --synctex-editor-command "nvim --headless +%l %f"'
        end

        vim.g.vimtex_quickfix_open_on_warning = 0
    end,
}
