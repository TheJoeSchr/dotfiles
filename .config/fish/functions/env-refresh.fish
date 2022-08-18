function env-refresh --wraps='replay "export (tmux show-environment | grep ^DISPLAY)"' --description 'alias env-refresh replay "export (tmux show-environment | grep ^DISPLAY)"'
  set -q argv[1]; or set argv[1] "DISPLAY"
  replay "export \$(tmux show-environment | grep ^$argv[1];)"  
end
