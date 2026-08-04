function poetry-import
cat $argv | xargs -I % sh -c 'poetry add "%"' 
end
