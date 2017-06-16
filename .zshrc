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
plugins=(git themes nyan)

# User configuration

source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

# rbenv settings
if [[ -e $HOME/.rbenv ]]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# Gem settings
if [[ -e $HOME/.gem ]]; then
  export PATH=`gem environment | grep 'USER INSTALLATION DIRECTORY:' | sed -e 's/  - USER INSTALLATION DIRECTORY: //g'`/bin:$PATH
fi

# Powerline settings
if [[ -e $HOME/.cache/dein ]]; then
  export PATH=$HOME/.cache/dein/repos/github.com/powerline/powerline/scripts:$PATH
fi

# Set of use editor
export EDITOR="vim"

# Using 256-colors mode
export TERM="xterm-256color"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias emacs=$EDITOR
alias vi=$EDITOR

# Spelling correction for commands
setopt correct

# Show motd
if [[ -e /usr/bin/archey3 && -n $TMUX ]]; then
  if [[ ! `id -u` -eq 0 ]]; then
    archey3
  fi
fi

# Run tmux
if [[ -e /usr/bin/tmux && ! -n $TMUX && ! $- == *l* ]]; then
  if [[ `tmux ls 2>&1` =~ "no.*$" ]]; then
    tmux
  else
    tmux a
  fi
  exit
fi
