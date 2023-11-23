return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local whichkey = require("which-key")

		whichkey.register({
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>e"] = { name = "File [E]xplorer", _ = "which_key_ignore" },
			["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
			["<leader>h"] = { name = "[H]arpoon", _ = "which_key_ignore" },
			["<leader>m"] = { name = "[M]ason", _ = "which_key_ignore" },
			["<leader>n"] = { name = "[N]ext", _ = "which_key_ignore" },
			["<leader>p"] = { name = "[P]revious", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]plit", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[T]ab", _ = "which_key_ignore" },
		})
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
