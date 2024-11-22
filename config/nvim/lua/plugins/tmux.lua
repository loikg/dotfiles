return {
    {
        'mrjones2014/smart-splits.nvim',
        config = function()
            -- moving between splits
            vim.keymap.set('n', '<M-h>', require('smart-splits').move_cursor_left)
            vim.keymap.set('n', '<M-j>', require('smart-splits').move_cursor_down)
            vim.keymap.set('n', '<M-k>', require('smart-splits').move_cursor_up)
            vim.keymap.set('n', '<M-l>', require('smart-splits').move_cursor_right)
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        enabled = false,
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
            { "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
            { "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
            { "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
        },
    }
}
