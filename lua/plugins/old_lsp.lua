
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
	  'hrsh7th/cmp-buffer',   -- Buffer source
	  'hrsh7th/cmp-path',     -- Path source
	  'L3MON4D3/LuaSnip',     -- Snippet engine
	  'saadparwaiz1/cmp_luasnip', -- Snippet source for nvim-cmp
    },
    config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = {buffer = event.buf}

				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
			end,
		})

		local mason = require('mason')
      local mason_lspconfig = require("mason-lspconfig")
      -- local lspconfig = require("lspconfig")
	  vim.lsp.enable("ts_ls")
      local cmp = require("cmp")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
	  local cmp = require('cmp')
	  local luasnip = require('luasnip')

      -- Mason Setup
	  mason.setup()
      mason_lspconfig.setup({
        ensure_installed = { "ts_ls" },
        handlers = {
          -- function(server_name)
          --   lspconfig[server_name].setup({})
          -- end,
        },
      })

      -- Autocompletion Setup
      cmp.setup({
		snippet = {
		  expand = function(args)
			  luasnip.lsp_expand(args.body)
		  end,
		},
		sources = cmp.config.sources({
			-- { name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'buffer' },
			{ name = 'path' },
		}),
		      -- sources = {
		      --   { name = "nvim_lsp" },
		      -- },
		mapping = cmp.mapping.preset.insert({
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-u>'] = cmp.mapping.scroll_docs(-4),
			['<C-d>'] = cmp.mapping.scroll_docs(4),
			['<CR>'] = cmp.mapping.confirm({ select=true }),	
		}),
		snippet = {
			expand = function(args)
				vim.snippet.expand(args.body)
			end,
		},

      })

      -- Optional: Configure diagnostic signs and virtual text
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          active = signs,
        },
        update_in_insert = true,
        severity_sort = true,
      })
	  -- Enable auto-formatting
	  vim.api.nvim_create_autocmd("BufWritePre", {
		  group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
		  buffer = 0,
		  callback = function(opts)
			  if vim.bo[opts.buf].filetype == "typescript" or vim.bo[opts.buf].filetype == "typescriptreact" then
				  vim.lsp.buf.format({
					  async = false,
					  timeout_ms = 1000,
				  })
			  end
		  end,
	  })
    end,
  },
}
-- return {
-- 	{
-- 		"VonHeikemen/lsp-zero.nvim",
-- 		branch = 'v3.x', -- Use the latest stable branch.
-- 		dependencies = {
-- 			-- LSP Support
-- 			{"neovim/nvim-lspconfig"},
-- 			{"williamboman/mason.nvim"},
-- 			{"williamboman/mason-lspconfig.nvim"},
--
-- 			-- Autocompletion
-- 			{"hrsh7th/nvim-cmp"},
-- 			{"hrsh7th/cmp-nvim-lsp"},
-- 		},
-- 		config = function()
-- 			local lsp_zero = require("lsp-zero")
--
-- 			-- This single call handles the setup for Mason, nvim-lspconfig,
-- 			-- and nvim-cmp, including the autocompletion sources.
-- 			lsp_zero.setup({
-- 				set_signcolumn = true,
-- 			})
--
-- 			-- This is the recommended way to set up keymaps that depend on a running LSP client.
-- 			lsp_zero.on_attach(function(client, bufnr)
-- 				local opts = {buffer = bufnr}
--
-- 				-- You can still manually configure keymaps if you prefer.
-- 				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
-- 				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
-- 				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
-- 				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
-- 				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
-- 				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
-- 				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
-- 				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
-- 				vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
-- 				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
-- 			end)
-- 		end
-- 	},
-- }
-- return {
-- 	{
-- 		"VonHeikemen/lsp-zero.nvim",
-- 	},
-- 	-- Autocompletion
-- 	{
-- 		'hrsh7th/nvim-cmp',
-- 		event = 'InsertEnter',
-- 		config = function()
-- 			local cmp = require('cmp')
--
-- 			cmp.setup({
-- 				sources = {
-- 					{name = 'nvim_lsp'},
-- 				},
-- 				mapping = cmp.mapping.preset.insert({
-- 					['<C-Space>'] = cmp.mapping.complete(),
-- 					['<C-u>'] = cmp.mapping.scroll_docs(-4),
-- 					['<C-d>'] = cmp.mapping.scroll_docs(4),
-- 					['<CR>'] = cmp.mapping.confirm({ select=true }),	
-- 				}),
-- 				snippet = {
-- 					expand = function(args)
-- 						vim.snippet.expand(args.body)
-- 					end,
-- 				},
-- 			})
-- 		end
-- 	},
-- 	-- LSP
-- 	{
-- 		'neovim/nvim-lspconfig',
-- 		cmd = {'LspInfo', 'LspInstall', 'LspStart'},
-- 		event = {'BufReadPre', 'BufNewFile'},
-- 		dependencies = {
-- 			{'hrsh7th/cmp-nvim-lsp'},
-- 			{'williamboman/mason.nvim'},
-- 			{'williamboman/mason-lspconfig.nvim'},
-- 		},
-- 		init = function()
-- 			-- Reserve a space in the gutter
-- 			-- This will avoid an annoying layout shift in the screen
-- 			vim.opt.signcolumn = 'yes'
-- 		end,
-- 		config = function()
-- 			-- LspAttach is where you enable features that only work
-- 			-- if there is a language server active in the file
-- 			vim.api.nvim_create_autocmd('LspAttach', {
-- 				desc = 'LSP actions',
-- 				callback = function(event)
-- 					local opts = {buffer = event.buf}
--
-- 					vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
-- 					vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
-- 					vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
-- 					vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
-- 					vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
-- 					vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
-- 					vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
-- 					vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
-- 					vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
-- 					vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
-- 				end,
-- 			})
--
-- 			-- LSP format on save.
-- 			-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 			-- 	callback = function()
-- 			-- 		local mode = vim.api.nvim_get_mode().mode
-- 			-- 		local filetype = vim.bo.filetype
-- 			-- 		if vim.bo.modified == true and mode == 'n' and filetype ~= "oil" then
-- 			-- 			vim.cmd('lua vim.lsp.buf.format({async = true})')
-- 			-- 		else
-- 			-- 		end
-- 			-- 	end
-- 			-- })
-- 			require('mason-lspconfig').setup(
-- 			{
-- 				automatic_enable = true,
-- 				ensure_installed = {},
-- 				-- Correct the handlers table to use a key-value pair
-- 				handlers = {
-- 					-- Use a key like 'default' or a specific server name
-- 					-- to map the function.
-- 					default = function(server_name)
-- 						local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- 						require('lspconfig')[server_name].setup({
-- 							capabilities = capabilities,
-- 						})
-- 					end,
-- 				}
-- 				-- handlers = {
-- 				-- 	-- this first function is the "default handler"
-- 				-- 	-- it applies to every language server without a "custom handler"
-- 				--
-- 				-- 	function(server_name)
-- 				-- 		local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- 				-- 		require('lspconfig')[server_name].setup({
-- 				-- 			capabilities = capabilities,
-- 				-- 		})
-- 				-- 	end
-- 				-- 	-- function(server_name)
-- 				-- 	-- 	require('lspconfig')[server_name].setup({})
-- 				-- 	-- end,
-- 				-- }
-- 			}
-- 			)
-- 		end
-- 	}
-- }
