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

  -- Use netrw instead of nerdtree, improve with `0-`
  -- { "tpope/vim-vinegar", keys = { "-", "<Plug>VinegarUp", desc = "VinegarUp" } },
  -- Also use nnn as filepicker
  -- "luukvbaal/nnn.nvim",
  -- EXPLORER MODE
  -- :NnnExplorer
  -- to open nnn in a vertical split simliar to NERDTree/nvim-tree.

  -- In this mode, the plugin makes use of nnn's -F flag to listen for opened files. Pressing Enter on a file will open that file in a new buffer, while keeping the nnn window open.

  -- PICKER MODE
  -- :NnnPicker to open nnn in a floating window.

  -- In this mode nnn's -p flag is used to listen for opened files on program exit. Picker mode implies only a single selection will be made before quitting nnn and thus the floating window.

  -- SELECTION
  -- In both modes it's possible to select multiple files before pressing Enter. Doing so will open the entire selection all at once, excluding the hovered file.
  -- { "luukvbaal/nnn.nvim", lazy = false, enabled = true, config = true },
  -- use nnn instead
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  -- Comment stuff out.
  -- gcc: comment out a line (takes a count)
  -- gc: comment out the target of a motion (for example, gcap to comment out a paragraph)
  -- vmap gc: in visual mode to comment out the selection,
  -- gc in operator pending mode to target a comment
  { "tpope/vim-commentary" },
  { "vimwiki/vimwiki" },
  { "bkad/CamelCaseMotion", lazy = false },
  -- Fuzzy Finder
  -- "junegunn/fzf', { 'dir': '~/.fzf', 'do",: { -> fzf#install() } }
  -- need twice to create folder for other extensions
  { "junegunn/fzf.vim" },
  { "stsewd/fzf-checkout.vim" },
  -- - helps with sneak scoping
  { "unblevable/quick-scope" },
  { "https://gitlab.com/yorickpeterse/nvim-window.git" },
  -- "justinmk/vim-sneak", replaced by leap

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
  -- "dag/vim-fish",
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
  -- === / UNIVERSAL PLUGINS: NATIVE VIM
  -- === NATIVE ONLY ===
  -- F3 => zoom now
  { "szw/vim-maximizer", event = "VeryLazy" },
  -- Startify
  -- "mhinz/vim-startify",
  -- Center Text
  -- {"junegunn/goyo.vim"},
  -- for checkhealth
  -- "nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate",}
  -- -- themes
  -- "artanikin/vim-synthwave84",
  -- "flazz/vim-colorschemes",
  -- "sonph/onehalf', {'rtp': 'vim/",}
  -- "morhetz/gruvbox",
  -- "dracula/vim",
  -- "ericbn/vim-solarized",

  -- -- git helper
  -- "airblade/vim-gitgutter", -- replaced by gitsigns?
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-rhubarb", event = "VeryLazy" },

  "nvim-treesitter/playground",
  "theprimeagen/harpoon",
  "mbbill/undotree",
  "tpope/vim-fugitive",

  -- not working yet
  -- "Olical/clojure-dap",
  -- -- linter (works with eslint)
  -- "dense-analysis/ale", # disable for now, using coc todo lint, format
  -- and autocomplete
  -- -- emulate vscode-vim stuff
  -- "tpope/vim-commentary",
  -- -- original easymotion
  -- -- typescript support
  -- "leafgarland/typescript-vim",
  -- -- -- vue
  -- "pangloss/vim-javascript",
  -- -- VUE syntax highlight
  -- "digitaltoad/vim-pug",
  -- "posva/vim-vue",
  -- -- vue: vetur alternative
  -- :CocInstall @yaegassy/coc-volar
  -- "yaegassy/coc-volar', {'do': 'yarn install --frozen-lockfile",}

  -- PYTHON
  -- iPython support
  -- for Python code completion based on Jedi, a Python language server.
  -- "jpalardy/vim-slime', { 'for': 'python", }
  -- "hanschen/vim-ipython-cell', { 'for': 'python", }
  -- jupyter notebook support
  { "jupyter-vim/jupyter-vim" },
  -- "goerz/jupytext.vim",
  { "untitled-ai/jupyter_ascending.vim" },
  -- "davidhalter/jedi-vim",
  -- "pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main", }

  -- CLOJURE(-SCRIPT)
  -- "liuchengxu/vim-clap', { 'do",: { -> clap#installer#force_download() } }
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
    keys = { "<localleader>cs", ":execute ClerkShow()<CR>" },
    ft = { "clojure", "python", "lua" },
  },
  { "jiangmiao/auto-pairs" },
  -- lot of *()
  -- Jack in to Boot, Clj & Leiningen from Vim. Inspired by the feature in CIDER.el
  -- :Boot [args]
  -- :Clj [args]
  -- :Lein [args]
  { "tpope/vim-dispatch" },
  { "clojure-vim/vim-jack-in" },
  -- Only in Neovim:
  { "radenling/vim-dispatch-neovim" },
  -- -- other
  -- Ansible
  -- "pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh", }

  -- airline
  -- "vim-airline/vim-airline",
  -- -- airline theme
  -- "vim-airline/vim-airline-themes",
  -- TMUX
  {
    "christoomey/vim-tmux-navigator",
    -- needed otherwise doesn't work with lazy
    event = "VimEnter",
  },

  -- COLORED LOG file, start with
  -- :AnsiEsc
  { "powerman/vim-plugin-AnsiEsc" },

  -- CODE OUTLINE
  -- mainly used via <leader>o
  -- see tags, overview, etc
  -- "liuchengxu/vista.vim",

  { "ThePrimeagen/refactoring.nvim" },
  -- easily jump to any location and enhanced f/t motions for Leap
  { "ggandor/leap.nvim" },
  { "tpope/vim-surround" },
  { "godlygeek/tabular" }, -- Quickly align text by pattern
  { "tpope/vim-repeat" }, -- Repeat actions better
  { "tpope/vim-abolish" }, -- Cool things with words!
  { "romainl/vim-qf" }, -- wrangle quickfix

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
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- override nvim-cmp and add cmp-emoji
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "L3MON4D3/LuaSnip",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-nvim-lua",
  --     "hrsh7th/cmp-path",
  --     "onsails/lspkind.nvim",
  --     "saadparwaiz1/cmp_luasnip",
  --     "hrsh7th/cmp-emoji",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
  --   end,
  -- },

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
