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
  { "tpope/vim-eunuch", event = "BufReadPost" },

  -- PICKER MODE
  -- :NnnPicker to open nnn in a floating window.

  -- Comment stuff out.
  -- gcc: comment out a line (takes a count)
  -- gc: comment out the target of a motion (for example, gcap to comment out a paragraph)
  -- vmap gc: in visual mode to comment out the selection,
  -- gc in operator pending mode to target a comment
  { "tpope/vim-commentary", event = "BufReadPost" },

  { "vimwiki/vimwiki", keys = { { "<leader>ww", desc = "Vimwiki" }, event = "BufReadPost" } },
  { "bkad/CamelCaseMotion", event = "BufReadPost" },

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

  -- github copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = true },
    },
  },

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
  {
    "tpope/vim-fugitive",
    keys = { { "<leader>gg" }, { "<leader>GG" } },
    cmd = "G",
    dependencies = {
      { "tpope/vim-rhubarb" },
    },
  }, -- nvim v0.8.0
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  -- git diff branches
  -- https://stackoverflow.com/questions/13304469/how-can-i-diff-two-branches-with-fugitive/75099935#75099935
  { "idanarye/vim-merginal", cmd = "Merginal", dependencies = { "tpope/vim-fugitive" } },
  { "theprimeagen/harpoon" },
  { "mbbill/undotree", event = "BufRead" },

  -- not working yet
  { "Olical/clojure-dap" },

  -- PYTHON
  {
    -- use vim to write jupyter notebooks
    "goerz/jupytext.vim",
    ft = { "python", "jupytext" },
    dependencies = {
      -- "jupyter-vim/jupyter-vim", -- not sure if still working
      "kana/vim-textobj-user",
      -- add ]h, ah and ih to select code cells
      "GCBallesteros/vim-textobj-hydrogen",
    },
  },
  -- rest of REPL works with conjure

  -- CLOJURE(-SCRIPT)
  -- == SEXP MOTION MAPPINGS
  -- W, B, E, gE to use WORD motions

  -- == SEXP TEXT OBJECTS
  -- a] and i] to select the current element
  -- List manipulation mappings
  -- >l and <l to move a list
  -- >f and <f to move a form
  -- >e and <e to move an element.

  -- >), <), >(, and <( to handle slurpage and barfage are handled,
  -- where the angle bracket indicates the direction,
  -- the parenthesis indicates which end to operate on.

  -- Insertion mappings
  -- ,i/I to wrap the current form in a list
  -- ,w/W to wrap the current element in a list
  -- Use <I and >I to insert at the beginning and ending of a form.

  -- Mappings inspired by surround.vim
  -- Note that surround.vim out of the box works great with the sexp.vim motions and text objects. Use ysaf), for example, to surround the current form with parentheses. To this, we add a few more mappings:

  -- dsf: splice (delete surroundings of form)
  -- cse(/cse)/cseb: surround element in parentheses
  -- cse[/cse]: surround element in brackets
  -- cse{/cse}: surround element in braces
  {
    "Olical/conjure",
    -- event = "VimEnter",
    dependencies = { { "guns/vim-sexp" }, { "tpope/vim-sexp-mappings-for-regular-people" } },
    keys = { "<localleader>cs", ":execute ClerkShow()<CR>", desc = "Show Clerk" },
    ft = { "clojure", "python", "lua" },
  },
  -- Jack in to Boot, Clj & Leiningen from Vim. Inspired by the feature in CIDER.el
  -- :Boot [args]
  -- :Clj [args]
  -- :Lein [args]
  {
    "clojure-vim/vim-jack-in",
    ft = { "clojure" },
    dependencies = { "tpope/vim-dispatch", "radenling/vim-dispatch-neovim" },
  },

  -- COLORED LOG file, start with
  -- :AnsiEsc
  { "powerman/vim-plugin-AnsiEsc" },

  { "ThePrimeagen/refactoring.nvim" },
  -- easily jump to any location and enhanced f/t motions for Leap
  { "tpope/vim-surround" },
  { "godlygeek/tabular" }, -- Quickly align text by pattern
  { "tpope/vim-repeat" }, -- Repeat actions better
  { "tpope/vim-abolish" }, -- Cool things with words!
  { "romainl/vim-qf" }, -- wrangle quickfix

  -- LUA
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "SmiteshP/nvim-navic",
    },
  },
  -- DART
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
          -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
          -- see |:help dap.set_exception_breakpoints()| for more info
          exception_breakpoints = {},
          -- Whether to call toString() on objects in debug views like hovers and the
          -- variables list.
          -- Invoking toString() has a performance cost and may introduce side-effects,
          -- although users may expected this functionality. null is treated like false.
          evaluate_to_string_in_debug_views = true,
          register_configurations = function(paths)
            require("dap").configurations.dart = {
              --put here config that you would find in .vscode/launch.json
            }
            -- If you want to load .vscode launch.json automatically run the following:
            require("dap.ext.vscode").load_launchjs()
          end,
        },
      }) -- use defaults
    end,
  },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },
  {
    "mrjones2014/legendary.nvim",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    dependencies = { "kkharji/sqlite.lua" },
    config = function()
      require("legendary").setup({
        extensions = {
          lazy_nvim = true,
          which_key = {
            -- Automatically add which-key tables to legendary
            -- see WHICH_KEY.md for more details
            auto_register = true,
            -- you can put which-key.nvim tables here,
            -- or alternatively have them auto-register,
            -- see WHICH_KEY.md
            mappings = {},
            opts = {},
            -- controls whether legendary.nvim actually binds they keymaps,
            -- or if you want to let which-key.nvim handle the bindings.
            -- if not passed, true by default
            do_binding = true,
            -- controls whether to use legendary.nvim item groups
            -- matching your which-key.nvim groups; if false, all keymaps
            -- are added at toplevel instead of in a group.
            use_groups = true,
          },
        },
      })
    end,
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "debugpy",
        "shfmt",
        -- "flake8",
        "pyright",
        "clojure-lsp",
      },
    },
  },
}
