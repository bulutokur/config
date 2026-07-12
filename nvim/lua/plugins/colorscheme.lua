return {
    -- Solarized8 Colorscheme (Default)
    {
        "lifepillar/vim-solarized8",
        lazy = false,
        priority = 1200, -- load before everything else
        config = function()
            vim.o.termguicolors = true
            vim.o.background = "dark" -- or "light"
            vim.cmd("colorscheme solarized8")
        end,
    },

    -- VSCode Colorscheme (NEW)
    {
        "Mofiqul/vscode.nvim",
        lazy = true,
        priority = 1150, -- right after solarized8
        config = function()
            vim.o.termguicolors = true
            vim.o.background = "dark" -- or "light"

            local c = require("vscode.colors").get_colors()
            require("vscode").setup({
                transparent = false,
                italic_comments = true,
                italic_inlayhints = true,
                disable_nvimtree_bg = true,
                terminal_colors = true,
            })

            -- To load immediately, uncomment below:
            -- vim.cmd.colorscheme("vscode")
        end,
    },

    -- Monokai Pro Colorscheme (Optional)
    {
        "loctvl842/monokai-pro.nvim",
        lazy = true,
        priority = 1100,
        opts = {
            filter = "pro",
            transparent_background = false,
            terminal_colors = true,
            devicons = true,
            styles = {
                comment = { italic = true },
                keyword = { italic = true },
                type = { italic = true },
                storageclass = { italic = true },
                structure = { italic = true },
            },
            override = function(c)
                return {
                    Type = { fg = "#5fd7ff", italic = true },
                    StorageClass = { fg = "#5fd7ff", italic = true },
                    Structure = { fg = "#5fd7ff", italic = true },
                    Keyword = { fg = "#a9dc76", italic = true },
                    Boolean = { fg = "#a9dc76", italic = true },
                    Statement = { fg = "#a9dc76", italic = true },
                    ["@type"] = { fg = "#5fd7ff", italic = true },
                    ["@type.builtin"] = { fg = "#5fd7ff", italic = true },
                    ["@storageclass"] = { fg = "#5fd7ff", italic = true },
                    ["@keyword"] = { fg = "#a9dc76", italic = true },
                    ["@boolean"] = { fg = "#a9dc76", italic = true },
                }
            end,
        },
        config = function(_, opts)
            require("monokai-pro").setup(opts)
        end,
    },

    -- Ashen Colorscheme (Optional)
    {
        "ficcdaf/ashen.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            style_presets = {
                italic_comments = true,
                bold_functions = true,
            },
        },
        config = function(_, opts)
            require("ashen").setup(opts)
        end,
    },

    -- Solarized.nvim (Optional alternative)
    {
        "maxmx03/solarized.nvim",
        lazy = true,
        priority = 900,
        opts = { theme = "light" },
        config = function(_, opts)
            vim.o.termguicolors = true
            vim.o.background = "light"
            require("solarized").setup(opts)
        end,
    },

    -- Kanagawa Colorscheme (Optional)
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 800,
        config = function()
            require("kanagawa").setup({
                commentStyle = { italic = true },
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                theme = "wave",
                background = { dark = "wave", light = "lotus" },
            })
        end,
    },

    -- Gruvbox Material Colorscheme (Optional)
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        priority = 700,
        config = function()
            vim.g.gruvbox_material_background = "soft"
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_better_performance = 1
            vim.o.background = "dark"
        end,
    },

    -- Tokyo Night Colorscheme (Optional)
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 650,
        opts = {
            style = "night",
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                functions = { bold = true },
            },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
        end,
    },
}

