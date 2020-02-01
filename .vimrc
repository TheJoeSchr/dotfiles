" Must stand before other uses
" Map Leader to Space
let mapleader="\\"
map <Space> \
" Ctrl+Space removes Space leader lag for multiple Space inserts
inoremap <C-Space> <Space>

"
"  =============== PLUGINS ============
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'ericbn/vim-solarized'

" -- from vscode
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'justinmk/vim-sneak'
Plug 'bkad/CamelCaseMotion'

" maybe use for autocompletion, basially port of vscode
" https://github.com/neoclide/coc.nvim
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.cmd'}

" - f scoping
Plug 'unblevable/quick-scope'   
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
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" yankring with alt+p && alt+shift+p && use :Yanks
Plug 'maxbrunsfeld/vim-yankstack'

" Airline
Plug 'bling/vim-airline'
" Airline Theme
Plug 'vim-airline/vim-airline-themes'

" no visual delay after jk / kj
" Plug 'zhou13/vim-easyescape'

" Initialize plugin system
call plug#end()

"  =============== SETTINGS ============
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
set background=dark
colorscheme solarized
" solarized airline
let g:airline_solarized_bg='dark'

" yank to windows clipboard
set clipboard=unnamedplus
" automatically refresh any files that haven't been edited by Vim 
set autoread
" " https://stackoverflow.com/questions/1457540/how-to-navigate-in-large-project-in-vim
" set path=$PWD/**

" Show file options above the command line
" https://gist.github.com/csswizardry/9a33342dace4786a9fee35c73fa5deeb
set wildmenu

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
" no visual delay after jk / kj
" let g:easyescape_chars = { "j": 1, "k": 1 }
" let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>

" ---------------- FZF -----------------
" fuzzy find files in the working directory (where you launched Vim from)
nnoremap <C-p> :Files<Cr>
" nmap <leader>f :Files<cr>    

" fuzzy find lines in the current file
nmap <leader>/ :BLines<cr>   
" fuzzy find an open buffer
nmap <leader>b :Buffers<cr>  
" fuzzy find text in the working directory
nmap <leader>r :Rg           
" fuzzy find Vim commands (like Ctrl-Shift-P in Sublime/Atom/VSC)
nmap <leader>c :Commands<cr> 

" F3 resets search highlight
nnoremap <F3> :set hlsearch!<CR>

" ---------------- CTRL P -----------------
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'

" exit insert mode without ESC
" native, but with delay
" imap jk <Esc>
" imap kj <Esc>

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
" nerdtrees show dotfiles
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

" ----------- EASYMOTIONS ----------------
map <Leader><Leader>l <Plug>(easymotion-lineforward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><Leader>h <Plug>(easymotion-linebackward)

" ---------------- YANKSTACK -----------------
nmap <M-p> <Plug>yankstack_substitute_older_paste
nmap <M-P> <Plug>yankstack_substitute_newer_paste

" call camelcasemotion#CreateMotionMappings('<leader>')
