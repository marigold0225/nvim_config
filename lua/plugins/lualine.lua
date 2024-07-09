local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    purple = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
}

local icons = {
    use_icons = true,
    kind = {
        Array = "",
        Boolean = "",
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "󰉋",
        Function = "",
        Interface = "",
        Key = "",
        Keyword = "",
        Method = "",
        Module = "",
        Namespace = "",
        Null = "󰟢",
        Number = "",
        Object = "",
        Operator = "",
        Package = "",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "",
    },
    git = {
        LineAdded = "",
        LineModified = "",
        LineRemoved = "",
        FileDeleted = "",
        FileIgnored = "◌",
        FileRenamed = "",
        FileStaged = "S",
        FileUnmerged = "",
        FileUnstaged = "",
        FileUntracked = "U",
        Diff = "",
        Repo = "",
        Octoface = "",
        Branch = "",
    },
    ui = {
        ArrowCircleDown = "",
        ArrowCircleLeft = "",
        ArrowCircleRight = "",
        ArrowCircleUp = "",
        BoldArrowDown = "",
        BoldArrowLeft = "",
        BoldArrowRight = "",
        BoldArrowUp = "",
        BoldClose = "",
        BoldDividerLeft = "",
        BoldDividerRight = "",
        BoldLineLeft = "▎",
        BookMark = "",
        BoxChecked = "",
        Bug = "",
        Stacks = "",
        Scopes = "",
        Watches = "󰂥",
        DebugConsole = "",
        Calendar = "",
        Check = "",
        ChevronRight = ">",
        ChevronShortDown = "",
        ChevronShortLeft = "",
        ChevronShortRight = "",
        ChevronShortUp = "",
        Circle = "",
        Close = "󰅖",
        CloudDownload = "",
        Code = "",
        Comment = "",
        Dashboard = "",
        DividerLeft = "",
        DividerRight = "",
        DoubleChevronRight = "»",
        Ellipsis = "",
        EmptyFolder = "",
        EmptyFolderOpen = "",
        File = "",
        FileSymlink = "",
        Files = "",
        FindFile = "󰈞",
        FindText = "󰊄",
        Fire = "",
        Folder = "󰉋",
        FolderOpen = "",
        FolderSymlink = "",
        Forward = "",
        Gear = "",
        History = "",
        Lightbulb = "",
        LineLeft = "▏",
        LineMiddle = "│",
        List = "",
        Lock = "",
        NewFile = "",
        Note = "",
        Package = "",
        Pencil = "󰏫",
        Plus = "",
        Project = "",
        Search = "",
        SignIn = "",
        SignOut = "",
        Tab = "󰌒",
        Table = "",
        Target = "󰀘",
        Telescope = "",
        Text = "",
        Tree = "",
        Triangle = "󰐊",
        TriangleShortArrowDown = "",
        TriangleShortArrowLeft = "",
        TriangleShortArrowRight = "",
        TriangleShortArrowUp = "",
    },
    diagnostics = {
        BoldError = "",
        Error = "",
        BoldWarning = "",
        Warning = "",
        BoldInformation = "",
        Information = "",
        BoldQuestion = "",
        Question = "",
        BoldHint = "",
        Hint = "󰌶",
        Debug = "",
        Trace = "✎",
    },
    misc = {
        Robot = "󰚩",
        Squirrel = "",
        Tag = "",
        Watch = "",
        Smiley = "",
        Package = "",
        CircuitBoard = "",
    },
}
local window_width_limit = 100

local conditions = {
    buffer_not_empty = function() return vim.fn.empty(vim.fn.expand "%:t") ~= 1 end,
    hide_in_width = function() return vim.o.columns > window_width_limit end,
}

