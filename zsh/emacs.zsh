#!/bin/zsh
# [[ `uname` == "Darwin" ]] && alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs "$@" && alias emacsclient=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
export EDITOR="emacsclient"
alias ec='emacsclient'
function man_ () {
    emacsclient -e "(man \"$*\")" 2>&1 >/dev/null || man "$*"
}
alias man=man_

