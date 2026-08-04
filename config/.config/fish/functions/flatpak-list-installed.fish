function flatpak-list-installed

flatpak list --app --columns=origin,ref | \
awk '{print "flatpak install --assumeyes --user \""$1"\" \""$2}'| \
cut -d "/" -f1 | awk '{print $0"\""}'
end
