vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>tt", function()
   vim.cmd("botright 10split | terminal")
   vim.cmd("startinsert")
end)
vim.keymap.set("t", "<C-e>", "<C-\\><C-n><C-w>c")
