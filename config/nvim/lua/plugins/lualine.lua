return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            disabled_filetypes = { 'NvimTree_1' },
            options = {
                theme = "auto",
            },
            sections = {
                lualine_a = {},
                lualine_b = { 'branch', 'diagnostics' },
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                    }
                },
                lualine_x = { 'searchcount' },
                lualine_y = { 'location' },
                lualine_z = {}
            },
        }
    end
}
