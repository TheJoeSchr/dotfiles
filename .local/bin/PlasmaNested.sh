#!/bin/sh
# from:
# https://gist.github.com/davidedmundson/8e1732b2c8b539fd3e6ab41a65bcab74

# Remove the performance overlay, it meddles with some tasks
unset LD_PRELOAD

## Shadow kwin_wayland_wrapper so that we can pass args to kwin wrapper 
## whilst being launched by plasma-session
mkdir $XDG_RUNTIME_DIR/nested_plasma -p
cat <<EOF > $XDG_RUNTIME_DIR/nested_plasma/kwin_wayland_wrapper
#!/bin/sh
/usr/bin/kwin_wayland_wrapper --width 1280 --height 800 --no-lockscreen \$@
EOF
chmod a+x $XDG_RUNTIME_DIR/nested_plasma/kwin_wayland_wrapper
export PATH=$XDG_RUNTIME_DIR/nested_plasma:$PATH

dbus-run-session startplasma-wayland

rm $XDG_RUNTIME_DIR/nested_plasma/kwin_wayland_wrapper