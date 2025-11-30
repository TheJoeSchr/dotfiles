#! /bin/env fish

# A collection of functions to setup an Arch Linux system.
# It is interactive and asks for confirmation before performing actions.
# scope env vars
begin
# Setup environment variables for optimized build
set -gx CFLAGS "-O2 -march=native -flto"
set -gx CXXFLAGS "-O2 -march=native -flto"
set -gx RUSTFLAGS "-C opt-level=2 -C target-cpu=native -C lto=fat"
set -gx MAKEFLAGS "-j$(nproc)"
set -gx USE_CCACHE 1
set -gx CCACHE_DIR "$HOME/.ccache"
if command -sq ccache
    ccache -M 10G # allocate 10GB cache
end

printf "✅ Environment configured for optimized builds.\n"
printf "Using %s threads and CPU-specific optimizations:\n" "$MAKEFLAGS"
printf "  CFLAGS:    %s\n" "$CFLAGS"
printf "  CXXFLAGS:  %s\n" "$CXXFLAGS"
printf "  RUSTFLAGS: %s\n" "$RUSTFLAGS"

function install -d "Install packages using pikaur with optimizations"
    pikaur -S --needed --noconfirm $argv
end

function ask -d "Ask for confirmation"
    read -P "$argv[1] " -n 1 confirm
    echo
    test "$confirm" = y
end

mkdir -p ~/Downloads
mkdir -p ~/.config ~/.local/sources
touch ~/.vimrc.local
touch ~/.bashrc.local
touch ~/.config/Xresources.local

# IS STEAMDECK (includes running in distrobox)
set -l HOSTNAME (uname --nodename)
set -g is_steam false
if string match -q 'steamdeck*' $HOSTNAME
    set is_steam true
end

# IS STEAMDECK METAL
set -g is_steam_host false
if test "$HOSTNAME" = steamdeck
    set is_steam_host true
end

if test "$is_steam" = true
    printf "Host is steamdeck\n"
else
    printf "Host is not steamdeck\n"
end

# on steamdeck: first make writeable
if test "$is_steam_host" = true
    if ask "Did you manually set 'passwd'?"
        # make writeable
        sudo steamos-readonly disable
        # enable ssh access
        sudo systemctl enable --now sshd
        # disable wifi powersave for lagfree ssh
        sudo iw dev wlan0 set power_save off
        # fix permission problems for X11 sockets for distrobox
        sudo cp ~/scripts/fix_tmp_x11.sh /etc/profile.d/
    else
        exit
    end
end #/steamdeck

if ask "Init keys ( and full upgrade on NON steamdeck)?"
    # init & refresh keys
    if not test "$is_steam_host" = true
        sudo env bash ~/archlinux/init-pacman-keys.sh # also does full system upgrades
    end
    if test "$is_steam_host" = true
        echo "Installing holo-keyring"
        sudo pacman-key --init
        sudo pacman-key --populate archlinux
        sudo pacman-key --populate holo
        sudo pacman -Sy --noconfirm holo-keyring
        sudo pacman -S --noconfirm tmux fish neovim git
        sudo pacman -Sy --noconfirm
    end
    # STEAMDECK: fix broken headers
    if test "$is_steam_host" = true
        echo "Steamdeck: fixing broken headers of buildtools"
        # no --needed, doesn't updated headers
        sudo pacman -S --noconfirm gcc glibc lib32-glibc linux-headers linux-api-headers cmake ncurses
        # FIX ALL THE BROKEN HEADERS
        if ask "Re-install all packages with missing headers?"
            # installs packages with missing files
            cat ~/.local/sources/steam-missing.txt | sudo pacman -S --noconfirm -
        end
    end
end # / full upgrade

if ask "Rank mirrors?"
    env bash ~/archlinux/install-aur-and-mirror-helpers.sh rank_mirrors
end

# install AUR helper:
if not command -sq pikaur
    if ask "Install pikaur"
        if test "$is_steam_host" = true
            # need build tools first
            sudo env bash ~/archlinux/install-buildtools.sh
            cd ~/.local/sources/
            git clone https://aur.archlinux.org/pikaur.git
            cd pikaur
            # pikaur > 1.20 needed python^3.12
            # git checkout 75bc4f07
            makepkg -si
            cd ~/archlinux/
        else
            # need build tools first
            sudo env bash ~/archlinux/install-buildtools.sh
            env bash ~/archlinux/install-aur-and-mirror-helpers.sh
        end
        echo $PWD
    end
