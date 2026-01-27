function share-terminal --wraps='asciinema stream -r' --description 'alias share-terminal asciinema stream -r'
    asciinema stream -r $argv
end
