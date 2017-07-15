# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(web-search)

# Zsh hook functions
zshaddhistory() { [[ ${#1%%$'\n'} -ge 5 ]] }

# Ignore C-s
stty stop undef

# Source configuration
source $ZSH/oh-my-zsh.sh
if [[ -e /usr/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Set variables
export EDITOR="vim"
export TERM="xterm-256color"
export GPG_TTY=$(tty)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias emacs=$EDITOR
alias vi=$EDITOR

# Spelling correction for commands
setopt correct

# Ruby settings
if [ `which ruby` ]; then
  # rbenv settings
  if [[ ! -e $HOME/.rbenv ]]; then
    echo "[*] Installing rbenv..."
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo "[*] Installing ruby-build..."
    mkdir ~/.rbenv/plugins
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"

  # gem settings
  export PATH=`ruby -e'print Gem.user_dir'`/bin:$PATH

  [ ! `which bundler` ] && (echo "[*] Installing bundler..." && gem install bundler)
  [ ! `which kramdown` ] && (echo "[*] Installing kramdown..." && gem install kramdown)
fi

# Show motd
[[ -n `which screenfetch` && -n $TMUX && `id -u` -ne 0 ]] && screenfetch

# Run tmux
if [[ -n `which tmux` && ! -n $TMUX && $- != *l* ]]; then
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

  [[ ! -n `tmux ls 2> /dev/null` && `ps x | grep powerline-daemon | grep -v grep |  wc -l` ]] && killall powerline-daemon
  exit
fi
