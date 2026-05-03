require("copilot").setup({
    filetypes = {
        c = true,
        cpp = true,
        html = true,
        python = true,
        java = true,
        lua = true,
        systemverilog = true,
        css = true,
        json = true,
        javascript = true,
        -- tex = true,
        rust = true,
        ["*"] = false,
    },
    panel = {
        enabled = true,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
            accept = "<C-j>",
            prev = false,
            next = false,
        },
    },
})
