-- Gruber-darker colorscheme config
require('gruber-darker.config').setup({
  bold = true,
  invert = {
    signs = false,
    tabline = false,
    visual = false,
  },
  italic = {
    strings = false,
    comments = true,
    operators = false,
    folds = true,
  },
  undercurl = true,
  underline = true,
})

vim.cmd('colorscheme gruber-darker')

vim.api.nvim_set_hl(0, "GruberDarkerDarkNiagara", { fg = "#6d80a8"}) -- needed to make this hl_group more readable

local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false})
vim.api.nvim_set_hl(0, "Winbar", { link = "GruberDarkerYellowBold" })

