-- return {
--     "stevearc/overseer.nvim",
--     cmd = {
--         "OverseerOpen",
--         "OverseerClose",
--         "OverseerToggle",
--         "OverseerSaveBundle",
--         "OverseerLoadBundle",
--         "OverseerDeleteBundle",
--         "OverseerRunCmd",
--         "OverseerRun",
--         "OverseerInfo",
--         "OverseerBuild",
--         "OverseerQuickAction",
--         "OverseerTaskAction ",
--         "OverseerClearCache",
--     },
--     ---@param opts overseer.Config
--     opts = function(_, opts)
--         local astrocore = require "astrocore"
--         if astrocore.is_available "toggleterm.nvim" then opts.strategy = "toggleterm" end
--         opts.dap = false
--         opts.templates = { "make", "cargo", "shell", "user.run_python", "user.run_script" }
--         opts.task_list = {
--             direction = "left",
--             bindings = {
--                 ["<C-l>"] = false,
--                 ["<C-h>"] = false,
--                 ["<C-k>"] = false,
--                 ["<C-j>"] = false,
--                 q = "<Cmd>close<CR>",
--                 K = "IncreaseDetail",
--                 J = "DecreaseDetail",
--                 ["<C-p>"] = "ScrollOutputUp",
--                 ["<C-n>"] = "ScrollOutputDown",
--             },
--         }
--         local overseer = require "overseer"
--         overseer.add_template_hook({
--             module = "^make$",
--         }, function(task_defn, util)
--             util.add_component(task_defn, { "on_output_quickfix", open_on_exit = "failure" })
--             util.add_component(task_defn, "on_complete_notify")
--             util.add_component(task_defn, { "display_duration", detail_level = 1 })
--         end)
--     end,
--     dependencies = {
--         { "AstroNvim/astroui", opts = { icons = { Overseer = "" } } },
--         {
--             "AstroNvim/astrocore",
--             opts = function(_, opts)
--                 local maps = opts.mappings
--                 local prefix = "<leader>M"
--                 maps.n[prefix] = { desc = require("astroui").get_icon("Overseer", 1, true) .. "Overseer" }

--                 maps.n[prefix .. "t"] = { "<Cmd>OverseerToggle<CR>", desc = "Toggle Overseer" }
--                 maps.n[prefix .. "c"] = { "<Cmd>OverseerRunCmd<CR>", desc = "Run Command" }
--                 maps.n[prefix .. "r"] = { "<Cmd>OverseerRun<CR>", desc = "Run Task" }
--                 maps.n[prefix .. "q"] = { "<Cmd>OverseerQuickAction<CR>", desc = "Quick Action" }
--                 maps.n[prefix .. "a"] = { "<Cmd>OverseerTaskAction<CR>", desc = "Task Action" }
--                 maps.n[prefix .. "i"] = { "<Cmd>OverseerInfo<CR>", desc = "Overseer Info" }
--             end,
--         },
--     },

--     {
--         "catppuccin",
--         optional = true,
--         ---@type CatppuccinOptions
--         opts = { integrations = { overseer = true } },
--     },
-- }
return {
    "stevearc/overseer.nvim",
    init = function()
        vim.keymap.set("n", "<Leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Toggle overseer task list" })
        vim.keymap.set("n", "<Leader>or", "<cmd>OverseerRun<cr>", { desc = "List overseer run templates" })
    end,
    config = function()
        local overseer = require "overseer"
        overseer.setup {
            dap = false,
            templates = { "make", "cargo", "shell","user.cpp_build", "user.run_python", "user.run_script" },
            task_list = {
                direction = "left",
                bindings = {
                    ["<C-u>"] = false,
                    ["<C-d>"] = false,
                    ["<C-h>"] = false,
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["<C-l>"] = false,
                },
            },
        }
        -- custom behavior of make templates
        overseer.add_template_hook({
            module = "^make$",
        }, function(task_defn, util)
            util.add_component(task_defn, { "on_output_quickfix", open_on_exit = "failure" })
            util.add_component(task_defn, "on_complete_notify")
            util.add_component(task_defn, { "display_duration", detail_level = 1 })
        end)
    end,
}
