function! neoformat#formatters#sql#enabled() abort
    return ['sqlformatter']
endfunction

function! neoformat#formatters#sql#sqlformatter() abort
    return {
        \ 'exe': 'sql-formatter',
        \ 'args': ['-l postgresql', '-u'],
        \ 'stdin': 1
        \ }
endfunction
