syntax on
filetype plugin indent on

augroup MyAutoCmd
  autocmd!
augroup END

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,sjis,euc-jp
set switchbuf=useopen,usetab,newtab
set backspace=indent,eol,start
set nrformats-=octal
set virtualedit=block
set mouse=a
set visualbell t_vb=
set wildignorecase
set wildmenu
set tildeop
set hidden
set autoread
set lazyredraw
set ttyfast
set termguicolors
set noswapfile
set nowritebackup
set splitbelow
set splitright
set cursorline
set cursorcolumn
set nostartofline
set noshowmode
set showcmd
set title
set number
set ruler
set list
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
set scrolloff=5
set showtabline=2
set laststatus=2
set ignorecase
set smartcase
set incsearch
set hlsearch
set history=1000
set showmatch
set matchpairs=(:),{:},[:],<:>
set matchtime=3
set autoindent
set breakindent
set expandtab
set tabstop=4
set shiftwidth=4

if has('nvim')
  set winblend=30
  set pumblend=30
endif

if has('nvim') || has('unnamedplus')
  set clipboard& clipboard^=unnamedplus
elseif has('clipboard')
  set clipboard& clipboard^=unnamed
endif

if !has('nvim') && !has('gui')
  set ttymouse=sgr
endif
