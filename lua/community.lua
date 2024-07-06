-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
    -- import/override with your plugins folder
    { import = "astrocommunity.colorscheme.catppuccin" },
    { import = "astrocommunity.colorscheme.tokyonight-nvim" },

    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.cmake" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.bash" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.markdown-and-latex.vimtex" },
    -- { import = "astrocommunity.snippet.nvim-snippets" },

    { import = "astrocommunity.indent.indent-blankline-nvim" },
    { import = "astrocommunity.indent.mini-indentscope" },

    { import = "astrocommunity.utility.noice-nvim" },

    { import = "astrocommunity.completion.cmp-cmdline" },
    { import = "astrocommunity.completion.cmp-latex-symbols" },
    { import = "astrocommunity.completion.cmp-emoji" },
    { import = "astrocommunity.completion.copilot-cmp" },

    { import = "astrocommunity.motion.flash-nvim" },
    { import = "astrocommunity.diagnostics.trouble-nvim" },

    { import = "astrocommunity.code-runner.sniprun" },
    { import = "astrocommunity.bars-and-lines.vim-illuminate" },

    { import = "astrocommunity.bars-and-lines.lualine-nvim" },
}
