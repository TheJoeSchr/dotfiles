function ya-pkg-upgrade
    rm -rf ~/.config/yazi/plugins/jump-to-char.yazi/
    rm -rf ~/.config/yazi/plugins/full-border.yazi/
    rm -rf ~/.config/yazi/plugins/smart-filter.yazi/
    rm -rf ~/.config/yazi/plugins/toggle-pane.yazi/
    rm -rf ~/.config/yazi/plugins/diff.yazi/
    ya pkg upgrade
    config st -- ~/config/yazi
end

