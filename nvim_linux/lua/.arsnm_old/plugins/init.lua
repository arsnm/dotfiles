return {
	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',

	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = 'ibl',
		opts = {},
	},

	"nvim-lua/plenary.nvim", -- lua functions that many plugins use

	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	"inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
}
