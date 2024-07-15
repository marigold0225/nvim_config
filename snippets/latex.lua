local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
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
        t { "", "\\end{itemize}" },
    }),
}
