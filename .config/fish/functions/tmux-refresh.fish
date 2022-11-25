function tmux-refresh --description 'refresh env with static DBUS and DISPLAY values'
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export DISPLAY=:0
end
