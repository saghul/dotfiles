# dotfiles

My dotfiles.

## Installation

I'm using a *bare get repository* setup now.

First, clone the (bare) repository:

```bash
git clone --bare https://github.com/saghul/dotfiles.git ~/.dotfiles
```

Prepare an alias to work with it:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Ignore untracked files, since we are treating our entire `$HOME` as a git repository:

```bash
dotfiles config --local status.showUntrackedFiles no
```

Checkout the working files:

```bash
dotfiles checkout # this will likely give an error on the first try, backup your files!
dotfiles checkout -f
```
