local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup()

-- Global LSP defaults
vim.diagnostic.config({ virtual_text = true, signs = true })
