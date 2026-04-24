-- fix syntax highlighting for CoffeeScript files, which is currently broken in Treesitter
return {
  -- .eco syntax is also borked with Treesitter, so hardcode to use it here
  "AndrewRadev/vim-eco",
  lazy = false,
  ft = { "eco" },
  dependencies = {
    "kchmck/vim-coffee-script",
    lazy = false,
    ft = { "coffee", "eco", "haml" },
    config = function()
      vim.filetype.add({ extension = { eco = "eco" } })
    end,
  },
}
