
install: install-shell install-bin install-git install-darcs install-misc

install-shell:
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
	git config --global core.editor "vim"
	git config --global core.excludesfile ~/.gitignore

install-darcs:
	mkdir -p ~/.darcs
	rm -f ~/.darcs/author
	rm -f ~/.darcs/defaults
	ln -s `pwd`/darcs/author ~/.darcs/author
	ln -s `pwd`/darcs/defaults ~/.darcs/defaults

install-misc:
	rm -f ~/.ackrc
	rm -f ~/.tmux.conf
	ln -s `pwd`/misc/ackrc ~/.ackrc
ifeq ($(shell uname), Darwin)
	ln -s `pwd`/misc/tmux.conf.osx ~/.tmux.conf
endif


