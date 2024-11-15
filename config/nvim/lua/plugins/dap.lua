return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",

        -- adapters
        "leoluz/nvim-dap-go",
        "mxsdev/nvim-dap-vscode-js"
    },
    config = function()
        local dap = require('dap')
        local dapui = require("dapui")

        require("dap-go").setup()
        require("dap-vscode-js").setup({
            adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
        })


        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set('n', '<F5>', function() dap.continue() end)
        -- vim.keymap.set('n', '<F10>', function() dap.step_over() end)
        -- vim.keymap.set('n', '<F11>', function() dap.step_into() end)
        -- vim.keymap.set('n', '<F12>', function() dap.step_out() end)
        vim.keymap.set('n', '<F1>', function() dap.toggle_breakpoint() end)
        -- vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
    end,
}
