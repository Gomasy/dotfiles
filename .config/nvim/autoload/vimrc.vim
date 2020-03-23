function! vimrc#plugin_dir()
  if !has('nvim')
    return expand('~/.vim') . '/plugins'
  else
    return expand('~/.config/nvim') . '/plugins'
  endif
endfunction

function! vimrc#init()
  let g:dein_dir = vimrc#plugin_dir()
  let g:repo_dir = g:dein_dir . '/repos/github.com'
  let g:dein_repo_dir = g:repo_dir . '/Shougo/dein.vim'

  if !isdirectory(g:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(g:dein_repo_dir))
  endif
  exec 'set runtimepath& runtimepath^=' . fnamemodify(g:dein_repo_dir, ':p')

  let s:toml = g:dein_dir . '/dein.toml'
  let s:lazy_toml = g:dein_dir . '/dein_lazy.toml'
  let g:dein#types#git#clone_depth = 1

  if dein#load_state(g:dein_dir)
    call dein#begin(g:dein_dir)

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

  runtime! configs/*.vim
endfunction
