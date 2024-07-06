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
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.snippet.nvim-snippets" },

  { import = "astrocommunity.indent.indent-blankline-nvim" },

  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.utility.noice-nvim" },

  { import = "astrocommunity.markdown-and-latex.vimtex" },

  { import = "astrocommunity.completion.cmp-cmdline" },

  { import = "astrocommunity.motion.hop-nvim" },
}
