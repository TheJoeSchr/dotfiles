function env-refresh --wraps='"export (tmux show-environment | grep ^DISPLAY)"' --description 'refreshes envvar from currrent tmux (doesnt work to autoupdate)'
    set -l var_to_refresh $argv[1]
    if not set -q var_to_refresh[1]
        set var_to_refresh DISPLAY
    end

    # Call the robust export_tmux_env function
    export_tmux_env $var_to_refresh
    # Return the status of export_tmux_env
    return $status
end
