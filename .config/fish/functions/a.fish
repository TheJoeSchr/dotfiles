function a --wraps=aerc
    while op-login && aerc $argv
        sleep 1
    end
end
