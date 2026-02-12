local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("Telescope not found!", vim.log.levels.ERROR)
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
})

local builtin = require("telescope.builtin")

-- Keymaps
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find Files" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope: Git Files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help Tags" })