end

if test "$is_steam_host" = true
    if ask "Install steamos-btrfs"
        set t "$(mktemp -d)"
        curl -sSL https://gitlab.com/popsulfr/steamos-btrfs/-/archive/main/steamos-btrfs-main.tar.gz | tar -xzf - -C "$t" --strip-components=1
        "$t/install.sh"
        env rm -rf "$t"
    end
end

if ask "Install advcpmv"
    set t "$(mktemp -d)"
    curl https://raw.githubusercontent.com/jarun/advcpmv/master/install.sh --create-dirs -o $t/advcpmv/install.sh; and begin
        cd $t/advcpmv; and sh install.sh; and mv $t/advcpmv/advcp $HOME/.local/bin/; and mv $t/advcpmv/advmv $HOME/.local/bin/
    end
    env rm -rf "$t"
end

# FIRST TRY SCRIPT, MAY FAIL BECAUSE GIT SUBMODULES NOT CHECKED OUT
if ask "Install CLI essentials (and GUI on steamdeck)"
    install rustup
    # prep for rust based pkgs e.g. fish-git, yazi-git
    rustup default stable
    if test "$is_steam_host" = true
        echo "~/archlinux/install-steamdeck-essentials.sh"
        env bash ~/archlinux/install-steamdeck-essentials.sh
    else
        echo "~/archlinux/install-cli-essentials.sh"
        env bash ~/archlinux/install-cli-essentials.sh
        if ask "Install cli-extra?"
            echo "~/archlinux/install-cli-extra.sh"
            env bash ~/archlinux/install-cli-extra.sh

        end
    end
end

# ESSENTIALS SYSTEM
if ask "Manually install CLI essentials (fish, zoxide, exa, tmux, ...)"
    install rustup
    # prep for rust based pkgs e.g. fish-git, yazi-git
    rustup default stable
    install \
        fish-git \
        tmux \
        # fish uses "hostname" in many scripts
        inetutils \
        # folder watchers
        inotify-tools \
        #fails because of scdoc depenendy:
        neovim-remote \
        direnv \
        babashka-bin \
        ripgrep \
        # modern cli
        fzf fd duf dust exa bottom bat procs tldr rm-improved-bin \
        python3 python-pip python-pipx uv python-poetry \
        yazi-git \
        # fish z
        zoxide
    # sshuttle neovim-nightly see below for steamdeck special case

    # ESSENTIALS w/ STEAM special cases
    # eg. neovim-git htop  mosh urlview
    if test "$is_steam" = true
        # sshuttle
        install sshuttle --overwrite "/usr/lib/python3.*" && sudo pacman -S python

        # NVIM
        install neovim-nightly tree-sitter-cli xsel
        nvim --version # print current version
        if ask "Manually install NEOVIM-GIT (version >= 7 needed)?"
            # pikaur -S --needed neovim-git 
            cd ~/.local/sources
            pikaur -G neovim-nightly
            cd neovim-nightly
            makepkg --syncdeps --install --clean
            cd
        end
        # URLVIEW
        install urlview --overwrite "/etc/urlview/*"
        # HTOP
        if ask "Manually install htop?"
            # need at least this version for current ~/.htop
            if not test "htop 3.2.1" = (htop --version)
                install ncurses libnl libcap && install htop-git

                # manually (fallback)
                htop --version
                if ask "Manually install HTOP?"
                    git clone https://github.com/htop-dev/htop ~/.local/sources/htop
                    cd ~/.local/sources/htop
                    ./autogen.sh && ./configure \
                        --prefix=/usr \
                        --sysconfdir=/etc \
                        --enable-unicode \
                        --enable-openvz \
                        --enable-vserver
                    sudo make install
                    cd ~
                end
            end
        end
        # NVIMPAGER
        if not command nvimpager
            if ask "Manually install NVIMPAGER?"
                cd ~/Downloads
                git clone https://git.sr.ht/~sircmpwn/scdoc
                cd scdoc
                make
                sudo make install
                cd ~/Downloads
                git clone https://github.com/lucc/nvimpager
                cd nvimpager/
                make PREFIX=$HOME/.local/bin install
                cd ~
                rm -rf ~/Downloads/nvimpager ~/Downloads/scdoc
            end
        end
    else # not steam should just work
        install \
            neovim-nightly tree-sitter-cli xsel nvimpager \
            urlview sshuttle
        # keep empty line for "end"
    end
    # keep empty line
