local M = {}

function M.load(profile)
  local ok, _ = pcall(require, "profiles." .. profile .. ".init")
  if not ok then
    vim.notify("Profile '" .. profile .. "' not found", vim.log.levels.WARN)
  else
    vim.g.current_profile = profile
    vim.notify("Loaded profile: " .. profile)
  end
end

-- Command to switch profiles on the fly
vim.api.nvim_create_user_command("ProfileLoad", function(opts)
  M.load(opts.args)
end, { nargs = 1 })

return M
