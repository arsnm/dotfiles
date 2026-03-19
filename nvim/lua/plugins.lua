-- This file only declare the plugins to install, the configuration of each
-- plugin is in a separate file in the "plugins" directory (the configuration
-- are required manually).
-- The plugins are automatically updadted very Monday.

-- Plugins list
vim.pack.add({
    { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/m3xshen/autoclose.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/saghen/blink.cmp",             version = vim.version.range("*") },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/L2MON4D3/LuaSnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/catgoose/nvim-colorizer.lua" },
    { src = "https://github.com/zbirenbaum/copilot.lua" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

-- Auto-update plugins
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

-- Load plugins configuration
require("plugins_conf.mini_pick")
require("plugins_conf.mini_icons")
require("plugins_conf.autoclose")
require("plugins_conf.oil")
require("plugins_conf.mason")
require("plugins_conf.lspconfig")
require("plugins_conf.blink_cmp")
require("plugins_conf.conform")
require("plugins_conf.colorizer")
require("plugins_conf.luasnip")
require("plugins_conf.copilot")
