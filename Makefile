# Existince check
BVI := $(shell which bvi 2> /dev/null)
GPG := $(shell which gpg 2> /dev/null)
PWLINE := $(shell which powerline 2> /dev/null)
RUBY := $(shell which ruby 2> /dev/null)
TERM := $(shell which terminator 2> /dev/null)
TMUX := $(shell which tmux 2> /dev/null)
NEOVIM := $(shell which nvim 2> /dev/null)
VIM := $(shell which vim 2> /dev/null)
X := $(shell which X 2> /dev/null)
YARN := $(shell which yarn 2> /dev/null)
ZSH := $(shell which zsh 2> /dev/null)

install:
	chmod 700 ${PWD}/.config
	chmod 700 ${PWD}/.gnupg
	chmod 700 ${PWD}/.ssh

	mkdir -p -m 700 ${HOME}/.ssh
	ln -sf ${PWD}/.ssh/config ${HOME}/.ssh/config
	ln -sf ${PWD}/.gitconfig ${HOME}/.gitconfig

ifdef BVI
	ln -sf ${PWD}/.bvirc ${HOME}/.bvirc
endif

ifdef GPG
	mkdir -p ${HOME}/.gnupg
	ln -sf ${PWD}/.gnupg/gpg-agent.conf ${HOME}/.gnupg/gpg-agent.conf
endif

ifdef PWLINE
	mkdir -p -m 700 ${HOME}/.config
	ln -sf ${PWD}/.config/powerline ${HOME}/.config/powerline
endif

ifdef RUBY
	ln -sf ${PWD}/.gemrc ${HOME}/.gemrc
endif

ifdef TMUX
	ln -sf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
endif

ifdef VIM
ifdef NEOVIM
	ln -sf ${PWD}/.config/nvim ${HOME}/.config/nvim
else
	ln -sf ${PWD}/.config/nvim ${HOME}/.vim
	ln -sf ${PWD}/.config/nvim/init.vim ${HOME}/.vimrc
endif
else
ifdef NEOVIM
	ln -sf ${PWD}/.config/nvim ${HOME}/.config/nvim
endif
endif

ifdef X
	ln -sf ${PWD}/.xinitrc ${HOME}/.xinitrc
	ln -sf ${PWD}/.xprofile ${HOME}/.xprofile

ifdef TERM
	mkdir -p -m 700 ${HOME}/.config
	ln -sf ${PWD}/.config/terminator ${HOME}/.config/terminator
endif
endif

ifdef YARN
	ln -sf ${PWD}/.yarnrc ${HOME}/.yarnrc
endif

ifdef ZSH
	ln -sf ${PWD}/.zshrc ${HOME}/.zshrc
endif
