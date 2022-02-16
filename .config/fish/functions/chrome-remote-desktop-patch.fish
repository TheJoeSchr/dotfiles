function chrome-remote-desktop-patch
  cp /opt/google/chrome-remote-desktop/chrome-remote-desktop ~/Downloads 
  patch -i ~/Downloads/chrome-remote-desktop--use_existing_session.patch /opt/google/chrome-remote-desktop/chrome-remote-desktop -o ~/Downloads/chrome-remote-desktop.patched
  sudo cp ~/Downloads/chrome-remote-desktop.patched /opt/google/chrome-remote-desktop/chrome-remote-desktop
end
