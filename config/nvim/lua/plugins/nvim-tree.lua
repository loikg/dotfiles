return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        -- nvim-tree
        local function nvim_tree_on_attach(bufnr)
            local api = require("nvim-tree.api")

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', '<leader>b', api.tree.toggle)
        end

        require("nvim-tree").setup({
            on_attach = nvim_tree_on_attach,
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        })
    end,
}
