" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " enables syntax highlighing
set hidden                              " required to keep multiple buffers open multiple buffers
set encoding=UTF-8                      " The encoding displayed
" set number relativenumber
set rnu                                 " relative numbering starts from 0
set pumheight=10                        " makes popup menu smaller
set fileencoding=utf-8                  " the encoding written to file
set ruler              			        " show the cursor position all the time
set termguicolors						" true color support
set cmdheight=2                         " more space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set splitbelow                          " horizontal splits will automatically be below
set clipboard=unnamed					" public copy/paste register
set incsearch							" search as characters are entered
set splitright                          " vertical splits will automatically be to the right
set wildmenu							" graphical auto complete menu
set lazyredraw							" redraws the screen when it need to
set t_Co=256                            " support 256 colors
set smartindent                         " makes indenting smart
set smarttab							" makes tabbing smarter will realize you have 2 vs 4
set mouse=a								" enables mouse
set autoindent							" good auto indent
set shiftwidth=2
set spelllang=en_us						" setting spell language
set spell								" spell check
set showmatch                           " show matching brackets
set tabstop=2                           " render TABs
set hlsearch							" highlight search results
set cursorline                          " enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " always show tabs
set updatetime=300                      " faster completion
set timeoutlen=500                      " by default timeoutlen is 1000 ms
set formatoptions-=cro                  " stop newline continution of comments
set clipboard=unnamedplus               " copy paste between vim and everything else
set autochdir                           " your working directory will always be the same as your working directory

" custom statusline
set laststatus=2
set statusline=

" left side
set statusline+=\ %M
set statusline+=\ %y
set statusline+=\ %r
set statusline+=\ %F

" right side
set statusline+=%=
set statusline+=\ %c:%l/%L
set statusline+=\ %p%%
set statusline+=\ [%n]

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'c': ['clang']
\}

" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="Google"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
