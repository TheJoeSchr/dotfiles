#! /bin/env fish

mkdir ~/Downloads
mkdir ~/.config mkdir ~/.local/sources
touch ~/.vimrc.local
touch ~/.bashrc.local
touch ~/.config/Xresources.local

# IS STEAMDECK (includes running in distrobox)
set HOSTNAME (uname --nodename)
if string match 'steamdeck*' $HOSTNAME
  set is_steam true
else
  set is_steam false
end

# IS STEAMDECK METAL
if test (uname --nodename) = "steamdeck" 
  set is_steam_host true
else
  set is_steam_host false
end

if $is_steam
  printf "Host is steamdeck\n"
else
  printf "Host is not steamdeck\n"
end

# on steamdeck: first make writeable
if $is_steam_host;
  if test (read -P "Did you manually set 'passwd'?" -n 1) = "y"
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

if test (read -P "Init keys and full upgrade?" -n 1) = "y"
  # init & refresh keys
  if not $is_steam_host
  sudo env bash ~/archlinux/init-pacman-keys.sh # also does full system upgrades
  end
  if $is_steam_host
    echo "Installing holo-keyring"
    sudo pacman-key --init
    sudo pacman-key --populate archlinux
    sudo pacman-key --populate holo
    sudo pacman -Sy --noconfirm holo-keyring
    sudo pacman -S --noconfirm tmux fish nvim git
  end 
  # STEAMDECK: fix broken headers
  if $is_steam_host
    echo "Steamdeck: fixing broken headers of buildtools"
    # no --needed, doesn't updated headers
    sudo pacman -S --noconfirm gcc glibc lib32-glibc linux-headers linux-api-headers asp cmake
    # FIX ALL THE BROKEN HEADERS
    if test (read -P "Re-install all packages with missing headers?" -n 1) = "y"
      # installs packages with missing files
      cat ~/.local/sources/steam-missing.txt | sudo pacman -S -
    end
  end
end # / full upgrade


# install AUR helper:
if not command -sq "pikaur"
  if test (read -P "Install pikaur" -n 1) = "y"
  cd ~/archlinux # change PWD for ./common.sh import
    # need build tools first
    sudo env bash ~/archlinux/install-buildtools.sh
    env bash ~/archlinux/install-aur-and-mirror-helpers.sh
  cd -
  echo $PWD
  end
end


# FIRST TRY SCRIPT, MAY FAIL BECAUSE GIT SUBMODULES NOT CHECKED OUT
if test (read -P "Install CLI essentials" -n 1) = "y"
  cd ~/archlinux # change PWD for ./common.sh import
  if not $is_steam_host
    sudo env bash ~/archlinux/install-steamdeck-essentials.sh
  else
    sudo env bash ~/archlinux/install-cli-essentials.sh
  end
  cd -
  echo $PWD
end

# ESSENTIALS SYSTEM
if test (read -P "Install CLI essentials (fish, tmux, ...)" -n 1) = "y"
  pikaur -S --needed --noconfirm \
    fish \
    tmux fpp \
    # fish uses "hostname" in many scripts
    inetutils \
    #fails because of scdoc depenendy:
    neovim-remote \
    direnv \
    babashka-bin \
    ripgrep nnn jaapi-advcpmv \
    # modern cli
    bash-completion fzy fzf fd duf dust exa bottom bat procs tldr \
    python3 python-pip python-poetry \
    github-cli \
    nordvpn-bin \
    # fish z
    zoxide \

  # ESSENTIALS w/ STEAM special cases
    # eg. neovim-git htop  mosh urlview
  if $is_steam
    # googler
    pikaur -S --noconfirm googler-git \
      --overwrite "/etc/bash_completion.d/googler" \
    # sshuttle
    pikaur -S --noconfirm sshuttle  --overwrite "/usr/lib/python3.*" && \
      sudo pacman -S python

    # NVIM
    pikaur -S --noconfirm neovim-git xsel
    nvim --version # print current version
    if test (read -P "Manually install NEOVIM-GIT (version >= 7 needed)?" -n 1) = "y"
      # pikaur -S --needed neovim-git 
      cd ~/.local/sources
      pikaur -G neovim-git
      cd neovim-git
      makepkg --syncdeps --install --clean
      cd 
    end
    # MOSH
    pikaur -S --noconfirm mosh --overwrite "/etc/ufw/applications.d/mosh"
    # URLVIEW
    pikaur -S urlview --noconfirm --overwrite "/etc/urlview/*"
    # HTOP
    if test (read -P "Manually install htop?" -n 1) = "y"
      # need at least this version for current ~/.htop
      if nottest "htop 3.2.1" = (htop --version)
        pikaur -S --noconfirm --needed ncurses libnl libcap && pikaur -S htop-git

        # manually (fallback)
        htop --version
        if test (read -P "Manually install HTOP?" -n 1) = "y"
          git clone https://github.com/htop-dev/htop ~/.local/sources/htop
          cd ~/.local/sources/htop
            ./autogen.sh && \
            ./configure \
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
    if not command "nvimpager"
      if test (read -P "Manually install NVIMPAGER?" -n 1) = "y"
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
    pikaur -S \ 
      neovim-git nvimpager-git \
      mosh \
      urlview \
      googler-git \
      sshuttle \

  # keep empty line for "end"
  end
