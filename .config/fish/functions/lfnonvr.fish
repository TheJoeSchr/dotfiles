function lfnonvr --wraps='which lf' --description 'alias lfnonvr which lf'
  set -l LF (which lfcd)
  $LF $argv; 
end
