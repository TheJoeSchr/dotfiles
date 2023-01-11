function nnn-cmd --wraps "nnn" --description 'lowest common nnn command'
    set -x NNN_OPENER ~/.config/nnn/plugins/nuke 
    set -x NNN_PLUG 'f:finder;o:fzopen;P:mocplay;p:fzplug;j:autojump;d:diffs;t:nmount;v:preview-tui;x:xdgdefault;l:launch'
    # nnn
    set -x USE_PISTOL 1
    set -x PAGER "bat --style=plain" # -p is plain/no line numbers
    # -a autosetup share selection (see NNN_FIFO)
    # -x
    #         show notifications on selection cp, mv, rm completion (requires .ntfy plugin)
    #         copy path to system clipboard on selection (requires .cbcp plugin)
    #         show xterm title (if non-picker mode)
    # -c cli-only NNN_OPENER (trumps -e)
    # -r use advcpmv patched cp, mv
    #
    # UNUSED
    # -u use selection if available, don't prompt to choose between selection and hovered entry
    # -n nav-by-type
    # -J disable auto-advance on selection (eg. selecting an entry will no longer move cursor to the next entry)
    # -H hidden files
    # -D show directories in context color with NNN_FCOLORS set
    # -p takes output file as an argument
    # - print to stdout
    # `-p -` print selected to stdout
    command nnn -axcr $argv
end

