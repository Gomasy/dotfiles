# Get CPU threads count
CPU := $(shell grep 'model name' /proc/cpuinfo | wc -l)

# Existince check
X := $(shell which /usr/bin/X 2> /dev/null)
ZSH := $(shell which /bin/zsh 2> /dev/null)
VIM := $(shell which /usr/bin/vim 2> /dev/null)
TMUX := $(shell which /usr/bin/tmux 2> /dev/null)
RUBY := $(shell which /usr/bin/ruby 2> /dev/null)
BVI := $(shell which /usr/bin/bvi 2> /dev/null)
GPG := $(shell which /usr/bin/gpg2 2> /dev/null)
TERM := $(shell which /usr/bin/terminator 2> /dev/null)
PWLINE := $(shell which /usr/bin/powerline 2> /dev/null)

install:
	mkdir -p -m 700 ${HOME}/.ssh
	ln -sf ${PWD}/.ssh/config ${HOME}/.ssh/config
	ln -sf ${PWD}/.gitconfig ${HOME}/.gitconfig

ifdef GPG
	mkdir -p ${HOME}/.gnupg
	ln -sf ${PWD}/.gnupg/gpg-agent.conf ${HOME}/.gnupg/gpg-agent.conf
endif

ifdef X
	ln -sf ${PWD}/.xinitrc ${HOME}/.xinitrc
	ln -sf ${PWD}/.xprofile ${HOME}/.xprofile
	mkdir -p -m 700 ${HOME}/.config
	ln -sf ${PWD}/.config/fontconfig ${HOME}/.config/fontconfig

ifdef TERM
	ln -sf ${PWD}/.config/terminator ${HOME}/.config/terminator
endif
endif

ifdef PWLINE
	mkdir -p -m 700 ${HOME}/.config
	ln -sf ${PWD}/.config/powerline ${HOME}/.config/powerline
endif

ifdef VIM
ifneq ($(CPU), 1)
	ln -sf ${PWD}/.vim ${HOME}/.vim
else
	ln -sf ${PWD}/.vimrc_simple ${HOME}/.vimrc
endif
endif

ifdef ZSH
	ln -sf ${PWD}/.zshrc ${HOME}/.zshrc
endif

ifdef TMUX
	ln -sf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
endif

ifdef RUBY
	ln -sf ${PWD}/.gemrc ${HOME}/.gemrc
endif

ifdef BVI
	ln -sf ${PWD}/.bvirc ${HOME}/.bvirc
endif

clean:
	rm -rf ${HOME}/.cache/neo*
	rm -rf ${HOME}/.gem
	rm -rf ${HOME}/.local/share/vim*
	rm -rf ${HOME}/.rbenv
	rm -rf ${HOME}/.zgen
	rm -rf ${HOME}/.vim/dein/*
	rm -rf ${HOME}/.vim/dein/.cache
	rm -f ${HOME}/.vim
	rm -f ${HOME}/.config/fontconfig
	rm -f ${HOME}/.config/powerline
	rm -f ${HOME}/.config/terminator
	rm -f ${HOME}/.ssh/config
	rm -f ${HOME}/.gnupg/gpg-agent.conf
	rm -f ${HOME}/.bvirc
	rm -f ${HOME}/.gemrc
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.tmux.conf
	rm -f ${HOME}/.vimrc
	rm -f ${HOME}/.xinitrc
	rm -f ${HOME}/.xprofile
	rm -f ${HOME}/.zcompdump*
	rm -f ${HOME}/.zshrc
	rm -f ${HOME}/.zsh-update
