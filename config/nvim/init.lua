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


-- Reserve a space in the gutter with by many plugins
vim.opt.signcolumn = 'yes'

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

vim.opt.colorcolumn = "100"

-- ignore case when the search pattern is all lowercase
vim.o.smartcase = true
vim.o.ignorecase = true

-- clear search highlights after submit
vim.o.hlsearch = false

vim.g.mapleader = " "

-- set clipboard to system clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- save current file
vim.keymap.set('n', '<leader>w', '<cmd>write<cr><esc>', { desc = 'Save file' })

-- save all files and quit
vim.keymap.set('n', '<leader>q', '<cmd>quitall<cr>', { desc = 'Exit vim' })

-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.diagnostic.config({
    virtual_text = false,
})

require("lazy").setup("plugins")
