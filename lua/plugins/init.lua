return {
  -- LSP Core
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  { "L3MON4D3/LuaSnip" },
  { "onsails/lspkind.nvim" },
  { "rafamadriz/friendly-snippets" },

  -- TypeScript helper
  -- { "pmizio/typescript-tools.nvim" },
  { "nvim-lua/plenary.nvim" },

  -- Formatter
  { "stevearc/conform.nvim" },

  -- Third party
  { "nvim-lua/plenary.nvim" },
  { "ThePrimeagen/harpoon" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  -- Treesitter for syntax highlighting
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "javascript", "typescript", "tsx", "lua", "python", "json", "html", "css" },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- Git signs
  { 
    "lewis6991/gitsigns.nvim", 
    config = function()
      require("gitsigns").setup({
        current_line_blame = false, -- disable inline blame here (use Blamer plugin)
      })
    end
  },

  -- Undo tree
  { "mbbill/undotree" },

  -- Lazygit terminal integration
  { "kdheepak/lazygit.nvim" },

  -- Git blamer
  { 
    "f-person/git-blame.nvim", 
    config = function()
      vim.g.gitblame_enabled = 1
      vim.g.gitblame_message_template = '<author>, <date> • <summary>'
    end
  },

  -- tmux project switcher
  {
    'natecraddock/workspaces.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'Shatur/neovim-session-manager',
      'nvim-lua/plenary.nvim',
    },
    event = 'VeryLazy',
    config = function()
      require('config.project_switcher')
    end,
  },

  --Git conflict
  {
    'akinsho/git-conflict.nvim',
    config = function()
      require('config.git_conflict') -- load config from lua/config/
    end,
  },
}
