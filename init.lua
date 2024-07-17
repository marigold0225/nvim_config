-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
-- 自动切换输入法为英文

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.o.guifont = "JetBrainsMono Nerd Font:h16" -- text below applies for VimScript
    vim.g.neovide_transparency = 0.75
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_profiler = false

    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    vim.g.neovide_text_gamma = 0.0
    vim.g.neovide_text_contrast = 0.5

    vim.g.neovide_scale_factor = 1.0

    vim.opt.linespace = 0
end

vim.cmd [[
  augroup imselect
    autocmd!
    autocmd InsertLeave * silent !im-select.exe 1033
    autocmd InsertEnter * silent !im-select.exe 1033
  augroup END
]]
-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
end

require "lazy_setup"
require "polish"
