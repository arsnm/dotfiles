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
        enabled = false,
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
