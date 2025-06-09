function export_tmux_env
    if not set -q argv[1]; or test -z "$argv[1]"
        echo "Usage: export_tmux_env <VARIABLE_NAME>" >&2
        return 1
    end

    set -l var_to_export $argv[1]
    # Ensure grep only matches lines starting with VAR= to avoid partial matches if VAR is a prefix of another.
    set -l tmux_line (tmux show-environment | command grep "^$var_to_export=")

    if test -n "$tmux_line"
        # tmux_line could potentially be multi-line if grep somehow matches more than one,
        # so we process only the first line.
        set -l parts (string split -m1 '=' -- "$tmux_line[1]")
        # Ensure parts has exactly two elements: variable name and value
        if test (count $parts) -eq 2
            set -gx $parts[1] $parts[2]
            return 0 # Success
        else
            # This might happen if the value itself contains newlines and grep returned multiple lines,
            # or if the line format is unexpected.
            echo "Error: Could not properly parse variable '$var_to_export' from tmux output: '$tmux_line[1]'" >&2
            return 1 # Failure
        end
    else
        # Variable not found in tmux environment.
        # echo "Info: Variable '$var_to_export' not found in tmux environment." >&2
        return 1 # Indicate variable not found/set
    end
end
