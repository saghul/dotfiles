#!/bin/bash

NOW=`date +%Y-%m-%d.%H:%M:%S`
BACKUP_DIR="dotfiles-backup.$NOW.$$"
CURRENT_DIR=`pwd`

## Backup existing configuration
FILES=".profile .bashrc .gitconfig .gitignore .darcs"
pushd ~ > /dev/null 2>&1
mkdir $BACKUP_DIR
mv -f $FILES $BACKUP_DIR 2> /dev/null
popd > /dev/null 2>&1
echo "Current configuration has been backed up to $BACKUP_DIR"

## Copy new configuration
# dotfiles
DOTFILES="profile bashrc gitconfig gitignore"
for F in $DOTFILES
do
    \cp $F ~/.$F
done
# custom scripts
mkdir -p ~/bin
\cp bin/* ~/bin/
# darcs config
mkdir -p ~/.darcs
\cp -r darcs/* ~/.darcs/

## git postinstall stuff
# editor
if [[ `uname` == "Darwin"  ]]; then
    git config --global core.editor "mvim -f"
else
    git config --global core.editor "vim --noplugin"
fi
git config --global core.excludesfile ~/.gitignore
# github token
if [[ -f ~/.github_token ]]; then
    TOKEN=`cat ~/.github_token`
    git config --global github.token $TOKEN
fi

echo "All done!"
exit 0

