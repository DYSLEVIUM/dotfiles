" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " file Explorer
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " themes
    Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}

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

    " telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " git
    Plug 'tpope/vim-fugitive'

    " sneak
    Plug 'justinmk/vim-sneak'

    " icons
    Plug 'ryanoasis/vim-devicons'

    " indent
    Plug 'thaerkh/vim-indentguides'

    " surround
    Plug 'tpope/vim-surround'

    " easy-motion
    Plug 'easymotion/vim-easymotion'

    " startify
    Plug 'mhinz/vim-startify'
call plug#end()
