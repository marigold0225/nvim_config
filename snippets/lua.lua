local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
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
