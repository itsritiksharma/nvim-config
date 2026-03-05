-- local harpoon = require("harpoon")
-- local ui = require("harpoon.ui")

-- -- REQUIRED
-- harpoon:setup({})
-- -- REQUIRED

-- -- Keymaps for adding files and navigating
-- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon Add File" })
-- vim.keymap.set("n", "<leader>A", function() ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Quick Menu" })

-- -- Jump to files quickly
-- vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon Jump 1" })
-- vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon Jump 2" })
-- vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon Jump 3" })
-- vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon Jump 4" })

-- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- vim.keymap.set("n", "<leader>A", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
-- -- vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
-- -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
-- vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon Jump 1" })
-- vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon Jump 2" })
-- vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon Jump 3" })
-- vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon Jump 4" })
--
-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "1", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "", function() harpoon:list():next() end)
