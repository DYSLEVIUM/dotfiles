" Example config in VimScript
let g:gruvbox_baby_function_style = "NONE"
let g:gruvbox_baby_keyword_style = "italic"

" Enable telescope theme
let g:gruvbox_baby_telescope_theme = 1

" Enable transparent mode
let g:gruvbox_baby_transparent_mode = 1

hi Comment cterm=italic

" Load the colorscheme
colorscheme gruvbox-baby

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
  set termguicolors
  hi LineNr ctermbg=NONE guibg=NONE
endif
