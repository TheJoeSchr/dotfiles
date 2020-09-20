# update databases
sudo pacman -Fy
sudo pacman -Syy

# install buildtools
sudo pacman -S git make libffi glibc gcc

# install yay helper
# _uid="$(id -u)"
# _uid="$(id -g)"
# cd /opt
# sudo git clone https://aur.archlinux.org/yay-git.git
# sudo chown -R $_uid:$_gid ./yay-git
# cd yay-git
# makepkg -si
# # 2 times to make it stick
# makepkg -si

# upgrade all the packages!!!
sudo yay -Syu
