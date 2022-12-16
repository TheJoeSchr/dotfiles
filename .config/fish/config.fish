echo Setting global exports...
set -gx SHELL (which bash)
set -gx PAGER nvimpager
set -gx EDITOR nvim
set -gx VISUAL nvr # ewrap is used by nnn with editor split
set -gx BROWSER google-chrome-stable
# nnn
set -x USE_PISTOL 1
# always try to set DISPLAY
set -q DISPLAY; or set -gx DISPLAY ":0"
# add user bin to path
fish_add_path ~/.local/bin
fish_add_path ~/.local/podman/bin

# INTERACTIVE
if status --is-interactive
  echo Setting key bindings...
  fish_vi_key_bindings
  # Tab is history expand
  bind -M insert \t forward-char
  # C-p completes history expand
  bind -M insert \cP forward-char
  # Tab-Tab is complete
  bind -M insert \t\t complete
  # C-f moves one word forward
  bind -M insert \cF nextd-or-forward-word
  # Setting fd as the default source for fzf
  export FZF_DEFAULT_COMMAND='fd --type f'

# need `:` for multiline comment
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
  abbr ga 'git add'
  abbr gs 'git st'
  alias glg 'PAGER=/usr/bin/less git lg'
  alias gla 'PAGER=/usr/bin/less git lga'
  abbr lg 'glg'
  abbr lga 'gla'
  alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  abbr cfg 'config'
  # use both because sometimes I start typing cng and then realize I want to use config
  abbr cng 'config'
  abbr cnfg 'config'
  alias du 'dust -d 1'
  alias df 'duf --hide-mp /var/lib/snapd/snap/\*'
  abbr e 'nvim'
  abbr db 'distrobox'
  alias lf 'lfcd' 
  abbr fda 'fd -uu'
  abbr find 'fd -uu'
  abbr install 'pikaur -S --needed --noconfirm'
  abbr mail 'cmdg'
  abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
  abbr rg 'rg -S'
  abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
  abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
  abbr ta 'tmux a'
  abbr upgrade 'sudo pacman -Syu --noconfirm && pikaur -Syu --noconfirm'
  abbr upgrade-paru 'paru -Syu --skipreview --useask --noconfirm'
  abbr vultr 'vultr-cli --config ~/vultr-cli.yaml'
  abbr psax 'procs'
  alias pbcopy 'xsel --clipboard --input'
  alias pbpaste 'xsel --clipboard --output'
  alias ls 'exa -G --icons'
  alias lll 'ls -lT --level=1'
  alias tree 'lll -a --level=3'
  # NNN aliases
  # -P v + => opens preview-tui mapped to 'v'
  # -n nav-by-type
  # -J no jump into directory
  # -H hidden files
  # -D dirs in context colors
  # -p takes output file as an argument
  # - print to stdout
  # `-p -` print selected to stdout
  alias N 'sudo -E (fish -c nnn-with-editor-split -H)'
  # find
  alias n 'nnn-prints-selection'
  # explore and go
  alias ll 'nnn-cd'
  alias la 'll -H'
  # functions/fileexplorer_user_key_bindings.fish
  # ALT+o => nnn-nav-by-type
  # CTRL+o or ALT+t => nnn-filepicker
  alias vimdiff "$EDITOR -d"


  if type -q "omf"
    echo "Set Theme"
    omf theme yimmy
  end
  # zoxide init
  if type -q "zoxide"
    zoxide init fish | source
    abbr cd z
  end

  if type -q "tmux"
    # if inside tmux refresh DBUS
    switch $TERM
        case "screen*"
            echo "Refresh DBUS '$DBUS_SESSION_BUS_ADDRESS' for tmux"
            tmux-refresh
    end
  end
  # autostart ssh-add
  # fish_ssh_agent
  # autostart lf, or use CTRL+O to open it
  # lfcd
end # /(INTERACTIVE)

# noninteractive:
if type -q "direnv"
  # direnv hook fish | source
  eval (direnv hook fish)
end

