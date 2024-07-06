-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
    "nvimtools/none-ls.nvim",
    opts = function(_, config)
        -- config variable is the default configuration table for the setup function call
        local null_ls = require "null-ls"

        local clang_format = null_ls.builtins.formatting.clang_format.with {
            extra_args = { "-style", "{BasedOnStyle: LLVM, IndentWidth: 4}" },
        }

        local black = null_ls.builtins.formatting.black.with {
            filetypes = { "python" },
            extra_args = { "--line-length", "80" },
        }

        config.sources = {
            -- Set a formatter
            null_ls.builtins.formatting.stylua,
            clang_format,
            black,

            -- null_ls.builtins.formatting.prettier,
        }
        return config -- return final config table
    end,
}
