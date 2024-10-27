function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        if type -q zoxide
            set foldername (basename $cwd)
            zoxide add -- "$foldername"
        end
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
