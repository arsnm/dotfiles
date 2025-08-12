vim.pack.add({
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = "*", build = "cargo build --release" },
})

require("mini.pick").setup()
require("mini.icons").setup()

vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { link = "Visual" })

require("oil").setup({
    columns = {
        "icon",
        "permissions",
        "size",
    },
    show_hidden = true,
    win_options = {
        winbar = "%#WinBar#%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}",
    }
})

require("mason").setup()

require("blink.cmp").setup({
    enabled = function() return true end,
    fuzzy = { implementation = "prefer_rust" },
    completion = {
        menu = { auto_show = false },
    }
})

local map = vim.keymap.set

map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>e', ':Oil<CR>')
