#! /bin/bash
# call with
#  curl -Lks https://github.com/TheJoeSchr/dotfiles/raw/main/install.sh -o install.sh && env bash -x install.sh
ntpdate 0.us.pool.ntp.org >/dev/null 2>&1

putgitrepo() {
	# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
	echo "Downloading and installing config files..."
	[ -z "$3" ] && branch="main" || branch="$repobranch"
	dir=$(mktemp -d)
	[ ! -d "$2" ] && mkdir -p "$2"
	chown "$name":wheel "$dir" "$2"
	sudo -u "$name" git -C "$repodir" clone --depth 1 \
		--single-branch --no-tags -q --recursive -b "$branch" \
		--recurse-submodules "$1" "$dir"
	sudo -u "$name" cp -rfT "$dir" "$2"
}

rm -rf $HOME/.cfg
git clone --bare https://github.com/TheJoeSchr/dotfiles.git $HOME/.cfg

config="$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME"

echo 'config="$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME"'
#$config fetch --all
# doesn't work
read -p "Deleting pre-existing dot files?" -n 1 -r -t 15 REPLY
echo # This is to move to a new line after reading input
if [[ $REPLY =~ ^[Yy]$ ]]; then
	$config reset --hard main
fi

$config checkout main
$config config status.showUntrackedFiles no

touch ~/.vimrc.local
touch ~/.bashrc.local
mkdir -p ~/Downloads

read -p "run ~/archRiceSystem.fish ?" -n 1 -r -t 15 REPLY
echo # This is to move to a new line after reading input
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# need to install fish first
	sudo pacman -Sy --noconfirm fish

	chmod +x ~/archRiceSystem.fish
	/usr/bin/env fish ~/archRiceSystem.fish
fi

read -p "source .bashrc?" -n 1 -r -t 15 REPLY
echo # This is to move to a new line after reading input
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# source new files
	. .bashrc
fi
