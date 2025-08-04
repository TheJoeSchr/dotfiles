set -gx SHELL (which bash) # needs bash for nvim python
# export environment variable VMUX_EDITOR, either vim or nvim
set -gx VMUX_EDITOR nvim
set -gx VMUX_REALEDITOR_NVIM_QT /usr/bin/nvim-qt
set -gx VMUX_REALEDITOR_NVIM (which nvim)
set -gx VMUX_REALEDITOR_NVR /usr/bin/nvr
# set -gx PAGER 'nvimpager -p'
# unset pager so delta can do it's thing, also then works on systems without nvimpager installed
set -e PAGER
set -gx EDITOR nvim
set -gx VISUAL ewrap
set -gx BROWSER google-chrome-stable
set -gx DELTA_FEATURES diff-so-fancy
# always try to set DISPLAY
# set -q DISPLAY; or set -gx DISPLAY ":0"
# add user bin to path
fish_add_path ~/.bun/bin
fish_add_path ~/.config/composer/vendor/bin
fish_add_path ~/.pub-cache/bin/
fish_add_path ~/.docker/cli-plugins/
fish_add_path ~/.krew/bin/
fish_add_path ~/bin/
# masons bin to have all formatters and linters also available in fish
fish_add_path ~/.local/share/nvim/mason/bin//
if [ ! -f /run/.containerenv ] && [ ! -f /.dockerenv ]
    fish_add_path ~/.local/bin
    fish_add_path ~/.local/podman/bin
end

# INTERACTIVE
if status --is-interactive
    echo "Starting fish shell interactively..."
    set HOSTNAME (uname --nodename)
    if test (uname --nodename) = steamdeck
        set is_steam_host true
    else
        set is_steam_host false
    end

    # CTRL-D should not close the terminal
    # bind ctrl-d delete-char
    fish_vi_key_bindings
    # usually automatically, but call to overwrite
    if functions -q fish_user_key_bindings
        fish_user_key_bindings
    end
    # Ctrl-f directory
    # Ctrl-Alt-v environment variable
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --directory=\cf --variables=\e\cv 2>/dev/null
    end

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
    abbr l y # goes to cd
    abbr ll y # goes to cd
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
    abbr wget wcurl
    abbr ai aider
    abbr aim 'aider --model anthropic/claude-sonnet-4-20250514 --message'

    alias pbcopy 'xsel --clipboard --input'
    alias pbpaste 'xsel --clipboard --output'
    alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    alias df 'duf --hide-mp /var/lib/snapd/snap/\*'
    alias du 'dust -d 1'
    alias edit nvim
    # alias gh "op plugin run -- gh"
    # alias glab "op plugin run -- glab"
    alias lf y
    alias mail cmdg
    alias Y 'sudo -E fish -c "y"'
    alias yfp y-filepicker
    alias wget wcurl

    if type -q omf
        omf theme yimmy
    end
    # zoxide init
    if type -q zoxide
        zoxide init fish | source
        abbr cd z
    end

    if type -q pyenv
        pyenv init - | source
    end

    if type -q advmv
        abbr cp 'advcp -g'
        abbr mv 'advmv -g'
    end

    if type -q exa
        alias la 'exa --all -1'
        alias ls 'exa -G --icons'
        alias lll 'ls -lT --level=1'
        alias tree 'lll -a --level=3'
    end

    if type -q tmux
        # if inside tmux refresh DBUS
        switch $TERM
            case "screen*"
                # echo "Refresh DISPLAY for xsel/tmux"
                env-refresh DISPLAY
                # echo "Refresh DBUS '$DBUS_SESSION_BUS_ADDRESS' for tmux"
                set -gx DBUS_SESSION_BUS_ADDRESS unix:path=/run/user/1000/bus
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