local function env_cleanup(venv)
    if string.find(venv, "/") then
        local final_venv = venv
        for w in venv:gmatch "([^/]+)" do
            final_venv = w
        end
        venv = final_venv
    end
    return venv
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local function list_registered_providers_names(filetype)
    local s = require "null-ls.sources"
    local available_sources = s.get_available(filetype)
    local registered = {}
    for _, source in ipairs(available_sources) do
        for method in pairs(source.methods) do
            registered[method] = registered[method] or {}
            table.insert(registered[method], source.name)
        end
    end
    return registered
end
local null_ls = require "null-ls"
local method = null_ls.methods.FORMATTING
local alternative_methods = {
    null_ls.methods.DIAGNOSTICS,
    null_ls.methods.DIAGNOSTICS_ON_OPEN,
    null_ls.methods.DIAGNOSTICS_ON_SAVE,
}
local function list_registered(filetype)
    local registered_providers = list_registered_providers_names(filetype)
    return registered_providers[method] or {}
end

local function list_registered_linters(filetype)
    local registered_providers = list_registered_providers_names(filetype)
    local providers_for_methods =
        vim.iter(vim.tbl_map(function(m) return registered_providers[m] or {} end, alternative_methods))
            :flatten()
            :totable()
    return providers_for_methods
end

local branch = icons.git.Branch

local components = {
    mode = {
        function() return " " .. icons.ui.Target .. " " end,
        padding = { left = 0, right = 0 },
        color = {},
        cond = nil,
    },
    branch = {
        "b:gitsigns_head",
        icon = branch,
        color = { gui = "bold" },
    },
    filename = {
        "filename",
        color = {},
        cond = nil,
    },
    diff = {
        "diff",
        source = diff_source,
        symbols = {
            added = icons.git.LineAdded .. " ",
            modified = icons.git.LineModified .. " ",
            removed = icons.git.LineRemoved .. " ",
        },
        padding = { left = 2, right = 1 },
        diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.yellow },
            removed = { fg = colors.red },
        },
        cond = nil,
    },
    python_env = {
        function()
            if vim.bo.filetype == "python" then
                local venv = os.getenv "CONDA_DEFAULT_ENV" or os.getenv "VIRTUAL_ENV"
                if venv then
                    local _icons = require "nvim-web-devicons"
                    local py_icon, _ = _icons.get_icon ".py"
                    return string.format(" " .. py_icon .. " (%s)", env_cleanup(venv))
                end
            end
            return ""
        end,
        color = { fg = colors.green },
        cond = conditions.hide_in_width,
    },
    diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
            error = icons.diagnostics.BoldError .. " ",
            warn = icons.diagnostics.BoldWarning .. " ",
            info = icons.diagnostics.BoldInformation .. " ",
            hint = icons.diagnostics.BoldHint .. " ",
        },
        -- cond = conditions.hide_in_width,
    },
    treesitter = {
        function() return icons.ui.Tree end,
        color = function()
            local buf = vim.api.nvim_get_current_buf()
            local ts = vim.treesitter.highlighter.active[buf]
            return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
        end,
        cond = conditions.hide_in_width,
    },
    lsp = {
        function()
            local buf_clients = vim.lsp.get_clients { bufnr = 0 }
            if #buf_clients == 0 then return "LSP Inactive" end

            local buf_ft = vim.bo.filetype
            local buf_client_names = {}
            local copilot_active = false

            -- add client
            for _, client in pairs(buf_clients) do
                if client.name ~= "null-ls" and client.name ~= "copilot" then
                    table.insert(buf_client_names, client.name)
                end

                if client.name == "copilot" then copilot_active = true end
            end

            -- add formatter
            local supported_formatters = list_registered(buf_ft)
            vim.list_extend(buf_client_names, supported_formatters)

            -- add linter
            local supported_linters = list_registered_linters(buf_ft)
            vim.list_extend(buf_client_names, supported_linters)

            -- if type(buf_client_names) ~= "table" then buf_client_names = {} end

            local unique_client_names = vim.fn.uniq(buf_client_names)

            local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

            if copilot_active then
                language_servers = language_servers .. "%#SLCopilot#" .. " " .. icons.git.Octoface .. "%*"
            end

            return language_servers
        end,
        color = { gui = "bold" },
        cond = conditions.hide_in_width,
    },
    location = { "location" },
    progress = {
        "progress",
        fmt = function() return "%P/%L" end,
        color = {},
    },

    spaces = {
        function()
            local shiftwidth = vim.api.nvim_buf_get_option("shiftwidth", { buf = 0 })
            return icons.ui.Tab .. " " .. shiftwidth
        end,
        padding = 1,
    },
    encoding = {
        "o:encoding",
        fmt = string.upper,
        color = {},
        cond = conditions.hide_in_width,
    },
    filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
    scrollbar = {
        function()
            local current_line = vim.fn.line "."
            local total_lines = vim.fn.line "$"
            local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            return chars[index]
        end,
        padding = { left = 0, right = 0 },
        color = "SLProgress",
        cond = nil,
    },
}

