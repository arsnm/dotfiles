return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")

		-- enable comment
		comment.setup({})
	end,
}
