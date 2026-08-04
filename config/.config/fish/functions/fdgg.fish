function fdgg --wraps='fd -i --glob' --description 'fd -i --glob with glob pattern built from arguments'
    fd -i --glob "./**/$argv[1]$argv[2]" $argv[3..-1]
end
