# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================
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
# test for browser so it works with flatpak or native, and set BROWSER accordingly
if type -q google-chrome-stable
    set -gx BROWSER google-chrome-stable
end
if type -q google-chrome
    set -gx BROWSER google-chrome
end
# `-q` => grep silent
# without 'Cc' for casing
if flatpak list | grep -q hrome
    set -gx BROWSER "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/chrome com.google.Chrome"
end

set -gx DELTA_FEATURES diff-so-fancy
# always try to set DISPLAY
# set -q DISPLAY; or set -gx DISPLAY ":0"

# =============================================================================
# PATH SETUP
# =============================================================================
fish_add_path ~/.bun/bin
fish_add_path ~/.config/composer/vendor/bin
fish_add_path ~/.pub-cache/bin/
fish_add_path ~/.docker/cli-plugins/
fish_add_path ~/.krew/bin/
# masons bin to have all formatters and linters also available in fish
fish_add_path ~/.local/share/nvim/mason/bin/
if [ ! -f /run/.containerenv ] && [ ! -f /.dockerenv ]
    fish_add_path ~/.local/bin
    fish_add_path ~/.local/podman/bin
end

# =============================================================================
# INTERACTIVE SESSION
# =============================================================================
if status --is-interactive
    echo "Starting fish shell interactively..."
    set HOSTNAME (uname --nodename)
    if test (uname --nodename) = steamdeck
        set is_steam_host true
    else
        set is_steam_host false
    end

    # 1. Native Tool Hooks (No Fisher plugins required)
    # using `psub` instead of direct `xy | source` 
    # for bettererror handling
    # command fails won't break the shell
    if type -q rbenv
        source (rbenv init - fish | psub)
    end
    if type -q mise
        source (mise activate fish | psub)
    end
    if type -q fnm
        source (fnm env --use-on-cd | psub)
    end
    if type -q fzf
        source (fzf --fish | psub)
    end
    if type -q zoxide
        source (zoxide init fish | psub) && abbr cd z
    end
    # use `uv` instead
    # if type -q pyenv
    #     source (pyenv init - | psub)
    # end

    if type -q uv
        # for DEBUG
        # echo "uv found, setting up auto-activation for uv virtualenvs..."
        # Auto-activate uv virtualenv
        function __auto_activate_venv --on-variable PWD
            if test -f .venv/bin/activate.fish
                source .venv/bin/activate.fish
            end
        end
    end

    # omf is unmainted for years, don't use it:
    # - using own prompt at `functions/fish_prompt.fish` now instead
    # - `omf destroy` to remove
    # if type -q omf
    #     # omf theme yimmy
    #     omf theme default
    # end

    # 2. Key Bindings & UI
    # CTRL-D should not close the terminal
    # bind ctrl-d delete-char
    fish_vi_key_bindings
    # usually automatically, but call to overwrite
    if functions -q fish_user_key_bindings
        fish_user_key_bindings
    end

    if functions -q fzf_configure_bindings
        # Ctrl-f directory
        # Ctrl-Alt-v environment variable
        fzf_configure_bindings --directory=\cf --variables=\e\cv
        # Setting fd as the default source for fzf
        set -gx FZF_DEFAULT_COMMAND 'fd --type f'
    end

    # 3. Abbreviations & Aliases
    # need `:` for multiline comment
    : '
THE THREE TYPES OF ALIAS
==============================

 - alias:
    Make a something functionally equivalent to something else. This holds true if you press return, chain things together, pipe, redirect, and such. In recent versions of fish, context aware tab completion will work here too.

 - abbr:
    Type something and have it expanded into something else after pressing space or semicolon (but not return). The new hotness.

    Abbreviations are stored in a variable named fish_user_abbreviations. This is automatically created as a universal variable the first time an abbreviation is created. If you want your abbreviations to be private to a particular fish session you can put the following in your *~/.config/fish/config.fish* file before you define your first abbrevation:
    # set -g fish_user_abbreviations

    You can create abbreviations directly on the command line and they will be saved automatically and made visible to other fish sessions if fish_user_abbreviations is a universal variable. If you keep the variable as universal, abbr --add statements in config.fish will do nothing but slow down startup slightly.

 - function:
    Make something functionally equivalent to one or more something elses, and optionally permute data that are being worked on with (argv).Strictly speaking, alias is itself just an alias for a function that blindly accepts argv and tacks them to the end of its something else. But this pattern is so prolific that it got its own name, so we will consider it unique for today.
