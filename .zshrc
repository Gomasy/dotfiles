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

setopt AUTO_MENU
setopt AUTO_CD
setopt AUTO_NAME_DIRS
setopt AUTO_REMOVE_SLASH
setopt AUTO_LIST
setopt AUTO_PARAM_KEYS
setopt PROMPT_SUBST
setopt AUTO_RESUME
setopt RM_STAR_WAIT
setopt SUN_KEYBOARD_HACK
setopt EXTENDED_GLOB
setopt LIST_TYPES
setopt NO_BEEP
setopt ALWAYS_LAST_PROMPT
setopt CDABLE_VARS
setopt SH_WORD_SPLIT
setopt ALL_EXPORT
setopt AUTO_PARAM_SLASH
setopt AUTO_PUSHD
setopt CORRECT
setopt LIST_PACKED
setopt PUSHD_IGNORE_DUPS
setopt NO_LIST_BEEP
setopt NOTIFY
setopt MULTIOS
setopt NUMERIC_GLOB_SORT
setopt MAGIC_EQUAL_SUBST
setopt PRINT_EIGHT_BIT
setopt TRANSIENT_RPROMPT
setopt BRACE_CCL
setopt HISTVERIFY
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt NO_CHECK_JOBS
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_NO_FUNCTIONS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt NO_PROMPTCR
setopt AUTOREMOVESLASH
setopt SHARE_HISTORY
setopt FUNCTION_ARGZERO
setopt NO_FLOW_CONTROL
setopt INTERACTIVE_COMMENTS
setopt COMPLETE_IN_WORD
setopt NO_TIFY

PROMPT='%B%F{green}%n@%m:%F{blue}%~${vcs_info_msg_0_}%#%b%f '
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias ll="ls -l"
alias la="ls -A"
alias l="ls -CF"
alias sl="ruby ~/Public/sl_tweet/sl.rb"
