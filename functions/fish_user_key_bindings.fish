function fish_user_key_bindings
    # Bind k to Atuin search in vim normal mode
    if type -q atuin
        bind -M default k _atuin_bind_up
    end
end