# keep empty line
end # / if cli essentials

if test (read -P "Install pip wheel pynvim autopep8 flake8?" -n 1) = "y"
  pip3 install --user wheel pynvim 
  pip3 install --user autopep8  # might fail
  pip3 install --user flake8  # might fail
end

if test (read -P "Setup fishlogin?" -n 1) = "y"
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

if test (read -P "Install fisher + theme + plugins?" -n 1) = "y"
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
  if test (read -P "Manually install OMF?" -n 1) = "y"
    mkdir -p ~/.local/sources
    cd ~/.local/sources
    git clone -c core.autocrlf=false https://github.com/oh-my-fish/oh-my-fish
    cd oh-my-fish
    bin/install --offline --noninteractive
    cd 
  end
end

# NPM / YARN / NODE / NVM
if test (read -P "Setup NPM / YARN / NODE / NVM installations?" -n 1) = "y"
  pikaur -S --noconfirm nvm
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
if test (read -P "Install CLOJURE?" -n 1) = "y"
  cd ~/.local/sources
  # build clojure
  pikaur -G clojure && \
    cd clojure/repos/community-any && \
    makepkg --noconfirm --syncdeps --clean --force && \
    sudo pacman -U --noconfirm clojure-*.pkg.tar.zst --overwrite "*" && \
  # leiningen
  gpg --receive-keys 040193357D0606ED && \
    sudo pacman -S --noconfirm readline && \
    pikaur -S --noconfirm leiningen rlwrap 
  cd ~
end

