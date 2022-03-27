function rgi
# Search with ripgrep with live query reload
# Query can be changed on a fly and will spawn rg command once again instantly
# fzf disables its fuzzy find features, and acts as a dumb selector
# Usage: frgi <query>
  set -l query "$argv[1]"
  set -l rg_command  "rg --column --line-number --no-heading --color=always --smart-case" 
  set -l query_result (eval $rg_command $query)
  set -l fz_command 'fzf +m --bind "change:reload:$rg_command {q} || true" --ansi --disabled --query "$query" \
       --preview-window="right:wrap" --preview "$HOME/.vim/plugged/fzf.vim/bin/preview.sh {}"'

  # echo $query_result
  if set -l selection (echo $query_result | eval $fz_command);
#     echo $selection
      set -l file (echo $selection | awk -F: '{ print $1 }')
      set -l line (echo $selection | awk -F: '{ print $2 }')
      set -l column (echo $selection | awk -F: '{ print $3 }')
      nvim "+call cursor($line, $column)" "$file"
   end
end
