-- =====================================================================
-- 1. DECLARE FUNCTIONAL PLUGINS
-- =====================================================================
vim.pack.add({
  -- Dependencies & Icons
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',

  -- Core Plugins
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/hat0uma/csvview.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
 -- 'https://github.com/ThePrimeagen/vim-be-good',

  -- Autocompletion Stack (nvim-cmp)
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',

  -- Optional / Disabled:
  -- 'https://github.com/nvim-tree/nvim-tree.lua',
 --  'https://github.com/echasnovski/mini.indentscope',
   'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/chomosuke/typst-preview.nvim',
  'https://github.com/nvim-mini/mini.map',
  'https://github.com/folke/trouble.nvim',
})

-- =====================================================================
-- 2. PLUGIN CONFIGURATIONS
-- =====================================================================

-- Autopairs
require("nvim-autopairs").setup({ check_ts = true })

-- CSV View
require("csvview").setup({
  parser = { comments = { "#", "//" } },
  keymaps = {
    textobject_field_inner = { "if", mode = { "o", "x" } },
    textobject_field_outer = { "af", mode = { "o", "x" } },
    jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
    jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
    jump_next_row = { "<Enter>", mode = { "n", "v" } },
    jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
  },
})

-- Telescope
require("telescope").setup({})

-- Statusline (lualine)
require("lualine").setup({
  options = {
    theme = "gruvbox-material",
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

-- nvim-cmp + LuaSnip
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Vim Be Good
vim.g.vim_be_good_delete_me_offset = 35

local map = require('mini.map')

vim.api.nvim_set_hl(0, 'MiniMapCurrentLine', {
  fg = '#f9e2af',
  bold = true,
})

local function current_line()
  local source_buf = MiniMap.current.buf_data.source
  if not source_buf or not vim.api.nvim_buf_is_valid(source_buf) then
    return {}
  end

  local source_win = vim.fn.bufwinid(source_buf)
  if source_win == -1 then
    return {}
  end

  return {
    {
      line = vim.api.nvim_win_get_cursor(source_win)[1],
      hl_group = 'MiniMapCurrentLine',
    },
  }
end

map.setup({
  integrations = {
    current_line,
    map.gen_integration.builtin_search(),
    map.gen_integration.diagnostic({
      error = 'DiagnosticFloatingError',
      warn = 'DiagnosticFloatingWarn',
      info = 'DiagnosticFloatingInfo',
      hint = 'DiagnosticFloatingHint',
    }),
  },

  symbols = {
    encode = map.gen_encode_symbols.block('3x2'),
    scroll_line = '',
    scroll_view = '',
  },

  window = {
    side = 'right',
    width = 14,
    winblend = 100,
    show_integration_count = false,
  },
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  callback = function()
    if MiniMap.current.win_data[vim.api.nvim_get_current_tabpage()] then
      MiniMap.refresh({}, {
        lines = false,
        scrollbar = false,
        integrations = true,
      })
    end
  end,
})

vim.keymap.set('n', '<leader>mt', MiniMap.toggle)
vim.keymap.set('n', '<leader>mf', MiniMap.toggle_focus)
vim.keymap.set('n', '<leader>ms', MiniMap.toggle_side)
require("trouble").setup({})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {
  desc = "Diagnostics (Trouble)",
})

--[[
require("mini.indentscope").setup({
  symbol = "┇",
  draw = {
    delay = 50,
  },
    options = {
    try_as_border = true,
  },
})
--]]
