function fish_user_key_bindings
    # Make `!!` and `!$` work
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
    bind \cr __fancy_history
end
