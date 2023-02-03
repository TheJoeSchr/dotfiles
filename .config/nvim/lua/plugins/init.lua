-- TODO: configure firenvim
--
--
-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- " UNIVERSAL:
  -- :Remove: Delete a file on disk without E211: File no longer available.
  -- :Delete: Delete a file on disk and the buffer too.
  -- :Move: Rename a buffer and the file on disk simultaneously. See also :Rename, :Copy, and :Duplicate.
  -- :Chmod: Change the permissions of the current file.
  -- :Mkdir: Create a directory, defaulting to the parent of the current file.
  -- :Cfind: Run find and load the results into the quickfix list.
  -- :Clocate: Run locate and load the results into the quickfix list.
  -- :Lfind/:Llocate: Like above, but use the location list.
  -- :Wall: Write every open window. Handy for kicking off tools like guard.
  -- :SudoWrite: Write a privileged file with sudo.
  -- :SudoEdit: Edit a privileged file with sudo.
  { "tpope/vim-eunuch" },

  -- PICKER MODE
  -- :NnnPicker to open nnn in a floating window.

  -- Comment stuff out.
  -- gcc: comment out a line (takes a count)
  -- gc: comment out the target of a motion (for example, gcap to comment out a paragraph)
  -- vmap gc: in visual mode to comment out the selection,
  -- gc in operator pending mode to target a comment
  { "tpope/vim-commentary" },

  { "vimwiki/vimwiki" },
  { "bkad/CamelCaseMotion", lazy = false },

  -- VIM-ABOLISH
  -- Abolish lets you quickly find, substitute, and abbreviate several variations
  -- of a word at once.  By default, three case variants (foo, Foo, and FOO) are
  -- operated on by every command.
  -- :Subvert provides an alternative, more concise syntax for searching and substituting.
  -- :%S/child{,ren}/adult{,s}/g
  -- COERCE
  -- crs (coerce to snake_case).
  -- MixedCase (crm),
  -- camelCase (crc),
  -- snake_case (crs),
  -- UPPER_CASE (cru),
  -- dash-case (cr-),
  -- dot.case (cr.),
  -- space case (cr<space>),
  -- and Title Case (crt) are all just 3 keystrokes away.
  { "tpope/vim-abolish", event = "BufReadPost" },
  -- Surround
  { "tpope/vim-surround", event = "BufReadPost" },
  -- unimpaired ([p,]p etc)
  { "tpope/vim-unimpaired", event = "VeryLazy" },

  -- fish file editing
  -- imortant, no lsp so far
  { "dag/vim-fish", ft = "fish" },

  -- close other buffers (and more)
  -- " nnoremap <silent> Q     :close<CR>
  -- nnoremap <silent> Q     :Bdelete menu<CR>
  -- nnoremap <silent> <C-q> :Bdelete menu<CR>
  -- nnoremap <silent> <leader>Q     :Bdelete other<CR>
  -- nnoremap <silent> <leader>q :Bdelete menu<CR>
  {
    "Asheq/close-buffers.vim",
    keys = { { "<leader>q", desc = "Close Buffers" }, { "<leader>Q", desc = "Close Buffers" } },
  },
  -- github copilot
  { "github/copilot.vim", event = "InsertEnter" },

  { "szw/vim-maximizer", event = "VeryLazy" },
  {
    "christoomey/vim-tmux-navigator",
    -- needed otherwise doesn't work with lazy
    event = "VimEnter",
  },
  -- {
  --   { "https://gitlab.com/yorickpeterse/nvim-window.git" },
  --   keys = { "<leader>wf", require("nvim-window").pick, desc = "Window Management" },
  --   config = true,
  -- },

  -- -- git helper
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-rhubarb", event = "VeryLazy" },

  { "theprimeagen/harpoon" },
  { "mbbill/undotree" },

  -- not working yet
  { "Olical/clojure-dap" },

  -- PYTHON
  -- use vim to write jupyter notebooks
  { "goerz/jupytext.vim", lazy = true },
  -- rest of REPL works with conjure

  -- CLOJURE(-SCRIPT)
  -- == SEXP MOTION MAPPINGS
  -- W, B, E, gE to use WORD motions

  -- List manipulation mappings
  -- >f and <f to move a form
  -- >e and <e to move an element.

  -- >), <), >(, and <( to handle slurpage and barfage are handled,
  -- where the angle bracket indicates the direction,
  -- the parenthesis indicates which end to operate on.

  -- Insertion mappings
  -- Use <I and >I to insert at the beginning and ending of a form.

  -- Mappings inspired by surround.vim
  -- Note that surround.vim out of the box works great with the sexp.vim motions and text objects. Use ysaf), for example, to surround the current form with parentheses. To this, we add a few more mappings:

  -- dsf: splice (delete surroundings of form)
  -- cse(/cse)/cseb: surround element in parentheses
  -- cse[/cse]: surround element in brackets
  -- cse{/cse}: surround element in braces
  { "tpope/vim-sexp-mappings-for-regular-people" },
  {
    "Olical/conjure",
    dependencies = { "guns/vim-sexp" },
    keys = { "<localleader>cs", ":execute ClerkShow()<CR>", desc = "Show Clerk" },
    ft = { "clojure", "python", "lua" },
  },
  -- Jack in to Boot, Clj & Leiningen from Vim. Inspired by the feature in CIDER.el
  -- :Boot [args]
  -- :Clj [args]
  -- :Lein [args]
  { "tpope/vim-dispatch", dependencies = { "radenling/vim-dispatch-neovim" } },
  { "clojure-vim/vim-jack-in" },

  -- COLORED LOG file, start with
  -- :AnsiEsc
  { "powerman/vim-plugin-AnsiEsc" },

  { "ThePrimeagen/refactoring.nvim" },
  -- easily jump to any location and enhanced f/t motions for Leap
  { "ggandor/leap.nvim" },
  { "tpope/vim-surround" },
  { "godlygeek/tabular" }, -- Quickly align text by pattern
  { "tpope/vim-repeat" }, -- Repeat actions better
  { "tpope/vim-abolish" }, -- Cool things with words!
  { "romainl/vim-qf" }, -- wrangle quickfix

  -- firenvim
  -- connect to firefox, chrome, etc
  -- useful for github, gmail, etc
  {
    "glacambre/firenvim",
    enabled = true,
    lazy = false,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "SmiteshP/nvim-navic",
    },
  },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>co", "<cmd>SymbolsOutline<cr>", desc = "Symbols [O]utline" } },
    config = true,
  },
  -- Use your favorite package manager to install, for example in lazy.nvim
  {
    "tjdevries/sg.nvim",
    build = "cargo build --workspace",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- nnoremap <space>ss <cmd>lua require('sg.telescope').fuzzy_search_results()<CR>
    keys = { { "<leader>sS", "<cmd>lua require('sg.telescope').fuzzy_search_results()<CR>", desc = "Symbols Outline" } },
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "pyright",
      },
    },
  },
}
