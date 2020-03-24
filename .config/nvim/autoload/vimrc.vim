function! vimrc#plugin_dir()
  if !has('nvim')
    return expand('~/.vim/plugins')
  else
    return expand('~/.config/nvim/plugins')
  endif
endfunction

function! vimrc#setup_dein()
  if !isdirectory(g:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(g:dein_repo_dir))
  endif
  exec 'set runtimepath& runtimepath^=' . fnamemodify(g:dein_repo_dir, ':p')
endfunction

function! vimrc#load_dein()
  if dein#load_state(g:dein_dir)
    call dein#begin(g:dein_dir)

    call dein#load_toml(g:dein_dir . '/dein.toml')
    if dein#check_install()
      call dein#install()
    endif

    call dein#end()
    call dein#save_state()
  endif
endfunction

function! vimrc#init()
  let g:dein_dir = vimrc#plugin_dir()
  let g:repo_dir = g:dein_dir . '/repos/github.com'
  let g:dein_repo_dir = g:repo_dir . '/Shougo/dein.vim'
  let g:dein#types#git#clone_depth = 1
  let g:mapleader = ","

  call vimrc#setup_dein()
  call vimrc#load_dein()

  runtime! configs/*.vim
endfunction

function! vimrc#reload()
  if has('nvim')
    exec ':source ~/.config/nvim/init.vim'
  else
    exec ':source ~/.vimrc'
  endif
endfunction
