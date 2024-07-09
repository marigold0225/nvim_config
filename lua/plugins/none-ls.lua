-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
    "nvimtools/none-ls.nvim",
    opts = function(_, config)
        -- config variable is the default configuration table for the setup function call
        local null_ls = require "null-ls"
        local formatting = null_ls.builtins.formatting

        local clang_format = formatting.clang_format.with {
            extra_args = { "-style", "{BasedOnStyle: LLVM, IndentWidth: 4}" },
        }

        local black = formatting.black.with {
            filetypes = { "python" },
            extra_args = { "--line-length", "80" },
        }

        config.sources = {
            -- Set a formatter
            formatting.stylua,
            clang_format,
            black,
            formatting.prettier,
        }
        return config -- return final config table
    end,
}
