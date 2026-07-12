require("config.lazy")
require("config.keymaps")
require("plugins.telescope")
--require("plugins.treesitter")
require("plugins.autopairs")
require("plugins.colorscheme")
--require("plugins.vimtex")
--require("plugins.nvim-tree")
require("plugins.indentscope")
require("plugins.typst")

-- Block caret 
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"

-- No line highlighting
vim.o.cursorline = false

-- Disable cursorline specifically for netrw
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

vim.cmd("colorscheme solarized")

-- Colorscheme
vim.cmd("colorscheme blue")
vim.cmd("highlight clear")

-- Base text & line numbers
vim.api.nvim_set_hl(0, "Normal", { fg = "#FFFFFF", bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFFFF", bold = true })

-- Comments (light gray)
vim.api.nvim_set_hl(0, "Comment", { fg = "#A0A0A0", italic = true })

-- Variables: user variables light blue, built-ins white
vim.api.nvim_set_hl(0, "@variable", { fg = "#87CEFA" })         -- user vars
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#FFFFFF" }) -- cin, cout
vim.api.nvim_set_hl(0, "Identifier", { fg = "#FFFFFF" })        -- fallback

-- Built-in functions (e.g., sync_with_stdio)
vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#FFFFFF" })

-- Numbers (green)
vim.api.nvim_set_hl(0, "Number", { fg = "#00FF7F" })

-- Strings and Braces {} (light yellow)
vim.api.nvim_set_hl(0, "String", { fg = "#FFFF99" })
vim.api.nvim_set_hl(0, "Delimiter", { fg = "#FFFF99" })

-- Types (white)
vim.api.nvim_set_hl(0, "Type", { fg = "#FFFFFF" })

-- Keywords (white)
vim.api.nvim_set_hl(0, "Keyword", { fg = "#FFFFFF", bold = true })
vim.api.nvim_set_hl(0, "Statement", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "PreProc", { fg = "#FFFFFF" })

-- Thick underline cursor
--vim.opt.guicursor = "n-v-c:hor20,i-ci:hor20,r-cr-o:hor20"

vim.cmd([[autocmd FileType * inoremap : :]])
vim.opt.indentexpr = ""
vim.opt.autoindent = false
vim.opt.smartindent = false

--vim.cmd("colorscheme blue")
vim.cmd("set cinkeys -=:") -- std:: fix
vim.cmd(":set tabstop=2 shiftwidth=2 softtabstop=2 expandtab")

vim.cmd("colorscheme ashen")

--vim.opt.guicursor = "i:hor40"
vim.cmd("colorscheme solarized8")
vim.cmd("set background=light")

-- Kitty controls the caret, probably.
--vim.opt.guicursor = { "i:hor40-blinkon5-blinkoff5-blinkwait0" }
--vim.opt.guicursor = { "i:ver25" }

-- Thick underline cursor
--vim.opt.guicursor = "n-v-c:hor20,i-ci:hor20,r-cr-o:hor20"
--
-- bar cursor ?
--vim.opt.guicursor = {
 -- "i-ci:hor20",
--}

--[[
vim.cmd("set background=dark")
-- The function to set transparent highlights
local function set_transparent_highlights()
  local highlights = {
    "Normal",      -- The normal editor background
    "NormalFloat", -- Floating windows like LSP info
    "MsgArea",     -- The message area at the bottom
    "SignColumn",  -- The column where git signs, etc., appear
    "LineNr",      -- Line numbers
    "CursorLineNr",-- The line number on the current line
    "EndOfBuffer", -- The tilde (~) characters at the end of the file
    "WinSeparator",-- Separators between vertical/horizontal splits
  }

  for _, group in ipairs(highlights) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

-- extend your function to cover nvim-tree groups
local function set_transparent_highlights()
  local highlights = {
    "Normal",
    "NormalFloat",
    "MsgArea",
    "SignColumn",
    "LineNr",
    "CursorLineNr",
    "EndOfBuffer",
    "WinSeparator",

    -- nvim-tree specific
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "NvimTreeEndOfBuffer",
    "NvimTreeVertSplit",
  }

  for _, group in ipairs(highlights) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

-- Call the function to apply the settings
set_transparent_highlights()
--]]


vim.lsp.enable('clangd')
--vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"

-- LSP config for clangd
vim.lsp.config['clangd'] = {
  cmd = {
    'clangd',
    '--header-insertion=never',
    '--clang-tidy',
    '--suggest-missing-includes',
    '--completion-style=detailed',
    '--background-index',
    '--cross-file-rename',
    '--enable-config',
    '--offset-encoding=utf-16',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = { 'compile_commands.json', '.clangd', '.git' },
  settings = {
    clangd = {
      fallbackFlags = { '-std=c++23' },
    },
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
  callback = function()
    vim.diagnostic.config({
      virtual_text = {
        source = "if_many",
        prefix = "●",
        spacing = 2,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "if_many",
        focusable = false,
      },
    })

    vim.o.updatetime = 750

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = 0,
      callback = function()
        vim.diagnostic.open_float(nil, {
          focus = false,
          scope = "cursor",
          border = "rounded",
          source = "if_many",
        })
      end,
    })
  end,
})

vim.lsp.enable('clangd')

--vim.cmd("colorscheme 256_noir")

--vim.opt.guicursor = "i-ci:hor20,r-cr-o:hor20"
--vim.cmd("colorscheme vscode")
--
--vim.cmd("colorscheme blue")

vim.cmd("colorscheme solarized")
vim.cmd("set background=light")

vim.cmd [[highlight LspReferenceText cterm=bold guibg=LightYellow]]
vim.cmd [[highlight LspReferenceRead cterm=bold ctermbg=0 guibg=LightYellow]]
vim.cmd [[highlight LspReferenceWrite cterm=bold ctermbg=0 guibg=LightYellow]]
