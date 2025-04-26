function export_tmux_env
    set -g (tmux show-environment | grep "^$argv[1]" | string split "=")
end
