return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness
        local builtin = require("telescope.builtin")

        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Fuzzy find string in cwd" })
        keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Fuzzy find string under cursor in cwd" })
        keymap.set("n", "<leader>fb", "builtin.buffers", { desc = "Fuzzy find opened buffers" })
        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    end,
}
