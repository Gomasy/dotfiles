"NeoBundle
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
if has('gui_running')
  set t_Co=256
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'itchyny/lightline.vim'
call neobundle#end()

"General
syntax on
colorscheme ron

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

"lightline.vim
let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
