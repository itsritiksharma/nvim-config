local harpoon = require("harpoon")

harpoon:setup({})

-- Keymaps for adding files and navigating
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon Add File" })
vim.keymap.set("n", "<leader>A", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Quick Menu" })

-- Jump to files quickly
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon Jump 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon Jump 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon Jump 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon Jump 4" })
