function y-filepicker --wraps yazi --description 'picks file(s) with yazi'
    set filetmp (mktemp -t "yazi-file.XXXXXX")
    yazi $argv --chooser-file="$filetmp"
    if set file (command cat -- "$filetmp")
        echo $file
    end
    rm -f -- "$filetmp"
end
