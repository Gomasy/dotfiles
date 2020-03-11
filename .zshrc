# Load zgen
if [[ ! -e $HOME/.zgen ]]; then
    echo "\e[1m[*] Installing zgen...\e[m"
    git clone https://github.com/tarjoilija/zgen.git $HOME/.zgen
fi
source $HOME/.zgen/zgen.zsh

# Install plugins
if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh themes/agnoster

    zgen load willghatch/zsh-cdr
    zgen load zsh-users/zaw
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting

    zgen save
fi

# Zsh functions
zshaddhistory() { [[ ${#1%%$'\n'} -ge 5 ]] }
zshexit() {
    ! tmux has 2> /dev/null && [[ `ps x | grep \[p\]owerline-daemon | wc -l` -ne 0 ]] && powerline-daemon -k
}
prompt_context() {
    if [[ $USER != "gomasy" || -n $SSH_CONNECTION ]]; then
        prompt_segment black default "%(!.%{%F{yellow}%}.)$USER@%m"
    fi
}
yay() {
    /usr/bin/yay $@ && rm -rf ~/.{cache,config}/yay
}

# Ignore C-s
stty stop undef

# Key bindings
bindkey "^G^F" zaw-git-files
bindkey "^G^L" zaw-git-log
bindkey "^G^S" zaw-git-status
bindkey "^F" zaw-cdr
bindkey "^H" zaw-history
bindkey "^P" zaw-process
bindkey "^T" zaw-tmux

# Set options
setopt correct
setopt extended_glob
setopt hist_fcntl_lock
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt ignore_eof
setopt list_packed
setopt list_rows_first
setopt menu_complete
setopt no_beep
setopt no_hist_beep
setopt no_list_beep

# Set style options
zstyle ":filter-select" extended-search yes
zstyle ":filter-select" rotate-list yes

# Set environment variables
export EDITOR="vim"
export GPG_TTY=$(tty)

# Set personal aliases
alias emacs=$EDITOR
alias vi=$EDITOR

# Set shell variables
REPORTTIME=3

# Load local .zshrc
[[ -e $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

if [[ `id -u` -ne 0 ]]; then
    # Ruby settings
    if which ruby &> /dev/null; then
        export PATH=$HOME/.rbenv/bin:$PATH
        export PATH=$(ruby -e'print Gem.user_dir')/bin:$PATH

        if ! which rbenv &> /dev/null; then
            if [[ ! -e $HOME/.rbenv ]]; then
                echo "\e[1m[*] Installing rbenv...\e[m"
                git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv

                echo "\e[1m[*] Installing ruby-build...\e[m"
                git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
            fi
        else
            eval "$(rbenv init -)"
        fi

        if ! which bundler &> /dev/null; then
            echo "\e[1m[*] Installing bundler...\e[m"
            gem install bundler
        fi

        if ! which kramdown &> /dev/null; then
            echo "\e[1m[*] Installing kramdown...\e[m"
            gem install kramdown
        fi

        if ! which solargraph &> /dev/null && which node &> /dev/null; then
            echo "\e[1m[*] Installing solargraph...\e[m"
            gem install solargraph
        fi
    fi

    # PHP settings
    if which php &> /dev/null; then
        export PATH=$HOME/.phpenv/bin:$PATH

        if ! which phpenv &> /dev/null; then
            if [[ ! -e $HOME/.phpenv ]]; then
                echo "\e[1m[*] Installing phpenv...\e[m"
                git clone https://github.com/phpenv/phpenv.git $HOME/.phpenv

                echo "\e[1m[*] Installing php-build...\e[m"
                git clone https://github.com/php-build/php-build.git $HOME/.phpenv/plugins/php-build
            fi
        else
            eval "$(phpenv init -)"
        fi
    fi

    # Node settings
    if which node &> /dev/null; then
        if ! which nvm &> /dev/null; then
            if [[ ! -e $HOME/.nvm ]]; then
                echo "\e[1m[*] Installing nvm...\e[m"
                git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
            fi

            . $HOME/.nvm/nvm.sh
            . $HOME/.nvm/bash_completion
        fi
    fi
fi

# Show motd
which screenfetch &> /dev/null && [[ -n $TMUX ]] && screenfetch -c 4,15

# Run tmux
if which tmux &> /dev/null && [[ $- != *l* ]]; then
    if tmux has 2> /dev/null; then
        active=$(tmux ls | grep -v attached | wc -l)
        if [[ $active -ne 0 ]]; then
            if [[ $active -gt 1 ]]; then
                tmux ls | perl -pe's/(^.*?):/\033[31;1m$1:\033[m/'
                echo -n "tmux: attach? (y or num)>> " && read input

                [[ $input =~ ^[Yy]?$ || ! -n $input ]] && tmux a || tmux a -t $input
                unset input
            else
                tmux a
            fi
        else
            tmux new
        fi
    else
        tmux new
    fi

    exit
fi
