return {
    { 'tpope/vim-fugitive' },
    {
        'lewis6991/gitsigns.nvim',
        tag = 'v0.7',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '+' },
                },
            })
        end,
    },
    {
        'ThePrimeagen/git-worktree.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            require('git-worktree').setup({})
            local telescope = require('telescope')
            telescope.load_extension("git_worktree")
            vim.keymap.set('n', '<leader>gww', telescope.extensions.git_worktree.git_worktrees, {})
            vim.keymap.set('n', '<leader>gwc', telescope.extensions.git_worktree.create_git_worktree, {})
        end,
    }
}