if test (read -P "Install GUI essentials (alacritty, signal, steam)" -n 1) = "y"
  # ESSENTIALS GUI & DESKTOP

  # 1. create some space on steamdeck 
  if $is_steam
    # delete unneeded docs/fonts
    pikaur -R \
      qt5-examples qt5-doc
    pikaur -R \
      noto-fonts-cjk

    # MOVE steam
    if test (read -P "Move /usr/lib/steam?" -n 1) = "y"
      sudo rsync -avzh --remove-source-files --progress /usr/lib/steam ~/.local/lib/ && \
      sudo rmdir /usr/lib/steam/steam_launcher/ && \
      sudo rmdir /usr/lib/steam/ &&  \
      sudo ln -s /home/deck/.local/lib/steam/ /usr/lib/steam
    end
    # MOVE signal-desktop
    if test (read -P "Move /usr/lib/signal-desktop?" -n 1) = "y"
       sudo rsync -avzh --remove-source-files --progress /usr/lib/signal-desktop ~/.local/lib/ && \
       sudo rm -rf /usr/lib/signal-desktop/ &&  \
       sudo ln -s /home/deck/.local/lib/signal-desktop/ /usr/lib/signal-desktop
    end
    # MOVE python3.10
    if test (read -P "Move /usr/lib/python3.10?" -n 1) = "y"
       sudo rsync -avzh --remove-source-files --progress /usr/lib/python3.10 ~/.local/lib/ && \
       sudo rm -rf /usr/lib/python3.10/ &&  \
       sudo ln -s /home/deck/.local/lib/python3.10/ /usr/lib/python3.10
    end
    # MOVE insync
    if test (read -P "Move /usr/lib/insync?" -n 1) = "y"
       sudo rsync -avzh --remove-source-files --progress /usr/lib/insync ~/.local/lib/ && \
       sudo rm -rf /usr/lib/insync/ &&  \
       sudo ln -s /home/deck/.local/lib/insync/ /usr/lib/insync
    end
    # MOVE jvm
    if test (read -P "Move /usr/lib/jvm?" -n 1) = "y"
       sudo rsync -avzh --remove-source-files --progress /usr/lib/jvm ~/.local/lib/ && \
       sudo rm -rf /usr/lib/jvm/ &&  \
       sudo ln -s /home/deck/.local/lib/jvm/ /usr/lib/jvm
    end
  end
  # 2. install GUI apps
  pikaur -S --needed --noconfirm \
    filelight \
        --overwrite "/etc/xdg/filelightrc" \
    kdeconnect \
        --overwrite "/etc/xdg/autostart/org.kde.kdeconnect.daemon.desktop" \
    google-chrome kdialog \
        --overwrite "/opt/google/chrome/*" \
    # xclip is for alacritty \
    alacritty xclip \
    yakuake \
    # 1password:
    1password-cli \
    1password-beta \
        --overwrite "/opt/1Password/*" \
    # vscode
    # (needed for sync auth)
    gnome-keyring libsecret libgnome-keyring \
        --overwrite "/etc/xdg/autostart/gnome-keyring-*" \
    visual-studio-code-bin \
        --overwrite "/opt/visual-studio-code/*" \
    # unify for logitech setpoint
    ltunify \
    # FONTS
    powerline-fonts ttf-inconsolata ttf-joypixels nerd-fonts-hack \
    # MAYBE NOT SO ESSENTIAL...
    zathura \
    signal-desktop \
    cpupower-gui cpupower \
        --overwrite "/etc/cpupower_gui*" \
    insync \

  if not $is_steam
    pikaur -S --needed --noconfirm \
      latte-dock-git \
      noto-fonts \

    pikaur -S --needed --noconfirm \
      kwin-bismuth-bin \
      appimagelauncher-git \

  else
    # KWIN-BISMUTH
    if test (read -P "Manually install KWIN-BISMUTH?" -n 1) = "y"
      cd ~/.local/sources
      pikaur -G kwin-bismuth
      cd kwin-bismuth
      # maybe?
      pikaur -S --noconfirm cmake ninja esbuild extra-cmake-modules
      sudo pacman -S \
       plasma-framework \
       qt5-script qt5-svg qt5-declarative \
       extra-cmake-modules \
       plasma \
       kdecoration \
       kconfig kcoreaddons \
       kconfigwidgets \
       kcodecs \
       kwidgetsaddons \
       kglobalaccel \
       kauth ki18n \
       kdeclarative  && \

      makepkg --noconfirm --syncdeps --install --clean
    end

    # APPIMAGELAUNCHER
    if test (read -P "Manually install APPIMAGELAUNCHER?" -n 1) = "y"
      cd ~/.local/sources/
      pikaur -G appimagelauncher-git
      cd appimagelauncher-git
      sudo pacman -S libxpm lib32-glibc make cmake glib2 cairo librsvg zlib sysprof
      makepkg --noconfirm  --syncdeps --install --clean
      cd ~
    end

    # CMDG
    if test (read -P "Manually install CMDG?" -n 1) = "y"
      git clone https://github.com/JoeSchr/cmdg.git ~/.local/sources/cmdg
      cd ~/.local/sources/cmdg
      pikaur -S go --noconfirm
      go build ./cmd/cmdg
      sudo cp cmdg /usr/local/bin
      # press Ctrl-A u to open urls in mail
      pikaur -S --noconfirm urlview lynx \
        --overwrite "/etc/lynx.lss"
      pikaur -R go
      cd ~
    end

    # 1PASSWORD
    if test (read -P "Manually install 1PASSWORD?" -n 1) = "y"
      cd ~/.local/sources/
      curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
      git clone https://aur.archlinux.org/1password.git
      cd 1password &&  makepkg -si
      cd ~
    end
  end
end # GUI essentials

if test (read -P "Install ta-lib" -n 1) = "y"
# TA-LIB
cd ~/Downloads \
  && wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
  && tar xvzf ta-lib-0.4.0-src.tar.gz \
  && cd ta-lib \
  && sed -i.bak "s|0.00000001|0.000000000000000001 |g" src/ta_func/ta_utility.h \
  && ./configure --prefix=/usr/local \
  && make \
  && sudo make install \ && cd .. \
  && mv ta-lib/ ~/.local/sources/ta-lib \

end

# MANUALLY powerline fonts
if test (read -P "Manually install POWERLINE-FONTS?" -n 1) = "y"
  cd ~/Downloads
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
  cd ~/Downloads
end

