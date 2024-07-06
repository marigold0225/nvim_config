return { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
        -- opts parameter is the default options table
        -- the function is lazy loaded so cmp is able to be required
        local cmp = require "cmp"
        -- modify the sources part of the options table
        opts.sources = cmp.config.sources {
            { name = "copilot", priority = 1200 },
            { name = "nvim_lsp", priority = 1000 },
            { name = "luasnip", priority = 750 },
            { name = "buffer", priority = 500 },
            { name = "path", priority = 250 },
        }
    end,
}

-- local has_words_before = function()
--     unpack = unpack or table.unpack
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
-- end

-- local luasnip = require "luasnip"
-- local cmp = require "cmp"

-- return {
--     "hrsh7th/nvim-cmp",
--     config = function()
--         cmp.setup {
--             snippet = {
--                 expand = function(args)
--                     require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
--                 end,
--             },
--             mapping = cmp.mapping.preset.insert {
--                 -- Use <C-b/f> to scroll the docs
--                 ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--                 ["<C-f>"] = cmp.mapping.scroll_docs(4),
--                 -- Use <C-k/j> to switch in items
--                 ["<C-k>"] = cmp.mapping.select_prev_item(),
--                 ["<C-j>"] = cmp.mapping.select_next_item(),
--                 ["<CR>"] = cmp.mapping.confirm { select = true },

--                 -- A super tab
--                 ["<Tab>"] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_next_item()
--                     elseif has_words_before() then
--                         cmp.complete()
--                     else
--                         fallback()
--                     end
--                 end, { "i", "s" }), -- i - insert mode; s - select mode
--                 ["<S-Tab>"] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_prev_item()
--                     elseif luasnip.jumpable(-1) then
--                         luasnip.jump(-1)
--                     else
--                         fallback()
--                     end
--                 end, { "i", "s" }),
--             },
--             -- Let's configure the item's appearance
--             -- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
--             formatting = {
--                 fields = { "abbr", "menu" },

--                 format = function(entry, vim_item)
--                     vim_item.menu = ({
--                         nvim_lsp = "[Lsp]",
--                         luasnip = "[Luasnip]",
--                         buffer = "[File]",
--                         path = "[Path]",
--                     })[entry.source.name]
--                     return vim_item
--                 end,
--             },

--             -- Set source precedence
--             sources = cmp.config.sources {
--                 { name = "nvim_lsp" }, -- For nvim-lsp
--                 { name = "luasnip" }, -- For luasnip user
--                 { name = "buffer" }, -- For buffer word completion
--                 { name = "path" }, -- For path completion
--             },
--         }
--     end,
-- }
