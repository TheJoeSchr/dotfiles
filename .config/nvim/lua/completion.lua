vim.opt.shortmess:append("c")

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

-- Initialize lspkind (for icons in completion)
lspkind.init({})

-- General nvim-cmp setup (insert mode)
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Update window configuration to use the new API for bordered documentation
  window = {
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text", -- Show both symbol and text (optional)
      maxwidth = 50, -- Max width of the completion item
      ellipsis_char = "...", -- When the item exceeds the maxwidth, it will truncate with ellipsis
      -- Specify custom menu labels
      menu = {
        buffer = "[Buffer]",
        luasnip = "[LuaSnip]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
      },
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "cody" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
  }),
  completion = { completeopt = "menu,menuone,noinsert" },
})

-- Command-line mode completion (for ':')
cmp.setup.cmdline(":", {
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item({ "c" }),
    ["<S-Tab>"] = cmp.mapping.select_prev_item({ "c" }),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})
-- LuaSnip configuration
luasnip.config.setup({
  history = false,
  updateevents = "TextChanged,TextChangedI",
})
-- Load custom LuaSnip snippets from the 'lua/snippets/' folder
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
  loadfile(ft_path)()
end
-- LuaSnip keybindings
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })
-- Setup for SQL filetype (optional)
cmp.setup.filetype({ "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})
