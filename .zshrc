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
plugins=()

# User configuration
source $ZSH/oh-my-zsh.sh

# Ruby settings
if [[ -e /usr/bin/ruby ]]; then
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
  export PATH=`gem environment | grep 'USER INSTALLATION DIRECTORY:' | sed -e 's/  - USER INSTALLATION DIRECTORY: //g'`/bin:$PATH
  if [[ `which kramdown &> /dev/null; echo $?` -eq 1 ]]; then
    echo "[*] Installing kramdown..."
    gem install kramdown
  fi
fi

# Powerline settings
if [[ -e $HOME/.cache/dein ]]; then
  export PATH=$HOME/.cache/dein/repos/github.com/powerline/powerline/scripts:$PATH
fi

# Set of use editor
export EDITOR="vim"

# Using 256-colors mode
export TERM="xterm-256color"

# Set tty used by pinentry
export GPG_TTY=$(tty)

# Exit flag filename
_TMUX="/tmp/tmux-1000/no_term_exit"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias emacs=$EDITOR
alias vi=$EDITOR
alias quit="touch $_TMUX; exit"

# Spelling correction for commands
setopt correct

# Show motd
[[ -e /usr/bin/screenfetch && -n $TMUX && ! `id -u` -eq 0 ]] && screenfetch

# Run tmux
if [[ -e /usr/bin/tmux && ! -n $TMUX && ! $- == *l* ]]; then
  [[ ! -e /tmp/tmux-1000/default ]] && tmux start-server
  [[ `tmux ls 2>&1` =~ "no.*$" ]] && tmux || tmux a
  [[ ! -e $_TMUX ]] && exit || rm $_TMUX
fi
