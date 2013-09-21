# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github perl python rails command-not-found brew osx)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/home/vikrant/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

#end of oh-my-zsh config

# Shell exports
export LANG=en_US.utf8

# aliases
alias resh='source ~/.zshrc'
alias halt='sudo halt'
alias reboot='sudo reboot'
alias hibernate='sudo pm-hibernate'
alias byebye='sudo shutdown now'
alias i='sudo apt-get install -y'
alias t='tree -C | more'
alias lt='ls --color -lht | head'
alias lt='ls --color -lht | head'
#alias ltr='find . -mtime -1 -print0 | xargs -0 head | xargs -0 ls -lht'
alias git-make='make -j 8 CFLAGS="-g -O0 -Wall"'
alias git-prove 'make -j 8 CFLAGS="-g -O0 -Wall" DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="-j 15" test'

# set up emacs-like editing
bindkey -e
bindkey '\C-x \C-k' kill-region
bindkey '\C-w' backward-kill-word

# customize history
setopt extended_history
setopt hist_ignore_all_dups

# customize the prompt
autoload -U colors && colors
ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

PS1='%{$fg_bold[red]%} %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

RPS1=$'%{\e[30m%}%t%{\e[0m%}'

# autocorrect is irritating
unsetopt correct_all

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
