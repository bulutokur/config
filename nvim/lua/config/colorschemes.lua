-- =====================================================================
-- 1. DECLARE COLORSCHEME PACKAGES
-- =====================================================================
vim.pack.add({
  'https://github.com/andreasvc/vim-256noir',
  'https://github.com/lifepillar/vim-solarized8',
  'https://github.com/Mofiqul/vscode.nvim',
  'https://github.com/loctvl842/monokai-pro.nvim',
  'https://github.com/ficcdaf/ashen.nvim',
  'https://github.com/maxmx03/solarized.nvim',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/sainnhe/gruvbox-material',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/neanias/everforest-nvim',
  'https://github.com/thallada/farout.nvim',
  'https://github.com/savq/melange-nvim',
  'https://github.com/vimcolorschemes/olive-crt.nvim'
})

vim.o.background = "dark"
vim.cmd("colorscheme solarized8")

vim.cmd("colorscheme 256_noir")

require("vscode").setup({ transparent = false, italic_comments = true, terminal_colors = true })
 vim.cmd("colorscheme vscode")

require("ashen").setup({ style_presets = { italic_comments = true, bold_functions = true } })
vim.cmd("colorscheme ashen")

require("solarized").setup({ theme = "light" })
vim.o.background = "light"
vim.cmd("colorscheme solarized")

require("kanagawa").setup({ theme = "wave", commentStyle = { italic = true } })
vim.cmd("colorscheme kanagawa")

vim.g.gruvbox_material_background = "soft"
vim.cmd("colorscheme gruvbox-material")

require("tokyonight").setup({ style = "night" })
vim.cmd("colorscheme tokyonight")

require("everforest").setup({
  -- Your config here
})

vim.cmd([[colorscheme monokai-pro-classic]])
--vim.cmd("set background=dark")

-- White thick underline caret
--vim.api.nvim_set_hl(0, "CuretColor", {
--  bg = vim.o.background == "light" and "#000000" or "#FFFFFF",
--})

--White thick underline caret
--vim.api.nvim_set_hl(0, "CaretColor", {bg = "#FFFFFF"})

--[[
vim.opt.guicursor = table.concat({
  "n-v-c:hor40-CaretColor",
  "i-ci:hor40-CaretColor",
  "r-cr-o:hor40-CaretColor",
}, ",")
--]]

vim.cmd("colorscheme solarized8")
vim.cmd.colorscheme("melange")
vim.cmd("set background=dark")
vim.cmd("colorscheme olive-crt")
