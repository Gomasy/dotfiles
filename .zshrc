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

  if [[ -e /usr/share/zsh/plugins/zsh-syntax-highlighting ]]; then
    zgen load /usr/share/zsh/plugins/zsh-syntax-highlighting
  fi
fi

# Zsh hook functions
zshaddhistory() { [[ ${#1%%$'\n'} -ge 5 ]] }

# Ignore C-s
stty stop undef

# Set variables
export EDITOR="vim"
export TERM="xterm-256color"
export GPG_TTY=$(tty)

# Set personal aliases
alias emacs=$EDITOR
alias vi=$EDITOR

# Spelling correction for commands
setopt correct

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
  if [[ `tty` =~ ".+(tty0|pts\/0)$" && -n `tmux ls 2> /dev/null` ]]; then
    if [[ `tmux ls | wc -l` -gt 1 ]]; then
      echo "List of sessions:\e[4m" && tmux list-sessions
      echo -n "\n\e[m\e[1mPlease select session to attach.\nnumber> "
      read num

      tmux attach -t $num
      unset num
    else
      tmux attach
    fi
  else
    tmux new-session
  fi

  [[ ! -n `tmux ls 2> /dev/null` && `ps x | grep powerline-daemon | grep -v grep |  wc -l` -ne 0 ]] && killall powerline-daemon
  exit
fi
