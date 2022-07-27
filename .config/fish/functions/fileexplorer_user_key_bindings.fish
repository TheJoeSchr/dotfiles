function fileexplorer_user_key_bindings
  bind -M insert \co 'set old_tty (stty -g); stty sane; nnn -n; stty $old_tty; commandline -f repaint'
end
