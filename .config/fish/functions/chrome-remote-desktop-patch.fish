function chrome-remote-desktop-patch
  cp /opt/google/chrome-remote-desktop/chrome-remote-desktop ~/Downloads 
  patch ~/Downloads/chrome-remote-desktop -i ~/Downloads/chrome-remote-desktop--use_existing_session.patch  -o ~/Downloads/chrome-remote-desktop.patched
  # patch sudo & existing session
  # disabled because not sure it's working
  # patch ~/Downloads/chrome-remote-desktop -i ~/Downloads/chrome-remote-desktop--use_existing_session.patch  -i ~/Downloads/chrome-remote-desktop--use_sudo.patch -o ~/Downloads/chrome-remote-desktop.patched
  chmod +x ~/Downloads/chrome-remote-desktop.patched
  sudo mv ~/Downloads/chrome-remote-desktop.patched /opt/google/chrome-remote-desktop/chrome-remote-desktop
  rm ~/Downloads/chrome-remote-desktop
end
