#! /bin/bash

# call with
# 
# curl -Lks https://github.com/JoeSchr/dotfiles/raw/master/install-cfg.sh | /bin/bash
if [[ $(uname --nodename) = "steamdeck" ]]; 
then
 # set root password
 passwd
 # make writeable
 sudo steamos-readonly disable
 # enable ssh access
 sudo systemctl enable --now sshd
fi

# upgrade system
sudo pacman-key --init
sudo pacman-key --populate 
sudo pacman-key --refresh-keys
sudo pacman -Syu --noconfirm
# install essentials
sudo pacman -Sy --noconfirm git which rsync fish neovim fzf base-devel

git clone --bare https://github.com/JoeSchr/dotfiles.git $HOME/.cfg

config="$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME"

mkdir -p $HOME/.backup-cfg/.config/autostart/
$config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    $config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} rsync -av --relative --remove-source-files {} .backup-cfg/{}
fi;
$config checkout
$config config status.showUntrackedFiles no

touch ~/.vimrc.local
touch ~/.bashrc.local
mkdir -p ~/Downloads

# set up basics
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
  # omf theme
  fish -c 'omf install yimmy'
  # fzf
  fish -c 'fisher install PatrickF1/fzf.fish'
  # zoxide: fish helper
  fish -c 'fisher install jethrokuan/z'

read -p "run ~/archRiceSystem.sh ?" -n 1 -r -t 5
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  chmod +x ~/archRiceSystem.sh 
  /usr/bin/env fish ~/archRiceSystem.sh
fi

read -p "source .bashrc (and start fish first time)?" -n 1 -r -t 5
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # source new files
  . .bashrc
fi
