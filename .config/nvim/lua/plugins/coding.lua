return {
  -- {
  --   "saghen/blink.cmp",
  --   dependencies = { "saghen/blink.compat" },
  --   opts = {
  --     sources = {
  --       -- adding any nvim-cmp sources here will enable them
  --       -- with blink.compat
  --       compat = {},
  --       default = { "lsp", "path", "snippets", "buffer" },
  --     },
  --     completion = {
  --       accept = {
  --         auto_brackets = {
  --           kind_resolution = {
  --             blocked_filetypes = { "typescriptreact", "javascriptreact", "vue", "codecompanion" },
  --           },
  --         },
  --       },
  --     },
  --     keymap = {
  --       preset = "default",
  --     },
  --   },
  -- },
  { -- use together with nvim.surround
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    --         Old text                    Command         New text
    -- --------------------------------------------------------------------------------
    --     surr*ound_words             ysiw)           (surround_words)
    --     *make strings               ys$"            "make strings"
    --     [delete ar*ound me!]        ds]             delete around me!
    --     remove <b>HTML t*ags</b>    dst             remove HTML tags
    --     'change quot*es'            cs'"            "change quotes"
    --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    --     delete(functi*on calls)     dsf             function calls
    --     require"nvim-surroun*d"     ysa")           require("nvim-surround")
    --     int a[] = *32;              yst;}           int a[] = {32};
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
}
