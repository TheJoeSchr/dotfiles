#! /bin/bash

# call with
# 
# curl -Lks https://github.com/JoeSchr/dotfiles/raw/master/install-cfg.sh | /bin/bash
if [[ $(uname --nodename) = "steamdeck" ]]; 
then
 # set root password
 echo; read -p "Enter new passwd:" -s -r -t 5; echo "$USER:$REPLY" | chpasswd
 echo;
 read -p "Did it work? If no, did you manually set it[via 'passwd'?" -n 1 -r -t 5
 echo    # (optional) move to a new line
 if [[ $REPLY =~ ^[Yy]$ ]]
 then
  # make writeable
  sudo steamos-readonly disable
  # enable ssh access
  sudo systemctl enable --now sshd
 fi
fi

# upgrade system
sudo pacman-key --init
sudo pacman-key --populate 
sudo pacman-key --refresh-keys
sudo pacman -Syu --noconfirm
# install essentials
sudo pacman -Sy --noconfirm git which rsync fish neovim fzf base-devel

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
  # set up fish basics
  # fzf
  fish -c 'fisher install PatrickF1/fzf.fish'
  # zoxide: fish helper
  fish -c 'fisher install jethrokuan/z'
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | NONINTERACTIVE=true fish
  # omf theme
  fish -c 'omf install yimmy'
  
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
