# use vi mode
set -o vi

# utility shit
alias ll='ls -al'
alias flush='dscacheutil -flushcache'
alias lighty="lighttpd -D -f config/lighty.conf"

# rails 2.x
alias ss='script/server'
alias sc='script/console'
alias sg='script/generate'

# rails 3
alias rs='rails server'
alias rc='rails console'
alias rg='rails generate'

# git
alias gs='git status'
alias gc='git checkout'
alias gb='git branch'

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[$RED\u@\h:\w$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\$ "
PS2='> '
PS4='+ '
}
proml


# Find unmerged commits
function unmerged() {
	for b in `git branch $@ | grep -v -E '^[* ]*(demo|master)$'`; do echo "$b"; git cherry -v master "$b"; done
}

# use macvim
EDITOR=/usr/bin/vim
BUNDLER_EDITOR=/usr/local/bin/mvim

# rdoc
RDOCOPT="--exclude=test/*"

PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/usr/local/ruby/bin:$PATH"
export EDITOR BUNDLER_EDITOR SATISFACTION_TOOLS PATH RDOCOPT

if [ -f $SATISFACTION_TOOLS/tools.bash ]; then
  source $SATISFACTION_TOOLS/tools.bash
fi

# RVM Config
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

source ~/dotfiles/secure
