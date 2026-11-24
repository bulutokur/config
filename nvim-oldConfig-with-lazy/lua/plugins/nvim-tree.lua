
return {
  --[[
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    require("nvim-tree").setup()

    vim.keymap.set('n', '<leader>fe', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    -- auto-close tree on quit
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          require("nvim-tree.api").tree.close()
        end,
      })
  end
  --]]
}
