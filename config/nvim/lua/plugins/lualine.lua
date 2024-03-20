return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            disabled_filetypes = { 'NvimTree' },
            theme = "catppuccin",
            sections = {
                lualine_a = {},
                lualine_b = { 'branch', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'searchcount' },
                lualine_y = { 'location' },
                lualine_z = {}
            },
        }
    end
}
