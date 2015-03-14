"--------------------------------------------------
" NeoBundle settings
"--------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

if has('gui_running')
  set t_Co=256
endif

call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'AndrewRadev/switch.vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'bronson/vim-trailing-whitespace'
  NeoBundle 'nathanaelkane/vim-indent-guides'
call neobundle#end()


"--------------------------------------------------
" General settings
"--------------------------------------------------
syntax on              "シンタックスハイライトを有効化
colorscheme ron        "カラースキームを設定
set encoding=utf-8     "エンコーディングを設定
set fileencoding=utf-8 "カレントバッファ内のファイルの文字エンコーディングを設定
set scrolloff=5        "スクロール時、指定した分行数に余裕を持たせる
set laststatus=2       "ステータスラインを表示するウィンドウを設定する
set mouse=a            "マウスを使えるようにする
set nostartofline      "移動コマンドを使った際行頭に移動しない
set noswapfile         "一時ファイルを作成しない
set nobackup           "バックアップを作成しない
set nowritebackup      "ファイルを上書きする際バックアップを作成しない
set title              "ターミナルのタイトルに編集中のファイル名を表示
set number             "行番号を表示
set ruler              "カーソルがどこに置かれているか表示する
set list               "タブ文字、行末などの不可視文字を表示する

"上記の設定で表示される文字のフォーマットを指定する
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮


"--------------------------------------------------
" Search settings
"--------------------------------------------------
set ignorecase   "大文字小文字を区別しない
set smartcase    "大文字も含めた検索の場合はその通りにする
set incsearch    "インクリメンタルサーチを行う
set nowrapscan   "ファイルの末端まで検索しても先頭へ戻らない
set history=1000 "履歴の最大値


"--------------------------------------------------
" Bracket settings
"--------------------------------------------------
set matchpairs=(:),{:},[:],<:> "パーセントキーでカーソル移動できる組み合わせ
set showmatch                  "対応する括弧やブレースを表示する
set matchtime=3                "括弧を表示する時間


"--------------------------------------------------
" Tab settings
"--------------------------------------------------
set tabstop=2    "タブの文字数を設定
set shiftwidth=2 "インデントのスペース数を設定


"--------------------------------------------------
" Plugin settings
"--------------------------------------------------

"switch.vim
nnoremap t :Switch<cr>


"vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2


"neocomplete.vim
let g:neocomplete#enable_at_startup=1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'


"emmet-vim
let g:user_emmet_settings = {
      \  'variables': {
      \    'indentation': '    ',
      \    'lang': 'ja'
      \  }
      \ }


"lightline.vim
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
      \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
      \  &ft == 'unite' ? unite#get_status_string() :
      \  &ft == 'vimshell' ? vimshell#get_status_string() :
      \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
      \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
