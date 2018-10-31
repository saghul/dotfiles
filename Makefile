
install: install-shell install-powerline install-bin install-git install-darcs install-misc

install-powerline:
	go get -u github.com/justjanne/powerline-go

install-shell: install-powerline
	rm -f ~/.profile
	rm -f ~/.bashrc
	ln -s `pwd`/shell/profile ~/.profile
	ln -s `pwd`/shell/bashrc ~/.bashrc

install-bin:
	mkdir -p ~/bin
	cp -f `pwd`/bin/* ~/bin/

install-git:
	rm -f ~/.gitconfig
	rm -f ~/.gitignore
	rm -f ~/.git-completion.bash
	ln -s `pwd`/git/gitconfig ~/.gitconfig
	ln -s `pwd`/git/gitignore ~/.gitignore
	ln -s `pwd`/git/git-completion.bash ~/.git-completion.bash

install-darcs:
	mkdir -p ~/.darcs
	rm -f ~/.darcs/author
	rm -f ~/.darcs/defaults
	ln -s `pwd`/darcs/author ~/.darcs/author
	ln -s `pwd`/darcs/defaults ~/.darcs/defaults

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

