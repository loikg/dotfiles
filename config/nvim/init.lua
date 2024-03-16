-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- disable netrw as it's replace by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1





-- disable line wrapping
vim.o.wrap = false

vim.o.termguicolors = true

-- Decrease update time
vim.o.updatetime = 50

-- enable numbers and relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.g.mapleader = " "

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin-latte"
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "javascript",
                    "typescript",
                    "tsx",
                    "rust",
                    "go",
                    "gomod",
                    "gosum",
                    "hcl",
                    "python",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            })
        end
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- telescope
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fm', builtin.marks, {})
            vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols, {})
            vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fc', builtin.commands, {})
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
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    -- LSP setup
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({})
        end
    },
    { 'williamboman/mason-lspconfig.nvim' },
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
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lsp_zero = require('lsp-zero')
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "golangci_lint_ls",
                    "terraformls",
                    "tsserver",
                    "rust_analyzer",
                    "eslint",
                    "pyright",
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
    { 'L3MON4D3/LuaSnip' },

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

    {
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
                renderer = {
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = false,
                            git = false,
                            modified = false,
                            diagnostics = false,
                            bookmarks = false,
                        }
                    }
                },
            })
        end,
    },

    -- UI select for lsp code action
    { "nvim-telescope/telescope-ui-select.nvim" },

    { "tpope/vim-surround",                     lazy = false },
    { "tpope/vim-commentary",                   lazy = false },

    { "github/copilot.vim" },

    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap = require('dap')
            local dapui = require("dapui")
            require("dap-go").setup()
            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set('n', '<F5>', function() dap.continue() end)
            -- vim.keymap.set('n', '<F10>', function() dap.step_over() end)
            -- vim.keymap.set('n', '<F11>', function() dap.step_into() end)
            -- vim.keymap.set('n', '<F12>', function() dap.step_out() end)
            vim.keymap.set('n', '<F1>', function() dap.toggle_breakpoint() end)
            -- vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
        end,
    },
})
