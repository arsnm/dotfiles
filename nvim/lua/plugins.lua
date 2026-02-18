vim.pack.add({
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/m4xshen/autoclose.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp",             version = vim.version.range("*") },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/catgoose/nvim-colorizer.lua" },
    { src = "https://github.com/zbirenbaum/copilot.lua" },
    -- { src = "https://github.com/github/copilot.vim" },
})

local update_file = vim.fn.stdpath("config") .. "/last_update.txt"
local last_update = nil
local f = io.open(update_file, "r")
if f then
    last_update = f:read("*l")
    f:close()
end

local today = tostring(os.date("%Y-%m-%d"))
local weekday_num = os.date("%w") -- 0 = Sunday, 1 = Monday, ...

if weekday_num == '1' and last_update ~= today then
    vim.pack.update()
    local f_w = io.open(update_file, "w")
    if f_w then
        f_w:write(today)
        f_w:close()
    end
end

require("mini.pick").setup()
require("mini.icons").setup()
require("autoclose").setup()

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
    },
    snippets = { preset = 'luasnip' },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})

vim.api.nvim_create_user_command("ToggleBufCompletion", function()
    vim.b.completion = not (vim.b.completion ~= false)
    print("Blink completion (buffer): " .. (vim.b.completion and "enabled" or "disabled"))
end, {})

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

local map = vim.keymap.set

map('n', '<leader>lf', function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

require('colorizer').setup()

map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>b', ':Pick buffers<CR>')
map('n', '<leader>g', ':Pick grep_live<CR>')
map('n', '<leader>e', ':Oil<CR>')

local ls = require('luasnip')
ls.setup()
ls.filetype_extend('cpp', { 'c' })
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
require('luasnip.loaders.from_lua').lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

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
        tex = true,
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
