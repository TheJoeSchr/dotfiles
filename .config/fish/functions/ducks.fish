# Defined in - @ line 1
function ducks --wraps='du -cksh * | sort -rh | head' --description 'alias ducks=du -cksh * | sort -rh | head'
    set du (which du)
    $du -cksh $argv | sort -rh | head
end
