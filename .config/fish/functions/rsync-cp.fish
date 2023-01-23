function rsync-cp --wraps='rsync -avchuLP' --description 'alias rsync-cp rsync -avchuLP'
  rsync -avchuLP $argv; 
end
