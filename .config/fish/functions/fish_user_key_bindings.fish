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
end
