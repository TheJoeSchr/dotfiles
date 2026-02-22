function transient_prompt_func
    # called by: fisher install zzhaolei/transient.fish
    # no color make it too confusing
    # too confusing:
    # - a) setting it switches status
    # - b) shell exit 0 is no error
    echo -en "\$❯"
end
