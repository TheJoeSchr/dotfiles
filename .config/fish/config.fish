set -gx SHELL (which bash) # needs bash for nvim python
# export environment variable VMUX_EDITOR, either vim or nvim
set -gx VMUX_EDITOR nvim
set -gx VMUX_REALEDITOR_NVIM_QT /usr/bin/nvim-qt
set -gx VMUX_REALEDITOR_NVR /usr/bin/nvr
set -gx VMUX_GLOBAL 1
set -gx VMUX_NOT_SELECT_PANE 1

set -gx PAGER nvimpager # or env less
set -gx EDITOR nvim
set -gx VISUAL nvim # ewrap is used by nnn with editor split
set -gx BROWSER google-chrome-stable
# always try to set DISPLAY
# set -q DISPLAY; or set -gx DISPLAY ":0"
# add user bin to path
if [ ! -f /run/.containerenv ] && [ ! -f /.dockerenv ]
    fish_add_path ~/.local/bin
    fish_add_path ~/.local/podman/bin
end

# INTERACTIVE
if status --is-interactive
    echo Starting fish shell interactivily...
    set HOSTNAME (uname --nodename)
    if test (uname --nodename) = steamdeck
        set is_steam_host true
    else
        set is_steam_host false
    end

    fish_vi_key_bindings
    # usually automatically, but call to overwrite
    fish_user_key_bindings
    # Ctrl-f directory
    # Ctrl-Alt-v environment variable
    fzf_configure_bindings --directory=\cf --variables=\e\cv

    # Setting fd as the default source for fzf
    set -gx FZF_DEFAULT_COMMAND 'fd --type f'

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
    # no upgrade by default for steamdeck
    if not $is_steam_host
        abbr upgrade 'sudo pacman -Syu --noconfirm && VISUAL=nvim pikaur -Syu --noconfirm'
    else
        abbr upgrade 'sudo pacman -Sy --noconfirm && VISUAL=nvim pikaur -Sy --noconfirm'
    end
    # Abbreviations are stored in a variable named fish_user_abbreviations. This is automatically created as a universal variable the first time an abbreviation is created. If you want your abbreviations to be private to a particular fish session you can put the following in your *~/.config/fish/config.fish* file before you define your first abbrevation:
    # You can create abbreviations directly on the command line and they will be saved automatically and made visible to other fish sessions if fish_user_abbreviations is a universal variable. If you keep the variable as universal, abbr --add statements in config.fish will do nothing but slow down startup slightly.
    # set -g fish_user_abbreviations
    abbr c config
    abbr ca 'config add '
    abbr ccc 'config ci'
    abbr cf config
    abbr cs 'config st'
    abbr db distrobox
    abbr e edit
    abbr fda 'fd -uu'
    abbr find 'fd -uu'
    abbr G git
    abbr g git
    abbr ga 'git add'
    abbr gl 'PAGER=/usr/bin/less git lg'
    abbr gla 'PAGER=/usr/bin/less git lga'
    abbr gs 'git st'
    abbr install 'pikaur -S --needed --noconfirm'
    abbr lal 'la -l'
    abbr ll nnn-cd # goes to cd
    abbr n nnn
    abbr poetry 'SHELL=(which fish) poetry'
    abbr psax procs
    abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
    abbr rg 'rg -S'
    abbr rm rip
    abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
    abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
    abbr ta 'tmux a'
    abbr tff 'tf -y'
    abbr tp tmux-sessionizer
    abbr upgrade-paru 'paru -Syu --skipreview --useask --noconfirm'
    abbr vimdiff "$EDITOR -d"
    abbr vultr 'vultr-cli --config ~/vultr-cli.yaml'

    alias pbcopy 'xsel --clipboard --input'
    alias pbpaste 'xsel --clipboard --output'
    alias tree 'lll -a --level=3'
    alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    alias df 'duf --hide-mp /var/lib/snapd/snap/\*'
    alias du 'dust -d 1'
    alias edit nvim
    alias la 'exa --all -1'
    alias lf nnn
    alias lll 'ls -lT --level=1'
    alias ls 'exa -G --icons'
    alias mail cmdg

    # NNN 
    # ALT+o => nnn-nav-by-type
    # CTRL+o or ALT+t => nnn-filepicker
    # functions/fileexplorer_user_key_bindings.fish

    # -H hidden files
    # -e      text in $VISUAL/$EDITOR/
    # -E      internal edits in EDITOR
    # sudo -E preserve enviornment (sudoedit doesn't work)
    # prints selections to stdout (useful for piping)
    # but no change to directory
    alias N 'sudo -E fish -c "nnn-prints-selection -HeE"'
    alias nnn 'nnn-cd -P v'
    # use like (nfp) instead of (nnn-filepicker) because it replaces cli
    alias nfp 'nnn-with-editor-split -eEDH -P v -p -'


    if type -q omf
        omf theme yimmy
    end
    # zoxide init
    if type -q zoxide
        zoxide init fish | source
        abbr cd z
    end

    if type -q tmux
        # if inside tmux refresh DBUS
        switch $TERM
            case "screen*"
                # echo "Refresh DBUS '$DBUS_SESSION_BUS_ADDRESS' for tmux"
                tmux-refresh
        end
    end
    echo "        _            _       _____ _     _          "
    echo "       | | ___   ___( )___  |  ___(_)___| |__       "
    echo "    _  | |/ _ \ / _ \// __| | |_  | / __| '_ \      "
    echo "   | |_| | (_) |  __/ \__ \ |  _| | \__ \ | | |     "
    echo "    \___/ \___/ \___| |___/ |_|   |_|___/_| |_|     "
    echo "                                                    "
    echo "    ESCAPE HATCH: \`bash --norc\`  or \`bash -c \"\"\` "
    echo "    _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   "
    echo "                                                    "
    echo "                                                    "
    # autostart ssh-add
    # fish_ssh_agent
end # /(INTERACTIVE)

# noninteractive:
if type -q direnv
    # direnv hook fish | source
    eval (direnv hook fish)
end
