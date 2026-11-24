vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load keymaps and consolidated plugins
require("config.colorschemes")
require("config.plugins")
require("config.keymaps")

-- =====================================================================
-- GENERAL EDITOR SETTINGS & HIGHLIGHTS
-- =====================================================================
vim.o.termguicolors = true
vim.o.cursorline = false
vim.opt.indentexpr = ""
vim.opt.autoindent = false
vim.opt.smartindent = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

vim.cmd([[autocmd FileType * inoremap : :]])
vim.cmd("set cinkeys -=:")
vim.cmd(":set tabstop=2 shiftwidth=2 softtabstop=2 expandtab")

-- Custom C / C++ Syntax Highlights
--[[
vim.cmd("highlight clear")
vim.api.nvim_set_hl(0, "Normal", { fg = "#FFFFFF", bg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFFFF", bold = true })
vim.api.nvim_set_hl(0, "Comment", { fg = "#A0A0A0", italic = true })
vim.api.nvim_set_hl(0, "@variable", { fg = "#87CEFA" })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "Number", { fg = "#00FF7F" })
vim.api.nvim_set_hl(0, "String", { fg = "#FFFF99" })
vim.api.nvim_set_hl(0, "Delimiter", { fg = "#FFFF99" })
vim.api.nvim_set_hl(0, "Type", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#FFFFFF", bold = true })
vim.api.nvim_set_hl(0, "Statement", { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "PreProc", { fg = "#FFFFFF" })
--]]

-- White thick underline caret
--[[
vim.api.nvim_set_hl(0, "WhiteCursor", { fg = "#000000", bg = "#FFFFFF" })
vim.opt.guicursor = table.concat({
  "n-v-c:hor40-WhiteCursor",
  "i-ci:hor40-WhiteCursor",
  "r-cr-o:hor40-WhiteCursor",
}, ",")
--]]

-- =====================================================================
-- CLANGD (C / C++ Competitive Programming LSP)
-- =====================================================================
vim.lsp.enable('clangd')

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
      virtual_text = { source = "if_many", prefix = "●", spacing = 2 },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { border = "rounded", source = "if_many", focusable = false },
    })
    vim.o.updatetime = 750
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = 0,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false, scope = "cursor", border = "rounded", source = "if_many" })
      end,
    })
  end,
})

-- Set 8 spaces exclusively for Assembly (.asm) files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "asm", "nasm" },
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

vim.cmd("colorscheme solarized8")
vim.cmd("set background=dark")
