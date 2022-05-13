echo -n Setting global exports...
set -gx SHELL (which fish)
set -gx PAGER nvimpager
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER google-chrome-stable
# always try to set DISPLAY
set -q DISPLAY; or set -x DISPLAY ":0"


# INTERACTIVE
if status --is-interactive
  fish_vi_key_bindings
  # Tab is complete
  bind -M \t complete
  # C-p completes history expand
  bind -M insert \cP forward-char
  bind -M insert \c\t forward-char
  # C-f moves one word forward
  bind -M insert \cF nextd-or-forward-word
  # Setting fd as the default source for fzf
  export FZF_DEFAULT_COMMAND='fd --type f'
  source ~/.fzf/shell/key-bindings.fish
  echo -n Setting abbreviations...
  set -g fish_user_abbreviations

: '
THE THREE TYPES OF ALIAS
==============================

 - alias: 
    Make a something functionally equivalent to something else. This holds true if you press return, chain things together, pipe, redirect, and such. In recent versions of fish, context aware tab completion will work here too.

 - abbr: 
    Type something and have it expanded into something else after pressing space or semicolon (but not return). The new hotness.

 - function: 
    Make something functionally equivalent to one or more something elses, and optionally permute data that are being worked on with (argv).Strictly speaking, alias is itself just an alias for a function that blindly accepts argv and tacks them to the end of its something else. But this pattern is so prolific that it got its own name, so we will consider it unique for today.
'
  alias g 'git'
  alias G 'git'
  abbr gs 'git status'
  abbr gl 'PAGER=/usr/bin/less git lg'
  abbr gla 'PAGER=/usr/bin/less git lga'
  alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  abbr cng 'config'
  alias du 'dust -d 1'
  alias df 'duf --hide-mp /var/lib/snapd/snap/\*'
  abbr e 'nvim'
  alias nlf 'EDITOR=nvr lf -command "set ratios 1:2; set preview"' 
  abbr lfn 'nlf'
  abbr fda 'fd -uu'
  alias find 'fd -uu'
  abbr install 'pikaur -S --needed --noconfirm'
  abbr mail 'cmdg'
  abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
  abbr rg 'rg -S'
  abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
  abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
  abbr ta 'tmux a'
  abbr upgrade 'paru -Syu --skipreview --useask --noconfirm'
  abbr vultr 'vultr-cli --config ~/vultr-cli.yaml'
  abbr yay 'paru'
  abbr psax 'procs'
  alias pbcopy 'xsel --clipboard --input'
  alias pbpaste 'xsel --clipboard --output'
  alias ls 'exa -G --icons'
  alias ll 'ls -lT --level=1'
  alias la 'll -a'
  alias tree 'll -a --level=3'


  echo "Set Theme"
  omf theme yimmy
  # zoxide init
  zoxide init fish | source
  # autostart ssh-add
  # fish_ssh_agent
  # autostart lf, or use CTRL+O to open it
  # lfcd
end

# FINALLY (INTERACTIVE)
# direnv hook fish | source
eval (direnv hook fish)

