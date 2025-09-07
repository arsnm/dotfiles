vim.pack.add({
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/echasnovski/mini.snippets" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*")},
    { src = "https://github.com/m4xshen/autoclose.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
})

local update_file = vim.fn.stdpath("config") .. "/last_update.txt"
local last_update = nil
local f = io.open(update_file, "r")
if f then
    last_update = f:read("*l")
    f:close()
end

local today = os.date("%Y-%m-%d")
local weekday_num = os.date("%w") -- 0 = Sunday, 1 = Monday, ...

if weekday_num == '1' and last_update ~= today then
    vim.pack.update()
    local f = io.open(update_file, "w")
    if f then
        f:write(today)
        f:close()
    end
end

require("mini.pick").setup()
require("mini.icons").setup()

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
    snippets = {
        gen_loader.from_file(vim.fn.stdpath("config") .. '/snippets/global.json'),
        gen_loader.from_lang(),
    }
})


vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { link = "Visual" })

require("oil").setup({
    columns = {
        "icon",
        "permissions",
        "size",
    },
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
            return name == '.DS_Store'
        end,
    },
    win_options = {
        winbar = "%#WinBar#%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}",
    }
})

require("mason").setup()

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
    }
})

vim.api.nvim_create_user_command("ToggleBufCompletion", function()
    vim.b.completion = not (vim.b.completion ~= false)
    print("Blink completion (buffer : )" .. (vim.b.completion and "enabled" or "disabled"))
end, {})

require("autoclose").setup()

require'colorizer'.setup()

local map = vim.keymap.set

map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>e', ':Oil<CR>')
