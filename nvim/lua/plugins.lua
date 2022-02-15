-- Bootstrap packer, refer https://github.com/wbthomason/packer.nvim#bootstrapping
vim.cmd [[
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]]

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
  -- Packer can manage itself
  Plug 'wbthomason/packer.nvim'
  Plug ('neoclide/coc.nvim', {branch = 'release'})
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'windwp/nvim-spectre'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'sindrets/diffview.nvim'  
  Plug ('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
  Plug 'windwp/nvim-ts-autotag'
  Plug 'windwp/nvim-autopairs'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'alvarosevilla95/luatab.nvim'
  Plug 'Mofiqul/vscode.nvim'
  Plug ('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && npm install' })
  Plug 'phaazon/hop.nvim'
vim.call('plug#end')

