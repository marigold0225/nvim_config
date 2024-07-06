local ls = require "luasnip"

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.conditions"
local conds_expand = require "luasnip.extras.conditions.expand"

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls
rec_ls = function()
    return sn(
        nil,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t "",
            sn(nil, { t { "", "\t\\item " }, i(1), d(2, rec_ls, {}) }),
        })
    )
end
-- 定义代码片段
local lua_snippets = {
    s("func", {
        t "function ",
        i(1, "name"),
        t "(",
        i(2, "params"),
        t ")",
        t { "", "  " },
        i(0),
        t { "", "end" },
    }),
    s("local", {
        t "local ",
        i(1, "var"),
        t " = ",
        i(0, "value"),
    }),
}

local python_snippets = {
    s("class", {
        t "class ",
        i(1, "ClassName"),
        t { ":", "    def __init__(self, " },
        i(2, "params"),
        t { "):", "        " },
        i(0),
    }),
    s("def", {
        t "def ",
        i(1, "function_name"),
        t "(",
        i(2, "params"),
        t { "):", "    " },
        i(0),
    }),
}

local latex_snippets = {
    s("beg", {
        t "\\begin{",
        i(1, "environment"),
        t { "}", "  " },
        i(0),
        t { "", "\\end{" },
        rep(1),
        t "}",
    }),
    s("sec", {
        t "\\section{",
        i(1, "section_title"),
        t "}",
        t { "", "" },
        i(0),
    }),
    s("ls", {
        t { "\\begin{itemize}", "\t\\item " },
        i(1),
        d(2, rec_ls, {}),
        t { "", "\\end{itemize}" },
    }),
}

-- 添加代码片段

ls.add_snippets("lua", lua_snippets, { key = "lua_snippets" })
ls.add_snippets("python", python_snippets, { key = "python_snippets" })
ls.add_snippets("tex", latex_snippets, { key = "latex_snippets" })
