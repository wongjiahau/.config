require('plugins')
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local function nnoremap(key, cmd)
    vim.api.nvim_set_keymap('n', key, cmd, {noremap = true})
end
local function vnoremap(key, cmd)
    vim.api.nvim_set_keymap('v', key, cmd, {noremap = true})
end

-- Set leader
g.mapleader = " "

-- Tree sitter settings
require('nvim-treesitter.configs').setup({
    autotag = {enable = true},
    ensure_installed = "all",
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {} -- list of language that will be disabled
    }
})

-- Autopair settings
require('nvim-autopairs').setup({})

-- COC settings
g.coc_global_extensions = {'coc-json', 'coc-explorer', 'coc-tsserver'}
-- Open file tree explorer (N-erdTree)
nnoremap('<Leader>n', ':CocCommand explorer<CR>')
g.coc_enable_locationlist = 0
-- Make sure all types of *.graphql files get syntax highlighting.
-- This is necessary for coc-prettier to work
vim.cmd('autocmd BufNewFile,BufRead *.graphql set ft=graphql')
vim.cmd [[
  nmap gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gh :call Show_documentation()<CR>
  xmap <Leader>,  v<Plug>(coc-codeaction-selected)
  nmap <Leader>,  v<Plug>(coc-codeaction-selected)
  nmap <Leader>r <Plug>(coc-rename)
  nmap <silent> <leader>e <Plug>(coc-diagnostic-next-error)
  nmap <silent> <leader>E <Plug>(coc-diagnostic-prev-error)

  nmap <silent> <leader>w <Plug>(coc-diagnostic-next)
  nmap <silent> <leader>W <Plug>(coc-diagnostic-prev)

  function! Show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  
  " Press Enter to use the first suggestion
  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

]]

-- lualine settings
require('lualine').setup({
    options = {theme = 'ayu_mirage'},
    sections = {
        lualine_a = {{'filename', path = 1}},
        lualine_b = {'g:coc_status'},
        lualine_c = {{'diagnostics', sources = {'coc'}}},
        lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {'branch'}
    }
})

-- diffview settings
require('diffview').setup({
    file_panel = {win_config = {tree_options = {flatten_dirs = false}}}
})

-- telescope settings
require('telescope').setup({defaults = {preview = false}})

-- https://github.com/alvarosevilla95/luatab.nvim
require('luatab').setup({})


-- key mappings
nnoremap('<CR>', ':wa<CR>')
nnoremap('<C-j>', ':cnext<CR>')
nnoremap('<C-k>', ':cprev<CR>')
-- Open [g]it dashboard 
nnoremap('<Leader>g', ':tab Git<CR>')
-- Open [G]it diffs 
nnoremap('<Leader>G', ':DiffviewOpen<CR>')
-- For opening Git [d]iff of current file vertically 
nnoremap('<Leader>d', ':vert Gdiff<CR>')
-- [s]earch and replace
nnoremap('<leader>s', ':lua require("spectre").open() <CR>')
-- [s]earch current highlighted word
vnoremap('<leader>s', ':lua require("spectre").open_visual() <CR>')
-- Open file search (follows VSCode Cmd+p)
nnoremap('<Leader>p', ':Telescope git_files<CR>')
-- Open command pallete (follows VSCode Cmd+shift+p)
nnoremap('<Leader>P', ':Telescope commands<CR>')
-- Open registers search
nnoremap('<Leader>"', ':Telescope registers<CR>')
-- Open [b]uffer search
nnoremap('<Leader>b', ':Telescope buffers<CR>')
-- Global [f]ind
nnoremap('<Leader>f', ':Telescope live_grep<cr>')
-- Open current file [h]istory
nnoremap('<Leader>h', ':DiffviewFileHistory %<CR>')
-- Toggle hop.nvim
nnoremap('<Leader>t', ':HopWord<CR>')

-- vim settings
o.clipboard = o.clipboard .. 'unnamedplus'
o.number = true
o.autowrite = true
o.smartcase = true
o.ignorecase = true
o.tabstop = 2
o.shiftwidth = 2
o.shell = 'fish'
o.expandtab = true
o.wrap = false
o.swapfile = false
o.cursorline = true
o.cursorcolumn = true
o.hlsearch = true
o.incsearch = true
o.ttimeoutlen = 10
o.mouse = 'a'
o.inccommand = 'nosplit' -- For viewing live substitution
o.hidden = true -- to ensure terminal remains alive
o.relativenumber = true

-- colorscheme
vim.o.background = "light"
vim.g.vscode_transparent = 1
vim.cmd [[colorscheme vscode]]

-- tabline colors
vim.cmd [[
hi TabLine guibg=#A89984
hi TabLineFill guibg=#3C3836
]]

-- floating windows color
vim.cmd [[
hi NormalFloat guibg=#fbf1c7
hi Visual guibg=yellow
]]

-- COC colors
vim.cmd [[
hi CocErrorLine guibg=#ffe7ea
hi CocErrorVirtualText guibg=#ffe7ea guifg=darkred
hi CocInfoLine guibg=#fffcbb
hi CocInfoVirtualText guibg=#fffcbb guifg=orange
]]

-- Vim built-in menu
-- Refer https://vi.stackexchange.com/a/12665/31905
vim.cmd [[
hi PmenuSel guibg=lightblue
]]

-- Treat dash as part of a word
-- Refer https://vi.stackexchange.com/a/13813/31905
vim.cmd [[
set iskeyword+=-
]]

-- Auto format on save
-- Refer https://github.com/sbdchd/neoformat#basic-usage
vim.cmd [[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]]

-- https://github.com/lewis6991/gitsigns.nvim
require('gitsigns').setup()
