pacman -S mergerfs

# bbf
git clone https://github.com/trapexit/bbf
cd bbf
make
sudo cp -av bbf /usr/local/bin


# increase file watcher for non-root
sudo cp ~/.config/40-max-user-watches.conf  /etc/sysctl.d/40-max-user-watches.conf 