end # / if cli essentials

if ask "Install pip wheel pynvim autopep8 flake8?"
    pip3 install --user wheel pynvim
    pip3 install --user autopep8 # might fail
    pip3 install --user flake8 # might fail
end

if ask "Setup fishlogin?"
    # FISH DEFAULT SHELL
    # 1. Copy this file to /usr/local/bin/fishlogin
    sudo ln -s ~/.local/bin/fishlogin /usr/local/bin/fishlogin
    # 2. Make it executable:
    sudo chmod +x /usr/local/bin/fishlogin
    # 3. Add it to /etc/shells
    echo /usr/local/bin/fishlogin | sudo tee -a /etc/shells
    # 4. print Instructions
    printf "4. Switch your login shell:\n
  chsh -s /usr/local/bin/fishlogin $USER\n
  # source: https://superuser.com/a/1046884\n"
end

if ask "Install fisher + theme + plugins?"
    # fix weird symbols when connecting via JuiceSSH
    # set -Ua fish_features no-keyboard-protocols
    # FISHER 
    fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'

    # fzf
    fish -c 'fisher install PatrickF1/fzf.fish'

    # ssh-agent
    # fish -c 'fisher install danhper/fish-ssh-agent'

    # zoxide: fish helper
    # use:
    # z alias cd
    # zi => interactive
    fish -c 'fisher install jethrokuan/z'

    # replay: take bash commands and use return value
    # e.g.:  replay "source /usr/share/nvm.sh --no-use && nvm use latest" # installs and uses latest nvm
    fish -c 'fisher install jorgebucaran/replay.fish'

    # bass: makes it easy to use utilities written for Bash in fish shell.
    # e.g.: bass export X=3 
    fish -c 'fisher install edc/bass'

    # fish -c 'fisher install andreiborisov/sponge'
    # fish -c 'fisher install gazorby/fish-abbreviation-tips'

    # omf
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | NONINTERACTIVE=true fish
    # omf theme
    fish -c 'omf install yimmy'

    # MANUAL: install OH-MY-FISH
    if ask "Manually install OMF?"
        mkdir -p ~/.local/sources
        cd ~/.local/sources
        git clone -c core.autocrlf=false https://github.com/oh-my-fish/oh-my-fish
        cd oh-my-fish
        bin/install --offline --noninteractive
        cd
    end
end

# NPM / YARN / NODE / NVM
if ask "Setup NPM / YARN / NODE / NVM installations?"
    install nvm
    # install ~/.nvm
    bash --norc /usr/share/nvm/init-nvm.sh

    cd ~
    mkdir -p ~/.local/share/nvm
    fish -c 'fisher install jorgebucaran/nvm.fish'
    nvm install lts
    nvm use lts
    npm install -G yarn
end

# CLOJURE (steamdeck)
if ask "Install CLOJURE?"
    cd ~/.local/sources
    # build clojure
    pikaur -G clojure && cd clojure/repos/community-any && makepkg --noconfirm --syncdeps --clean --force && sudo pacman -U --noconfirm clojure-*.pkg.tar.zst --overwrite "*" && \
        # leiningen
        gpg --receive-keys 040193357D0606ED && sudo pacman -S --noconfirm readline && pikaur -S --noconfirm leiningen rlwrap
    cd ~
end

if ask "Install 1password + CLI"
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
    install --overwrite "/opt/1Password/*" 1password 1password-cli
end
# 1. create some space on steamdeck
if test "$is_steam" = true
    if ask "Create some space on steamdeck?"
        # delete unneeded docs/fonts
        pikaur -R \
            qt5-examples qt5-doc
        pikaur -R \
            noto-fonts-cjk

        # MOVE steam
        if ask "Move /usr/lib/steam?"
            sudo rsync -avzh --remove-source-files --progress /usr/lib/steam ~/.local/lib/ && sudo rmdir /usr/lib/steam/steam_launcher/ && sudo rmdir /usr/lib/steam/ && sudo ln -s /home/deck/.local/lib/steam/ /usr/lib/steam
        end
        # MOVE signal-desktop
        if ask "Move /usr/lib/signal-desktop?"
            sudo rsync -avzh --remove-source-files --progress /usr/lib/signal-desktop ~/.local/lib/ && sudo rm -rf /usr/lib/signal-desktop/ && sudo ln -s /home/deck/.local/lib/signal-desktop/ /usr/lib/signal-desktop
        end
        # MOVE insync
        if ask "Move /usr/lib/insync?"
            sudo rsync -avzh --remove-source-files --progress /usr/lib/insync ~/.local/lib/ && sudo rm -rf /usr/lib/insync/ && sudo ln -s /home/deck/.local/lib/insync/ /usr/lib/insync
        end
        # MOVE jvm
        if ask "Move /usr/lib/jvm?"
            sudo rsync -avzh --remove-source-files --progress /usr/lib/jvm ~/.local/lib/ && sudo rm -rf /usr/lib/jvm/ && sudo ln -s /home/deck/.local/lib/jvm/ /usr/lib/jvm
        end
    end
