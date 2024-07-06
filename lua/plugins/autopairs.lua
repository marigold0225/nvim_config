-- autopair.lua
local M = {}

function M.config()
    local autopairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"
    local cond = require "nvim-autopairs.conds"

    autopairs.setup {
        map_char = {
            all = "(",
            tex = "{",
        },
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = false,
        disable_in_visualblock = false,
        disable_in_replace_mode = true,
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        enable_afterquote = true,
        enable_abbr = false,
        break_undo = true,
        map_cr = true,
        map_bs = true,
        map_c_w = false,
        map_c_h = false,
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",
            highlight_grey = "Comment",
        },
    }

    autopairs.add_rules {
        Rule("(", ")"):with_pair(cond.not_after_regex "%w"):with_pair(cond.not_before_regex("%w", 1)),

        Rule("{", "}"):with_pair(cond.not_after_regex "%w"):with_pair(cond.not_before_regex("%w", 1)),

        Rule("[", "]"):with_pair(cond.not_after_regex "%w"):with_pair(cond.not_before_regex("%w", 1)),

        Rule("$", "$", { "tex", "latex" })
            :with_pair(cond.not_after_regex "%%")
            :with_pair(cond.not_before_regex("xxx", 3))
            :with_move(cond.none())
            :with_del(cond.not_after_regex "xx")
            :with_cr(cond.none()),

        -- Rule("a", "a", "-vim"),
    }
    -- CMP integration for autopairs
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
end

M.setup = function()
    local status_ok, autopairs = pcall(require, "nvim-autopairs")
    if status_ok then M.config() end
end

return {
    "windwp/nvim-autopairs",
    config = M.setup,
}
