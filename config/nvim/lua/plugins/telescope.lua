return {
    "nvim-telescope/telescope-ui-select.nvim",
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local telescope = require('telescope')

            telescope.setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    },
                },
                pickers = {
                    find_files = {
                        find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }
                    }
                },
            }

            telescope.load_extension("ui-select")
            telescope.load_extension('fzf')

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fm', builtin.marks, {})
            vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols, {})
            vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fc', builtin.commands, {})
        end
    },
}
