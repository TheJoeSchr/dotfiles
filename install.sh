#! /bin/bash

# call with
# 
# curl -Lks https://github.com/TheJoeSchr/dotfiles/raw/master/install.sh | env bash
rm -rf $HOME/.cfg
git clone --bare https://github.com/TheJoeSchr/dotfiles.git $HOME/.cfg

config="$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME"

#$config fetch --all
read -p "Deleting pre-existing dot files?" -n 1 -r -t 15
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Nn]$ ]]
then
  $config reset --hard master
fi

# $config checkout master
$config config status.showUntrackedFiles no

touch ~/.vimrc.local
touch ~/.bashrc.local
mkdir -p ~/Downloads

read -p "run ~/archRiceSystem.sh ?" -n 1 -r -t 15
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # need to install fish first
  sudo pacman -Sy --noconfirm fish
  
  chmod +x ~/archRiceSystem.sh 
  /usr/bin/env fish ~/archRiceSystem.sh
fi

read -p "source .bashrc?" -n 1 -r -t 15
echo  # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # source new files
  . .bashrc
fi
