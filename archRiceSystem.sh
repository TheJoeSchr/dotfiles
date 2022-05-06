#! /bin/fish

mkdir ~/Downloads
mkdir ~/.config
touch ~/.vimrc.local
touch ~/.bashrc.local
touch ~/.config/Xresources.local

# install buildtools like eg. git make libffi glibc gcc
sudo pacman -S base-devel 
sudo pacman -S git ed python python-pip 
# LAST RESORT RESET
# # update mirror-list
# pacman-mirrors -g
# # update keydatabases
# sudo rm -R /etc/pacman.d/gnupg
# sudo rm -R /root/.gnupg sudo dirmngr </dev/null

# sudo pacman-key --init
# sudo pacman-key --populate archlinux manjaro
# sudo pacman -Sy gnupg archlinux-keyring manjaro-keyring
# sudo pacman-key --refresh-keys
# sudo systemctl start pacman-init
# # update databases
# sudo pacman -Fy
# sudo pacman -Syy

read -p "Is AUR support in \'Add/Remove Software\' enabled?" -n 1 -r 
# install AUR helper:
# try automatic
sudo pamac install paru

# manual
pip install --user commonmark wheel pyalpm

# update all
sudo pacman -Syu

# risky/estoric on arm
paru -S  ntfs-3g-fuse
# ESSENTIALS SYSTEM
paru -S --noconfirm neovim ripgrep npm nvm tmux urlview python3 python-pip autopep8 mosh htop \
  bash-completion fish fzy fzf nodejs procs tldr fd duf dust exa bat nvimpager-git neovim-remote \
  direnv
pip3 install --user wheel pynvim 
pip3 install --user autopep8  # might fail
pip3 install --user flake8  # might fail


# FISH DEFAULT SHELL

# 1. Copy this file to /usr/local/bin/fishlogin
sudo ln -s ~/.local/bin/fishlogin /usr/local/bin/fishlogin
# 2. Make it executable:
sudo chmod +x /usr/local/bin/fishlogin
# 3. Add it to /etc/shells
echo /usr/local/bin/fishlogin | sudo tee -a /etc/shells
# 4. Switch your login shell
chsh -s /usr/local/bin/fishlogin $USER
# source: https://superuser.com/a/1046884

# FISHER fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'

# omf
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# omf theme
fish -c 'omf install yimmy'
# fzf
fish -c 'fisher install PatrickF1/fzf.fish'
# ssh-agent
fish -c 'fisher install danhper/fish-ssh-agent'

fish -c 'fisher install jethrokuan/z'
fish -c 'fisher install jorgebucaran/replay.fish'
fish -c 'fisher install andreiborisov/sponge'
fish -c 'fisher install gazorby/fish-abbreviation-tips'

# MANUAL: install OH-MY-FISH
# cd ~/Downloads
 git clone -c core.autocrlf=false https://github.com/oh-my-fish/oh-my-fish
 cd oh-my-fish
 bin/install --offline

# NPM / YARN / NODE / NVM
nvm install --lts
nvm use --lts
nvm alias default 12
nvm use default
npm install -G yarn
cd ~
# install nvm for fish
mkdir -p ~/.local/share/nvm
fish -c 'fisher install jorgebucaran/nvm.fish'


#INSTALL GUI & RICE
# ESSENTIALS DESKTOP
paru -S --noconfirm kwin-bismuth latte-dock-git signal-desktop cpupower-gui cpupower google-chrome zathura
# VSCODE
paru -S --noconfirm visual-studio-code-bin 

# FONTS
paru -Sy noto-fonts powerline-fonts ttf-inconsolata ttf-joypixels nerd-fonts-hack
# powerline fonts
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
cd ~/Downloads

