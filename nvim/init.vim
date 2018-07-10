call plug#begin('~/.local/share/nvim/plugged')
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"Plug 'cazador481/fakeclip.neovim' " not sure this is needed anymore
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'roxma/nvim-completion-manager' "Needs a lot of work to get going.
Plug 'mhartington/oceanic-next'
Plug 'bagrat/vim-workspace'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-jdaddy' " JSON tools.
Plug 'scrooloose/nerdtree' " See https://stackoverflow.com/questions/4571494/open-a-buffer-as-a-vertical-split-in-vim for tips on navigating and splitting panes
Plug 'Xuyuanp/nerdtree-git-plugin'

" Plugin prerequisites:
" To install vim-plug, run:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Ultisnips requires a python module to be installed on the system.  To fix
" this, run pip3 install --user neovim

" Installing plugins:
" Call :PlugInstall to install plugins (when installing or updating)

" This one package requires a recent build of Rust to be installed, along with
" the cargo package manager.
" that.
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

call plug#end()
set guicursor=
syntax on
filetype plugin on
filetype plugin indent on
colorscheme desert

set autoindent " Automatic indentation
set smartindent " Attempts to indent intelligently
set tabstop=2
set shiftwidth=2
set expandtab " expands tabs to spaces
set showmatch " Shows matching brackets as you type them
set incsearch " Moves cursor to match searches as you type them
set hidden " hide buffers instead of closing them
" set number " always show line numbers
 set ignorecase "Case-insensitive searches, setting smartcase causes case-sensitivity only if capital letters are present in the search
 set smartcase " ignore case while searching if search pattern is all lower-case
set hlsearch " highlight search terms
set diffopt=vertical "By default, diffs are started with a vertical split.

set foldmethod=indent
set foldlevel=99

"Set tab completion to first complete to the longest match (like bash),
"then to list matches with a second press of tab, and finally to complete
"to the first match with a third press of tab.
set wildmode=longest,list,full
set wildmenu

"To avoid having syntax highlighting get in the way of diff highlighting (and
"inadvertently hiding some characters), turn off syntax highlighting when
"starting up in diff mode.
if &diff
  syntax off
endif

" When performing a horizontal split, open below the current displayed buffer,
" instead of above it:
set splitbelow

" Disable F1 opening the help file (I often hit this when I mean to hit escape)
map <F1> <Esc>
imap <F1> <Esc>


" Highlight any trailing whitespace in a file
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

"Some weird crap with .tex files not being detected properly by default
let g:tex_flavor = 'tex'

" Quickly edit/reload the vimrc file
" Maps the ev and sv keys to edit/reload .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Sets the spacebar to be a trigger (leader) key for custom commands
" Spacebar makes good sense here, since it is accessible from both hands and
" is not really used while in normal mode.
let mapleader="\<SPACE>"


nmap <silent> <leader>gs :Gstatus<CR>
nmap <silent> <leader>gc :Gcommit<CR>

" F-key bindings:
" Binds the F9 key to run make on the current directory
map <f9> :make -j3<CR>

" Quickly quote the word under the cursor while in normal or insert mode using
" ctrl-q q:
"
" Mapping mnemonic: q = quote, p = parentheses, c = curly bracket, b =
" bracket, a = angle bracket
nmap <C-q>q ysiw"
imap <C-q>q <ESC>ysiw"i

nmap <C-q>p ysiw)
imap <C-q>p <ESC>ysiw)i


nmap <C-q>c ysiw}
imap <C-q>c <ESC>ysiw}i

nmap <C-q>a ysiw>
imap <C-q>a <ESC>ysiw>i

nmap <C-q>b ysiw]
imap <C-q>b <ESC>ysiw]i


function! SmartHome()
  let s:col = col(".")
  normal! ^
  if s:col == col(".")
    normal! 0
  endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>
"Set highlighting for terminals with a dark background
hi PreProc term=bold ctermfg=Cyan guifg=#80a0ff gui=bold

"nvim-completion-manager settings:
"
" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

" Enter closes the completion menu and starts a new line
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Tab selects the completion menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" OceanicNext settings
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

" Airline settings:
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 2
let g:airline_theme= 'oceanicnext'

" Nerdtree settings
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-jdaddy bindings:
" aj provides a text object for the outermost JSON object, array, string, number, or keyword.
" gqaj pretty prints (wraps/indents/sorts keys/otherwise cleans up) the JSON construct under the cursor.
" gwaj takes the JSON object on the clipboard and extends it into the JSON object under the cursor.
" There are also ij variants that target innermost rather than outermost JSON construct.
imap <C-q>jp <ESC>gqaji
nmap <C-q>jp gqaj
