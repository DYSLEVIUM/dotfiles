let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'cc': ['clang'],
    \ 'c': ['clang']
\}

let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'always'
