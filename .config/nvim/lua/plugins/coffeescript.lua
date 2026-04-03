-- fix syntax highlighting for CoffeeScript files, which is currently broken in Treesitter
return {
  {
    "kchmck/vim-coffee-script",
    ft = "coffee",
    init = function()
      -- This forces Neovim to use the plugin's syntax engine
      -- instead of the broken Treesitter one for this filetype
      vim.g.coffee_indent_keep = 1
    end,
  },
}
