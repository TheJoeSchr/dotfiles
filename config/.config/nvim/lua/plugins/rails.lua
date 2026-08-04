-- gem install neovim
-- force disable "gem install neovim"
-- disalbe so no debug process is spawned when opening a ruby file, since we are using lsp for formatting and linting
vim.g.loaded_ruby_provider = 0
-- add rubocop autoformat
vim.opt.signcolumn = "yes"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.lsp.start({
      name = "rubocop",
      cmd = { "bundle", "exec", "rubocop", "--lsp" },
    })
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rb",
  callback = function()
    vim.lsp.buf.format()
  end,
})

return {
  -- Format happens in `conform.lua`, no need to config here
  -- tpope goodness
  -- e.g:
  -- :BundleInstall,
  -- :A Opens test file and vice versa
  -- :Emodel
  -- :Econtroller
  -- :Eview
  -- :ERspec
  {
    "tpope/vim-rails",
    dependencies = { "tpope/vim-bundler", "tpope/vim-rake" },
  },
  -- Other highly recommended Rails plugins
  { "tpope/vim-bundler", ft = { "ruby" } },
  { "tpope/vim-rake", ft = { "ruby" } },
}
