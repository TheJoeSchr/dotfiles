# vi mode in bash!!!
set -o vi

# adds yarn global binaries to path"
export PATH="$PATH:`yarn global bin --offline`"

if [ "$OS" == "Windows_NT" ]; then
  alias config="`which git` --git-dir=/c/Users/Joe/Insync/josef.schroecker@gmail.com/Dropbox/userconf/.dotfiles-cfg --work-tree=/c/Users/Joe/AppData/Roaming/.home"
  . ~/.bashrc.win
else
  alias config="`which git`  --git-dir=$HOME/.dotfiles-cfg/ --work-tree=$HOME"
  . ~/.fzf.bash
  # show git branch with nice colors
  force_color_prompt=yes
  parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
  }
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\n\$ '
  #if [ "$color_prompt" = yes ]; then
  #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\n\$ '
  #else
  ##color_prompt if is not working on docker...
  #  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\n\$ '
  #fi
  unset color_prompt force_color_prompt
fi

# Use bash-completion, if available
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
. /usr/share/bash-completion/bash_completion

SSH_ENV=$HOME/.ssh/environment

# for docker postgraphile
export UID;

export EDITOR="nvim"
export REACT_EDITOR=code

# Setting for the new UTF-8 terminal support in TMUX
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# start the ssh-agent
function start_agent {
        echo "Initializing new SSH agent..."
        # spawn ssh-agent
        /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
        echo succeeded
        chmod 600 "${SSH_ENV}"
        . "${SSH_ENV}" > /dev/null
        /usr/bin/ssh-add
}
if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
                start_agent;
        }
else
        start_agent;
fi

## csh: pass arguments to windows shell for execution
function csh {
        arg="$@"    # needs helper arg for double-quotes ""
        cmd "/C $arg"
}
## removes docker lock ups hardcore mode
removecontainers() {
        docker stop $(docker ps -aq)
        docker rm $(docker ps -aq)
}

docker-armageddon() {
        removecontainers
        docker network prune -f
        docker rmi -f $(docker images --filter dangling=true -qa)
        docker volume rm $(docker volume ls --filter dangling=true -q)
        docker rmi -f $(docker images -qa)
}

alias less='less -r'
# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color --show-control-chars'
alias ll='ls -l'

## git stuff ##
        # git status
alias gs='git status '
alias ga='git add '
alias gap='git add --patch '
alias gai='git add -i '
        # git better log
alias gl='git lg'
        # git overview (all branches)
alias gov='gl --date=short --all'
        # git branches
alias gb='git branch '
        # git commit
alias gc='git commit'
alias gd='git diff'
        # git checkout
alias go='git checkout '
alias gpa='git push -u --all'
alias gp='git push'
        # git merge better for feature branch & generally
#alias gmf='git merge --no-ff '
alias gk='gitk --all&'
alias gx='gitx --all'
alias got='git '
alias get='git '
alias gpu='git pu  --rebase'
# after https://sandofsky.com/blog/git-workflow.html
alias gmsf='git merge --no-ff --no-commit '
alias gmf='git merge --squash '
alias gcv='git ci -v '
alias gri='git revise --interactive '

# install git-revise
alias install-git-revise='sudo apt update && sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget  && curl -O https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz && tar -xf Python-3.7.3.tar.xz && cd Python-3.7.3 && ./configure --enable-optimizations --with-ensurepip=install  && make -j 8 && sudo make altinstall && python3.7 --version && pip3 install --user git-revise && git revise --version'

alias cls="clear"

# find largest folder/file quickly (seperated in subdirs)
alias duckS='du -ckSh * | sort -rh | head'
# find largest folder/file quickly (summarized)
alias ducks='du -cksh * | sort -rh | head'

# source local commands
. ~/.bashrc.local

