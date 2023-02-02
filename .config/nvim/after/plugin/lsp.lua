-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require("lsp-zero")

local cmp_lsp = require("cmp_nvim_lsp")
local lsp_format = require("lsp-format")
local nvim_lsp = require("lspconfig")
local navic = require("nvim-navic")
local wk = require("which-key")
lsp.preset("recommended")

local function set_commands()
  -- Commands.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspOrganize lua lsp_organize_imports()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  vim.cmd("command! LspWorkspaceList lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
  vim.cmd("command! LspWorkspaceAdd lua vim.lsp.buf.add_workspace_folder()")
  vim.cmd("command! LspWorkspaceRemove lua vim.lsp.buf.remove_workspace_folder()")
end

lsp.ensure_installed({
  "tsserver",
  "sumneko_lua",
  -- "rust_analyzer",
})

-- Fix Undefined global 'vim'
lsp.configure("sumneko_lua", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
local function set_keymaps(bufnr)
  wk.register({
    c = {
      name = "LSP code",
      a = { "<cmd>CodeActionMenu<CR>", "code actions" },
      f = { "<cmd>Format<CR>", "format" },
      D = { "<cmd>LspTypeDef<CR>", "type definition" },
      L = { "<cmd>LspDeclaration<CR>", "declaration" },
      t = {
        name = "LSP [T]elescope",
        d = { "<cmd>Telescope lsp_definitions<CR>", "definitions" },
        r = { "<cmd>Telescope lsp_references<CR>", "references" },
        i = { "<cmd>Telescope lsp_implementations<CR>", "implementations" },
      },
      -- not working?
      w = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "[W]orkspace Symbols" },
    },
  }, {
    prefix = "<leader>",
    buffer = bufnr,
  })
  wk.register({
    K = { "<cmd>LspHover<CR>", "LSP hover" },
  }, {
    buffer = bufnr,
  })
  local opts = { buffer = bufnr, remap = false }

  -- Diagnostics
  vim.keymap.set("", "gkk", function()
    vim.lsp.buf.hover()
    vim.lsp.buf.hover()
  end, { desc = "Hover (Jump Into Window)" })
  vim.keymap.set("", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  -- Primagen
  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts)
  -- vim.keymap.set("n", "<leader>cw", function()
  --   vim.lsp.buf.workspace_symbol()
  -- end, { desc = "[W]orkspace Symbols", buffer = bufnr, remap = false })
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, { desc = "[C]ode [A]ction", buffer = bufnr, remap = false })
  vim.keymap.set("n", "<leader>cR", function()
    vim.lsp.buf.references()
  end, { desc = "[R]eferences", buffer = bufnr, remap = false })
  vim.keymap.set("n", "<leader>cr", function()
    vim.lsp.buf.rename()
  end, { desc = "[Rename]", buffer = bufnr, remap = false })
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, opts)
end
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  },
})

lsp.on_attach(function(client, bufnr)
  set_keymaps(bufnr)
end)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
