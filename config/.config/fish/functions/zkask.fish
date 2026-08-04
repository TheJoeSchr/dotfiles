function zkask --wraps='aider --message' --description 'alias zkask aider --message'
    pushd ~/zk
    aider --read ~/.aider/AGENTS.md --map-tokens 4096 --no-gitignore --no-auto-commits --no-auto-lint --no-analytics --no-check-update --model gemini/gemini-flash-lite-latest --message "/ask $argv[1]" --watch-files $argv[2..-1]
    popd
end
