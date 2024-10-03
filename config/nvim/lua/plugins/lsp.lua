return {
    -- LSP setup
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({})
        end
    },
    { 'williamboman/mason-lspconfig.nvim' },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'folke/neodev.nvim', opts = {} },
            {
                'VonHeikemen/lsp-zero.nvim',
                branch = 'v3.x',
                config = function()
                    -- LSP config
                    local lsp_zero = require('lsp-zero')

                    lsp_zero.on_attach(function(client, bufnr)
                        -- see :help lsp-zero-keybindings
                        -- to learn the available actions
                        lsp_zero.default_keymaps({ buffer = bufnr })
                        vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr })
                        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
                        vim.keymap.set({ 'i' }, "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr })
                        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
                        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
                    end)
                end,
            },
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "golangci_lint_ls",
                    "terraformls",
                    "ts_ls",
                    "rust_analyzer",
                    "eslint",
                    "pyright",
                    "html",
                    "htmx",
                    "cssls",
                    "tailwindcss",
                    "sqlls",
                },
                handlers = {
                    lsp_zero.default_setup,
                },
            })
        end,
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    -- ["<Tab>"] = cmp.mapping.confirm({ select = false }),
                }),
                experimental = {
                    ghost_text = true,
                }
            })
        end
    },
    {
        'stevearc/conform.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Formatter
            local conform = require("conform")
            conform.setup({
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    go = { "gofumpt", "goimports" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    svelte = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    graphql = { "prettier" },
                    rust = { "rustfmt" },
                    python = { "black" },
                },
            })

            vim.keymap.set("n", "<leader>fm", function()
                conform.format({
                    timeout_ms = 500,
                    lsp_fallback = true,
                })
            end)
        end
    },
    {
        "github/copilot.vim",
        config = function()
            -- Disable copilot by default
            vim.g.copilot_enabled = 0
        end
    },
}
