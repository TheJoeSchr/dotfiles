# vi mode in bash!!!
set -o vi

if [ "$OS" == "Windows_NT" ]; then
        . ~/.bashrc.win
else
        . ~/.fzf.bash
fi

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

SSH_ENV=$HOME/.ssh/environment
export REACT_EDITOR=code
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

alias config='/usr/bin/git --git-dir=/home/chrx/.cfg/ --work-tree=/home/chrx'
. ~/.bashrc.local
