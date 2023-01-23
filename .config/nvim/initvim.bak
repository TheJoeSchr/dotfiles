" ==================
" GLOBAL SETTINGS:
" ==================
"

" NOCOMPATIBLE:
" enter the current millennium, vi not used
set nocompatible

" LEADER IS "SPACE" AND "\":
" ==========================
" --------------------------
" for <leader><leader> use \ \
" --------------------------
" (eg. \\w for easymotion-w)
" --------------------------
"
let maplocalleader=","
" Must stand before other uses
" Maps leader to \
let mapleader="\\"
" Map SPACE to None
" Without that, pressing <Space> will not behave like other keys as mapleader.
" <Space> in normal mode is mapped to <right>.
" Just press <space> a couple of times in a row and you will see undesired behaviour.
nnoremap <Space> <Nop>
" Maps SPACE to \
map <Space> \
" Exclude in select mode, so space can be used to replace
" placeholder text in a snippet.
sunmap <Space>

" Ctrl+Space removes Space leader lag for multiple Space inserts
inoremap <C-Space> <leader>

" INSTALL plug.vim:
" ==================
" automagically install only works on linux
if !has('win32')
  if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
      echo "Downloading junegunn/vim-plug to manage plugins..."
      silent !mkdir -p ~/.config/nvim/autoload/
      silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
      autocmd VimEnter * PlugInstall
  endif
endif

" ==================
" FROM: HOW TO DO 90 PERCENT OF WHAT PLUGINS DO WITH JUST VIM:
" ==================
" https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
" https://www.youtube.com/watch?v=XA2WjJbmmoM

" BASIC SETUP:
" ==================
" enable syntax and plugins
syntax enable

" FINDING FILES:
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" https://stackoverflow.com/questions/1457540/how-to-navigate-in-large-project-in-vim
" FOR SLOWER MACHINES: (enable in vimrc.local)
" Set the working directory to wherever the open file lives
" set autochdir
" set path=$PWD/**

" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*

" Show all matching files above the command line when tab complete
" from: https://gist.github.com/csswizardry/9a33342dace4786a9fee35c73fa5deeb
set wildmenu

" ============================== UI  ========================================= "

" Enable true color support
set termguicolors

" Vim airline theme
" let g:airline_theme='space'

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow
" Set preview window to appear at right
set splitright

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer
" - split :vs **/*<partial file name><Tab>
" - :e **
" Now we’re at a point where I don’t need to look through any directories
" If I know I want to open my `_components.buttons.scss` file I just need to do:
" :vs **/*butto<Tab>


" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" NATIVE AUTOCOMPLETE IN INSERT MODE:
" ===================================
" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" (needs to be in INSERT MODE)
" - ~x~o omnicomplete (files)
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option
" - ^e Exist insert mode with keeping stuff you written before

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list


" FILE BROWSING:
" ==============

" (for netrw)
filetype plugin on

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=0  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_dirhistmax = 0

" =======================
" UNIVERSAL VIM SETTINGS:
" =======================
" from various sources over time

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" TERMINAL MODE
" Escape: Ctrl-\ + ESC
" Escape: Ctrl-\ + Ctrl-n
tnoremap <C-\><Esc> <C-\><C-n>
" set vim swap directory
set directory=~/.vim/swap
  if empty(glob('~/.vim/swap'))
    silent !mkdir -p ~/.vim/swap
  endif
" disable swapfile
set noswapfile
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" yank to windows clipboard
" on linux install xclip
set clipboard=unnamedplus
" if (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
"   set clipboard=unnamed
" endif
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
" set english Language
" for menu
set langmenu=en_US
" for everyhere
let $LANG = 'en_US'
" save on focus lost
au FocusLost * silent! wa
" save on buffer switch
"
set autowrite

set cursorline

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:☠,extends:▷
set list
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59


" only keep open buffer
command! BufOnly silent! execute "%bd|e#|bd#"


source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" =======================
" UNIVERSAL KEY MAPPINGS:
" =======================

" F3 resets search highlight
nnoremap <c-F3> :set hlsearch!<CR>

" exit insert mode without ESC
" native, but with delay
" imap jk <Esc>
" imap kj <Esc>

