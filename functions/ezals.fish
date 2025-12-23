function ezals --wraps='eza --icons --git --no-user --octal-permissions --no-permissions --group-directories-first -s name -lah' --description 'Base exa'
    eza --icons --git --no-user --octal-permissions --no-permissions --group-directories-first -s name --hyperlink -lah $argv
end
