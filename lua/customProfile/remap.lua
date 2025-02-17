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
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", ";", ":")
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
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]])
vim.keymap.set("n", "<Esc>", "<Esc>:noh<CR>", { noremap = true, silent= true})
vim.keymap.set("n", "<Tab>", "gt")
vim.keymap.set("n", "<S-Tab>", "gT")
vim.keymap.set("n", "<leader>x", ":tabclose<CR>")
vim.keymap.set("n", "<leader>f", ":tabs<CR>")
vim.keymap.set("n", "<leader>t", ":tabedit ")
vim.keymap.set("n", "<leader>r", vim.cmd.SnipRun)
vim.keymap.set("n", "<C-a>", vim.cmd.SnipClose)

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Visual mode
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>9", "ab<CR>")
vim.keymap.set("v", "<leader>[", "aB<CR>")
vim.keymap.set("v", "<leader>r", vim.cmd.SnipRun)
vim.keymap.set("v", "<C-a>", vim.cmd.SnipClose)

-- X mode
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Insert mode
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
-- vim.keymap.set("i", "<C-j>", ":m >+1<CR>gv=gv", { noremap = true, silent = true })

