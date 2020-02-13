# TODO: localize env, add ir_black color, learn vimrc

# If not running interactively, don't do anything
# Important for ssh+svn support
if [[ -z ${PS1} ]]; then
    return
fi
# Variables and Path {{{1
export EDITOR=vim
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man' -\""
# export GREP_OPTIONS='--color=auto --line-number --binary-files=without-match'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export XDG_CONFIG_HOME="$HOME/.config"
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# macbook only
export PATH="$PATH:$HOME/mongodb/bin:/Applications/MacVim.app/Contents/bin:/usr/local/Cellar/rabbitmq/3.2.1/sbin:export:$(brew --prefix)/bin:$HOME/nvim-osx64/bin:/Users/jcs/.rvm/gems/ruby-2.1.1/bin:/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:/Users/jcs/Library/Python/2.7/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:$HOME/redis-stable/src/redis-server:$HOME/redis-stable/src/redis-cli:/Users/jcs/.rvm/gems/ruby-2.1.1/bin:$HOME/coding-configs/bin"
export TCL_PATH="/usr/local/bin"
# :~/.npm-global/bin
# ln -sfv /usr/local/opt/rabbitmq/*.plist ~/Library/LaunchAgents

export PIP_PATH="/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages"
# Mac OS X {{{2
if [[ ${OSTYPE} == darwin* ]]; then
    # turn on colors
    CLICOLOR=1
    # 0 a - black   , -------------------- DIR
    # 1 b - red     | ,------------------- SYM_LINK
    # 2 c - green   | | ,----------------- SOCKET
    # 3 d - yellow  | | | ,--------------- PIPE
    # 4 e - blue    | | | | ,------------- EXE
    # 5 f - magenta | | | | | ,----------- BLOCK_SP
    # 6 g - cyan    | | | | | | ,--------- CHAR_SP
    # 7 h - gray    | | | | | | | ,------- EXE_SUID
    #   x - default | | | | | | | | ,----- EXE_GUID
    # fore/back     | | | | | | | | | ,--- DIR_STICKY
    # upper = bold  | | | | | | | | | | ,- DIR_WO_STICKY
    LSCOLORS=ExGxFxdaCxdadahbadheec
fi

# History {{{2
HISTFILE=~/.bash_history
SAVEHIST=10000
HISTSIZE=10000
# Terminal stuff {{{1
if [[ ${COLORTERM} == 'gnome-terminal' && ${TERM} == 'xterm' ]]; then
    TERM=xterm-256color
fi

if [[ ${TERM} != screen* ]]; then
    unset STY
    unset TMUX
fi

# if [[ -n ${STY} ]]; then
#     screen -X "shelltitle '% |zsh:'"
# fi

# Bash Options {{{1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file
shopt -s histappend
# don't put duplicate lines in the history. See bash(1) for more options
HISTCONTROL=ignoredups

# Set a fancy prompt {{{1
# Color definitions {{{2
if [[ -x $(which tput) ]]; then
    COLORS=$(tput colors)
    None="\[$(tput sgr0)\]"
    if (( ${COLORS} >= 16 )); then
        # For 16+ color term {{{
        Black="\[$(tput setaf 0)\]"
        DarkGray="\[$(tput setaf 8)\]"
        LightGray="\[$(tput setaf 7)\]"
        White="\[$(tput setaf 15)\]"
        Red="\[$(tput setaf 9)\]"
        DarkRed="\[$(tput setaf 1)\]"
        Green="\[$(tput setaf 10)\]"
        DarkGreen="\[$(tput setaf 2)\]"
        Yellow="\[$(tput setaf 11)\]"
        DarkYellow="\[$(tput setaf 3)\]"
        Blue="\[$(tput setaf 12)\]"
        DarkBlue="\[$(tput setaf 4)\]"
        Magenta="\[$(tput setaf 13)\]"
        DarkMagenta="\[$(tput setaf 5)\]"
        Cyan="\[$(tput setaf 14)\]"
        DarkCyan="\[$(tput setaf 6)\]"
        BlackBg="\[$(tput setab 0)\]"
        DarkGrayBg="\[$(tput setab 8)\]"
        LightGrayBg="\[$(tput setab 7)\]"
        WhiteBg="\[$(tput setab 15)\]"
        RedBg="\[$(tput setab 9)\]"
        DarkRedBg="\[$(tput setab 1)\]"
        GreenBg="\[$(tput setab 10)\]"
        DarkGreenBg="\[$(tput setab 2)\]"
        YellowBg="\[$(tput setab 11)\]"
        DarkYellowBg="\[$(tput setab 3)\]"
        BlueBg="\[$(tput setab 12)\]"
        DarkBlueBg="\[$(tput setab 4)\]"
        MagentaBg="\[$(tput setab 13)\]"
        DarkMagentaBg="\[$(tput setab 5)\]"
        CyanBg="\[$(tput setab 14)\]"
        DarkCyanBg="\[$(tput setab 6)\]"
        # }}}
    elif (( ${COLORS} == 8 )); then
        # For 8 color term {{{
        Black="\[$(tput setaf 0)\]"
        DarkGray="\[$(tput setaf 0;tput bold)\]"
        LightGray="\[$(tput setaf 7)\]"
        White="\[$(tput setaf 7;tput bold)\]"
        Red="\[$(tput setaf 1;tput bold)\]"
        DarkRed="\[$(tput setaf 1)\]"
        Green="\[$(tput setaf 2;tput bold)\]"
        DarkGreen="\[$(tput setaf 2)\]"
        Yellow="\[$(tput setaf 3;tput bold)\]"
        DarkYellow="\[$(tput setaf 3)\]"
        Blue="\[$(tput setaf 4;tput bold)\]"
        DarkBlue="\[$(tput setaf 4)\]"
        Magenta="\[$(tput setaf 5;tput bold)\]"
        DarkMagenta="\[$(tput setaf 5)\]"
        Cyan="\[$(tput setaf 6;tput bold)\]"
        DarkCyan="\[$(tput setaf 6)\]"
        BlackBg="\[$(tput setab 0)\]"
        DarkGrayBg="\[$(tput setab 0;tput blink)\]"
        LightGrayBg="\[$(tput setab 7)\]"
        WhiteBg="\[$(tput setab 7;tput blink)\]"
        RedBg="\[$(tput setab 1;tput blink)\]"
        DarkRedBg="\[$(tput setab 1)\]"
        GreenBg="\[$(tput setab 2;tput blink)\]"
        DarkGreenBg="\[$(tput setab 2)\]"
        YellowBg="\[$(tput setab 3;tput blink)\]"
        DarkYellowBg="\[$(tput setab 3)\]"
        BlueBg="\[$(tput setab 4;tput blink)\]"
        DarkBlueBg="\[$(tput setab 4)\]"
        MagentaBg="\[$(tput setab 5;tput blink)\]"
        DarkMagentaBg="\[$(tput setab 5)\]"
        CyanBg="\[$(tput setab 6;tput blink)\]"
        DarkCyanBg="\[$(tput setab 6)\]"
        # }}}
    fi
