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

vim.keymap.set('n', '<leader>e', ':Oil<CR>')
