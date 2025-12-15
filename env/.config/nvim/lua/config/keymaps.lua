-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("n", "<A-h>", "<Cmd>BufferLineCyclePrev<CR>", opts)
map("n", "<A-l>", "<Cmd>BufferLineCycleNext<CR>", opts)
map("n", "<A-c>", "<Cmd>bd<CR>", opts)
