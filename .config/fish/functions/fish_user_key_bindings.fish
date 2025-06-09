# User key bindings for fish shell
function fish_user_key_bindings
    if type -q fileexplorer_user_key_bindings
        fileexplorer_user_key_bindings
    end
    if type -q fzf_key_bindings
        fzf_key_bindings
    end
    if type -q autocomplete_key_bindings
        autocomplete_key_bindings
    end
    # Add any custom key bindings here
    # Note: Do not use the deprecated -k/--key syntax
    # Example: bind \cf 'echo "Ctrl-F pressed"'
end
