-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
    "nvimtools/none-ls.nvim",
    opts = function(_, config)
        -- config variable is the default configuration table for the setup function call
        local null_ls = require "null-ls"

        local formatting = null_ls.builtins.formatting
        local code_action = null_ls.builtins.code_actions
        local diagnostics = null_ls.builtins.diagnostics

        -- set a diagnostics
        -- local cmake_lint = { diagnostics.cmake_lint }

        -- Set a code_action
        local proselint = code_action.proselint
        --set a formatter
        local clang_format = formatting.clang_format.with {
            filetypes = { "c", "cpp", "cs", "java", "cuda", "proto" },
            extra_args = { "-style=file:" .. vim.fn.expand "~/.config/nvim/.clang-format" },
        }
        local cmake_format = formatting.cmake_format.with {
            filetypes = { "cmake" },
        }
        local findent = formatting.findent.with {
            filetypes = { "fortran" },
            extra_args = { "-i4" },
        }
        local codespell = formatting.codespell
        local black = formatting.black.with {
            filetypes = { "python" },
            extra_args = { "--line-length", "80" },
        }

        config.sources = require("astrocore").list_insert_unique(config.sources, {
            -- Set a formatter
            clang_format,
            formatting.stylua,
            black,
            formatting.prettier,
            cmake_format,
            findent,
            codespell,
            -- codeaction
            proselint,
            -- diagnostics
            diagnostics.codespell,
        })

        return config -- return final config table
    end,
    -- event = "BufEnter",
}
