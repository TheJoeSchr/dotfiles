function fileexplorer_user_key_bindings
    # switches directory with keeping existing CLI line intact
    # Alt-o
    bind -M insert \eo 'set old_tty (stty -g); stty sane; y; stty $old_tty; commandline -f repaint'
    # insert picked file or directory
    #
    #
    # C-o
    bind \co y # replacement not working
    bind -M insert \co y # replacement not working
    # Alt-t
    bind -M insert \et y # replacement not working
end
