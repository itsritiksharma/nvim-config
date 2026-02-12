local harpoon = require("harpoon")
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

harpoon.setup({})

-- Keymaps for adding files and navigating
vim.keymap.set("n", "<leader>a", function() mark.add_file() end, { desc = "Harpoon Add File" })
vim.keymap.set("n", "<leader>A", function() ui.toggle_quick_menu() end, { desc = "Harpoon Quick Menu" })
-- vim.keymap.set("n", "<leader>a", function() harpoon:add_file() end, { desc = "Harpoon Add File" })
-- vim.keymap.set("n", "<leader>A", ui.toggle_quick_menu, { desc = "Harpoon Quick Menu" })

-- Jump to files quickly
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon Jump 1" })
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon Jump 2" })
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon Jump 3" })
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon Jump 4" })


-- return {
--     "ThePrimeagen/harpoon",
--     branch = "harpoon2",
--     dependencies = { "nvim-lua/plenary.nvim" },
-- 	config = function()
--       require("harpoon"):setup()
--     end,
--     keys = {
--       { "<leader>a", function() require("harpoon"):list():add() end, desc = "harpoon file", },
--       { "<leader>A", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
--       { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
--       { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
--       { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
--       { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
--       { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
--     },
-- }
