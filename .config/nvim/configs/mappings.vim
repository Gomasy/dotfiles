function! mappings#toggle(name)
  echohl Title
  exec 'set ' . a:name . '!'
  if eval('&' . a:name)
    echo '*** Toggled ' . a:name . ' to true ***'
  else
    echo '*** Toggled ' . a:name . ' to false ***'
  endif
  echohl None
endfunction

"Common settings
nnoremap <silent><Leader>r :call vimrc#reload()<CR>
nnoremap <silent><ESC><ESC> :noh<CR>
nnoremap <silent><C-n> :new<CR>
nnoremap <silent><C-w>h :sp<CR>
nnoremap <silent><C-w>v :vsp<CR>
nnoremap <silent><S-n> :tabnew<CR>
nnoremap <silent><S-TAB> :tabp<CR>
nnoremap <silent><TAB> :tabn<CR>
nnoremap <C-w>oh :sp<Space>
nnoremap <C-w>ov :vsp<Space>
nnoremap <C-o> :o<Space>

if !has('nvim')
  nnoremap <silent><Leader>su :w !sudo tee %<CR>
endif

"Cursor settings
noremap j gj
noremap k gk
noremap <S-y> y$
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $

"Disable confusing keys
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

"Disable allow keys
noremap <Left> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>
inoremap <Left> <Nop>
inoremap <Down> <Nop>
inoremap <Up> <Nop>
inoremap <Right> <Nop>

"Window settings
nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l
nnoremap <S-Up> <C-w>+
nnoremap <S-Down> <C-w>-
nnoremap <S-Left> <C-w><
nnoremap <S-Right> <C-w>>

"Toggle options
nnoremap <silent><Leader>g :call mappings#toggle('termguicolors')<CR>
nnoremap <silent><Leader>n :call mappings#toggle('relativenumber')<CR>
nnoremap <silent><Leader>t :call mappings#toggle('expandtab')<CR>
nnoremap <silent><Leader>w :call mappings#toggle('wrap')<CR>
