return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "tsserver", "eslint" },
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local function filter_definitions(defs, root_dir)
        if not defs or vim.tbl_isempty(defs) then return {} end

        local filtered = {}
        local seen = {}

        -- Helper: get path from URI
        local function uri_to_path(uri)
          return vim.uri_to_fname(uri or "")
        end

        for _, loc in ipairs(defs) do
          local uri = loc.uri or loc.targetUri
          local path = uri_to_path(uri)

          -- Skip duplicates
          if path and not seen[path] then
            -- Skip declaration files if we have other source files
            local is_decl = path:match("%.d%.ts$") or path:match("%.d%.tsx$")
            if is_decl then
              -- Only add .d.ts if no other filtered file is non-declaration
              local has_non_decl = false
              for _, f in ipairs(filtered) do
                local p = uri_to_path(f.uri or f.targetUri)
                if p and not p:match("%.d%.ts$") and not p:match("%.d%.tsx$") then
                  has_non_decl = true
                  break
                end
              end
              if has_non_decl then
                -- skip this .d.ts file since we have better one
              else
                table.insert(filtered, loc)
                seen[path] = true
              end
            else
              -- If inside project root or root not defined, accept
              if not root_dir or vim.startswith(path, root_dir) then
                table.insert(filtered, loc)
                seen[path] = true
              end
            end
          end
        end

        -- If filtered is empty, fallback to all definitions
        if vim.tbl_isempty(filtered) then
          filtered = defs
        end

        return filtered
      end

      local function goto_definition_clean()
        local params = vim.lsp.util.make_position_params()
        local clients = vim.lsp.get_active_clients({bufnr=0})
        if #clients == 0 then
          vim.notify("LSP: No active clients", vim.log.levels.WARN)
          return
        end

        local root_dir = clients[1].config.root_dir

        vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result)
          if err then
            vim.notify("LSP definition error: " .. err.message, vim.log.levels.ERROR)
            return
          end
          if not result or vim.tbl_isempty(result) then
            vim.notify("No definition found", vim.log.levels.INFO)
            return
          end

          local locations = nil
          if vim.tbl_islist(result) then
            locations = filter_definitions(result, root_dir)
          else
            locations = { result }
          end

          if #locations == 0 then
            vim.notify("No suitable definition found", vim.log.levels.INFO)
            return
          end

          vim.lsp.util.jump_to_location(locations[1])
        end)
      end

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }
				vim.keymap.set('n', 'gd', goto_definition_filtered, opts)
        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end

      vim.lsp.config("tsserver", {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "package.json", ".git"),
      })

      vim.lsp.enable({ "tsserver" })

      -- nvim-cmp setup
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
        formatting = {
          format = lspkind.cmp_format({ mode = "symbol_text" }),
        },
      })
    end,
  },
}
