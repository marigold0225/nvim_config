-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

    -- == Examples of Adding Plugins ==

    -- "andweeb/presence.nvim",
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
    },

    -- == Examples of Overriding Plugins ==
    -- customize alpha options
    {

        "vhyrro/luarocks.nvim",
        dependencies = {

            "MunifTanjim/nui.nvim",

            "nvim-neotest/nvim-nio",

            "nvim-neorg/lua-utils.nvim",

            "nvim-lua/plenary.nvim",

            "pysan3/pathlib.nvim",
        },
        priority = 1000,

        config = true,
        opts = {

            luarocks_build_args = {

                "--with-lua-include=/usr/include",
            },
        },
    },
    {
        "goolord/alpha-nvim",
        opts = function(_, opts)
            -- customize the dashboard header
            opts.section.header.val = {
                "██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗",
                "██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝",
                "██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗",
                "╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝",
                " ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗",
                "  ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝",
            }
            return opts
        end,
    },

    -- You can disable default plugins as follows:
    { "max397574/better-escape.nvim", enabled = true },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",

            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup {
                lsp = {
                    -- override markdown rendering so that **cmp** and other cores use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },

                    hover = { enabled = false },
                    signature = { enabled = false },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = false, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            }
        end,
    },
    {
        "rcarriga/nvim-notify",
        opts = {

            stages = "static",
            render = "compact",
            max_width = "50",
            fps = 5,
            level = 1,
            timeout = 1000,
        },
    },

    -- {

    --     "3rd/image.nvim",
    --     dependencies = { "luarocks.nvim" },
    --     -- config = true,
    --     config = function()
    --         -- ...
    --         require("image").setup {

    --             backend = "kitty",

    --             integrations = {

    --                 markdown = {

    --                     enabled = true,

    --                     clear_in_insert_mode = false,

    --                     download_remote_images = true,

    --                     only_render_image_at_cursor = false,

    --                     filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    --                 },

    --                 neorg = {

    --                     enabled = true,

    --                     clear_in_insert_mode = false,

    --                     download_remote_images = true,

    --                     only_render_image_at_cursor = false,

    --                     filetypes = { "norg" },
    --                 },
    --             },

    --             max_width = nil,

    --             max_height = nil,

    --             max_width_window_percentage = nil,

    --             max_height_window_percentage = 50,

    --             window_overlap_clear_enabled = true, -- toggles images when windows are overlapped

    --             window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

    --             editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus

    --             tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)

    --             hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
    --         }
    --     end,
    -- },

    {
        "nvim-neorg/neorg",
        -- "benlubas/neorg",
        -- branch = "feat/async_images",
        event = "VeryLazy",

        dependencies = {
            { "luarocks.nvim" },
            dependencies = { "max397574/neorg-contexts" },
            {
                "nvim-treesitter/nvim-treesitter",
            },
            { "nvim-lua/plenary.nvim" },
            { "folke/tokyonight.nvim", config = function(_, _) vim.cmd.colorscheme "tokyonight-night" end },
        },
        config = function()
            require("neorg").setup {

                load = {

                    ["core.defaults"] = {}, -- loads default behaviour
                    ["core.autocommands"] = {},
                    ["core.keybinds"] = {},
                    ["core.integrations.treesitter"] = {},
                    ["core.concealer"] = {}, -- adds pretty icons to your documents
                    ["core.ui.calendar"] = {}, -- adds "]
                    ["core.neorgcmd"] = {},
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                        },
                    },
                    ["core.journal"] = {},
                    ["core.highlights"] = {},
                    -- ["core.integrations.image"] = {},

                    -- ["core.latex.renderer"] = {
                    --     config = {
                    --         conceal = true,
                    --         min_length = 3,
                    --         dpi = 300,
                    --         render_on_enter = true,
                    --         renderer = "core.integrations.image",
                    --         scale = 1,
                    --     },
                    -- },

                    ["core.dirman"] = { -- manages neorg workspaces

                        config = {

                            workspaces = {

                                notes = "~/notes",
                            },

                            default_workspace = "notes",
                        },
                    },
                },
            }
        end,
    },
    {
        "mikavilpas/yazi.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>ya",
                function() require("yazi").yazi() end,
                desc = "Open the file manager",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                function() require("yazi").yazi(nil, vim.fn.getcwd()) end,
                desc = "Open the file manager in nvim's working directory",
            },
        },
        -- -@type YaziConfig
        opts = {
            open_for_directories = false,
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        config = function()
            require("transparent").setup { -- Optional, you don't have to run setup.
                groups = { -- table: default groups
                    "Normal",
                    "NormalNC",
                    "Comment",
                    "Constant",
                    "Special",
                    "Identifier",
                    "Statement",
                    "PreProc",
                    "Type",
                    "Underlined",
                    "Todo",
                    "String",
                    "Function",
                    "Conditional",
                    "Repeat",
                    "Operator",
                    "Structure",
                    "LineNr",
                    "NonText",
                    "SignColumn",
                    "CursorLine",
                    "CursorLineNr",
                    "StatusLine",
                    "StatusLineNC",
                    "EndOfBuffer",
                },
                extra_groups = {}, -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- after = "nvim-treesitter",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
                            -- ["aa"] = "@parameter.outer",
                            -- ["ia"] = "@parameter.inner",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
            }
        end,
    },
}
