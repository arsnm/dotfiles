-- Options

local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scopped)

-- Case insensitive search unless precised
opt.ignorecase = true
opt.smartcase = true

-- Show line number
opt.number = true
opt.relativenumber = true

-- Enable mouse mode
opt.mouse = "a"

-- Display colors properly
opt.termguicolors = true

-- Change leader bind
g.mapleader = " "
g.localmapleader = " "

-- Hide the mode, since it's already in status line
opt.showmode = false

-- Enable break indent
opt.breakindent = true

-- Set clipboard to default settings (because of LazyVim default config)
opt.clipboard = ""

-- Save undo history
opt.undofile = true

-- Specify fold method
opt.foldmethod = "marker"

-- Disable line wrapping by default
opt.wrap = false

-- Specify default split config
opt.splitright = true
opt.splitbelow = true

-- Line length marker at the 'x'-th column
opt.colorcolumn = "80"

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Sets how neovim will display certain whitespace in the editor.
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Show which line cursor is on
opt.cursorline = true

-- Min number of line to keep above and below the cursor
opt.scrolloff = 20

-- Indicate python path for neovim
g.python3_host_prog = os.getenv("HOME") .. "/venvs/neovim/bin/python"

-- Tabs behavior
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
