function! powerline#init()
  let s:pl_global_dir = '/usr/lib/python*/site-packages/powerline'
  let s:pl_local_dir = g:repo_dir . '/powerline'
  let s:pl_bindings_dir = '/bindings/vim'

  if !isdirectory(glob(s:pl_global_dir))
    if !isdirectory(s:pl_local_dir)
      call system('git clone https://github.com/powerline/powerline ' . shellescape(s:pl_local_dir))
    endif

    let s:powerline_dir = s:pl_local_dir . '/powerline' . s:pl_bindings_dir
  else
    let s:powerline_dir = s:pl_global_dir . s:pl_bindings_dir
  endif
  exec 'set runtimepath^=' . fnamemodify(s:powerline_dir, ':p')
endfunction

if !has('nvim')
  call powerline#init()
endif
