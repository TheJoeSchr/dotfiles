function fish_user_key_bindings
  fzf_key_bindings
  bind -M insert \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
end
