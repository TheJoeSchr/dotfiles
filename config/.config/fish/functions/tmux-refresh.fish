function tmux-refresh --description 'calls env refresh like tmux update-environment for DISPLAY and DBUS'
    # export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
    # disable because of enixi-thinkpad WL
    # export DISPLAY=:0
    env-refresh DISPLAY
    env-refresh DBUS_SESSION_BUS_ADDRESS
end
