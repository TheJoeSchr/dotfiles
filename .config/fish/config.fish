echo Setting global exports...
set -gx SHELL (which bash)
set -gx PAGER nvimpager
set -gx EDITOR nvim
set -gx VISUAL nvr
set -gx BROWSER google-chrome-stable
set -x NNN_OPENER ~/.config/nnn/plugins/nuke 

set -x NNN_PLUG 'f:finder;o:fzopen;P:mocplay;p:fzplug;j:autojump;d:diffs;t:nmount;v:preview-tui;x:xdgdefault;l:launch'
set -x USE_PISTOL 1
# always try to set DISPLAY
set -q DISPLAY; or set -gx DISPLAY ":0"

# INTERACTIVE
if status --is-interactive
  echo Setting key bindings...
  fish_vi_key_bindings
  # Tab is complete
  bind -M insert \t complete
  # C-p completes history expand
  bind -M insert \cP forward-char
  bind -M insert \c\t forward-char
  # C-f moves one word forward
  bind -M insert \cF nextd-or-forward-word
  # Setting fd as the default source for fzf
  export FZF_DEFAULT_COMMAND='fd --type f'
  source ~/.fzf/shell/key-bindings.fish

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
  echo Setting abbreviations...
  # Abbreviations are stored in a variable named fish_user_abbreviations. This is automatically created as a universal variable the first time an abbreviation is created. If you want your abbreviations to be private to a particular fish session you can put the following in your *~/.config/fish/config.fish* file before you define your first abbrevation:
  # You can create abbreviations directly on the command line and they will be saved automatically and made visible to other fish sessions if fish_user_abbreviations is a universal variable. If you keep the variable as universal, abbr --add statements in config.fish will do nothing but slow down startup slightly.
  # set -g fish_user_abbreviations
  abbr g 'git'
  abbr G 'git'
  abbr gs 'git status'
  alias gl 'PAGER=/usr/bin/less git lg'
  alias gla 'PAGER=/usr/bin/less git lga'
  alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  abbr cng 'config'
  alias du 'dust -d 1'
  alias df 'duf --hide-mp /var/lib/snapd/snap/\*'
  abbr e 'nvim'
  alias lf 'lfcd' 
  abbr fda 'fd -uu'
  alias find 'fd -uu'
  abbr install 'pikaur -S --needed --noconfirm'
  abbr mail 'cmdg'
  abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
  abbr rg 'rg -S'
  abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
  abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
  abbr ta 'tmux a'
  abbr upgrade 'pikaur -Syu --noconfirm'
  abbr upgrade-paru 'paru -Syu --skipreview --useask --noconfirm'
  abbr vultr 'vultr-cli --config ~/vultr-cli.yaml'
  abbr yay 'paru'
  abbr psax 'procs'
  alias pbcopy 'xsel --clipboard --input'
  alias pbpaste 'xsel --clipboard --output'
  alias ls 'exa -G --icons'
  alias lll 'ls -lT --level=1'
  # alias n => ./functions/n.fish 
  alias N 'sudo -E nnn -DH'
  alias ll 'n -D'
  alias la 'll -H'
  alias tree 'll -a --level=3'


  echo "Set Theme"
  omf theme yimmy
  # zoxide init
  zoxide init fish | source
  # autostart ssh-add
  # fish_ssh_agent
  # autostart lf, or use CTRL+O to open it
  # lfcd
end # /(INTERACTIVE)

# noninteractive:
# direnv hook fish | source
eval (direnv hook fish)

