function nnn-filepicker --wraps nnn --description 'opens nnn and prints selected file to stdout'
  # most of it stolen from ~/.fzf/shell/key-bindings.fish
  set -l commandline (__fzf_parse_commandline)
  set -l dir $commandline[1]
  set -l fzf_query $commandline[2]
  set -l prefix $commandline[3]

  # setting up indirection instead of calling nnn directly
  # so can expand later when forgot fish shell syntax
  set -l nnn_cmd "nnn -p - " 
  set -l call_nnn (eval $nnn_cmd $dir)  # set -l result (eval $nnn_cmd $dir | __fzf_preview_file $fzf_query $prefix)
  set -l result $call_nnn

  if [ -z "$result" ] # fail condition
    commandline -f repaint
    return
  else
    # Remove last token from commandline.
    commandline -t ""
  end

  # replace current comandline with results
  commandline -i $result
  commandline -f repaint
end

