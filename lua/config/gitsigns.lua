-- lua/config/gitsigns.lua

-- Function to get current branch from gitsigns
function _G.gitsigns_branch()
  local gs = vim.b.gitsigns_status_dict
  if gs and gs.head then
    return ' ' .. gs.head
  end
  return ''
end

-- Minimal statusline using branch info
vim.o.statusline = "%f %{v:lua.gitsigns_branch()} %= %l:%c"

-- Refresh statusline automatically when gitsigns updates
vim.api.nvim_create_autocmd({"User"}, {
  pattern = "GitsignsUpdate",
  callback = function()
    vim.cmd("redrawstatus")
  end,
})