# DOCKER/PODMAN
paru -S --noconfirm podman catatonit crun
# needed for cgroups
# see: https://wiki.archlinux.org/index.php/Podman
sudo touch /etc/sub{u,g}id
sudo  usermod --add-subuids 165536-231072 --add-subgids 165536-231072 (whoami)
# add dockerhub
echo "[registries.search]
registries = ['docker.io']" | sudo tee -a /etc/containers/registries.conf

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-(uname -s)-(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# TA-LIB
cd ~/Downloads \
  && wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
  && tar xvzf ta-lib-0.4.0-src.tar.gz \
  && cd ta-lib \
  && sed -i.bak "s|0.00000001|0.000000000000000001 |g" src/ta_func/ta_utility.h \
  && ./configure --prefix=/usr/local \
  && make \
  && sudo make install \
  && cd .. \
  && mv ta-lib/ ~/.local/sources/ta-lib \

# TWEAKS
# increase number of file watcher
echo fs.inotify.max_user_watches=1048576 | sudo tee -a /etc/sysctl.d/50-max_user_watches.conf && sudo touch /etc/sysctl.conf && sudo sysctl -p

# fix ntfs-3g disk access on mount as user
sudo usermod -a -G disk (whoami)

# fix vscode signin isues
paru -S --nonconfirm qtkeychain gnome-keyring

# fix .ssh
chmod 600 .ssh/*

# bluetooth a2dp
# paru -Sy pulseaudio-bt-auto-enable-a2dp pulseaudio-bluetooth
# equalizer
paru -Sy pulseeffects
# unify for logitech setpoint
paru -S --noconfirm ltunify
# NVIDIA INTEL HYBRID STUFF
# sudo mhwd -i pci video-hybrid-intel-nvidia-450xx-prime
# paru -S cuda vulkan-mesa-layers vulkan-intel lib32-vulkan-intel  lib32-amdvlk  lib32-nvidia-utils  lib32-vulkan-mesa-layers
# sudo mhwd -r pci video-nvidia-455xx
# sudo paru -S lib32-opencl-nvidia-455xx opencl-nvidia

# sudo paru -S nvidia-dkms-beta vulkan-mesa-layers lib32-vulkan-intel lib32-nvidia-utils-beta lib32-vulkan-mesa-layers

# OPEN SHIFT
# Minishift & OC Cli
paru -Sy minishift origin-client
# ODO Cli
sudo curl -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64 -o /usr/local/bin/odo
sudo chmod +x /usr/local/bin/odo

# openshift crc
# install `crc` first from here:
# https://access.redhat.com/documentation/en-us/red_hat_codeready_containers/1.20/html/getting_started_guide/using-codeready-containers_gsg
# https://wiki.archlinux.org/index.php/OpenShift#openshift_v4

# INSTALL
paru -S libvirt qemu qemu-arch-extra
sudo pacman -Syu ebtables dnsmasq
sudo systemctl restart libvirtd
# CRC SETUP
crc setup
crc start

# nordvpn
paru -Syu --noconfirm nordvpn-bin
sudo groupadd -r nordvpn
sudo systemctl enable --now nordvpnd.service
sudo gpasswd -a (whoami) nordvpn

# cmdg
cd ~/Downloads
git clone https://github.com/JoeSchr/cmdg.git ~/.local/sources/cmdg
cd ~/.local/sources/cmdg
paru -S go --noconfirm
go build ./cmd/cmdg
sudo cp cmdg /usr/local/bin
# press Ctrl-A u to open urls in mail
paru -S --noconfirm urlview
cd ~/Downloads

cd ~/Downloads/
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git
cd 1password &&  makepkg -si
# CUSTOM KERNEL

## xenomod
gpg --receive-keys 38DBBDC86092693E
paru -S linux-manjaro-xanmod linux-manjaro-xanmod-headers
sudo ln -s /usr/src/linux-manjaro-xanmod  /usr/src/linux

# install beta, because of DKMS
paru -Sy nvidia-beta-dkms xorg-server-devel lib32-nvidia-utils-beta nvidia-settings-beta opencl-nvidia-beta

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

sudo groupadd plugdev
sudo usermod -aG plugdev $USER

# DOCKER (REFRESH GROUP)
# needs to be at end, because it sources .bashrc again
# DOCKER
sudo groupadd docker
sudo usermod -aG docker (whoami)
sudo systemctl enable docker
sudo systemctl start docker
sudo chown (id -u):(id -g) /var/run/docker.sock
newgrp docker

cd ~/Downloads
paru -S chrome-remote-desktop --noconfirm
cp /opt/google/chrome-remote-desktop/chrome-remote-desktop .
patch -i chrome-remote-desktop--use_existing_session.patch chrome-remote-desktop
sudo cp ./chrome-remote-desktop /opt/google/chrome-remote-desktop/chrome-remote-desktop

# System76 scheduler
pikaur -S system76-scheduler-git --noconfirm
sudo systemctl enable --now com.system76.Scheduler.service
