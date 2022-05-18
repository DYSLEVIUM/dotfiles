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
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    
    " themes
    Plug 'joshdick/onedark.vim'
    
    " statusline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    " ale
    Plug 'dense-analysis/ale'
    
    " conquer of completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}    
    
    " tabline plugin
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'romgrk/barbar.nvim'

    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    
    " git
    Plug 'tpope/vim-fugitive'
    
    " sneak
    Plug 'justinmk/vim-sneak'
    
    " icons
    Plug 'ryanoasis/vim-devicons'
    
    " indent
    Plug 'thaerkh/vim-indentguides'

call plug#end()
