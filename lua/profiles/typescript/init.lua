local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- require("typescript-tools").setup({
--   capabilities = capabilities,
--   settings = {
--     expose_as_code_action = {
--       "add_missing_imports",
--       "remove_unused",
--       "organize_imports",
--       "fix_all",
--     },
--     tsserver_file_preferences = {
--       importModuleSpecifierPreference = "non-relative",
--     },
--   },
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function(args)
    -- vim.cmd("TSToolsOrganizeImports sync")
    require("conform").format({ bufnr = args.buf, timeout_ms = 2000 })
  end,
})

vim.notify("TypeScript profile loaded ✅")
