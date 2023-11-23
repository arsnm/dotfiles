return {
	-- -- Theme inspired by Atom
	-- 'navarasu/onedark.nvim',
	-- priority = 1000,
	-- lazy = false,
	-- config = function()
	-- 	vim.cmd.colorscheme 'onedark'
	-- end,
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = false
		})
		-- setup must be called before loading
		vim.cmd.colorscheme "catppuccin"
	end,
}
