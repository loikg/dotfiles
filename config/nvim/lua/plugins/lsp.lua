return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                enabled = true,
                sources = {
                    { name = 'nvim_lsp' },
                },
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
    -- LSP setup
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'folke/neodev.nvim',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} }, -- small popup with lsp server info
        },
        config = function()
            require("neodev").setup {} -- setup everything require for lua development for nvim

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = 'rounded' }
            )
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = 'rounded' }
            )

            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- This is where you enable features that only work
            -- if there is a language server active in the file
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

            -- lsp_zero.on_attach(function(client, bufnr)
            -- end)

            local mason = require('mason')
            mason.setup({})

            local ensure_installed = {
                "lua_ls",
                "gopls",
                "golangci_lint_ls",
                "terraformls",
                "ts_ls",
                "denols",
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


            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,

                    ["denols"] = function()
                        require("lspconfig").denols.setup {
                            root_markers = { "deno.json", "deno.jsonc" },
                        }
                    end,

                    ["ts_ls"] = function()
                        require("lspconfig").ts_ls.setup {
                            root_markers = { "package.json", "tsconfig.json" },
                            on_attach = function(client)
                                if require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
                                    if client.name == "ts_ls" then
                                        client.stop()
                                        return
                                    end
                                end
                            end
                        }
                    end,
                },
            })

            require('mason-tool-installer').setup({
                ensure_installed = ensure_installed,
            })
        end,
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
