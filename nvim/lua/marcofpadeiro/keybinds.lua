local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
vim.keymap.set('i', '<C-j>', '<cmd>lua require("cmp").select_next_item()<CR>')
vim.keymap.set('i', '<C-k>', '<cmd>lua require("cmp").select_prev_item()<CR>')
vim.keymap.set('i', '<C-a>', '<cmd>lua require("cmp").complete()<CR>')

-- Fast saving
vim.keymap.set('n', "<leader>w", "<cmd>:lua vim.lsp.buf.format()<CR>:w<CR>")

-- Undo Tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Harpoon
vim.keymap.set('n', "<leader>h", ':lua require("harpoon.ui").nav_file(1)<CR>')
vim.keymap.set('n', "<leader>j", ':lua require("harpoon.ui").nav_file(2)<CR>')
vim.keymap.set('n', "<leader>k", ':lua require("harpoon.ui").nav_file(3)<CR>')
vim.keymap.set('n', "<leader>l", ':lua require("harpoon.ui").nav_file(4)<CR>')
vim.keymap.set('n', "<leader>m", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
vim.keymap.set('n', "<leader>a", ':lua require("harpoon.mark").add_file()<CR>')

-- nvterm
vim.keymap.set('n', "<A-h>", ':lua require("nvterm.terminal").toggle("horizontal")<CR>')
vim.keymap.set('n', "<A-v>", ':lua require("nvterm.terminal").toggle("vertical")<CR>')

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', "<leader>y", "\"+y")
vim.keymap.set('v', "<leader>y", "\"+y")
vim.keymap.set('n', "<leader>Y", "\"+Y")
vim.keymap.set('v', "<leader>p", "\"_dP")

-- Better window navigation
vim.keymap.set('n', "<C-h>", "<C-w>h")
vim.keymap.set('n', "<C-j>", "<C-w>j")
vim.keymap.set('n', "<C-k>", "<C-w>k")
vim.keymap.set('n', "<C-l>", "<C-w>l")

-- Nvimtree
vim.keymap.set('n', "<leader>e", ":NvimTreeToggle<cr>")
