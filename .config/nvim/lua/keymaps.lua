local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<C-s>", "<esc><Cmd>w<CR>", opts)
map("i", "<C-s>", "<esc><Cmd>w<CR>", opts)

map("n", "<C-x>", "<Cmd>bdelete!<CR>", opts)

map("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", opts)
map("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>", opts)