if not $is_steam

  if test (read -P "Install docker/podman" -n 1) = "y"
    # DOCKER/PODMAN
    pikaur -S --noconfirm podman catatonit crun
    # needed for cgroups
    # see: https://wiki.archlinux.org/index.php/Podman
    sudo touch /etc/sub{u,g}id
    sudo  usermod --add-subuids 165536-231072 --add-subgids 165536-231072 (whoami)
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


  if test (read -P "Install qemu/libwirt" -n 1) = "y"
    pikaur -S libvirt qemu qemu-arch-extra
    sudo pacman -Syu ebtables dnsmasq
    sudo systemctl restart libvirtd
  end

  # MANUAL/LOCAL BUILDS
  # CUSTOM KERNEL
  if test (read -P "Install xenomod" -n 1) = "y"
    ## xenomod
    gpg --receive-keys 38DBBDC86092693E
    pikaur -S linux-manjaro-xanmod linux-manjaro-xanmod-headers
    sudo ln -s /usr/src/linux-manjaro-xanmod  /usr/src/linux
  end

  if test (read -P "Install nvidia-beta driver?" -n 1) = "y"
    # install beta, because of DKMS
    pikaur -Sy nvidia-beta-dkms xorg-server-devel lib32-nvidia-utils-beta nvidia-settings-beta opencl-nvidia-beta
    sudo groupadd plugdev
    sudo usermod -aG plugdev $USER
  end
end


# chrome-remote-desktop
if test (read -P "Install chrome-remote-desktop?" -n 1) = "y"
  cd ~/Downloads
  pikaur -S chrome-remote-desktop --noconfirm
  if type -q "chrome-remote-desktop-patch"
    chrome-remote-desktop-patch
  else
    cp /opt/google/chrome-remote-desktop/chrome-remote-desktop .
    patch -i chrome-remote-desktop--use_existing_session.patch chrome-remote-desktop
    sudo cp ./chrome-remote-desktop /opt/google/chrome-remote-desktop/chrome-remote-desktop
  end
end

# TWEAKS
if not $is_steam
  if test (read -P "Fix ntfs-3g disk access? on mount as user?" -n 1) = "y"
    # fix ntfs-3g disk access on mount as user
    sudo usermod -a -G disk (whoami)
  end
  if test (read -P "Install system76 scheduler?" -n 1) = "y"
    # System76 scheduler
    pikaur -S system76-scheduler-git --noconfirm
    sudo systemctl enable --now com.system76.Scheduler.service
  end
end

if test (read -P "Increase number of file watchers?" -n 1) = "y"
  # increase number of file watcher
  echo fs.inotify.max_user_watches=1048576 | sudo tee -a /etc/sysctl.d/50-max_user_watches.conf && sudo touch /etc/sysctl.conf && sudo sysctl -p
end

# fix .ssh
if test (read -P "Fix .ssh/* permisssions" -n 1) = "y"
  chmod 600 "~/.ssh/*"
end

if test (read -P "Fix moonlander rules?" -n 1) = "y"
  # moonlander
  sudo touch /etc/udev/rules.d/50-oryx.rules

  echo "
   # Rule for all ZSA keyboards
   SUBSYSTEM==\"usb\", ATTR{idVendor}==\"3297\", GROUP=\"plugdev\"
   # Rule for the Moonlander
   SUBSYSTEM==\"usb\", ATTR{idVendor}==\"3297\", ATTR{idProduct}==\"1969\", GROUP=\"plugdev\"
   "| sudo tee -a /etc/udev/rules.d/50-oryx.rules

  sudo touch /etc/udev/rules.d/50-wally.rules
  echo "
  # STM32 rules for the Moonlander and Planck EZ
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
    MODE:="0666", \
    SYMLINK+="stm32_dfu"
   "| sudo tee -a /etc/udev/rules.d/50-wally.rules

end
if test (read -P "Fix groups for nordvpn, 1password, docker?" -n 1) = "y"
  # nordvpn
  sudo groupadd -r nordvpn
  sudo systemctl enable --now nordvpnd.service
  sudo gpasswd -a (whoami) nordvpn

  # 1password
  sudo groupadd onepassword-cli
  sudo chown root:onepassword-cli (which op) && \
  sudo chmod g+s (which op)

  # DOCKER (REFRESH GROUP)
  # needs to be at end, because it sources .bashrc again
  # DOCKER
  sudo groupadd docker
  sudo usermod -aG docker (whoami)
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo chown (id -u):(id -g) /var/run/docker.sock
  newgrp docker
end

# DELETE UNNEEDED PACKAGES
if test (read -P "Remove all unneeded packages?" -n 1) = "y"
  sudo pacman -Rs (pacman -Qtdq)
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
