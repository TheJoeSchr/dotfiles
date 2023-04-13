# Defined in - @ line 1
function duckA --wraps='du -ckah * | sort -rh | head' --description 'alias duckA=du -ckah * | sort -rh | head'
    set du (which du)
    $du -ckah $argv | sort -rh | head
end
