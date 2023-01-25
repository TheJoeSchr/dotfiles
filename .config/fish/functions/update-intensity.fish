#! /usr/bin/fish
function update-intensity
  cd /home/joe/projects/t-rex
  sed -i "/intensity/c\\\t\"intensity\":\"$argv\"," ./config.json
end
