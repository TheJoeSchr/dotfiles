fish_vi_key_bindings

# C-p completes history expand
bind -M insert \cP forward-char
# C-f moves one word forward
bind -M insert \cF nextd-or-forward-word

: '
THE THREE TYPES
 - alias: 
    Make a something functionally equivalent to something else. This holds true if you press return, chain things together, pipe, redirect, and such. In recent versions of fish, context aware tab completion will work here too.

 - abbr: 
    Type something and have it expanded into something else after pressing space or semicolon (but not return). The new hotness.

 - function: 
    Make something functionally equivalent to one or more something elses, and optionally permute data that are being worked on with (argv).Strictly speaking, alias is itself just an alias for a function that blindly accepts argv and tacks them to the end of its something else. But this pattern is so prolific that it got its own name, so we will consider it unique for today.
'

if status --is-interactive
  echo -n Setting abbreviations...
  set -g fish_user_abbreviations
  alias g 'git'
  abbr gs 'git status'
  abbr gl 'PAGER=/usr/bin/less git lg'
  abbr gla 'PAGER=/usr/bin/less git lga'
  alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  abbr cng 'config'
  # alias vim 'nvr'
  # alias nvim 'nvr'
  abbr e 'nvim'
  abbr fda 'fd -uu'
  alias find 'fda'
  alias du 'dust -d 1'
  alias df 'duf --hide-mp /var/lib/snapd/snap/\*'
  abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
  abbr pinstall 'pikaur -S --needed --noconfirm'
  abbr pupdate 'pikaur -Syu --noconfirm'
  abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
  abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
  abbr yay 'pikaur'
  abbr ta 'tmux a'
  abbr rg 'rg -S'
  abbr mail 'cmdg'
  abbr vultr 'vultr-cli --config ~/vultr-cli.yaml'
  alias ps 'procs'
  abbr psax 'procs'
  alias pbcopy 'xsel --clipboard --input'
  alias pbpaste 'xsel --clipboard --output'
  alias ls 'exa'
  alias ll 'ls -lG'
  alias lla 'll -a'
  alias tree 'll -T'
  alias llt 'tree'

  echo -n Setting global exports...
  set -gx PAGER nvimpager
  set -gx EDITOR nvim
  set -gx VISUAL nvim
  set -gx BROWSER google-chrome-stable
  # always try to set DISPLAY
  set -q DISPLAY; or set -x DISPLAY ":0"

  echo "Set Theme"
  omf theme yimmy
end

# direnv hook fish | source
eval (direnv hook fish)
