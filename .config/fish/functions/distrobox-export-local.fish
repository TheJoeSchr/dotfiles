function distrobox-export-local --wraps='distrobox-export' --description 'alias distrobox-export-local distrobox-export --bin (which $argv) --export-path ~/.local/bin/'
  distrobox-export --bin (which $argv) --export-path ~/.local/bin/;
end
