local ok, git_conflict = pcall(require, 'git-conflict')
if not ok then
  vim.notify('git-conflict.nvim not found!', vim.log.levels.WARN)
  return
end

git_conflict.setup {
  default_mappings = true,      -- enable built-in keymaps (disable if you prefer custom)
  default_commands = true,
  disable_diagnostics = false,  -- keep LSP diagnostics during conflicts
  list_opener = 'copen',        -- open conflicts list in quickfix
  highlights = {
    incoming = 'DiffAdd',
    current  = 'DiffText',
  },
}

-- 🪄 Optional: Custom keybindings (only if default_mappings = false)
-- These mimic VSCode-style merge conflict shortcuts
vim.keymap.set('n', '<leader>co', '<cmd>GitConflictChooseOurs<cr>',   { desc = 'Choose Ours' })
vim.keymap.set('n', '<leader>ct', '<cmd>GitConflictChooseTheirs<cr>', { desc = 'Choose Theirs' })
vim.keymap.set('n', '<leader>cb', '<cmd>GitConflictChooseBoth<cr>',   { desc = 'Choose Both' })
vim.keymap.set('n', '<leader>c0', '<cmd>GitConflictChooseNone<cr>',   { desc = 'Choose None' })
vim.keymap.set('n', ']x',         '<cmd>GitConflictNextConflict<cr>', { desc = 'Next Conflict' })
vim.keymap.set('n', '[x',         '<cmd>GitConflictPrevConflict<cr>', { desc = 'Prev Conflict' })
vim.keymap.set('n', '<leader>cl', '<cmd>GitConflictListQf<cr>',       { desc = 'List Conflicts' })
