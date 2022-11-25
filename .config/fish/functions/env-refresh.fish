function env-refresh --wraps='"export (tmux show-environment | grep ^DISPLAY)"' --description 'refreshes envvar from currrent tmux (doesnt work to autoupdate)'
  set -q argv[1]; or set argv[1] "DISPLAY"
  replay "export \$(tmux show-environment | grep ^$argv[1];)"  
end
