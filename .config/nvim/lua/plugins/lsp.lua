return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "lukas-reineke/lsp-format.nvim",
      "SmiteshP/nvim-navic",
      "hrsh7th/cmp-nvim-lsp",
      "folke/which-key.nvim",
      "ibhagwan/fzf-lua",
    },
    config = function()
      local M = {}
      local cmp_lsp = require("cmp_nvim_lsp")
      local lsp_format = require("lsp-format")
      local nvim_lsp = require("lspconfig")
      local navic = require("nvim-navic")
      local wk = require("which-key")
      local fzf = require("fzf-lua")

      -- Set up LSP commands
      local function set_commands()
        vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
        vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
        vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
        vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
        vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
        vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
        vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
        vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
        vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
        vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
      end

      -- Set up keymaps
      local function set_keymaps(bufnr)
        wk.register({
          g = {
            name = "LSP goto",
            d = {
              function()
                fzf.lsp_definitions()
              end,
              "definitions",
            },
            D = { "<cmd>LspTypeDef<CR>", "type definition" },
            L = { "<cmd>LspDeclaration<CR>", "declaration" },
            i = {
              function()
                fzf.lsp_implementations()
              end,
              "implementations",
            },
            r = {
              function()
                fzf.lsp_references()
              end,
              "references",
            },
          },
          c = {
            name = "LSP code changes",
            a = { "<cmd>LspCodeAction<CR>", "code actions" },
            f = { "<cmd>LspFormatting<CR>", "format" },
            r = { "<cmd>LspRename<CR>", "rename variable" },
          },
        }, {
          prefix = "<leader>",
          buffer = bufnr,
        })

        wk.register({
          K = { "<cmd>LspHover<CR>", "LSP hover" },
          ["<C-s>"] = { "<cmd>LspSignatureHelp<CR>", "LSP signature help" },
        }, {
          buffer = bufnr,
        })
      end

      -- Set up capabilities
      local capabilities = cmp_lsp.default_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- LSP Attach handler
      local function on_attach(client, bufnr)
        lsp_format.on_attach(client)
        if vim.b.lsp_buffer_set_up then
          return
        end

        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        set_commands()
        set_keymaps(bufnr)

        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        vim.b.lsp_buffer_set_up = true
      end

      -- Configure diagnostics
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      })

      -- Server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
            },
          },
        },
        pyright = {},
        clojure_lsp = {},
      }

      -- Set up servers
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      if have_mason then
        mlsp.setup({
          ensure_installed = vim.tbl_keys(servers),
          handlers = {
            function(server_name)
              nvim_lsp[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name] and servers[server_name].settings or {},
              })
            end,
          },
        })
      end
    end,
  },
}
