local opt = vim.opt

opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

opt.smartindent = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

opt.hlsearch = true
opt.incsearch = true

opt.updatetime = 50

opt.colorcolumn = "80"

opt.scrolloff = 10

vim.g.mapleader = " "
vim.g.localmapleader = "\\"

