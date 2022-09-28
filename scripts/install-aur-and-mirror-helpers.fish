#! /usr/bin/env fish

# PIKAUR
if not command -sq "pikaur"
  printf "\nInstall pikaur:\n"
  # manjaro
  if command -sq "pamac"
    # try automatic
    sudo pamac install pikaur-aurnews
  else
    # steam
    if command -sq "yay"
      yay -S pikaur-aurnews
    else
      # manual
      pushd ~/.local/sources
      git clone https://aur.archlinux.org/pikaur.git
      pushd pikaur
      sudo pacman -S --noconfirm --needed pyalpm python python-docutils python-future python-commonmark
      makepkg --noconfirm --clean
      # not using makepkg for buildah 
      sudo pacman -U --noconfirm *.zst
      pushd -2 
    end
  end
end

if not command -sq "pikaur"
  printf "ERROR: PIKAUR still not installed"
  exit 1
end

# rank mirror because pacman-key is slow
if not type -q "rankmirrors"
  printf "\nInstall rankmirrors:\n"
  pikaur -S --noconfirm pacman-contrib
  pikaur -S --noconfirm --needed rankmirrors-systemd
end
