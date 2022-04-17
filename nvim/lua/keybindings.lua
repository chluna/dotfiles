-- nvim: keybindings.lua

local map = function(mode, key, cmd)
    vim.api.nvim_set_keymap(mode, key, cmd, {noremap = true})
end

-- move lines
map("n", "<A-j>", ":m+<CR>==")
map("n", "<A-k>", ":m-2<CR>==")
map("i", "<A-j>", "<Esc>:m+<CR>==gi")
map("i", "<A-k>", "<Esc>:m-2<CR>==gi")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Telescope
map("n", "<leader><space>", ":Telescope builtin<CR>")
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fh", ":Telescope help_tags<CR>")

-- Glow
map("n", "<leader>p", ":Glow<CR>")

