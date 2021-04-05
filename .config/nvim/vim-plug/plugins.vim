" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " file Explorer
    Plug 'scrooloose/NERDTree'
    " auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
	" themes
	Plug 'joshdick/onedark.vim'
	" conquer of completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