else
    # {{{
    Black=""
    DarkGray=""
    LightGray=""
    White=""
    Red=""
    DarkRed=""
    Green=""
    DarkGreen=""
    Yellow=""
    DarkYellow=""
    Blue=""
    DarkBlue=""
    Magenta=""
    DarkMagenta=""
    Cyan=""
    DarkCyan=""
    BlackBg=""
    DarkGrayBg=""
    LightGrayBg=""
    WhiteBg=""
    RedBg=""
    DarkRedBg=""
    GreenBg=""
    DarkGreenBg=""
    YellowBg=""
    DarkYellowBg=""
    BlueBg=""
    DarkBlueBg=""
    MagentaBg=""
    DarkMagentaBg=""
    CyanBg=""
    DarkCyanBg=""
    None=""
    # }}}
fi
# }}}2
my_big_ps1="${None}(${Blue}\$?${None})--(${Cyan}\t${None})--(${Green}\u${None}@${Magenta}\h${None})--(${Red}\w${Yellow}\$(___git_ps1 ' %s')${None})\n\\$ "

my_small_ps1="${NONE}\w \\$ "
PS1=${my_big_ps1}

# a function to put the current time in the top-right corner of the terminal
# and change the title of the terminal
function prompt_command { #{{{2
    # If this is an xterm set the title to user@host:dir
    case ${TERM} in
    (xterm*|gnome*|konsole*|putty*|screen*)
        __xtermicontitle "${USER}@${HOSTNAME}: ${PWD}"
        ;;
    esac
    # If this is tmux or screen, print a bel
    if [[ ${TERM} == screen* && ( -n ${TMUX} || -n ${STY} ) ]]; then
        echo -ne "\a"
    fi
    # if [[ ${TERM} == screen* ]]; then
    #     __screentitle
    # fi
}

PROMPT_COMMAND=prompt_command

# Enable color support of ls and others {{{1
if [[ -x $(which dircolors) ]]; then
    if [[ -f ~/.dircolors-${COLORS} ]]; then
        eval "$(dircolors -b ~/.dircolors-${COLORS})"
    else
        eval "$(dircolors -b ~/.dircolors)"
    fi
fi

# Load other configurations {{{1
if [[ -f ~/.aliases ]]; then
    source ~/.aliases
fi

if [[ -f ~/.bash_functions ]]; then
    source ~/.bash_functions
fi

if [[ -f ~/.api-tokens ]]; then
    source ~/.api-tokens
fi

# enable igo aliases
if [[ -f ~/.igo_aliases ]]; then
    source ~/.igo_aliases
fi

# enable programmable completion features
if [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

# enable git completion
if [[ -f ~/.git-completion ]]; then
    source ~/.git-completion
fi


# }}}1
#
# vim: fdm=marker fen

# docker
# export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
# export DOCKER_TLS_VERIFY=1
# export DOCKER_HOST=tcp://127.0.0.1:2376
# export COMPOSE_PROJECT_NAME=cobaltstarfish

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
export npm_config_predevelop="caddy -conf ../Caddyfile2"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
#[ -f /Users/jcs/node_modules/tabtab/.completions/serverless.bash ] && . /Users/jcs/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
#[ -f /Users/jcs/node_modules/tabtab/.completions/sls.bash ] && . /Users/jcs/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
#[ -f /Users/jcs/node_modules/tabtab/.completions/slss.bash ] && . /Users/jcs/node_modules/tabtab/.completions/slss.bash
#export TMPDIR=/private/private/var/folders/q3/qbm50nfd1wvgcb8m8phjymbr0000gn/T/
