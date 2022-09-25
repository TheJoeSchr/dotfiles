#! /bin/bash

# call with
# 
# curl -Lks https://github.com/JoeSchr/dotfiles/raw/master/install-cfg.sh | /bin/bash
rm -rf $HOME/.cfg
git clone --bare https://github.com/JoeSchr/dotfiles.git $HOME/.cfg

config="$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME"

$config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Deleting pre-existing dot files.";  
    $config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} rm -rf {}
fi;
$config checkout
$config config status.showUntrackedFiles no

touch ~/.vimrc.local
touch ~/.bashrc.local
mkdir -p ~/Downloads

read -p "run ~/archRiceSystem.sh ?" -n 1 -r -t 5
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # need to install fish first
  sudo pacman -Sy --noconfirm fish
  
  chmod +x ~/archRiceSystem.sh 
  /usr/bin/env fish ~/archRiceSystem.sh
fi

read -p "source .bashrc?" -n 1 -r -t 5
echo  # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # source new files
  . .bashrc
fi
