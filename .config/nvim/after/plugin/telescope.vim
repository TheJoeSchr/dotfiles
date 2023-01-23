  " ---------------- TELESCOPE ------------


  " === Telescope shorcuts === "
  "   <ctrl>p - Browse list of buffers & files in current directory/project
  "   <leader>: - Search command history
  "   <leader>; - Search for open buffers
  "   <leader>fg - Search current directory (rg)
  "   <leader>fw - Search current directory for occurences of word under cursor
  " Using lua functions
  nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
  " file finder
  nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
  " file finder via nnn
  nnoremap <leader>fp <cmd>NnnPicker<CR>

  " grep in curren buffer
  nnoremap <leader>fs <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
  " grep all files in workdir
  nnoremap <leader>fa <cmd>lua require('telescope.builtin').live_grep()<cr>
  " rg | fzf
  nnoremap <leader>fA :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
  nnoremap <leader>faw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
  " search in current buffer
  nnoremap <leader>fs <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
  " find word under cursor

  nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap <Leader>' <cmd>lua require('telescope.builtin').marks()<cr>
  nnoremap <leader>; <cmd>lua require('telescope.builtin').oldfiles()<cr>
  nnoremap <Leader>fg <cmd>lua require('telescope.builtin').git_commits()<cr>
  nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
  nnoremap <leader>f: <cmd>lua require('telescope.builtin').commands_history()<cr>
  nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
  nnoremap <leader>ft <cmd>lua require('telescope.builtin').tags()<cr>
  nnoremap <leader>fk <cmd>lua require('telescope.builtin').keymaps()<cr>
  nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfixhistory()<cr>
  " ChatGPT
  nnoremap <leader>fr ggVG<cmd>lua require('chatgpt').edit_with_instructions()<CR>
  vnoremap <leader>fr <cmd>lua require('chatgpt').edit_with_instructions()<CR>
  " ---------------- /Telescope --------
