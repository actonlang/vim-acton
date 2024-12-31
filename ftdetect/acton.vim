" Vim filetype detection file
" Language: Acton

augroup ActonFileDetection
    autocmd!
    autocmd BufRead,BufNewFile *.act setfiletype acton
    autocmd FileType acton setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
augroup END
