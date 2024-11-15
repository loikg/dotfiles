return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- Adapters
        {
            "fredrikaverpil/neotest-golang",
            version = "*",
            dependencies = {
                -- test debugging
                "leoluz/nvim-dap-go",
            },
        },
        "marilari88/neotest-vitest",
    },
    config = function()
        local neotest = require('neotest')
        neotest.setup({
            adapters = {
                require("neotest-golang"),
                require("neotest-vitest"),
            },
        })

        local map_opts = { noremap = true, silent = true, nowait = true }

        -- Run nearest test to the cursor
        vim.keymap.set("n", "<leader>tc", function()
            neotest.run.run()
        end)

        -- Run the current file
        vim.keymap.set("n", "<leader>tf", function()
            neotest.run.run(vim.fn.expand("%"))
        end)

        -- Debug nearest test
        vim.keymap.set("n", "<leader>td", function()
            neotest.run.run({ strategy = "dap" })
        end)

        -- Toggle tests summary sidebar
        vim.keymap.set("n", "<leader>ts", function()
            neotest.summary.toggle()
        end)
    end
}
