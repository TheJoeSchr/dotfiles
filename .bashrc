# If not running interactively, skipps this file
if [ -t 0 ]; then
  # .bashrc.local bgets sourced at the end of this file
  echo "Running interactively, loading .bashrc"
else
  echo "Not running interactively, skipping .bashrc"
  [ -e $HOME/.profile ] && source $HOME/.profile
  return
  # [ -e $HOME/.bashrc.local ] && source $HOME/.bashrc.local
fi

SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

if command -v fish >/dev/null; then
  # if don't want to use fish, just use exit in .bashrc.local
  [ -e ~/.bashrc.local ] && . ~/.bashrc.local

    ## FISH
    # echo " |---------------------------------------------------|"
    # echo " | ESCAPE HATCH:                                     |"
    # echo " | \`bash --norc\`  or \`bash -c \"\"\`                    |"
    # echo " | to manually enter Bash                            |"
    # echo " | without executing the commands from ~/.bashrc     |"
    # echo " | which would run \`exec -l fish\`                    |"
    # echo " |---------------------------------------------------|"

    # To have commands such as `bash -c 'echo test'` run the command in Bash instead of starting fish
    # from: /usr/bin/[ --help:
    # -z STRING            the length of STRING is zero
    if [ -z "$BASH_EXECUTION_STRING" ]; then
      # Drop in to fish only if the parent process is not fish. This allows to quickly enter in to bash by invoking bash command without lusing ~/.bashrc configuration:
      if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" ]]
      then
        echo "Exec fish from \`.bashrc\`"
        exec -l fish "$@"
      fi
    fi
fi

# NO FISH
echo "NO FISH"
# USE BASH INTERACTIVELY ONLY

# vi mode in bash!!!
set -o vi

# Use bash-completion, if available
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
. /usr/share/bash-completion/bash_completion

# Use git-completion, if available
if [ -f /usr/share/bash-completion/completions/git ]; then
  . /usr/share/bash-completion/completions/git
fi
[[ $PS1 && -f /usr/share/bash-completion/completions/git ]] && \
. /usr/share/bash-completion/completions/git

if [ "$OS" == "Windows_NT" ]; then
  alias config="`which git` --git-dir=/c/Users/Joe/Insync/josef.schroecker@gmail.com/Dropbox/userconf/.dotfiles-cfg --work-tree=/c/Users/Joe/AppData/Roaming/.home"
  __git_complete config _git
  # Add tmux path (not working so far)
  export PATH="$PATH:/c/msys64/usr/bin/"
  . ~/.bashrc.win
else
  alias config="`which git`  --git-dir=$HOME/.cfg/ --work-tree=$HOME"
  __git_complete config _git
  alias config-changed="config checkout 2>&1 | egrep \s+\. | awk {'print $1'} | xargs -I{} echo {}"
  # alias config-changed="config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} git --git-dir=$HOME/.dotfiles-cfg/ --work-tree=$HOME add -- {}"

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

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/usr/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/joe/micromamba";
__mamba_setup="$('/usr/bin/micromamba' shell hook --shell bash --prefix '/home/joe/micromamba' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/joe/micromamba/etc/profile.d/mamba.sh" ]; then
        . "/home/joe/micromamba/etc/profile.d/mamba.sh"
    else
        export PATH="/home/joe/micromamba/bin:$PATH"
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

## ALIASES AND COMMANDS

## csh: pass arguments to windows shell for execution
function csh {
        arg="$@"    # needs helper arg for double-quotes ""
        cmd "/C $arg"
}
## removes docker lock ups hardcore mode
docker-removecontainers() {
        docker stop $(docker ps -aq)
        docker rm $(docker ps -aq)
}

docker-armageddon() {
        docker-removecontainers
        docker network prune -f
        docker rmi -f $(docker images --filter dangling=true -qa)
        docker volume rm $(docker volume ls --filter dangling=true -q)
        docker rmi -f $(docker images -qa)
}

# e for edit
alias e="nvim"

alias less='less -r'
# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color --show-control-chars'
alias ll='ls -alkh'

# ssh-add
alias ssh-add-all="ssh-add ~/.ssh/id_rsa_*"

