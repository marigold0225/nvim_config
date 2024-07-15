local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
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
