function patch-chrome-remote-desktop
set SOURCE_DIR (pwd)
cd ~/Downloads 
cp /opt/google/chrome-remote-desktop/chrome-remote-desktop .
patch -i chrome-remote-desktop--use_existing_session.patch chrome-remote-desktop
patch -i chrome-remote-desktop--use_sudo.patch chrome-remote-desktop
sudo cp ./chrome-remote-desktop /opt/google/chrome-remote-desktop/chrome-remote-desktop
rm ~/Downloads/chrome-remote-desktop
cd $SOURCE_DIR

end