'
    # no upgrade by default for steamdeck
    if not $is_steam_host
        abbr upgrade 'VISUAL=nvim pikaurspeed -Syu --devel --needed --noconfirm'
    else
        abbr upgrade 'VISUAL=nvim pikaurspeed -Su --devel --needed --noconfirm'
    end

    abbr ai 'aider --read ~/.aider/AGENTS.md --no-gitignore --watch-files'
    abbr c config
    abbr ca 'config add '
    abbr ccc 'config ci'
    abbr cf config
    abbr cs 'config st'
    abbr db distrobox
    abbr e nvim
    abbr edit nvim
    abbr fda 'fd -uu'
    abbr find 'fd -uu'
    abbr G git
    abbr g git
    abbr ga 'git add'
    abbr gl 'PAGER=/usr/bin/less git lg'
    abbr gla 'PAGER=/usr/bin/less git lga'
    abbr gs 'git st'
    abbr gh "op plugin run -- gh"
    abbr glab "op plugin run -- glab"
    abbr install 'pikaur -S --needed --noconfirm'
    abbr lal 'la -l'
    abbr l y # goes to cd
    abbr ll y # goes to cd
    abbr n nvim
    abbr poetry 'SHELL=(which fish) poetry'
    abbr psax procs
    abbr piks 'VISUAL=nvim pikaurspeed'
    abbr pikss 'VISUAL=nvim pikaurspeed -S'
    # alias pikss
    abbr piss 'VISUAL=nvim pikaurspeed -S'
    abbr piksy 'pikaurspeed -S --noconfirm'
    # alias piksy
    abbr pyes 'pikaurspeed -S --noconfirm'
    # ...g because --rebuild is mostly needed for -git packages
    abbr piksg 'VISUAL=nvim pikaurspeed -S --rebuild'
    # alias piksg
    abbr pig 'VISUAL=nvim pikaurspeed -S --rebuild'
    abbr pir 'pikaur -R --noconfirm'
    abbr reboot-linux 'sudo grub-reboot "Manjaro Linux"'
    abbr rg 'rg -S'
    abbr rmp rip
    abbr rsync-mv 'rsync -avzh --remove-source-files --progress'
    abbr ssh-add-all 'ssh-add ~/.ssh/id_rsa_*'
    # tmux attach
    abbr ta "tmux a"
    abbr upgrade-paru 'paru -Syu --skipreview --useask --noconfirm'
    abbr vimdiff "$EDITOR -d"
    abbr vultr 'vultr-cli --config ~/vultr-cli.yaml'
    abbr wget wcurl
    # abbr y is in functions/y.fish; and functions -q y; and functions y
    if functions -q y
        abbr Y 'sudo -E fish -c "y"'
        abbr yfp y-filepicker
    end

    alias pbcopy 'xsel --clipboard --input'
    alias pbpaste 'xsel --clipboard --output'
    alias config 'git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    alias df 'duf --hide-mp /var/lib/snapd/snap/\*'
    alias du 'dust -d 1'
    alias mail aerc

    # 4. SSH Agent bridge (Fisher plugin)
    if functions -q fish_ssh_agent
        fish_ssh_agent
    end

    if type -q pgcli
        abbr pgcli 'VISUAL=nvim pgcli'
    end

    if type -q advmv
        abbr cp 'advcp -g'
        abbr mv 'advmv -g'
    end

    if type -q exa
        alias la 'exa --all -1'
        alias ls 'exa -G --icons'
        alias lll 'ls -lT --level=1'
        alias llla 'ls -alT --level=1'
        alias tree 'exa -G --icons -T --level=3'
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

    # 5. Tool Loaders (Mamba, etc)
    # >>> mamba initialize (LAZY LOADED) >>>
    if type -q micromamba
        set -gx MAMBA_EXE (command -v micromamba)
        set -gx MAMBA_ROOT_PREFIX "$HOME/micromamba"

        function __mamba_lazy_init
            if not set -q --global __MAMBA_INITIALIZED
                set -gx __MAMBA_INITIALIZED 1
                source ($MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFX | psub)
            end
        end

        function micromamba
            __mamba_lazy_init
            micromamba $argv
        end

        function conda
            __mamba_lazy_init
            conda $argv
        end

        function mamba
            __mamba_lazy_init
            mamba $argv
        end
    end
    # <<< mamba initialize <<<

    # print big banner to visually confirm it's an interactive shell, and also for fun
    #
    function joe_banner
        if type -q figlet; and type -q lolcat
            figlet -t "JOE'S FIS4" | lolcat -a -d 3
        else
            echo "(╯°□°）╯︵ ┻━┻"
            echo ""
            echo "❌ WARNING: Big Banner skipped!❌"
            echo "🛠️\`figlet\` or \`lolcat\` not found."
        end
    end

    # orint bfg banner
    joe_banner

    # orint escaoenhatch anywsyd
    echo ""
    echo "⚠️ ============================================="
    echo ""
    echo "⚠️ ESCAPE HATCH: (╯°□°）╯︵ ┻━┻"
    echo "   ............................................."
    echo "⚠️ `bash --norc` || `bash -`"
    echo "   ............................................."
    echo "⚠️ ============================================="
    echo ""
end # /(INTERACTIVE)
# 6. Non-interactive Hooks

# always including noninteractive:
if type -q direnv
    # previously used, but if direnv fails to load, it can break the shell
    # eval (direnv hook fish) 
    source (direnv hook fish | psub)
end
