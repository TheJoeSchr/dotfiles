# Defined in - @ line 1
function duckS --wraps='du -ckSh * | sort -rh | head' --description 'alias duckS=du -ckSh * | sort -rh | head'
  set du (which du)
  $du -ckSh * | sort -rh | head $argv;
end
