-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local wk = require("which-key")

-- AI Assistance
vim.keymap.set("i", "<C-g>", "<cmd>ChatGPTCompleteCode<CR>", { silent = true, desc = "ChatGPT Complete Code" })

-- Movement and Navigation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })
vim.keymap.set("n", "<C-y>", "<C-d>", { desc = "Scroll down" })

-- Buffer Operations
vim.keymap.set("n", "<C-s>", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format buffer" })
vim.keymap.set("n", "<C-S>", "<cmd>write<CR>", { desc = "Save buffer" })

-- Register Operations
wk.add({
  ["<leader>p"] = { [["_dP]], "Paste (keep register)" },
  ["<leader>y"] = { [["+y]], "Yank to system clipboard" },
  ["<leader>Y"] = { [["+Y]], "Yank line to system clipboard" },
  ["<leader>d"] = { [["_d]], "Delete (no register)" },
}, { mode = { "n", "v" } })

-- File Operations
wk.add({
  ["<leader>xx"] = { "<cmd>!chmod +x %<CR>", "Make file executable" },
  ["<leader>S"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and replace word" },
})

-- Tmux Integration
wk.add({
  ["<leader>ap"] = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Open tmux sessionizer" },
})

-- LSP Operations
wk.add({
  ["<leader>g"] = {
    name = "LSP goto",
    d = {
      function()
        require("fzf-lua").lsp_definitions()
      end,
      "definitions",
    },
    D = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "type definition",
    },
    L = {
      function()
        vim.lsp.buf.declaration()
      end,
      "declaration",
    },
    i = {
      function()
        require("fzf-lua").lsp_implementations()
      end,
      "implementations",
    },
    r = {
      function()
        require("fzf-lua").lsp_references()
      end,
      "references",
    },
  },
})

wk.add({
  ["<leader>c"] = {
    name = "LSP code changes",
    a = {
      function()
        vim.lsp.buf.code_action()
      end,
      "code actions",
    },
    f = {
      function()
        vim.lsp.buf.formatting()
      end,
      "format",
    },
    r = {
      function()
        vim.lsp.buf.rename()
      end,
      "rename variable",
    },
  },
})

-- Other LSP mappings
wk.add({
  K = {
    function()
      vim.lsp.buf.hover()
    end,
    "LSP hover",
  },
  ["<C-s>"] = {
    function()
      vim.lsp.buf.signature_help()
    end,
    "LSP signature help",
  },
})

-- Git Operations (Fugitive)
wk.add({
  ["<leader>G"] = {
    name = "Git",
    L = { "<cmd>0Gclog<CR>", "File log in quickfix" },
    l = { "<cmd>Gclog<CR>", "Log in quickfix" },
    g = { "<cmd>G<CR>", "Git status" },
    c = { "<cmd>FzfLua git_commits<CR>", "Git commits" },
    d = {
      name = "Diff",
      ["3"] = { "<cmd>Gvdiffsplit<CR>", "3-way diff split" },
      d = { "<cmd>Gdiff<CR>", "Diff" },
    },
  },
})
