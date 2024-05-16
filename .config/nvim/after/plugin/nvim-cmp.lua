-- because borked
local M = {}
local cmp = require("cmp")
--
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})
--
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})
return M
--
--
-- local lspkind = require("lspkind")
-- local luasnip = require("luasnip")
-- function M.setup()
--   cmp.setup({
--     snippet = {
--       expand = function(args)
--         luasnip.lsp_expand(args.body)
--       end,
--     },
--     completion = {
--       completeopt = "menu,menuone,noselect",
--     },
--     documentation = {
--       border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
--     },
--
--     mapping = cmp.mapping.preset.insert({
--       ["<Tab>"] = cmp.mapping.select_next_item(),
--       ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--       ["<C-p>"] = cmp.mapping.select_prev_item(),
--       ["<C-n>"] = cmp.mapping.select_next_item(),
--       ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--       ["<C-f>"] = cmp.mapping.scroll_docs(4),
--       ["<C-Space>"] = cmp.mapping.complete(),
--       ["<C-e>"] = cmp.mapping.close(),
--       ["<CR>"] = cmp.mapping.confirm({
--         select = true,
--         behavior = cmp.ConfirmBehavior.Replace,
--       }),
--     }),
--     formatting = {
--       format = lspkind.cmp_format({
--         menu = {
--           buffer = "[Buffer]",
--           luasnip = "[LuaSnip]",
--           nvim_lsp = "[LSP]",
--           nvim_lua = "[Lua]",
--           path = "[Path]",
--         },
--       }),
--     },
--     sources = cmp.config.sources({
--       { name = "nvim_lsp" },
--       { name = "luasnip" },
--       { name = "nvim_lua" },
--       { name = "buffer" },
--       { name = "path" },
--     }),
--   })
-- end
-- return M
