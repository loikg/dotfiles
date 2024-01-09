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
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    -- LSP setup
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },

    {
        'stevearc/conform.nvim',
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = .7,
            },
        },
    },

    { "nvim-tree/nvim-tree.lua" },

    -- UI select for lsp code action
    { "nvim-telescope/telescope-ui-select.nvim" },

    { "tpope/vim-surround",                     lazy = false },
    { "tpope/vim-commentary",                   lazy = false },

    { "github/copilot.vim" },
})

-- disable netrw as it's replace by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function nvim_tree_on_attach(bufnr)
    local api = require("nvim-tree.api")

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<leader>b', api.tree.toggle)
end

-- nvim-tree
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

-- LSP config
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set({ 'i' }, "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr })
end)

require('mason').setup({})
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

-- telescope
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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>o', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
-- telescope fzf
require('telescope').load_extension('fzf')

-- Zen Mode
local zen = require("zen-mode")

vim.keymap.set("n", "<leader>z", zen.toggle, {})

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
