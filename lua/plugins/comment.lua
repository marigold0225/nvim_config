local M = {}

M.config = {
    active = true,
    on_config_done = nil,
    padding = true,
    sticky = true,
    ignore = "^$",
    mappings = {
        basic = true,
        extra = true,
    },
    toggler = {
        line = "gcc",
        block = "gbc",
    },
    opleader = {
        line = "gc",
        block = "gb",
    },
    extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
    },
    pre_hook = function(...)
        local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
        if loaded and ts_comment then return ts_comment.create_pre_hook()(...) end
    end,
    post_hook = nil,
}

M.setup = function()
    local status_ok, nvim_comment = pcall(require, "Comment")
    if not status_ok then return end

    nvim_comment.setup(M.config)
    if M.config.on_config_done then M.config.on_config_done(nvim_comment) end
end

return {
    "numToStr/Comment.nvim",
    config = M.setup,
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    event = "BufRead",
    enabled = true,
}
