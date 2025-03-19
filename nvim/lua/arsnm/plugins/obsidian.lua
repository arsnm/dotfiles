return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
        "BufReadPre /Users/arsnm/vaults/zettelkasten/**.md",
        "BufNewFile /Users/arsnm/vaults/zettelkasten/**.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        workspaces = {
            {
                name = "school",
                path = "~/vaults/zettelkasten/areas/school",
            },
            {
                name = "zettelkasten",
                path = "~/vaults/zettelkasten",
            },
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        new_notes_location = "current_dir",
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>oc"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                desc = { "Toogle checkbox" },
                opts = { buffer = true },
            },
        },
    },
}
