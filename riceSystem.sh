#! /bin/bash

touch .vimrc.local
touch .bashrc.local

sudo apt update

sudo galliumos-update

# install ALL THE THINGS
sudo apt install -y neovim git nitrogen python3 python3-pip dmenu acpi xsel htop fonts-symbola fonts-noto-hinted fonts-powerline fonts-inconsolata
# buildtools
sudo apt install -y xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev gcc make cmake pkg-config glib-2.0 autoconf automake pkg-config libncurses5-dev libncursesw5-dev bison cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev libxcb-ewmh2

# download my dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --bare git@bitbucket.org:JozephS/dotfiles.git $HOME/.cfg

mkdir .config-backup/.ssh
mkdir --parents .config-backup/.config/vlc
mkdir -p .config-backup && config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}

config config --local status.showUntrackedFiles no
. .bashrc

# TODO download .ssh/ folder
chmod 600 .ssh/*

config  push --set-upstream origin master

#install bspwm, polybar and sxhkd
cd Downloads/

# sxhkd
git clone https://github.com/baskerville/sxhkd.git
cd sxhkd/
make
sudo make install
cd ..

# polybar
git clone https://github.com/polybar/polybar.git
cd polybar/
./build.sh

# BSPWM
git clone https://github.com/baskerville/bspwm.git
cd bspwm/
make
sudo make install
sudo cp contrib/freedesktop/bspwm.desktop /usr/share/xsessions/
cd ..
# tmux
cd ~/Downloads
git clone https://github.com/tmux/tmux.git
# tmux dependecies libevent ncurses yacc/bison
alias yacc="bison"
wget https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz
tar -xzf libevent-2.1.11-stable.tar.gz
mv libevent-2.1.11-stable libevent
cd libevent
./configure
make
# make verify   # (optional)
sudo make install
cd ..

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# install tmux
cd tmux
sh autogen.sh
./configure && make && sudo mv ./tmux /usr/bin
cd ..

# docker
sudo apt-get remove docker docker-engine docker.io containerd runc
cd ~/Downloads
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# add user to docker group so we can run it without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# nvm node-js yarn
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
mkdir ~/.nvm
bash install_nvm.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 12
nvm use 12
nvm alias default 12
nvm use default
npm install --global yarn
cd ~
rm -rf node_modules/
rm yarn.lock

# neovim (latest)
cd ~/Downloads
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage && rm /usr/bin/nvim && mv nvim.appimage /usr/bin/nvim
# neovim support
yarn global add neovim
pip3 install pynvim
# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
nvim &

#power line fonts
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# vscode
cd ~/Downloads
curl -o code.deb -L http://go.microsoft.com/fwlink/?LinkID=760868
sudo apt install ./code.deb

sudo apt remove -y xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev gcc make cmake pkg-config glib-2.0 autoconf automake pkg-config libncurses5-dev libncursesw5-dev bison cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev libxcb-ewmh2
sudo apt autoremove -y
