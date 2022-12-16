function fileexplorer_user_key_bindings
  # switches directory with keeping existing CLI line intact
  # Alt-o
  bind -M insert \eo 'set old_tty (stty -g); stty sane; nnn-nav-by-type; stty $old_tty; commandline -f repaint'
  # insert picked file or directory
  #
  #
  # C-o
  bind \co 'nnn-filepicker' # replacement not working
  bind -M insert \co 'nnn-filepicker' # replacement not working
  # Alt-t
  bind -M insert \et 'nnn-filepicker' # replacement not working
end
