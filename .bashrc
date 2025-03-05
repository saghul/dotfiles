# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# for debugging
#set -o errexit
#set -o xtrace

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Home directory bin apps
export PATH=~/bin:~/.local/bin:$PATH

# local paths
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# homebrew
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# my dotfiles
function dotfiles() {
    /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

# aliases
function _tmux_new_or_attach() {
    tmux has-session -t $1 2>/dev/null
    if [ "$?" -eq 1 ] ; then
        # No session found
        tmux -2 new-session -d -s $1
    fi
    tmux -2 attach-session -t $1
}

alias tmux='tmux -2'
alias t=_tmux_new_or_attach

if hash "tmux" > /dev/null 2>&1; then
    alias tmux='TMPDIR=/tmp tmux -2'
fi

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    if hash "eza" > /dev/null 2>&1; then
        alias ls='eza --icons'
        alias l='ls -F -h --grid'
    else
        if [[ `uname` == "Linux"  ]]; then
            eval "`dircolors -b`"
            alias ls='ls --color=auto'
        else
            alias ls='ls -G'
        fi

        alias l='ls -CF -h'
    fi
fi

alias ll='ls -lF -h'
alias la='ls -lFa -h'

alias ..='cd ..'
alias cd..='cd ..'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias du='du -sh'
alias df='df -h'

alias serve='python3 -m http.server'

if [[ `uname` == "Darwin"  ]]; then
    alias syslog='tail -f /var/log/system.log'
    alias xopen='open'
    alias ldd='otool -L'
else
    alias syslog='tail -f /var/log/syslog'
    alias xopen='xdg-open'
fi

if [[ `uname` == "Linux"  ]]; then
    alias screen-off='xset dpms force off'
fi

alias timestamp='date +%Y-%m-%dT%H:%M:%S%z'

# Colored man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# Terminal copy & paste
if [[ `uname` != "Darwin"  ]]; then
    alias pbcopy='xclip -in -selection clipboard'
    alias pbpaste='xclip -out -selection clipboard'
fi

# Bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
    export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    . "/usr/local/etc/profile.d/bash_completion.sh"
fi
if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
    export BASH_COMPLETION_COMPAT_DIR="/opt/homebrew/etc/bash_completion.d"
    . "/opt/homebrew/etc/profile.d/bash_completion.sh"
fi

# Always dump the core
ulimit -c unlimited

# ViM
alias vi='vim'
export EDITOR=vim

# language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Bash completion for git
[[ -s $HOME/.git-completion.bash ]] && source $HOME/.git-completion.bash

# Android
if [[ -d ~/Library/Android/sdk ]]
then
    export ANDROID_HOME=~/Library/Android/sdk
    export PATH=${PATH}:${ANDROID_HOME}/tools
    export PATH=${PATH}:${ANDROID_HOME}/platform-tools
fi

# Google Depot Tools
if [[ -d ~/src/depot_tools ]]
then
    export PATH=~/src/depot_tools:${PATH}
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# Node
if hash "npm" > /dev/null 2>&1; then
    source <(npm completion)
fi

# Wasmer
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# Rust
export PATH=/opt/homebrew/opt/rustup/bin:$PATH
if [[ -f ~/.cargo/env ]]; then
    source ~/.cargo/env
fi

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
if hash "ruby" > /dev/null 2>&1; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:${PATH}"
fi

# KDE / Plasma
export PLASMA_USE_QT_SCALING=1

# gh CLI
eval "$(gh completion -s bash)"

# fzf
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Cleanup PATH
export PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

# Extra customizations
if [[ -f ~/.bashrc-extra ]]; then
    source ~/.bashrc-extra
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# Prompt
function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}
starship_precmd_user_func="set_win_title"

eval "$(starship init bash)"


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
