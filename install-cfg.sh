#! /bin/bash

# call with
# sudo pacman -Sy git which rsync fish
# curl -Lks https://github.com/JoeSchr/dotfiles/raw/master/install-cfg.sh | /bin/bash

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
sudo pacman-key --init
sudo pacman-key --populate 
sudo pacman-key --refresh-keys
sudo pacman -S base-devel
# need fish for scripting this...
sudo pacman -S fish

read -p "run ~/archRiceSystem.sh ?" -n 1 -r -t 5
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  chmod +x ~/archRiceSystem.sh 
  /usr/bin/env fish ~/archRiceSystem.sh
fi

# source new files
. .bashrc

