return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'saghen/blink.cmp',
        version = '1.*',
        dependencies = {
            'Kaiser-Yang/blink-cmp-avante',
            'giuxtaposition/blink-cmp-copilot',
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'super-tab' },

            signature = {
                enabled = true
            },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = {
                documentation = {
                    auto_show = true,
                    window = { border = 'single' },
                },
                menu = { border = 'single' },
                ghost_text = { enabled = true },
            },

            sources = {
                default = { 'avante', 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    avante = {
                        module = 'blink-cmp-avante',
                        name = 'Avante',
                        opts = {
                            -- options for blink-cmp-avante
                        }
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },


            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    -- LSP setup
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim",                     opts = {} },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            { "neovim/nvim-lspconfig" },
            { "j-hui/fidget.nvim",                        opts = {} }, -- small popup with lsp server info
        },
        config = function()
            vim.o.winborder = 'rounded'

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    vim.keymap.set({ 'i', 'n' }, "<C-h>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
                end,
            })

            local ensure_installed = {
                "lua_ls",
                "gopls",
                "golangci_lint_ls",
                "terraformls",
                "ts_ls",
                -- "denols",
                "rust_analyzer",
                "eslint",
                "pyright",
                "html",
                "htmx",
                "cssls",
                "tailwindcss",

                -- formatters
                "gofumpt",
                "goimports",

                -- linters
                "actionlint",

                -- dap
                "delve",
            }

            require('mason-tool-installer').setup({
                ensure_installed = ensure_installed,
            })

            require("mason-lspconfig").setup()
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
        enabled = false,
        config = function()
            -- Disable copilot by default
            vim.g.copilot_enabled = 0
        end
    },
}