end

if ask "Install GUI essentials (ghostty, signal, steam)"
    # ESSENTIALS GUI & DESKTOP

    if not test "$is_steam" = true
        # 2. install GUI apps
        install \
            filelight \
            kdeconnect \
            google-chrome \
            # xsel is for ghostty \
            ghostty-git xsel \
            yakuake \
            # vscode
            # (needed for sync auth)
            gnome-keyring libsecret libgnome-keyring \
            visual-studio-code-bin \
            # unify for logitech setpoint
            ltunify \
            # FONTS
            powerline-fonts ttf-inconsolata ttf-joypixels ttf-hack-nerd \
            # MAYBE NOT SO ESSENTIAL...
            zathura \
            signal-desktop \
            cpupower-gui cpupower \
            insync

        install \
            noto-fonts
        install \
            appimagelauncher-git
    else
        # APPIMAGELAUNCHER
        if ask "Manually install APPIMAGELAUNCHER?"
            cd ~/.local/sources/
            pikaur -G appimagelauncher-git
            cd appimagelauncher-git
            sudo pacman -S libxpm lib32-glibc make cmake glib2 cairo librsvg zlib sysprof
            makepkg --noconfirm --syncdeps --install --clean
            cd ~
        end

        # 1PASSWORD
        if ask "Manually install 1PASSWORD?"
            cd ~/.local/sources/
            curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
            git clone https://aur.archlinux.org/1password.git
            cd 1password && makepkg -si --overwrite "/opt/1Password/*"
            cd ~
        end
    end
end # GUI essentials

if ask "Install ta-lib"
    # TA-LIB
    cd ~/Downloads \
        && wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
        && tar xvzf ta-lib-0.4.0-src.tar.gz \
        && cd ta-lib \
        && sed -i.bak "s|0.00000001|0.000000000000000001 |g" src/ta_func/ta_utility.h \
        && ./configure --prefix=/usr/local \
        && make \
        && sudo make install \  && cd .. \
        && mv ta-lib/ ~/.local/sources/ta-lib
end

# MANUALLY powerline fonts
if ask "Manually install POWERLINE-FONTS?"
    cd ~/Downloads
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
    cd ~/Downloads
end

if not test "$is_steam" = true

    if ask "Install docker/podman"
        # DOCKER/PODMAN
        pikaur -S --noconfirm podman catatonit crun
        # needed for cgroups
        # see: https://wiki.archlinux.org/index.php/Podman
        sudo touch /etc/sub{u,g}id
        sudo usermod --add-subuids 165536-231072 --add-subgids 165536-231072 $USER
        # add dockerhub
        echo "[registries.search]
    registries = ['docker.io']" | sudo tee -a /etc/containers/registries.conf

        # DOCKER-COMPOSE
        sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-(uname -s)-(uname -m) -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose

        # OPEN SHIFT
        # Minishift & OC Cli
        pikaur -Sy minishift origin-client
        # ODO Cli
        sudo curl -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64 -o /usr/local/bin/odo
        sudo chmod +x /usr/local/bin/odo

        # openshift crc
        # install `crc` first from here:
        # https://access.redhat.com/documentation/en-us/red_hat_codeready_containers/1.20/html/getting_started_guide/using-codeready-containers_gsg
        # https://wiki.archlinux.org/index.php/OpenShift#openshift_v4
        # # CRC SETUP
        # crc setup
        # crc start
    end

    # bluetooth a2dp
    # pikaur -Sy pulseaudio-bt-auto-enable-a2dp pulseaudio-bluetooth
    # equalizer
    # pikaur -Sy pulseeffects
    # NVIDIA INTEL HYBRID STUFF
    # sudo mhwd -i pci video-hybrid-intel-nvidia-450xx-prime
    # pikaur -S cuda vulkan-mesa-layers vulkan-intel lib32-vulkan-intel  lib32-amdvlk  lib32-nvidia-utils  lib32-vulkan-mesa-layers
    # sudo mhwd -r pci video-nvidia-455xx
    # sudo pikaur -S lib32-opencl-nvidia-455xx opencl-nvidia

    # sudo pikaur -S nvidia-dkms-beta vulkan-mesa-layers lib32-vulkan-intel lib32-nvidia-utils-beta lib32-vulkan-mesa-layers

    if ask "Install qemu/libwirt"
        pikaur -S libvirt qemu qemu-arch-extra
        sudo pacman -Syu ebtables dnsmasq
        sudo systemctl restart libvirtd
    end

    # MANUAL/LOCAL BUILDS
    # CUSTOM KERNEL
    if ask "Install xenomod"
        ## xenomod
        gpg --receive-keys 38DBBDC86092693E
        pikaur -S linux-manjaro-xanmod linux-manjaro-xanmod-headers
        sudo ln -s /usr/src/linux-manjaro-xanmod /usr/src/linux
    end

    if ask "Install nvidia-beta driver?"
        # install beta, because of DKMS
        pikaur -Sy nvidia-beta-dkms xorg-server-devel lib32-nvidia-utils-beta nvidia-settings-beta opencl-nvidia-beta
        sudo groupadd plugdev
        sudo usermod -aG plugdev $USER
    end
