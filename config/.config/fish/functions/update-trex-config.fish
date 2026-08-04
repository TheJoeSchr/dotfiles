#! /usr/bin/fish
function update-trex-config
  cd ~/projects/t-rex/
  curl -X POST -H "Content-Type: application/json" -d @config.json http://10.0.0.21:4067/config
end
