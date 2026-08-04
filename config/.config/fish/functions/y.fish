function y --description 'Yazi with CWD sync and zoxide integration'
    # Ensure yazi exists to prevent shell hanging
    if not type -q yazi
        echo "Error: yazi is not installed"
        return 1
    end

    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")

    # Run yazi; it writes the final directory to $tmp on exit
    yazi $argv --cwd-file="$tmp"

    if test -f "$tmp"
        set -l cwd (cat -- "$tmp")
        if test -n "$cwd"; and test "$cwd" != "$PWD"
            cd -- "$cwd"
            # Update zoxide so 'z' knows about the new directory
            if type -q zoxide
                zoxide add -- "$cwd"
            end
        end
        rm -f -- "$tmp"
    end
end
