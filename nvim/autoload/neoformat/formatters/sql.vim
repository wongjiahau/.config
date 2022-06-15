function! neoformat#formatters#sql#enabled() abort
    return ['sqlformatter']
endfunction

function! neoformat#formatters#sql#sqlformatter() abort
    return {
        \ 'exe': 'sql-formatter',
        \ 'args': ['-l postgresql', '-c ~/.config/nvim/sql-formatter.json'],
        \ 'stdin': 1
        \ }
endfunction
