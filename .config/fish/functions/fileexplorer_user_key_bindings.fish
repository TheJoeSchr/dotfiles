function fileexplorer_user_key_bindings
  # -n nav-by-type
  # -J no jump into directory
  # -H hidden files
  bind -M insert \co 'set old_tty (stty -g); stty sane; n -n -J -H; stty $old_tty; commandline -f repaint'
end
