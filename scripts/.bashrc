. /etc/profile

#v1.0.5 need to override TERM setting in /etc/profile...
#export TERM=xterm
# ...v2.13 removed.

#export HISTFILESIZE=2000
#export HISTCONTROL=ignoredups
#...v2.13 removed.

# begin saas-puppy v0.2

# prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
PS1="\e[0;32m\u@\h\e[m \e[0;36m\w\e[m \e[0;32m$(parse_git_branch)\e[m \n$ "

# defaults
EDITOR=nano

#aliases
alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias la='ls -a --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
