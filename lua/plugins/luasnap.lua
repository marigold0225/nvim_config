return {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
        require "astronvim.plugins.configs.luasnip"(plugin, opts)
        local ls = require "luasnip"
        ls.filetype_extend("javascript", { "javascriptreact" })

        vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if ls.choice_active() then ls.change_choice(1) end
        end, { silent = true })

        require("luasnip.loaders.from_lua").lazy_load { "~/.config/nvim/snippets" }
    end,
    event = "InsertEnter",
    dependencies = {
        "friendly-snippets",
    },
}
