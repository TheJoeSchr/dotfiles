function git-force-push-stack
    for branch in (git for-each-ref --format="%(refname:short)" refs/heads/)
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
