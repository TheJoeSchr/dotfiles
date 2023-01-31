  " ---------------- NVIM-DAP -----------------
  " mfussenegger/nvim-dap
  " in after/plugin/nvim-dap.lua
  " dap.configurations.javascript = {
  " dap.adapters.node2 = {


  "" like F5, start to debug
  nnoremap <F5> :lua require'dap'.continue()<CR>
  nnoremap <leader>DD :lua require'dap'.continue()<CR>
  nnoremap <S-F5> <Cmd>lua require'dap'.run_last()<CR>
  nnoremap <leader>DL :lua require'dap'.run_last()<CR>

  nnoremap <leader>db :lua require'dap'.toggle_breakpoint()<CR>

  nnoremap <leader>dk :lua require'dap'.step_out()<CR>
  nnoremap <M-F5> :lua require'dap'.step_out()<CR>

  nnoremap <leader>dl :lua require'dap'.step_into()<CR>
  nnoremap <S-F4> :lua require'dap'.step_into()<CR>

  nnoremap <leader>dj :lua require'dap'.step_over()<CR>
  nnoremap <F4> :lua require'dap'.step_over()<CR>
  nnoremap <leader>dd :lua require'dap'.step_over()<CR>

  nnoremap <leader>dc <cmd>lua require('dap').run_to_cursor()<CR>

  nnoremap <leader>DQ :lua require'dap'.close()<CR>
  nnoremap <leader>dH :lua require'dap'.up()<CR>
  nnoremap <leader>dL :lua require'dap'.down()<CR>
  nnoremap <leader>d_ :lua require'dap'.disconnect();require'dap'.close();require'dap'.run_last()<CR>
  " dap.ui is from nvim-dap
  vnoremap <leader>dh :lua require'dap.ui.widgets'.preview()<CR>
  nnoremap <leader>dh :lua require'dap.ui.widgets'.hover()<CR>
  nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
  " dapui is nvim-dap-u
  nnoremap <leader>ds :lua require("dapui").float_element('scopes')<CR>

  nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
  nnoremap <leader>da :lua require'debugHelper'.attach()<CR>
  nnoremap <leader>dA :lua require'debugHelper'.attachToRemote()<CR>
  nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
  nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>

  vnoremap <silent> <leader>dv <ESC>:lua require('dap-python').debug_selection()<CR>

  " Plug 'nvim-telescope/telescope-dap.nvim'
  " already in ./**/telescope.nvim.vim
  " require('telescope').setup() require('telescope').load_extension('dap')

  nnoremap <leader>dtf :Telescope dap frames<CR>
  nnoremap <leader>dtc :Telescope dap commands<CR>
  nnoremap <leader>dtb :Telescope dap list_breakpoints<CR>
  nnoremap <leader>dtv :Telescope dap variables<CR>

  " theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
  let g:dap_virtual_text = v:true
  " in after/plugin/nvim-dap-virtual-text.vim
  " require("nvim-dap-virtual-text").setup {

  " Plug 'rcarriga/nvim-dap-ui'
  " in after/plugin/nvim-dap.vim
  " require("dapui").setup()

  " Mappings DAPUI
    " expand = { "<CR>", "<2-LeftMouse>" },
    " open = "o",
    " remove = "d",
    " edit = "e",
    " repl = "r",
    " toggle = "t",
  " eg inscopes press 'o' to open a variable
  " nnoremap <leader>du :lua require("dapui").toggle()<CR>
  " send expression to debug REPL
  vnoremap <M-e> <Cmd>lua require("dapui").eval()<CR>
  nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
  " nnoremap ee V<Cmd>lua require("dapui").eval()<CR>

