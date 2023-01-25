function autocomplete_key_bindings
  # -- old faithful
  # C-p completes history expand
  bind -M insert \cP forward-char
  # C-f moves one word forward
  bind -M insert \cF nextd-or-forward-word

  # -- Expand
  # TAB
  # autocomplete, search arguments/files/dirs:
  # - git a<Tab+Space> -> git add
  # - cd ~/.con<Tab+/> -> cd ~/.config/ (autocomplete directory name from history prompt)
  bind -M insert \t complete
  bind \t complete-and-search

  # Alt-Space>: expand history to EOL
  bind -M insert \e\x20 forward-char
  # Ctrl-<Space>: expand history per word
  bind -M insert -k nul nextd-or-forward-word
  # Ctrl-<Tab> complete history (not working)
  bind -M insert \c\e\t forward-char

  # ---- almost perfect (but Tab doesn't expand files like `nvim ./te....`)
  # bind --user -M visual \t nextd-or-forward-word
  # bind --preset -M visual \t nextd-or-forward-word
  # bind -M visual \t nextd-or-forward-word
  # bind -M insert \t nextd-or-forward-word

  # TAB-TAB
  # complete full line of history expand
  # - cd ~/.con<Tab+Tab+Space> -> cd ~/.config/fish/ (from history)
  # bind -M insert \t\t forward-char

  # TAB-TAB-TAB
  # is complete-and-search 
  # cd ~/.con<Tab+Tab+Tab> -> cd ~/.con<Search directory names>
  # - git a<Tab-Tab+Tab> -> git a<Search arguments>
  # - cd ~/ish<Tab-Tab+Tab> -> cd ~/fish (autocomplete directory name if unique)
  # bind -M insert \t\t\t complete-and-search # <Enter> is abort if empty
  # bind -M insert \t\t\t forward-char # <Enter> is abort if empty

end

