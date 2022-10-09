
install: install-shell install-git install-misc

install-shell:
	rm -f ~/.profile
	rm -f ~/.bashrc
	ln -s `pwd`/shell/profile ~/.profile
	ln -s `pwd`/shell/bashrc ~/.bashrc

install-git:
	rm -f ~/.gitconfig
	rm -f ~/.gitignore
	rm -f ~/.git-completion.bash
	ln -s `pwd`/git/gitconfig ~/.gitconfig
	ln -s `pwd`/git/gitignore ~/.gitignore
	ln -s `pwd`/git/git-completion.bash ~/.git-completion.bash

install-misc:
	rm -f ~/.ackrc
	rm -f ~/.agignore
	rm -f ~/.tmux.conf
	ln -s `pwd`/misc/ackrc ~/.ackrc
	ln -s `pwd`/misc/agignore ~/.agignore
ifeq ($(shell uname), Darwin)
	ln -s `pwd`/misc/tmux.conf.osx ~/.tmux.conf
	touch ~/.hushlogin
else
	ln -s `pwd`/misc/tmux.conf.linux ~/.tmux.conf
endif

