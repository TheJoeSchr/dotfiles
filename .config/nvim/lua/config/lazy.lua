local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- import LazyVim plugins
    -- { "TheJoeSchr/LazyVim", dir = "~/.local/share/nvim/lazy/LazyVim/", import = "lazyvim.plugins" },
    -- { dir = "~/.local/share/nvim/lazy/LazyVimJoe/", import = "lazyvim.plugins" },
    { "TheJoeschr/LazyVim", dir = "~/.config/nvim/lua/LazyVim/", import = "lazyvim.plugins" },
    { import = "plugins" },
    -- import any extras modules here
    -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
    -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
    { import = "lazyvim.plugins.extras.lang.typescript" },
    -- add jsonls and schemastore ans setup treesitter for json, json5 and jsonc
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- use my own mini.starter instead of LazyVim's
    { import = "plugins.extras.ui.mini-starter" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
