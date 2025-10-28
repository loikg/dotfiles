return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        enabled = false,
        config = function()
            vim.cmd.colorscheme "catppuccin-latte"
            require("catppuccin").setup({
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    mason = true,
                    dap = true,
                    dap_ui = true,
                    telescope = {
                        enabled = true,
                    },
                    lsp_trouble = false,
                }
            })

            -- DAP integration config
            local sign = vim.fn.sign_define
            sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
            sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
        end
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            require("cyberdream").setup({
                variant = "auto",
            })
            vim.cmd.colorscheme("cyberdream")
        end
    },
    -- Auto theme detection
    {
        "f-person/auto-dark-mode.nvim",
        priority = 1000,
        config = function()
            local auto_dark_mode = require('auto-dark-mode')

            auto_dark_mode.setup({
                update_interval = 1000,
                set_dark_mode = function()
                    vim.api.nvim_set_option_value("background", "dark", {})
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option_value("background", "light", {})
                end,
            })
        end,
    },
}
