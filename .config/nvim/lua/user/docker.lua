vim.cmd([[
    " Dockerfile
    autocmd BufRead,BufNewFile [Dd]ockerfile setfiletype Dockerfile
    autocmd BufRead,BufNewFile [Dd]ockerfile* setfiletype Dockerfile
    autocmd BufRead,BufNewFile *.[Dd]ockerfile setfiletype Dockerfile
    autocmd BufRead,BufNewFile *.dock setfiletype Dockerfile
    autocmd BufRead,BufNewFile [Dd]ockerfile.vim setfiletype vim

    " Containerfile
    autocmd BufRead,BufNewFile [Cc]ontainerfile setfiletype Dockerfile
    autocmd BufRead,BufNewFile [Cc]ontainerfile* setfiletype Dockerfile
    autocmd BufRead,BufNewFile *.[Cc]ontainerfile setfiletype Dockerfile
]])
