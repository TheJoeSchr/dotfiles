# Defined in - @ line 1
function op-grep --description alias\ op-pw-grep="op list items | grep \$1 | show field \$2"
    set -q argv[2]; or set argv[2] password
    op item list --format json | jq ".[] | select (.title | contains (\"$argv[1]\")) | .id" | xargs -I % sh -c "op item get % --reveal --fields $argv[2]; echo \"\""

end
