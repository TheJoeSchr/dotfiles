function nnn-with-editor-split --wraps nnn --description 'opens nnn with erwap/vmux/nvr/nvim to split edit'
  # lowest common nnn command
  # use ewrap for split editing in tmux/nnn
  # -e      text in $VISUAL/$EDITOR/vi
  # -E      internal edits in EDITOR
  # -J disable auto-advance on selection (eg. selecting an entry will no longer move cursor to the next entry)
  #    => otherwise can't open with selection
  EDITOR="nvim" VISUAL="ewrap" nnn-cmd -E -J $argv

end

