if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'

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
