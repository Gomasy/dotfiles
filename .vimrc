"NeoBundle
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'AndrewRadev/switch.vim'

"General
syntax on
colorscheme evening

set encoding=utf-8
set fileencoding=utf-8
set scrolloff=5
set laststatus=2
set mouse=a
set nostartofline
set noswapfile
set nobackup
set nowritebackup
set number
set ruler
set list
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮

"Search
set ignorecase
set smartcase
set incsearch
set nowrapscan
set history=1000

"Brackets
set matchpairs& matchpairs+=<:>
set showmatch
set matchtime=3

"unite.vim
nnoremap <silent>,uf :<C-u>Unite file<CR>

"switch.vim
nnoremap <silent>,m :<C-u>Switch<CR>

"vim-quickrun
nnoremap <silent>,qr :<C-u>QuickRun<CR>
