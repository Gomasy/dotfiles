"dein Scripts-----------------------------

if !&compatible
  set nocompatible
endif

"reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"dein settings {{{
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
let s:lazy_toml = fnamemodify(expand('<sfile>'), ':h').'/.dein_lazy.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml, { 'lazy': 0 })
  call dein#load_toml(s:lazy_toml, { 'lazy': 1 })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install(['vimproc.vim'])
  call dein#install(['vimproc.vim'])
endif

if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


"General settings-------------------------
syntax on
colorscheme molokai
highlight Visual ctermbg=8
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,sjis,euc-jp
set display=uhex
set mouse=a
set visualbell t_vb=
set noerrorbells
set wildmenu
set tildeop
set emoji
set hidden
set autoread
set lazyredraw
set noswapfile
set nobackup
set nowritebackup


"UI settings------------------------------
set termguicolors
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
set laststatus=2


"Search settings--------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch
set nowrapscan
set history=1000


"Bracket settings-------------------------
set showmatch
set matchpairs=(:),{:},[:],<:>
set matchtime=3


"Indent settings-----------------------------
set autoindent
set breakindent
set expandtab
set tabstop=2
set shiftwidth=2


"Key binding settings---------------------
nnoremap <silent>,su :w !sudo tee %<CR>
nnoremap <silent><ESC><ESC> :noh<CR>
nnoremap <silent><C-n> :new<CR>
nnoremap <silent><C-w>s :sp<CR>
nnoremap <silent><C-w>v :vsp<CR>
nnoremap <C-w>os :sp<space>
nnoremap <C-w>ov :vsp<space>
nnoremap <C-o> :o<space>

function Tab_switch()
  if &expandtab
    set noexpandtab
  else
    set expandtab
  endif
endfunction
nnoremap <silent><S-TAB> :call Tab_switch()<CR>

function Wrap_switch()
  if &wrap
    set nowrap
  else
    set wrap
  endif
endfunction
nnoremap <silent><ESC>w :call Wrap_switch()<CR>

function TrueColor_switch()
  if &termguicolors
    set notermguicolors
  else
    set termguicolors
  endif
endfunction
nnoremap <silent><ESC>g :call TrueColor_switch()<CR>

function Mouse_switch()
  if &mouse == 'a'
    set mouse=
  else
    set mouse=a
  endif
endfunction
nnoremap <silent><ESC>m :call Mouse_switch()<CR>


"Plugin settings--------------------------

"nerdtree
let NERDTreeShowHidden = 1

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if winnr('$') == 1 && exists('b:NERDTree') | q | endif
nnoremap <silent><C-f> :NERDTreeToggle<CR>

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('rb', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')


"neocomplete.vim
let g:neocomplete#enable_at_startup = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'


"neosnippet
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <silent><C-k> <Esc>:let g:neosnippet_expanding_or_jumpping = 1<CR>a<Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


"neco-look
if !exists('g:neocomplete#text_mode_filetypes')
  let g:neocomplete#text_mode_filetypes = {}
endif

let g:neocomplete#text_mode_filetypes = {
  \ 'gitrebase': 1,
  \ 'gitcommit': 1,
  \ 'markdown': 1,
  \ 'hybrid' : 1,
  \ 'text': 1,
  \ 'help': 1,
  \ }


"vimshell
nnoremap <silent>,is :VimShell<CR>
nnoremap <silent>,ipy :VimShellInteractive python<CR>
nnoremap <silent>,irb :VimShellInteractive irb<CR>


"vim-quickrun
nnoremap <silent><C-e> :QuickRun<CR>


"switch.vim
nnoremap <silent>t :Switch<CR>


"vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_exclude_filetypes = [ 'help', 'nerdtree' ]


"lightline.vim
let g:lightline = {
  \ 'colorscheme': 'wombat',
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
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
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
    return strlen(_) ? ' '._ : ''
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