" Paste in visual mode without yanking the old value
" like `xnoremap p pgvy` but works with register
" xnoremap p pgv"@=v:register.'y'<cr>
" xnoremap <expr> p 'pgv"'.v:register.'y`>'

" replace currently selected text with default register
" without yanking it
" vnoremap <leader>p "_dP

" delete without yanking
" vnoremap <leader>d "_d

" When you move the cursor down (or up), the cursor will jump from one visual line to the next. Normally you can press j to move down one physical line, or gj to move down one displayed line.
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" Alias uppercase W for :w
command! W write

" Use Ctrl+S for save
noremap <C-S>          :update<CR>
vnoremap <C-S>         <C-C>:update<CR>
inoremap <C-S>         <C-O>:update<CR>

" FULL-SCREEN TERMINAL switching, very convenient
" Use <Ctrl-Z>

" SPLITS:
" ================
" MOVE BETWEEN SPLITS OR WINDOWS:
" more naturally with CTLR+jklw
" close is <C-W>Q
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

"Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" == CHEATSHEET =="
" RESIZING SPLITS:
" Max out the height of the current split
" ctrl + w _
" Max out the width of the current split
" ctrl + w |
" Normalize all split sizes, which is very handy when resizing terminal
" ctrl + w =
" MORE SPLIT MANIPULATION:
" Swap top/bottom or left/right split
" Ctrl+W R
" Break out current window into a new tabview
" Ctrl+W T
" Close every window in the current tabview but the current one
" Ctrl+W o


" VIM DIFF
" I used to feel that gvim was a big improvement for viewing diffs,
" but I've changed the background colour of my terminal to a dark non-black shade,
" and set below
" The result of this is that in diff mode, differing text shows up with a black background,
" and unchanged text is coloured with the terminal background colour.
" For side-by-side diffs, this works wonderfully, since you can tell immediately
" based on the other side whether a given line is a change or add; for non-side-by-side
" you will be able to see an unchanged part in a changed line.
" This means that you can leave syntax colouring on and still be able to see diffs.
" Again, you do need to be able to set the background colour of the terminal to
" a unique, dark, non-black shade.
:highlight DiffAdd ctermbg=None
:highlight DiffChange ctermbg=None
:highlight DiffDelete ctermbg=None
:highlight DiffText cterm=Bold ctermbg=Black


" ============== PLUGINS ============================
" ============== only NATIVE VIM  ===================
if !exists('g:vscode')
  " -------------- PLUGINS NATIVE VIM -------------------
  call plug#begin('~/.vim/plugged')
    " UNIVERSAL:
    " >============== UNIVERSAL PLUGINS: NATIVE VIM ===================
      " ------ needs to be duplicated because can't call plug#begin twice
      " :Remove: Delete a file on disk without E211: File no longer available.
      " :Delete: Delete a file on disk and the buffer too.
      " :Move: Rename a buffer and the file on disk simultaneously. See also :Rename, :Copy, and :Duplicate.
      " :Chmod: Change the permissions of the current file.
      " :Mkdir: Create a directory, defaulting to the parent of the current file.
      " :Cfind: Run find and load the results into the quickfix list.
      " :Clocate: Run locate and load the results into the quickfix list.
      " :Lfind/:Llocate: Like above, but use the location list.
      " :Wall: Write every open window. Handy for kicking off tools like guard.
      " :SudoWrite: Write a privileged file with sudo.
      " :SudoEdit: Edit a privileged file with sudo.
      Plug 'tpope/vim-eunuch'
      " Peekaboo will show you the contents of the registers on the sidebar when you hit " or @ in normal mode or <CTRL-R> in insert mode

      " You can toggle fullscreen mode by pressing spacebar.
      Plug 'junegunn/vim-peekaboo'
      " Comment stuff out.
      " gcc: comment out a line (takes a count)
      " gc: comment out the target of a motion (for example, gcap to comment out a paragraph)
      " vmap gc: in visual mode to comment out the selection,
      " gc in operator pending mode to target a comment
      Plug 'tpope/vim-commentary'
      Plug 'vimwiki/vimwiki'
      Plug 'bkad/CamelCaseMotion'
      " Fuzzy Finder
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
      " need twice to create folder for other extensions
      Plug 'junegunn/fzf.vim'
      Plug 'stsewd/fzf-checkout.vim'
      " Easymotion fuzzy search
      Plug 'haya14busa/incsearch.vim'
      Plug 'haya14busa/incsearch-fuzzy.vim'
      Plug 'haya14busa/incsearch-easymotion.vim'
      " - helps with sneak scoping
      Plug 'unblevable/quick-scope'
      Plug 'justinmk/vim-sneak'

      " VIM-ABOLISH
      " Abolish lets you quickly find, substitute, and abbreviate several variations
      " of a word at once.  By default, three case variants (foo, Foo, and FOO) are
      " operated on by every command.
      " :Subvert provides an alternative, more concise syntax for searching and substituting.
      " :%S/child{,ren}/adult{,s}/g
      " COERCE
      " crs (coerce to snake_case).
      " MixedCase (crm),
      " camelCase (crc),
      " snake_case (crs),
      " UPPER_CASE (cru),
      " dash-case (cr-),
      " dot.case (cr.),
      " space case (cr<space>),
      " and Title Case (crt) are all just 3 keystrokes away.
      Plug 'tpope/vim-abolish'
      " Surround
      Plug 'tpope/vim-surround'
      " unimpaired ([p,]p etc)
      Plug 'tpope/vim-unimpaired'
      " fish file editing
      Plug 'dag/vim-fish'
      " close other buffers (and more)
      Plug 'Asheq/close-buffers.vim'
      " github copilot
      Plug 'github/copilot.vim'

    " ============== / UNIVERSAL PLUGINS: NATIVE VIM ===================

    " === NATIVE ONLY ===
    " F3
    Plug 'szw/vim-maximizer'
    " Repeat.vim remaps . in a way that plugins can tap into it.
    Plug 'tpope/vim-repeat'
    " Startify
    Plug 'mhinz/vim-startify'
    " Center Text
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    " for checkhealth
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " -- themes
    Plug 'artanikin/vim-synthwave84'
    " Plug 'flazz/vim-colorschemes'
    " Plug 'sonph/onehalf', {'rtp': 'vim/'}
    Plug 'morhetz/gruvbox'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'ericbn/vim-solarized'

    " -- git helper
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'

    " -- DEBUGGER --"
    " Plug 'puremourning/vimspector'
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'rcarriga/nvim-dap-ui'
    " not working yet
    " Plug 'Olical/clojure-dap'
    " -- linter (works with eslint)
    " Plug 'dense-analysis/ale' # disable for now, using coc todo lint, format
    " and autocomplete
    " -- emulate vscode-vim stuff
    Plug 'tpope/vim-commentary'
    " -- original easymotion
    Plug 'easymotion/vim-easymotion'
    " -- typescript support
    Plug 'leafgarland/typescript-vim'
    " -- vue
    Plug 'pangloss/vim-javascript'
    " VUE syntax highlight
    Plug 'digitaltoad/vim-pug'
    Plug 'posva/vim-vue'
    " -- vue: vetur alternative
    " :CocInstall @yaegassy/coc-volar
    " Plug 'yaegassy/coc-volar', {'do': 'yarn install --frozen-lockfile'}

    " PYTHON
    " iPython support
    " Plug 'jpalardy/vim-slime', { 'for': 'python' }
    " Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
    " jupyter notebook support
    Plug 'jupyter-vim/jupyter-vim'
    " Plug 'goerz/jupytext.vim'
    Plug 'untitled-ai/jupyter_ascending.vim'
    " for Python code completion based on Jedi, a Python language server.
    " Plug 'davidhalter/jedi-vim'
    " Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }

    " CLOJURE(-SCRIPT)
    " Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
    Plug 'guns/vim-sexp',    {'for': 'clojure'}
    " == SEXP MOTION MAPPINGS
    " W, B, E, gE to use WORD motions

    " List manipulation mappings
    " >f and <f to move a form
    " >e and <e to move an element.

    " >), <), >(, and <( to handle slurpage and barfage are handled,
    " where the angle bracket indicates the direction,
    " the parenthesis indicates which end to operate on.

    " Insertion mappings
    " Use <I and >I to insert at the beginning and ending of a form.

    " Mappings inspired by surround.vim
    " Note that surround.vim out of the box works great with the sexp.vim motions and text objects. Use ysaf), for example, to surround the current form with parentheses. To this, we add a few more mappings:

    " dsf: splice (delete surroundings of form)
    " cse(/cse)/cseb: surround element in parentheses
    " cse[/cse]: surround element in brackets
    " cse{/cse}: surround element in braces
    Plug 'tpope/vim-sexp-mappings-for-regular-people'
    Plug 'Olical/conjure'
    Plug 'jiangmiao/auto-pairs', { 'tag': 'v2.0.0' } " lot of *()
    " Jack in to Boot, Clj & Leiningen from Vim. Inspired by the feature in CIDER.el
    " :Boot [args]
    " :Clj [args]
    " :Lein [args]
    Plug 'tpope/vim-dispatch'
    Plug 'clojure-vim/vim-jack-in'
    " Only in Neovim:
    Plug 'radenling/vim-dispatch-neovim'
    " -- other
    " Ansible
    Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

    " Use netrw instead of nerdtree, improve with `0-`
    Plug 'tpope/vim-vinegar'
    " Also use nnn as filepicker
    " EXPLORER MODE
    " :NnnExplorer
    " to open nnn in a vertical split simliar to NERDTree/nvim-tree.

    " In this mode, the plugin makes use of nnn's -F flag to listen for opened files. Pressing Enter on a file will open that file in a new buffer, while keeping the nnn window open.

    " PICKER MODE
    " :NnnPicker to open nnn in a floating window.

    " In this mode nnn's -p flag is used to listen for opened files on program exit. Picker mode implies only a single selection will be made before quitting nnn and thus the floating window.

    " SELECTION
    " In both modes it's possible to select multiple files before pressing Enter. Doing so will open the entire selection all at once, excluding the hovered file.
    Plug 'luukvbaal/nnn.nvim'

    " airline
    " Plug 'vim-airline/vim-airline'
    " " airline theme
    " Plug 'vim-airline/vim-airline-themes'
    " TMUX
    Plug 'christoomey/vim-tmux-navigator'

    " COLORED LOG file, start with
    " :AnsiEsc
    Plug 'powerman/vim-plugin-AnsiEsc'
    " nvim in browser textfields
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(-1) } }

    " CODE OUTLINE
    " mainly used via <leader>o
    " see tags, overview, etc
    Plug 'liuchengxu/vista.vim'

    Plug 'ThePrimeagen/refactoring.nvim'

    " AUTOCOMPLETION: basially port of vscode autocompletion
    " https://github.com/neoclide/coc.nvim
    " if has('win32')
    "   Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.cmd'}
    " else
    "   Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " endif
  call plug#end() " /Initialize plugin system

  " ----------------
  " NATIVE SETTINGS:
  " ----------------



  " correct syntax highlight of // comments in .json files
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " show cmd in right bottom
  set showcmd


  " LOCAL THEMES:
  " "(only put into vimrc.local)
  " " set solarized theme
  " colorscheme solarized
  " " make it light
  " set background=light
  " " solarized airline
  " let g:airline_solarized_bg='dark'
  " " guifont to hack and larger
  " set guifont=Hack:h16

  " NATIVE MAPPINGS:
  " ----------------

  " CONFIG NATIVE PLUGINS:
  " ----------------------
  " ---------------
  "  --- VIMWIKI
  " This will make sure vimwiki will only set the filetype of markdown files inside a wiki directory, rather than globally.
  let g:vimwiki_global_ext = 0
  let g:vimwiki_list = [{'path':'~/zk/',
                        \ 'syntax': 'markdown', 'ext': '.md'}]
  let g:vimwiki_ext2syntax = {'.md': 'markdown',
                  \ '.mkd': 'markdown',
                  \ '.wiki': 'media' }
  " don't use global default mappings, too invasive especiall with easymotion on <leader>w
  let g:vimwiki_key_mappings =
    \ {
    \   'all_maps': 1,
    \   'global': 0,
    \   'headers': 1,
    \   'text_objs': 1,
    \   'table_format': 1,
    \   'table_mappings': 0,
    \   'lists': 1,
    \   'links': 1,
    \   'html': 1,
    \   'mouse': 0,
    \ }
  nmap <LocalLeader><LocalLeader>ww <Plug>VimwikiIndex
  nmap <LocalLeader><LocalLeader>wt <Plug><Plug>VimwikiTabIndex
  nmap <LocalLeader><LocalLeader>ws <Plug>VimwikiUISelect

  "
  " --- GOYO ------------------
  let g:goyo_height='100%'
  function! s:goyo_enter()
    if executable('tmux') && strlen($TMUX)
      silent !tmux set status off
      silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set background=dark
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
  endfunction

  function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
      silent !tmux set status on
      silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set background=dark
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
  " --- NERDTREE ------------------
  " " use split model instead of drawer (so better netrw)
  " " http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
  " let NERDTreeHijackNetrw=1
  " " show dotfiles
  " let NERDTreeShowHidden=1
  " map <C-n> :NERDTreeToggle<CR>
  " " open current file in nerdtree
  " map <leader>n :NERDTreeToggle %<CR>

  " ------------------ iPython-cell ------------------
  "------------------------------------------------------------------------------
  " slime configuration
  "------------------------------------------------------------------------------
  " always use tmux
  let g:slime_target = 'tmux'

  " fix paste issues in ipython
  let g:slime_python_ipython = 1

  " always send text to the top-right pane in the current tmux tab without asking
  let g:slime_default_config = {
              \ 'socket_name': get(split($TMUX, ','), 0),
              \ 'target_pane': '{top-right}' }
  let g:slime_dont_ask_default = 1

  "------------------------------------------------------------------------------
  " ipython-cell configuration
  "------------------------------------------------------------------------------
  " Keyboard mappings. <Leader> is \ (backslash) by default

  " map <Leader>s to start IPython
  " nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>

  " map <Leader>r to run script
  nnoremap <Leader>r :IPythonCellRun<CR>

  " map <Leader>R to run script and time the execution
  nnoremap <Leader>R :IPythonCellRunTime<CR>

  " map <Leader>c to execute the current cell
  nnoremap <Leader>c :IPythonCellExecuteCell<CR>

  " map <Leader>C to execute the current cell and jump to the next cell
  nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>

  " map <Leader>l to clear IPython screen
  " nnoremap <Leader>l :IPythonCellClear<CR>

  " map <Leader>x to close all Matplotlib figure windows
  nnoremap <Leader>x :IPythonCellClose<CR>

  " map [c and ]c to jump to the previous and next cell header
  nnoremap <Leader>[c :IPythonCellPrevCell<CR>
  nnoremap <Leader>]c :IPythonCellNextCell<CR>

  " map <Leader>h to send the current line or current selection to IPython
  nmap <Leader>h <Plug>SlimeLineSend
  xmap <Leader>h <Plug>SlimeRegionSend

  " map <Leader>p to run the previous command
  " nnoremap <Leader>p :IPythonCellPrevCommand<CR>

  " map <Leader>Q to restart ipython
  " nnoremap <Leader>Q :IPythonCellRestart<CR>

  " map <Leader>d to start debug mode
  " nnoremap <Leader>d :SlimeSend1 %debug<CR>

  " map <Leader>q to exit debug mode or IPython
  " nnoremap <Leader>q :SlimeSend1 exit<CR>
  " ------------------ /IPYTHON-CELL ------------------
  "
  " ------------------ JUPYTEXT ------------------

  let g:jupytext_fmt = 'py:percent'
  nmap <space><space>x <Plug>JupyterExecute
  nmap <space><space>X <Plug>JupyterExecuteAll
  " ------------------ /JUPYTEXT ------------------


  " ------------------ Vinegar ------------------
  map <C-n> <Plug>VinegarUp
  nmap <leader>n <Plug>VinegarUp
  nmap - <Plug>VinegarUp
  " disable annoying netrw keeps open
  autocmd FileType netrw setl bufhidden=wipe
  let g:netrw_fastbrowse = 0
  " Remove 'set hidden'
  set nohidden
  augroup netrw_buf_hidden_fix
      autocmd!

      " Set all non-netrw buffers to bufhidden=hide
      autocmd BufWinEnter *
                  \  if &ft != 'netrw'
                  \|     set bufhidden=hide
                  \| endif

  augroup end
  " ---------------- CAMELCASE -----------------
  " call camelcasemotion#CreateMotionMappings('<leader><leader>')
  " ---------------- YANKSTACK -----------------
  " nmap <M-p> <Plug>yankstack_substitute_older_paste
  " nmap <M-P> <Plug>yankstack_substitute_newer_paste
  " ---------------- YOINK -----------------
  " after performing a paste, cycle through history by hitting <c-n> and <c-p>
  " for it to work in VISUAL we need vim-subversive
  " nmap <c-n> <plug>(YoinkPostPasteSwapBack)
  " nmap <leader><c-p> <plug>(YoinkPostPasteSwapForward)
  " We also need to override the p and P keys to notify Yoink
  " nmap p <plug>(YoinkPaste_p)
  " nmap P <plug>(YoinkPaste_P)

  " " [y/]y change current yank and preview in status bar
  " nmap [y <plug>(YoinkRotateBack)
  " nmap ]y <plug>(YoinkRotateForward)

  " toggling whether the current paste is formatted or not:
  " now hitting <c-=> after a paste will toggle between formatted and unformatted
  " (equivalent to using the = key)
  " nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

  " cursor position will not change after performing a yank
  " nmap y <plug>(YoinkYankPreserveCursorPosition)
  " xmap y <plug>(YoinkYankPreserveCursorPosition)

  " ---------------- ALE ----------------------
  " fix files on save (let coc do it)
  let g:ale_fix_on_save = 0

  " disable because of coc
  let g:ale_disable_lsp = 1

  " lint after 1000ms after changes are made both on insert mode and normal mode
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_lint_delay = 1000

  " use nice symbols for errors and warnings
  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '⚠ '

  " fixer configurations
  " let g:ale_fixers = { 'python': ['yapf'] }
  " \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  " \   'javascript': ['prettier', 'eslint'],
  " \   'vue': ['prettier', 'eslint'],
  let g:ale_linters = {
      \ 'clojure': ['clj-kondo', 'joker']
  \}
{
  " dap.adapters.node2 = {

  "" manually configure different testrunner if auto-detect fails
  ""lua require('dap-python').test_runner = 'pytest'
  lua require('dap.ext.vscode').load_launchjs()
  "" find local virtualenv
  lua require('dap-python').setup(string.format('%s/bin/python', os.getenv('VIRTUAL_ENV'))) 

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
  " require('telescope').setup()
  " require('telescope').load_extension('dap')

  nnoremap <leader>dvf :Telescope dap frames<CR>
  nnoremap <leader>dvc :Telescope dap commands<CR>
  nnoremap <leader>dvb :Telescope dap list_breakpoints<CR>
  nnoremap <leader>dvv :Telescope dap variables<CR>

  " theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
  "
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
  nnoremap <leader>du :lua require("dapui").toggle()<CR>
  " send expression to debug REPL
  vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>
  nnoremap <leader>dr :lua require'dap'.repl.open({}, 'split')<CR><C-w>l
  " nnoremap ee V<Cmd>lua require("dapui").eval()<CR>

  " ---------------- NVIM-DAP -----------------
  " mfussenegger/nvim-dap
  " in after/plugin/nvim-dap.vim
  " dap.configurations.javascript = {
  " dap.adapters.node2 = {

  "" manually configure different testrunner if auto-detect fails
  ""lua require('dap-python').test_runner = 'pytest'
  lua require('dap.ext.vscode').load_launchjs()
  "" find local virtualenv
  lua require('dap-python').setup(string.format('%s/bin/python', os.getenv('VIRTUAL_ENV')))

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
  " require('telescope').setup()
  " require('telescope').load_extension('dap')

  nnoremap <leader>dvf :Telescope dap frames<CR>
  nnoremap <leader>dvc :Telescope dap commands<CR>
  nnoremap <leader>dvb :Telescope dap list_breakpoints<CR>
  nnoremap <leader>dvv :Telescope dap variables<CR>

  " theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
  "
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
  nnoremap <leader>du :lua require("dapui").toggle()<CR>
  " send expression to debug REPL
  vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>
  nnoremap <leader>dr :lua require'dap'.repl.open({}, 'split')<CR><C-w>l
  " nnoremap ee V<Cmd>lua require("dapui").eval()<CR>

  " jank/vim-test and mfussenegger/nvim-dap nnoremap <leader>dt :TestNearest -strategy=jest<CR>
  "
  function! JestStrategy(cmd)
    let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
    let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
    call luaeval("require'debugHelper'.debugJest([[" . testName . "]], [[" . fileName . "]])")
  endfunction
  let g:test#custom_strategies = {'jest': function('JestStrategy')}
  " ---------------- VIMSPECTOR -----------------
  " " packadd! vimspector
  " let g:vimspector_enable_mappings = 'HUMAN'
  " " mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
  " " for normal mode - the word under the cursor
  " nmap <Leader>di <Plug>VimspectorBalloonEval
  " " for visual mode, the visually selected text
  " xmap <Leader>di <Plug>VimspectorBalloonEval
  " " mnemonic 'dh' = like gh in coc
  " " for normal mode - the word under the cursor
  " nmap <Leader>dh <Plug>VimspectorBalloonEval
  " " for visual mode, the visually selected text
  " xmap <Leader>dh <Plug>VimspectorBalloonEval

  " nnoremap <leader>dd :call vimspector#Launch()<CR>
  " nnoremap <leader>de :call GotoWindow(g:vimspector_session_windows.code)<CR>
  " nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
  " nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
  " nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
  " nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
  " nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
  " nnoremap <leader>dq :call vimspector#Reset()<CR>


  " nmap <leader>dl <Plug>VimspectorStepInto
  " nmap <leader>dj <Plug>VimspectorStepOver
  " nmap <leader>dk <Plug>VimspectorStepOut
  " nmap <leader>d_ <Plug>VimspectorRestart
  " nnoremap <leader>dJ :call vimspector#Continue()<CR>

  " nmap <leader>drc <Plug>VimspectorRunToCursor

  " nmap <C-F9> <Plug>VimspectorToggleBreakpoint
  " nmap <F9> <Plug>VimspectorStepInto
  " nmap <leader>db <Plug>VimspectorToggleBreakpoint
  " nnoremap <leader>dbl <Plug>VimspectorToggleBreakpoint
  " nmap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint

  " ---------------- NNN -----------------

    " KEY BINDINGS
    " _ as netrw on alternativa
    nnoremap _ <cmd>NnnExplorer %:p:h<CR>
    " _ as netrw on alternativa
    " (beware tmux overlap)
    " tnoremap <C-A-O> <cmd>NnnExplorer<CR>
    " tnoremap <C-A-o> <cmd>NnnPicker<CR>
  " ---------------- FZF -----------------
  " MAIN KEYBIND
  " nnoremap <C-t> :Files<Cr>

  " fzf-checkout
  " Define a diff action using fugitive. You can use it with :GBranches diff or with :GBranches and pressing ctrl-f:
  let g:fzf_branch_actions = {
        \ 'diff': {
        \   'prompt': 'Diff> ',
        \   'execute': 'Git diff {branch}',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-f',
        \   'required': ['branch'],
        \   'confirm': v:false,
        \ },
        \}
  " buffers & old files history
  " nnoremap <silent> <Leader>B :History<CR>
  " nnoremap <silent> <Leader>rb :History<CR>

  " other Keybinds
  " nnoremap <silent> <Leader>rp :FZF<CR>
  " nnoremap <silent> <Leader>r/ :BLines<CR>
  " nnoremap <silent> <Leader>" :Marks<CR>
  " nnoremap <silent> <Leader>L :Commits<CR>
  " nnoremap <silent> <Leader>H :Helptags<CR>
  " nnoremap <silent> <Leader>rr :History/<CR>
  " nnoremap <silent> i<Leader>r: :History:<CR>

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

  " ---------------- / FZF ------------
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

  " grep all files in workdir
  nnoremap <leader>fa <cmd>lua require('telescope.builtin').live_grep()<cr>
  " search in current buffe
  nnoremap <leader>fs <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
  " rg | fzf
  nnoremap <leader>fg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
  nnoremap <leader>fG :Rg
  " find word under cursor
  nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>

  nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap <Leader>' <cmd>lua require('telescope.builtin').marks()<cr>
  nnoremap <leader>; <cmd>lua require('telescope.builtin').oldfiles()<cr>
  nnoremap <Leader>fl <cmd>lua require('telescope.builtin').git_commits()<cr>
  nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
  nnoremap <leader>f: <cmd>lua require('telescope.builtin').commands_history()<cr>
  nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
  nnoremap <leader>ft <cmd>Telescope lsp_document_symbols<CR>
  nnoremap <leader>fk <cmd>lua require('telescope.builtin').keymaps()<cr>
  nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfixhistory()<cr>
  " ChatGPT
  nnoremap <leader>fr ggVG<cmd>lua require('chatgpt').edit_with_instructions()<CR>
  vnoremap <leader>fr <cmd>lua require('chatgpt').edit_with_instructions()<CR>

  " Vista
  nnoremap <leader>o  <cmd>Vista nvim_lsp<CR>
  " ---------------- /Telescope --------
  " ---------------- Unimpaired --------
  " open quickfix
  nnoremap <leader>yq :copen<CR>
  " ---------------- Vista --------
  " How each level is indented and what to prepend.
  " This could make the display more compact or more spacious.
  " e.g., more compact: ["▸ ", ""]
  " Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]


  " To enable fzf's preview window set g:vista_fzf_preview.
  " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
  " For example:
  let g:vista_fzf_preview = ['right:50%']
  " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
  let g:vista#renderer#enable_icon = 1
  " How to show the detailed formation of current cursor symbol.
  let g:vista_echo_cursor_strategy = "floating_win"
  " Set this option to `1` to close the vista window automatically close when you jump to a symbol.
  let g:vista_close_on_jump = 0
  " Move to the vista window when it is opened. Set this option to `0` to stay in current windown when opening the vista sidebar.
  let g:vista_stay_on_open = 1

  let g:vista_default_executive = "nvim_lsp"
  "
  " ---------------- REFACTOR ------------
  "
  " Telescope with refactor operations
  " <leader>rr in ~/.config/nvim/after/plugin/telescope.nvim.vim
  " <leader>r* in ~/.config/nvim/after/plugin/refactoring.nvim.vim
  " visual mode
  " <leader>re Extract Function
  " <leader>rf Extract Function To File
  " <leader>rv Extract Variable
  " <leader>ri Inline Variable
  " normal mod                                                                e
  "<leader>rb  Extract Block
  "<leader>rbf Extract Block To File
  " Inline var
  "<leader>ri Inline Variable

  "

  " ---------------- Copilot ------------
  " Fixes <tab> not working well with coc and copilot
  " let g:copilot_no_tab_map = v:true
  " inoremap <silent><expr> <TAB>
  "       \ coc#pum#visible() ? coc#pum#next(1):
  "       \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
  "       \ CheckBackSpace() ? "\<Tab>" :
  "       \ coc#refresh()

  " ----------------- AIRLINE ---------------
  " let g:airline#extensions#tabline#enabled = 1

  " ---------------- FIRENVIM --------------
  let g:firenvim_config = {
      \ 'globalSettings': {
      \  },
      \ 'localSettings': {
          \ '.*': {
              \ 'cmdline': 'firenvim',
              \ 'priority': 0,
              \ 'selector': 'textarea',
              \ 'takeover': 'never',
          \ },
      \ }
  \ }
  let fc = g:firenvim_config['localSettings']
  if exists('g:started_by_firenvim')
    let g:airline_disable_statusline = 1
    let g:airline#extensions#tabline#enabled = 0
    " automatically syncing changes to the page
    " https://github.com/glacambre/firenvim
    au TextChanged * ++nested write
    au TextChangedI * ++nested write
  endif
  " ---------------- FUGITIVE --------------
  nnoremap <silent> <leader>g :G <CR>
  nnoremap <silent> <leader>Gd :0Gclog <CR>
  nnoremap <silent> <leader>Gl :Gclog <CR>
  command! GHistory call s:view_git_history

  " auto-clean fugitive bufffers (vimcasts #34)
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " maps .. to the above command, but only for buffers containing a git blob or tree:
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

  function! s:view_git_history() abort
    Git difftool --name-only ! !^@
    call s:diff_current_quickfix_entry()
    " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
    " There's probably a better way to map this without changing the window
    copen
    nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
    wincmd p
  endfunction

  function s:diff_current_quickfix_entry() abort
    " Cleanup windows
    for window in getwininfo()
      if window.winnr !=? winnr() && bufname(window.bufnr) =~? '^fugitive:'
        exe 'bdelete' window.bufnr
      endif
    endfor
    cc
    call s:add_mappings()
    let qf = getqflist({'context': 0, 'idx': 0})
    if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
      let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
      echom string(reverse(range(len(diff))))
      for i in reverse(range(len(diff)))
        exe (i ? 'leftabove' : 'rightbelow') 'vert diffsplit' fnameescape(diff[i].filename)
        call s:add_mappings()
      endfor
    endif
  endfunction

  function! s:add_mappings() abort
    nnoremap <buffer>]q :cnext <BAR> :call <sid>diff_current_quickfix_entry()<CR>
    nnoremap <buffer>[q :cprevious <BAR> :call <sid>diff_current_quickfix_entry()<CR>
    " Reset quickfix height. Sometimes it messes up after selecting another item
    11copen
    wincmd p
  endfunction
  " ------------------ /FUGITIVE -------------"
  " ---------------- COC ------------
  " coc config
  " automatically installs this coc extension
  " probably needs restart, check with <leader>e
  " let g:coc_global_extensions = [
  "   \ '@yaegassy/coc-volar',
  "   \ 'coc-css',
  "   \ 'coc-eslint',
  "   \ 'coc-git',
  "   \ 'coc-html',
  "   \ 'coc-json',
  "   \ 'coc-pairs',
  "   \ 'coc-prettier',
  "   \ 'coc-pyright',
  "   \ 'coc-snippets',
  "   \ 'coc-tsserver',
  "   \ 'coc-diagnostic',
  "   \ 'coc-conjure',
  "   \ ]
  " "  TextEdit might fail if hidden is not set.
  " set hidden

  " " Some servers have issues with backup files, see #649.
  " set nobackup
  " set nowritebackup

  " " Give more space for displaying messages.
  " set cmdheight=2

  " " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " " delays and poor user experience.
  " set updatetime=300

  " " Don't pass messages to |ins-completion-menu|.
  " set shortmess+=c

  " " Always show the signcolumn, otherwise it would shift the text each time
  " " diagnostics appear/become resolved.
  " " actually don't know patch number, just know not working with nvim 0.2
  " if has('patch8.1.1068')
  "   set signcolumn=yes
  " endif

  " " Use tab for trigger completion with characters ahead and navigate.
  " " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " " other plugin before putting this into your config.
  " inoremap <silent><expr> <TAB>
  "   \ coc#pum#visible() ? coc#_select_confirm() :
  "   \ coc#expandableOrJumpable() ?
  "   \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  "   \ <SID>check_back_space() ? "\<TAB>" :
  "   \ coc#refresh()

  " function! s:check_back_space() abort
  "   let col = col('.') - 1
  "   return !col || getline('.')[col - 1]  =~# '\s'
  " endfunction

  " let g:coc_snippet_next = '<tab>'

  " " Use `[g` and `]g` to navigate diagnostics
  " nmap <silent> [g <Plug>(coc-diagnostic-prev)
  " nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " " GoTo code navigation.
  " nmap <silent> gd <Plug>(coc-definition)
  " nmap <silent> gy <Plug>(coc-type-definition)
  " nmap <silent> gi <Plug>(coc-implementation)
  " nmap <silent> gr <Plug>(coc-references)

  " " Use K to show documentation in preview window.
  " nnoremap <silent> K :call <SID>show_documentation()<CR>
  " nnoremap <silent> gh :call <SID>show_documentation()<CR>

  " function! s:show_documentation()
  "   if (index(['vim','help'], &filetype) >= 0)
  "     execute 'h '.expand('<cword>')
  "   else
  "     call CocAction('doHover')
  "   endif
  " endfunction

  " " Highlight the symbol and its references when holding the cursor.
  " autocmd CursorHold * silent call CocActionAsync('highlight')

  " " Symbol renaming.
  " nmap <leader>rn <Plug>(coc-rename)

  " " Formatting selected code (with code).
  " xmap <leader>=  <Plug>(coc-format-selected)
  " nmap <leader>=  <Plug>(coc-format-selected)
  " nmap <leader>+  :Format<CR>
  " " add snowflake exception for VUE
  " " see: https://github.com/neoclide/coc-prettier/issues/73#issuecomment-742580180
  " command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
  " autocmd BufWritePre *.vue Prettier

  " augroup tsandjsgroupd
  "   autocmd!
  "   " Setup formatexpr specified filetype(s).
  "   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  "   " Update signature help on jump placeholder.
  "   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " augroup end

  " " Applying codeAction to the selected region.
  " " Example: `<leader>aap` for current paragraph
  " xmap <leader>a  <Plug>(coc-codeaction-selected)
  " nmap <leader>a  <Plug>(coc-codeaction-selected)

  " " Remap keys for applying codeAction to the current line.
  " nmap <leader>ac  <Plug>(coc-codeaction)
  " " Apply AutoFix to problem on the current line.
  " nmap <leader>aq  <Plug>(coc-fix-current)

  " " Introduce function text object
  " " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  " xmap if <Plug>(coc-funcobj-i)
  " xmap af <Plug>(coc-funcobj-a)
  " omap if <Plug>(coc-funcobj-i)
  " omap af <Plug>(coc-funcobj-a)

  " " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " " coc-tsserver, coc-python are the examples of servers that support it.
  " xmap <silent> <TAB> <Plug>(coc-range-select)
  " " don't use TAB in normal mode, it blocks CTRL-I
  " " nmap <silent> <TAB> <Plug>(coc-range-select)

  " " Add `:Format` command to format current buffer.
  " command! -nargs=0 Format :call CocAction('format')

  " " Add `:Fold` command to fold current buffer.
  " command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " " Add `:OR` command for organize imports of the current buffer.
  " command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " " Add (Neo)Vim's native statusline support.
  " " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " " provide custom statusline: lightline.vim, vim-airline.
  " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " " Mappings using CoCList:
  " " Show all diagnostics.
  " nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
  " " Manage extensions.
  " " nnoremap <silent> <leader>fe  :<C-u>CocList extensions<cr>
  " " Show commands.
  " nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
  " " Find symbol of current document.
  " nnoremap <silent> <leader>O  :<C-u>CocList --normal outline <cr>
  " " Search workspace symbols.
  " nnoremap <silent> <leader>S  :<C-u>CocList -I symbols -k<cr>
  " nnoremap <silent> <leader>s  :<C-u>Vista finder coc<cr>
  " " Do default action for next item.
  " nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
  " " Do default action for previous item.
  " nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
  " " Resume latest coc list.
  " nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>-----
  " " hover popup scroll "
  " if has('nvim-0.4.3') || has('patch-8.2.0750')
  "           nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  "           nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  "           inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  "           inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  " endif
  " ---------------- /COC ------------
endif
" ============== / only NATIVE VIM  ===================


" ============== VSCODE-NEOVIM ===================
"
if exists('g:vscode')
  " -------------- PLUGINS VSCODE -------------------
  call plug#begin('~/.vim/plugged')
    " ============== UNIVERSAL PLUGINS: VSCODE-NEOVIM ===================
    " ------ needs to be duplicated because can't call plug#begin twice
      Plug 'tpope/vim-eunuch'
      Plug 'junegunn/vim-peekaboo'
      Plug 'tpope/vim-commentary'
      Plug 'bkad/CamelCaseMotion'
      " Fuzzy Find
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
      Plug 'junegunn/fzf.vim'
      Plug 'stsewd/fzf-checkout.vim'
      " Easymotion fuzzy search
      Plug 'haya14busa/incsearch.vim'
      Plug 'haya14busa/incsearch-fuzzy.vim'
      Plug 'haya14busa/incsearch-easymotion.vim'
      " - helps with f scoping
      Plug 'unblevable/quick-scope'
      Plug 'justinmk/vim-sneak'
      " Surround
      Plug 'tpope/vim-surround'
      " unimpaired ([p,]p etc)
      Plug 'tpope/vim-unimpaired'
      " fish file editing
      Plug 'dag/vim-fish'
      " close other buffers (and more)
      Plug 'Asheq/close-buffers.vim'
    " ============== / UNIVERSAL PLUGINS: VSCODE-NEOVIM ===================
    " Special easymotion fork (only working in VSCode)
    Plug 'asvetliakov/vim-easymotion'
  call plug#end()
  " use VSCode built-in commentary instead of plug
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  " window navigate like with tmux plugin
  "
  xnoremap <silent> <C-j> :<C-u>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
  nnoremap <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  xnoremap <silent> <C-k> :<C-u>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
  nnoremap <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  xnoremap <silent> <C-h> :<C-u>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
  nnoremap <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
  xnoremap <silent> <C-l> :<C-u>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

  " unset clipboard for remote work
  " set clipboard=

  " don't display line numbers
  "
  set relativenumber!
  set number!
endif
" ============== / VSCODE-NEOVIM ===================
"
" ================== UNIVERSAL PLUGINS CONFIG =================
"
" ~/.config/nvim/lua/plugins.lua
lua require('plugins')
" ------------------ CONJURE  ------------------
"
function! ClerkShow()
  exe "w"
  exe "ConjureEval (nextjournal.clerk/show! \"" . expand("%:p") . "\")"
endfunction

nmap <localleader>cs :execute ClerkShow()<CR>

" ------------------ VIM-MAXIMIZER ------------------
"
nnoremap <silent><C-w>O :MaximizerToggle<CR>
vnoremap <silent><C-w>O :MaximizerToggle<CR>gv
inoremap <silent><C-w>O <C-o>:MaximizerToggle<CR>

" --------- SNEAK-----------
" 'fs': 2 character Sneak
" forward
map fs <Plug>Sneak_s
" beak
map Fs <Plug>Sneak_S
let g:sneak#label = 1

" immediately after invoking Sneak you can move to the
" next match by hitting `s` (or `S`) again
let g:sneak#s_next = 1

" DISABLED because of built-in sneak
" replace f and/or t with one-character Sneak?
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T


" --------- RIPGREP ---------
"  Search in files, with:
"  <leader>f
" if executable('rg')
"     set grepprg=rg\ --vimgrep\ --no-heading
"     set grepformat=%f:%l:%c:%m,%f:%l:%m
"     " For use with ack.vim
"     let g:ackprg = 'rg --vimgrep --no-heading'
"     " shortcut: <C-p>a
"     " nnoremap <C-p>a :Rg

"     " Adds command :Rg
"     command! -bang -nargs=* Rg
"       \ call fzf#vim#grep(
"       \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"       \   fzf#vim#with_preview(), <bang>0)

" endif

" --------- CLOSE-BUFFERS ---------
" nnoremap <silent> Q     :close<CR>
nnoremap <silent> Q     :Bdelete menu<CR>
nnoremap <silent> <C-q> :Bdelete menu<CR>
nnoremap <silent> <leader>Q     :Bdelete other<CR>
nnoremap <silent> <leader>q :Bdelete menu<CR>
" ================== / UNIVERSAL PLUGINS CONFIG =================

" in ~/.config/nvim/lua/telescope.lua
" lua require("telescope-config")

" ==== CURRENTLY UNUSED (from 90% without plugin) =====

" TAG JUMPING:
" ==================

" Create the `tags` file (may need to install ctags first)
" command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" SNIPPETS:
" =========

" EXAMPLE:
" Make an empty HTML template and move cursor to title
" nnoremap <leader>html :-1read $HOME/.vim/.skeleton.html<CR>3jw

" NOW WE CAN:
" - Take over the world!
"   (with much fewer keystrokes)

" BUILD INTEGRATION:
" ==================

" Steal Mr. Bradley's formatter & add it to our spec_helper
" http://philipbradley.net/rspec-into-vim-with-quickfix

" Configure the `make` command to run RSpec
" set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter

" NOW WE CAN:
"
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back
" ==== /CURRENTLY UNUSED (from 90% without plugin) =====


" (Shift+) F8 rotates through TDD phases red, green, refactor
source ~/.config/nvim/tddcolors.vim

lua require("newinit")
source ~/.vimrc.local
" ==== .vimrc.local EXAMPLE =======

" set relativenumber!
" set number!

" if exists('g:started_by_firenvim')
"   " make it light
"   set background=light
"   colorscheme onehalflight
"   let g:airline_solarized_bg='light'
"   " guifont to hack and larger
"   set guifont=Hack:h23
" else
"   set background=dark
"   let g:gruvbox_contrast_dark='hard'
"   let g:gruvbox_transparent_bg=1
"   colorscheme gruvbox
"   " solarized airline
"   let g:airline_solarized_bg='dark'
" endif
"
" set background transparent
" need to come after colorscheme
" set background transparent
" hi Normal guibg=NONE ctermbg=NONE
