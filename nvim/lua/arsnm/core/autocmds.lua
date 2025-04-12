-- Autocmds are automatically loaded on VeryLazy event

-- Disable completion on markdown files by default
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        require("cmp").setup({ enabled = false })
    end,
})

-- Change options for Markdown files
local function setup_markdown_options()
    vim.bo.textwidth = 90
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.opt.display:append("truncate")
end

local function reset_markdown_options()
    vim.bo.textwidth = 0
    vim.wo.wrap = false
    vim.wo.linebreak = false
    vim.wo.colorcolumn = ""
    vim.opt.display:remove("truncate")
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        setup_markdown_options()
    end,
})

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = { "*.md" },
    callback = function()
        reset_markdown_options()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "ocaml" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- -- Create an augroup to manage our autocmds
-- local augroup = vim.api.nvim_create_augroup("LaTeXRelativeNumber", { clear = true })
--
-- -- Define the autocmd to disable relative numbers for LaTeX files
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "tex",
-- 	group = augroup,
-- 	callback = function()
-- 		vim.opt.relativenumber = false
-- 	end,
-- })
--
-- -- Define the autocmd to enable relative numbers for non-LaTeX files
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*",
-- 	group = augroup,
-- 	callback = function()
-- 		if vim.bo.filetype ~= "tex" then
-- 			vim.opt.relativenumber = true
-- 		end
-- 	end,
-- })
