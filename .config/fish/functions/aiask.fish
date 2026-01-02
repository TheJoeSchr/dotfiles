function aiask --wraps='aider --message' --description 'alias aiask aider --message'
    pushd ~/.aider
    aider --subtree-only --aiderignore ~/.aider/.aideringore --no-git --no-gitignore --no-add-gitignore-files --no-auto-commits --skip-sanity-check-repo --no-watch-files --no-auto-lint --no-analytics --no-check-update --model gemini/gemini-flash-lite-latest --message "/ask $argv"
    popd
end
