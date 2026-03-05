local M = {}

function M.setup()
  -------------------------------------------------------
  -- Dependencies
  -------------------------------------------------------
  local Path = require('plenary.path')
  local sm = require('session_manager')
  local config = require('session_manager.config')

  -------------------------------------------------------
  -- Session Manager Setup
  -------------------------------------------------------
  sm.setup({
    sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
    autoload_mode = config.AutoloadMode.Disabled, -- manual control
  })

  -------------------------------------------------------
  -- Helper: Open Telescope with Git Files if Available
  -------------------------------------------------------
  local function open_telescope_project_files()
    -- Detect if the directory is a git repo
    local is_git = vim.fn.isdirectory('.git') == 1
    if is_git then
      require('telescope.builtin').git_files({ show_untracked = true })
    else
      require('telescope.builtin').find_files()
    end
  end

  -------------------------------------------------------
  -- Workspaces Setup
  -------------------------------------------------------
  require('workspaces').setup({
    path = vim.fn.stdpath('data') .. '/workspaces',
    hooks = {
      open_pre = {
        -- Save current session before switching
        'SessionManager save_current_session',
      },
      open = {
        -- Load session for new workspace
        'SessionManager load_current_dir_session',
        -- Optional: open Telescope to pick files
        open_telescope_project_files,
        -- 'Telescope find_files',
      },
    },
  })

  -------------------------------------------------------
  -- Telescope Integration
  -------------------------------------------------------
  require('telescope').load_extension('workspaces')

  -------------------------------------------------------
  -- Auto-save Session on Exit
  -------------------------------------------------------
  vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
      pcall(function()
        require('session_manager').save_current_session()
      end)
    end,
  })


  -------------------------------------------------------
  -- Auto-load Session on Exit
  -------------------------------------------------------
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      local sm = require('session_manager')
      local path = vim.fn.getcwd()
      local session_dir = require('plenary.path'):new(vim.fn.stdpath('data'), 'sessions')
      local session_file = session_dir:joinpath(vim.fn.fnamemodify(path, ":p:h:t") .. '.vim')
      if session_file:exists() then
        pcall(function() sm.load_current_dir_session() end)
      end
    end,
  })

  -------------------------------------------------------
  -- Keymaps
  -------------------------------------------------------
  local map = vim.keymap.set
  map('n', '<leader>p', function()
    require('telescope').extensions.workspaces.workspaces({ initial_mode = 'normal' })
  end, { desc = 'Switch project/workspace' })

  map('n', '<leader>pa', ':WorkspacesAdd<CR>', { desc = 'Add current dir as workspace' })
  map('n', '<leader>pr', ':WorkspacesRemove<CR>', { desc = 'Remove workspace' })
  map('n', '<leader>ps', ':SessionManager save_current_session<CR>', { desc = 'Save workspace session' })
  map('n', '<leader>pl', ':SessionManager load_current_dir_session<CR>', { desc = 'Load workspace session' })
end

M.setup()

return M
