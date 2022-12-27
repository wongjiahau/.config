function! neoformat#formatters#kk#enabled() abort
    return ['kk']
endfunction

function! neoformat#formatters#kk#kk() abort
    return {
        \ 'exe': '/Users/wongjiahau/repos/kk/target/debug/kk',
        \ 'args': ['format'],
        \ 'stdin': 1,
        \ }
endfunction
