# Load zgen
if [[ ! -e $HOME/.zgen ]]; then
  echo "\e[1m[*] Installing zgen...\e[m"
  git clone https://github.com/tarjoilija/zgen.git $HOME/.zgen
fi
source $HOME/.zgen/zgen.zsh

# Install plugins
if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh themes/agnoster

  zgen load zsh-users/zaw
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting

  zgen save
fi

# Zsh hook functions
zshaddhistory() { [[ ${#1%%$'\n'} -ge 5 ]] }
prompt_context() {
  if [[ $USER != "gomasy" || -n $SSH_CONNECTION ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER@%m"
  else
    prompt_segment black default ""
  fi
}

# Ignore C-s
stty stop undef

# Key bindings
bindkey "^G^F" zaw-git-files
bindkey "^G^L" zaw-git-log
bindkey "^G^S" zaw-git-status
bindkey "^H" zaw-history
bindkey "^P" zaw-process
bindkey "^T" zaw-tmux

# Set options
setopt correct
setopt hist_fcntl_lock
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt ignore_eof
setopt list_packed
setopt list_rows_first
setopt menu_complete
unsetopt auto_cd

# Set shell variables
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"

# Set environment variables
export EDITOR="vim"
export TERM="xterm-256color"
export GPG_TTY=$(tty)

# Set personal aliases
alias emacs=$EDITOR
alias vi=$EDITOR

# Ruby settings
if which ruby &> /dev/null && [[ `id -u` -ne 0 ]]; then
  # rbenv settings
  if [[ ! -e $HOME/.rbenv ]]; then
    echo "\e[1m[*] Installing rbenv...\e[m"
    git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv

    echo "\e[1m[*] Installing ruby-build...\e[m"
    git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  fi

  export PATH=$(ruby -e'print Gem.user_dir')/bin:$PATH
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"

  # gem settings
  if ! which bundler &> /dev/null; then
    echo "\e[1m[*] Installing bundler...\e[m"
    gem install bundler
  fi

  if ! which kramdown &> /dev/null; then
    echo "\e[1m[*] Installing kramdown...\e[m"
    gem install kramdown
  fi
fi

# Show motd
[[ -e /usr/bin/screenfetch && -n $TMUX ]] && screenfetch

# Run tmux
if [[ -e /usr/bin/tmux && $- != *l* ]]; then
  if `tmux has 2> /dev/null` && [[ `tty` =~ ^.+(tty0|pts\/0)$ ]]; then
    if [[ `tmux ls | wc -l` -gt 1 ]]; then
      tmux ls | perl -pe 's/(^.*?):/\033[31;1m$1:\033[m/'
      echo -n "tmux: attach? (y or num)>> " && read num

      [[ $num =~ ^[Yy]$ || ! -n $num ]] && tmux a || tmux a -t $num
      unset num
    else
      tmux a
    fi
  else
    tmux new-session
  fi

  ! `tmux has 2> /dev/null` && [[ `ps x | grep powerline-daemon | grep -v grep |  wc -l` -ne 0 ]] && killall powerline-daemon
  exit
fi
