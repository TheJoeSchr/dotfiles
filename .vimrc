" automagically plug.vim
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Must stand before other uses
" Map Leader to Space
let mapleader="\\"
map <Space> \
" Ctrl+Space removes Space leader lag for multiple Space inserts
inoremap <C-Space> <Space>
"  =============== GLOBAL PLUGINS ============
"  =============== GLOBAL SETTINGS ============
" yank to windows clipboard
set clipboard=unnamedplus
" automatically refresh any files that haven't been edited by Vim 
set autoread
" hides buffer instead of closing it
set hidden
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" you get relative numbers for all lines except the current, which is displayed as absolute.
set relativenumber
set number
" tabs
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab


" ============ Mappings =============

" F3 resets search highlight
nnoremap <F3> :set hlsearch!<CR>


" exit insert mode without ESC
" native, but with delay
imap jk <Esc>
imap kj <Esc>

" Paste in visual mode without yanking the old value
" like `xnoremap p pgvy` but works with register
" xnoremap p pgv"@=v:register.'y'<cr>
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" When you move the cursor down (or up), the cursor will jump from one visual line to the next. Normally you can press j to move down one physical line, or gj to move down one displayed line.
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
" ================== CONFIG PLUGINS =================
" ----------- EASYMOTIONS ----------------
map <Leader><Leader>l <Plug>(easymotion-lineforward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><Leader>h <Plug>(easymotion-linebackward)

" ---------------- YANKSTACK -----------------
nmap <M-p> <Plug>yankstack_substitute_older_paste
nmap <M-P> <Plug>yankstack_substitute_newer_paste

" --------- SNEAK-----------
" replace f with Sneak
map f <Plug>Sneak_s
map F <Plug>Sneak_S

let g:sneak#label = 1

" ============== only VSCODE ===================
if exists('g:vscode')
  " -------------- PLUGINS only for VSCODE -------------------
  call plug#begin('~/.vim/plugged')
    Plug 'justinmk/vim-sneak'
    Plug 'bkad/CamelCaseMotion'
    " Fuzzy Find, use :ctrlp or <c-p> 
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " - f scoping
    Plug 'unblevable/quick-scope'   
    " Special easymotion fork
    Plug 'asvetliakov/vim-easymotion'
  call plug#end()
  " config commentary
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
else
  " ordinary neovim
  " ============== PLUGINS VIM ===================
  call plug#begin('~/.vim/plugged')
    Plug 'justinmk/vim-sneak'
    Plug 'bkad/CamelCaseMotion'

    " - f scoping
    Plug 'unblevable/quick-scope'   
    " -- from vscode
    Plug 'ericbn/vim-solarized'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'easymotion/vim-easymotion'

    " -- typescript support
    Plug 'leafgarland/typescript-vim'
    " -- vue
    Plug 'posva/vim-vue'
    Plug 'pangloss/vim-javascript'

    " -- other
    " Make sure you use single quotes
    " On-demand loading
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

    " zooms font with + and -
    Plug 'thinca/vim-fontzoom'

    " Fuzzy Find, use :ctrlp or <c-p> 
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " yankring with alt+p && alt+shift+p && use :yanks
    Plug 'maxbrunsfeld/vim-yankstack'

    " airline
    Plug 'bling/vim-airline'
    " airline theme
    Plug 'vim-airline/vim-airline-themes'

    " maybe use for autocompletion, basially port of vscode
    " https://github.com/neoclide/coc.nvim
    if has('win32')
      " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.cmd'}
    else
      " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif

    " no visual delay after jk / kj
    " Plug 'zhou13/vim-easyescape'

  call plug#end() " /Initialize plugin system
  "-------- SETTINGS ----------

  " show cmd in right bottom
  set showcmd

  " guifont larger
  set guifont=Hack:h16
  " ---- Language english for menu
  set langmenu=en_US
  let $LANG = 'en_US'
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim

  "  set solarized
  syntax enable
  set background=light
  colorscheme solarized
  " solarized airline
  let g:airline_solarized_bg='dark'
  " " https://stackoverflow.com/questions/1457540/how-to-navigate-in-large-project-in-vim
  " set path=$PWD/**

  " Show file options above the command line
  " https://gist.github.com/csswizardry/9a33342dace4786a9fee35c73fa5deeb
  set wildmenu
  
  " ============ Mappings =============
  " ---------------- FZF -----------------
  nnoremap <C-p> :FZF<Cr>
  " An action can be a reference to a function that processes selected lines
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }


  " Default fzf layout
  " - down / up / left / right
  let g:fzf_layout = { 'down': '~40%' }

  " You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
  let g:fzf_layout = { 'window': 'enew' }
  let g:fzf_layout = { 'window': '-tabnew' }
  let g:fzf_layout = { 'window': '10new' }

  " Customize fzf colors to match your color scheme
  " - fzf#wrap translates this to a set of `--color` options
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  " Enable per-command history
  " - History files will be stored in the specified directory
  " - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
  "   'previous-history' instead of 'down' and 'up'.
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  " ---------------- Ctrl-P -----------------
  " fuzzy find files in the working directory (where you launched Vim from)
  " nnoremap <C-p> :Files<Cr>
  " nmap <leader>f :Files<cr>    

  " fuzzy find lines in the current file
  " nmap <leader>/ :BLines<cr>   
  " fuzzy find an open buffer
  " nmap <leader>b :Buffers<cr>  
  " fuzzy find text in the working directory
  " nmap <leader>r :Rg           
  " fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)
  " nmap <leader>c :Commands<cr> 

  " ================== CONFIG PLUGINS =================
  " nerdtrees show dotfiles
  let NERDTreeShowHidden=1
  map <C-n> :NERDTreeToggle<CR>
  " ------------------ COC ------------------
  " ------------------ CamelCase ------------------
  call camelcasemotion#CreateMotionMappings('<leader>')
  set directory=~/.vim/swap
  if empty(glob('~/.vim/swap'))
      silent !mkdir -p ~/.vim/swap
  endif
set directory=$HOME/.vim/tmp
endif

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    " For use with ack.vim 
    let g:ackprg = 'rg --vimgrep --no-heading'
    " shortcut: <C-p>a
    nmap <leader>r :Rg           
    nnoremap <C-p>a :Rg 
    
    " Adds command :Rg 
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

endif

source ~/.vimrc.local
