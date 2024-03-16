return {
    { 'L3MON4D3/LuaSnip' },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = .7,
            },
        },
        config = function()
            -- Zen Mode
            local zen = require("zen-mode")
            vim.keymap.set("n", "<leader>z", zen.toggle, {})
        end,
    },
    { "tpope/vim-surround",   lazy = false },
    { "tpope/vim-commentary", lazy = false },

}
