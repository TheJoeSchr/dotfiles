fish_vi_key_bindings

# C-p completes history expand
bind -M insert \cP forward-char
# C-f moves one word forward
bind -M insert \cF nextd-or-forward-word

if status --is-interactive
  echo -n Setting abbreviations...
  set -g fish_user_abbreviations
  abbr g 'git'
  abbr 'gri' 'git rebase --rebase-merges -i'
  abbr ga 'git add -p'
  abbr gs 'git status'
  abbr gov 'git lg --all'
  abbr cng 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  abbr e 'nvim'
  alias fda 'fd -uu'
  alias find 'fda'
  alias du 'dust -d 1'
  alias df 'duf'
  abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
  abbr pikstall 'pikaur -S --needed --noconfirm'
  abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
  abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
  abbr yay 'pikaur'
  abbr ta 'tmux a'
  abbr rg 'rg -S'
  abbr mail 'cmdg'
  abbr vultr 'vultr-cli --config ~/vultr-cli.yaml'
  alias ps 'procs'
  abbr psax 'procs '
  alias pbcopy 'xsel --clipboard --input'
  alias op-pw-grep 'op-grep'
  alias pbpaste 'xsel --clipboard --output'
  alias ls 'exa'
  alias ll 'ls -lG'
  alias lla 'll -a'
  alias tree 'll -T'
  alias llt 'tree'

  echo -n Setting global exports...
  set -gx PAGER less
  set -gx EDITOR nvim
  set -gx BROWSER google-chrome-stable
  set -gx VISUAL nvim
  # always try to set DISPLAY
  set -q DISPLAY; or set -x DISPLAY ":0"

  echo "Set Theme"
  omf theme yimmy
end

# direnv hook fish | source
eval (direnv hook fish)
