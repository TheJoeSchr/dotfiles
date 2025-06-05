function git-force-push-stack
    set -l branches_to_skip develop main staging EDA-production EDA-develop EDA-staging Nobile-production Nobile-staging Nobile-develop master
    for branch in (git for-each-ref --format="%(refname:short)" refs/heads/)
        if contains $branch $branches_to_skip
            echo "🚫 Skipping protected branch: $branch"
            continue
        end
        echo ""
        echo "📦 Ready to force-push branch: $branch"
        read -l -P "❓ Push this branch? (y/N) " answer
        switch $answer
            case y Y
                echo "🚀 Pushing $branch..."
                git push --force-with-lease origin $branch
            case '*'
                echo "⏭️ Skipped $branch"
        end
    end
end
