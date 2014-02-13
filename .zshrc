bindkey -v

autoload -U compinit promptinit
compinit
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "!"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:git:*' formats ' %B%F{yellow}%c%u(%b)%f '
zstyle ':vcs_info:git:*' actionformats ' (%b|%a) '
precmd() { vcs_info }

setopt auto_menu
setopt auto_cd
setopt auto_name_dirs
setopt auto_remove_slash
setopt auto_list
setopt auto_param_keys
setopt prompt_subst
setopt auto_resume
setopt rm_star_wait
setopt sun_keyboard_hack
setopt extended_glob
setopt list_types
setopt no_beep
setopt always_last_prompt
setopt cdable_vars
setopt sh_word_split
setopt all_export
setopt auto_param_slash
setopt auto_pushd
setopt correct
setopt list_packed
setopt pushd_ignore_dups
setopt no_list_beep
setopt notify
setopt multios
setopt numeric_glob_sort
setopt magic_equal_subst
setopt print_eight_bit
setopt transient_rprompt
setopt brace_ccl
setopt hist_verify
setopt hist_ignore_space
setopt append_history
setopt no_check_jobs
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_no_functions
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expand
setopt inc_append_history
setopt hist_no_store
setopt hist_reduce_blanks
setopt no_promptcr
setopt autoremoveslash
setopt share_history
setopt function_argzero
setopt no_flow_control
setopt interactive_comments
setopt complete_in_word
setopt no_tify

PROMPT='%B%F{green}%n@%m:%F{blue}%~${vcs_info_msg_0_}%#%b%f '
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -A"
alias l="ls -CF"
alias sl="ruby ~/Public/sl_tweet/sl.rb"