end

# chrome-remote-desktop
if ask "Install chrome-remote-desktop?"
    cd ~/Downloads
    install chrome-remote-desktop
    if type -q chrome-remote-desktop-patch
        chrome-remote-desktop-patch
    else
        cp /opt/google/chrome-remote-desktop/chrome-remote-desktop .
        patch -i chrome-remote-desktop--use_existing_session.patch chrome-remote-desktop
        sudo cp ./chrome-remote-desktop /opt/google/chrome-remote-desktop/chrome-remote-desktop
    end
end

# TWEAKS
if not test "$is_steam" = true
    if ask "Fix ntfs-3g disk access? on mount as user?"
        # fix ntfs-3g disk access on mount as user
        sudo usermod -a -G disk $USER
    end
    if ask "Install system76 scheduler?"
        # System76 scheduler
        install system76-scheduler-git
        sudo systemctl enable --now com.system76.Scheduler.service
    end
end

if ask "Increase number of file watchers?"
    # increase number of file watcher
    echo fs.inotify.max_user_watches=1048576 | sudo tee -a /etc/sysctl.d/50-max_user_watches.conf && sudo touch /etc/sysctl.conf && sudo sysctl -p
end

# fix .ssh
if ask "Fix .ssh/* permissions"
    chmod 600 "~/.ssh/*"
end

if ask "Fix moonlander rules?"
    # moonlander
    sudo ln -s ~/.local/share/50-zsa.rules /etc/udev/rules.d/50-zsa.rules

end
if ask "Fix groups for nordvpn, 1password, docker?"
    # nordvpn
    sudo groupadd -r nordvpn
    sudo systemctl enable --now nordvpnd.service
    sudo gpasswd -a $USER nordvpn

    # 1password
    sudo groupadd onepassword-cli
    sudo chown root:onepassword-cli (which op) && sudo chmod g+s (which op)

    # DOCKER (REFRESH GROUP)
    # needs to be at end, because it sources .bashrc again
    # DOCKER
    sudo systemctl stop docker
    sudo groupadd docker
    sudo usermod -aG docker $USER
    # Note that docker.service starts the service on boot, whereas docker.socket starts Docker on first usage which can decrease boot times
    sudo systemctl enable docker.socket
    sudo systemctl start docker
    sudo chown (id -u):(id -g) /var/run/docker.sock
    # creates newshell
    # newgrp docker
end

# DELETE UNNEEDED PACKAGES
if ask "Remove all unneeded packages?"
    sudo pacman -Rs (pacman -Qtdq)
end

end
#
# LAST RESORT KEY DB RESET
# # update mirror-list
# pacman-mirrors -g
# # update keydatabases
# sudo rm -R /etc/pacman.d/gnupg
# sudo rm -R /root/.gnupg
# sudo dirmngr </dev/null

# sudo pacman-key --init
# sudo pacman-key --populate
# sudo pacman -Sy gnupg archlinux-keyring manjaro-keyring
# sudo pacman-key --refresh-keys
# sudo systemctl restart pacman-init
# update databases
# sudo pacman -Fy
# sudo pacman -Syy