local styles = {
    lvim = nil,
    default = nil,
    none = nil,
}

styles.none = {
    style = "none",
    options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
}

styles.default = {
    style = "default",
    options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = icons.use_icons,
        component_separators = {
            left = icons.ui.DividerRight,
            right = icons.ui.DividerLeft,
        },
        section_separators = {
            left = icons.ui.BoldDividerRight,
            right = icons.ui.BoldDividerLeft,
        },
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
}

styles.lvim = {
    style = "lvim",
    options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = icons.use_icons,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
    },
    sections = {
        lualine_a = {
            components.mode,
            components.filename,
            components.encoding,
        },
        lualine_b = {
            components.branch,
        },
        lualine_c = {
            -- components.location,
            components.diff,
            components.python_env,
        },
        lualine_x = {
            components.treesitter,
            components.diagnostics,
            components.lsp,
            components.spaces,
            components.filetype,
        },
        lualine_y = { components.location },
        lualine_z = {
            components.progress,
        },
    },
    inactive_sections = {
        lualine_a = {
            components.mode,
        },
        lualine_b = {
            components.branch,
        },
        lualine_c = {
            components.diff,
            components.python_env,
        },
        lualine_x = {
            components.diagnostics,
            components.lsp,
            components.spaces,
            components.filetype,
        },
        lualine_y = { components.location },
        lualine_z = {
            components.progress,
        },
    },
    tabline = {},
    extensions = {},
}

function styles.get_style(style) return vim.deepcopy(styles[style]) end

function styles.update(lua_line)
    local style = styles.get_style(lua_line.config.style)
    lua_line.config = vim.tbl_deep_extend("keep", lua_line.config, style)

    local color_template = vim.g.colors_name
    local theme_supported, _ = pcall(function() require("lualine.utils.loader").load_theme(color_template) end)
    if theme_supported then
        lua_line.config.options.theme = color_template
    else
        lua_line.config.options.theme = "auto"
    end
end
local M = {}
M.config = {
    active = true,
    style = "lvim",
    options = {
        icons_enabled = nil,
        component_separators = nil,
        section_separators = nil,
        theme = nil,
        disabled_filetypes = { statusline = { "alpha" } },
        globalstatus = true,
    },
    sections = {
        lualine_a = nil,
        lualine_b = nil,
        lualine_c = nil,
        lualine_x = nil,
        lualine_y = nil,
        lualine_z = nil,
    },
    inactive_sections = {
        lualine_a = nil,
        lualine_b = nil,
        lualine_c = nil,
        lualine_x = nil,
        lualine_y = nil,
        lualine_z = nil,
    },
    tabline = nil,
    extensions = nil,
    on_config_done = nil,
    vim.cmd [[
      highlight SLCopilot guifg=#00FF00
    ]],
}

M.setup = function()
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then return end
    if M.config.active == false then return end
    styles.update(M)

    lualine.setup(M.config)

    if M.config.on_config_done then M.config.on_config_done(lualine) end
end

return {
    "nvim-lualine/lualine.nvim",
    config = M.setup,
}
