# Get CPU threads count
CPU := $(shell grep physical.id /proc/cpuinfo | wc -l)

# Existince check
X := $(shell which /usr/bin/X 2> /dev/null)
ZSH := $(shell which /bin/zsh 2> /dev/null)
VIM := $(shell which /usr/bin/vim 2> /dev/null)
TMUX := $(shell which /usr/bin/tmux 2> /dev/null)
RUBY := $(shell which /usr/bin/ruby 2> /dev/null)
BVI := $(shell which /usr/bin/bvi 2> /dev/null)
GPG := $(shell which /usr/bin/gpg2 2> /dev/null)
GPGCFG := $(shell ls ${HOME}/.gnupg 2> /dev/null)
TERM := $(shell which /usr/bin/terminator 2> /dev/null)
TERMCFG := $(shell ls ${HOME}/.config 2> /dev/null)

install:
	ln -sf ${PWD}/.gitconfig ${HOME}/.gitconfig

ifdef GPG
ifndef GPGCFG
	mkdir -m 700 ${HOME}/.gnupg
endif
	ln -sf ${PWD}/gnupg/gpg-agent.conf ${HOME}/.gnupg/gpg-agent.conf
endif

ifdef X
	ln -sf ${PWD}/.xinitrc ${HOME}/.xinitrc
	ln -sf ${PWD}/.xprofile ${HOME}/.xprofile

ifdef TERM
ifndef TERMCFG
	mkdir -m 700 ${HOME}/.config
endif
	ln -sf ${PWD}/terminator ${HOME}/.config/terminator
endif
endif

ifdef ZSH
	ln -sf ${PWD}/.zshrc ${HOME}/.zshrc
endif

ifdef VIM
ifneq (CPU, 1)
	ln -sf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -sf ${PWD}/.dein.toml ${HOME}/.dein.toml
	ln -sf ${PWD}/.dein_lazy.toml ${HOME}/.dein_lazy.toml
else
	ln -sf ${PWD}/.vimrc_simple ${HOME}/.vimrc
endif
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
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.xinitrc
	rm -f ${HOME}/.xprofile
	rm -f ${HOME}/.gnupg/gpg-agent.conf
	rm -f ${HOME}/.config/terminator
	rm -f ${HOME}/.zshrc
	rm -f ${HOME}/.vimrc
	rm -f ${HOME}/.dein.toml
	rm -f ${HOME}/.dein_lazy.toml
	rm -f ${HOME}/.tmux.conf
	rm -f ${HOME}/.gemrc
	rm -f ${HOME}/.bvirc
