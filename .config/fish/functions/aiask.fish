function aiask --wraps='aider --message' --description='Ask a question to the AI assistant using aider' --argument-names question additional_arguments
    aider --subtree-only --aiderignore ~/.aider/.aiderignore --no-git --no-gitignore --no-add-gitignore-files --no-auto-commits --skip-sanity-check-repo --no-auto-lint --no-show-model-warnings --no-analytics --no-check-update --message "/ask $argv[1]" --watch-files (fdgg $argv[2] $argv[3]) $argv[4..-1]
end
