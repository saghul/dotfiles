# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# color prompt

count=0
for color in "BLACK" "RED" "GREEN" "YELLOW" "BLUE" "PURPLE" "CYAN" "WHITE"
do
    eval ${color}=`echo -ne \"'\[\e[0;3'$count'm\]'\"`
    eval B_${color}=`echo -ne \"'\[\e[1;3'$count'm\]'\"`
    (( count = $count + 1 ))
done

COLOR_RESET='\[\e[0m\]'

if [[ "`id -u`" -eq 0 ]]; then
    _PS1="$B_RED\u$COLOR_RESET@$B_GREEN\H$COLOR_RESET:$B_RED\w$COLOR_RESET# "
else
    _PS1="$B_BLUE\u$COLOR_RESET@$B_GREEN\H$COLOR_RESET:$B_RED\w$COLOR_RESET$ "
fi

function update_PS1()
{
    nsh=$((SHLVL - 2))
    if [[ $nsh -gt 0 ]]; then
        nsh="($nsh)"
    else
        nsh=""
    fi
    virtual=""
    if [[ -n $VIRTUAL_ENV ]]; then
        virtual="(`basename \"$VIRTUAL_ENV\"`)"
    fi
    export PS1=$virtual$nsh$_PS1
}
PROMPT_COMMAND=update_PS1

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    if [[ `uname` == "Linux"  ]]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
    else
        alias ls='ls -G'
    fi
fi

# aliases
alias ll='ls -lF -h'
alias la='ls -lFa -h'
alias l='ls -CF -h'

alias ..='cd ..'
alias cd..='cd ..'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

if hash "ack-grep" > /dev/null 2>&1; then
    alias ack='ack-grep'
fi

alias du='du -sh'
alias df='df -h'

alias serve='python -m SimpleHTTPServer'
alias syslog='tail -f /var/log/syslog'
alias screen_off='xset dpms force off'

# Bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Home directory bin apps
export PATH=~/bin:$PATH

# Homebrew binaries
if [[ `uname` == "Darwin"  ]]; then
    export PATH=~/.homebrew/bin:$PATH
fi

# Always dump the core
ulimit -c unlimited

# ViM
alias vim='vim -p'
alias vi='vim'
alias gvim='gvim -p'
export EDITOR=vim

# Work
alias work='cd ~/work/ag-projects/'
export DEBEMAIL="Saul Ibarra <saul@ag-projects.com>"

# language
export LANG=en_US.UTF-8

# Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true


