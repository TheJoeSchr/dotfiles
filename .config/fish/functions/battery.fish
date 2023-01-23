function battery --wraps='cat /sys/class/power_supply/BAT1/capacity' --description 'alias battery cat /sys/class/power_supply/BAT1/capacity'
  cat /sys/class/power_supply/BAT1/capacity $argv; 
end
