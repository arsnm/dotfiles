local ls = require('luasnip')

ls.setup()
ls.filetype_extend('cpp', { 'c' })
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
require('luasnip.loaders.from_lua').lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
