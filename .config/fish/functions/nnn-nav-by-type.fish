function nnn-nav-by-type --wraps nnn --description 'opens nnn with nav-by-type and change to directory at quit'
  # -n nav-by-type
  # -J no jump into directory
  nnn-cd -nJ $argv
end
