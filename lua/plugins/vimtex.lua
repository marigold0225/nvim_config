return {
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_general_viewer = "SumatraPDF"
            -- vim.g.vimtex_view_general_options = '--reuse-instance --forward-search @tex @line @pdf'
            -- vim.g.vimtex_compiler_latexmk_engines = {
            --     -- _ = '-xelatex'
            -- }
            vim.g.vimtex_compiler_latexmk_engines = {
                _ = "-pdf",
                pdflatex = "-pdf",
                dvipdfex = "-pdfdvi",
                lualatex = "-lualatex",
                xelatex = "-xelatex",
                ["context (pdftex)"] = "-pdf -pdflatex=texexec",
                ["context (luatex)"] = "-pdf -pdflatex=context",
                ["context (xetex)"] = "-pdf -pdflatex='texexec --xtx'",
            }
            vim.g.vimtex_quickfix_open_on_warning = 0

            -- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
        end,
    },
}
