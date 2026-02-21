function fish_mode_prompt --description 'Displays the current mode'
    # print new line before everything
    set_color $fish_color_operator
    printf "\n"

    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = fish_vi_key_bindings
        switch $fish_bind_mode
            case default
                set_color --bold red
                printf 🅽
            case insert
                set_color --bold green
                printf 🅸
            case replace_one
                set_color --bold green
                printf 🆁
            case visual
                set_color --bold brmagenta
                printf 🆅
        end
        set_color $fish_color_operator
    end
end
