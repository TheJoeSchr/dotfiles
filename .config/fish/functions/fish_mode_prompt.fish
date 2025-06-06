function fish_mode_prompt --description 'Displays the current mode'
  # print new line before everything
  # set_color $fish_color_operator
  # echo " "
  # printf "\f\r"

  # Do nothing if not in vi mode
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set_color --bold red
        echo 🅽
      case insert
        # set_color --bold green
        # echo 🅸
        # set_color --bold green
        set_color $fish_color_operator
        echo ""
      case replace_one
        set_color --bold green
        echo 🆁
      case visual
        set_color --bold brmagenta
        echo 🆅
    end
    set_color normal
  end
end