## GIT ##
# now with autocomplete #
alias g="git"
# make autocomplete work with `g`
__git_complete g _git

# git status
alias gs='git status '
__git_complete gs _git_status

# git add
alias ga='git add '
__git_complete ga _git_add
alias gap='git add --patch '
__git_complete gap _git_add

# git better log
alias gl='git lg'
__git_complete gl _git_log
# git overview (all branches)
alias gov='git lg --date=short --all'
__git_complete gov _git_log

# git branches
alias gb='git branch '
__git_complete gb _git_branch

# git commit
alias gc='git ci '
__git_complete gc _git_commit

# git diff
alias gd='git diff'
__git_complete gd _git_diff

# git checkout
alias go='git checkout '
__git_complete go _git_checkout

alias gp='git push'
__git_complete gp _git_push


alias gk='gitk --all&'
alias gx='gitx --all'

# type safe
alias got='git '
__git_complete got _git
alias get='git '
__git_complete get _git

alias gpu='git pu  --rebase'
__git_complete gpu _git_pull

# after https://sandofsky.com/blog/git-workflow.html
alias gmsf='git merge --no-ff --no-commit '
__git_complete gmsf _git_merge
alias gms='git merge --squash '
__git_complete gms _git_merge
alias gmf='git feat  '
__git_complete gmf _git_merge
alias gm='git merge  '
__git_complete gm _git_merge
alias gr='git rebase  '
__git_complete gri _git_rebase
alias gri='git revise --interactive '
__git_complete gri _git_rebase
alias gbdr='git branch-delete-remote '
__git_complete gbdr _git_branch

alias cls="clear"
# find largest folder/file quickly (seperated in subdirs)
alias duckS='$(which du) -ckSh * | sort -rh | head'
# find largest folder/file quickly (summarized)
alias ducks='$(which du) -cksh * | sort -rh | head'
# search also hidden files
alias duckA='$(which du) -ckah * | sort -rh | head'

# alias killgrep
function killgrep {
  echo kill $(ps aux | grep "$1" | awk '{print $2}');
  kill $(ps aux | grep "$1" | awk '{print $2}');
}
export -f killgrep

# source local commands
source  ~/.bashrc.local

 # exit if inside tmux
if [[ "$TERM" =~ "screen".* ]]; then
  echo "Already inside TMUX"
else
  read -t 2 -n 1 -p "Start tmux (n/Y)? " answer
  [ -z "$answer" ] && answer="Y"  # 'yes' default choice
  case ${answer:0:1} in
     n|N )
         echo "No Tmux"
         ;;
     * )
         echo "Starting tmux-init"
         tmux attach -t base || tmux new -s base
     ;;
  esac
fi
# # -- EXAMPLES BASHRC.LOCAL

# source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

# echo "Local Config"
# # gets sourced in ~/.profile, which gets called by ~/.bash_profile
# # source ~/.profile.local

# # exit if inside tmux
# if [[ "$TERM" =~ "screen".* ]]; then
#   echo "Already inside TMUX"
# else
#   read -t 2 -n 1 -p "Start tmux (y/N)? " answer
#   [ -z "$answer" ] && answer="N"  # 'no' default choice
#   case ${answer:0:1} in
#      y|Y )
#          echo "Starting tmux-init"
#          tmux attach -t base || tmux new -s base
#          ;;
#      * )
#          echo "No Tmux"
#          ;;
#   esac
# fi



# # Inspired by http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu

# ## WSL
# # FIX on WSL so it doesn't get windows npm/yarn
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Program Files\/nodejs://')
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Program Files\/nodejs\/://')
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Users\/Joe\/AppData\/Roaming\/npm://')
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Program Files (x86)\/Yarn\/bin\/://')
# export PATH=$(echo "$PATH" | sed -e 's/\/mnt\/c\/Users\/Joe\/AppData\/Local\/Yarn\/bin://')

# # ALIASES
# ## TMUX
# alias tmux-init="tmux attach -t base || tmux new -s base"
# alias ca="config add"
# alias cs="config status"
# alias tmux-init="tmux attach -t base || tmux new -s base"
## search stackoverflow with googler
##alias so='googler -j -w stackoverflow.com (xsel)'

