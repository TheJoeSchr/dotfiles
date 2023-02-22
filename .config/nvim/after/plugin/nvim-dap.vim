  " ---------------- NVIM-DAP -----------------
  " mfussenegger/nvim-dap
  " in after/plugin/nvim-dap.lua
  " dap.configurations.javascript = {
  " dap.adapters.node2 = {


  "" like F5, start to debug
  nnoremap <F5> <cmd>lua require'dap'.continue()<CR>
  nnoremap <localleader>DD <cmd>lua require'dap'.continue()<CR>
  nnoremap <S-F5> <Cmd>lua require'dap'.run_last()<CR>
  nnoremap <localleader>DL <cmd>lua require'dap'.run_last()<CR>

  nnoremap <localleader>db <cmd>lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <M-d>b <cmd>lua require'dap'.toggle_breakpoint()<CR>

  nnoremap <localleader>dk <cmd>lua require'dap'.step_out()<CR>
  nnoremap <M-d>k <cmd>lua require'dap'.step_out()<CR>
  nnoremap <M-F5> <cmd>lua require'dap'.step_out()<CR>

  " nnoremap <localleader>dl <cmd>lua require'dap'.step_into()<CR>
  nnoremap <M-d>l <cmd>lua require'dap'.step_into()<CR>
  nnoremap <M-l> <cmd>lua require'dap'.step_into()<CR>
  nnoremap <S-F4> <cmd>lua require'dap'.step_into()<CR>

  " nnoremap <localleader>dj <cmd>lua require'dap'.step_over()<CR>
  nnoremap <M-d>j <cmd>lua require'dap'.step_over()<CR>
  nnoremap <M-j> <cmd>lua require'dap'.step_over()<CR>
  nnoremap <F4> <cmd>lua require'dap'.step_over()<CR>
  nnoremap <localleader>dd <cmd>lua require'dap'.step_over()<CR>

  nnoremap <localleader>dc <cmd>lua require('dap').run_to_cursor()<CR>
  nnoremap <M-d>c <cmd>lua require('dap').run_to_cursor()<CR>
  nnoremap <M-c> <cmd>lua require('dap').run_to_cursor()<CR>

  nnoremap <localleader>dQ <cmd>lua require'dap'.terminate()<CR>
  nnoremap <localleader>dK <cmd>lua require'dap'.up()<CR>
  nnoremap <M-k> <cmd>lua require'dap'.up()<CR>

  nnoremap <localleader>dh <cmd>lua require'dap'.down()<CR>
  nnoremap <M-h> <cmd>lua require'dap'.down()<CR>

  nnoremap <localleader>d_ <cmd>lua require'dap'.disconnect();require'dap'.close();require'dap'.run_last()<CR>
  nnoremap <M-d>_ <cmd>lua require'dap'.disconnect();require'dap'.close();require'dap'.run_last()<CR>
  " dap.ui is from nvim-dap
  vnoremap <localleader>dh <cmd>lua require'dap.ui.widgets'.preview()<CR>
  nnoremap <localleader>dh <cmd>lua require'dap.ui.widgets'.hover()<CR>
  nnoremap <M-H> <cmd>lua require'dap.ui.widgets'.hover()<CR>
  nnoremap <M-d>h <cmd>lua require'dap.ui.widgets'.hover()<CR>
  nnoremap <localleader>d? <cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
  " dapui is nvim-dap-ui
  nnoremap <localleader>ds <cmd>lua require("dapui").float_element('scopes')<CR>

  nnoremap <localleader>de <cmd>lua require'dap'.set_exception_breakpoints({"all"})<CR>
  nnoremap <localleader>da <cmd>lua require'debugHelper'.attach()<CR>
  nnoremap <localleader>dA <cmd>lua require'debugHelper'.attachToRemote()<CR>
  nnoremap <silent> <localleader>dn <cmd>lua require('dap-python').test_method()<CR>
  nnoremap <silent> <localleader>df <cmd>lua require('dap-python').test_class()<CR>

  vnoremap <silent> <localleader>dv <ESC><cmd>lua require('dap-python').debug_selection()<CR>
  vnoremap <silent> <localleader>dtd <ESC><cmd>lua require('dap-python').debug_test()<CR>

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
  " nnoremap <localleader>du <cmd>lua require("dapui").toggle()<CR>
  " send expression to debug REPL
  " TODO: check if dapui is open and dap running
  nnoremap <M-e> <Cmd>lua require("dapui").eval()<CR>
  vnoremap <M-e> <Cmd>lua require("dapui").eval()<CR>
  nnoremap <localleader>dE <Cmd>lua require("dapui").eval()<CR>
    
  " vnoremap  ; <Cmd>lua require("dapui").eval()<CR>
  " nnoremap <localleader>dr <cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l

