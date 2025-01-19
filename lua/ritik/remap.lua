-- Vim vim.api
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text.",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear=true}),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Vim keymaps
-- Normal mode
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>s", ":%s/\\<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Visual mode
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>d", "\"_d")

-- X mode
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Insert mode
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", ":m >+1<CR>gv=gv", { noremap = true, silent = true })














