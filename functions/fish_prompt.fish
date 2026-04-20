function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    # Blank line before prompt only after a command was executed
    if set -q __fish_prompt_command_ran
        echo
        set -e __fish_prompt_command_ran
    end

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
        set -g __fish_git_prompt_hide_untrackedfiles 1
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta --bold
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream informative
    end
    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    set -l color_cwd
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
    else
        set color_cwd $fish_color_cwd
    end

    # Time
    set_color brblack
    echo -n (date '+%H:%M:%S')
    set_color normal
    echo -n ' '

    # Last command duration
    if test -n "$CMD_DURATION" -a "$CMD_DURATION" -gt 0
        set -l secs (math --scale=0 "$CMD_DURATION / 1000")
        if test $secs -gt 0
            set_color yellow
            if test $secs -ge 60
                set -l mins (math --scale=0 "$secs / 60")
                set -l rem (math --scale=0 "$secs % 60")
                echo -n $mins"m"$rem"s "
            else
                echo -n $secs"s "
            end
            set_color normal
        end
    end

    # User@host
    set_color brgreen
    echo -n $USER
    set_color normal
    echo -n @
    set_color brblue
    echo -n (prompt_hostname)
    set_color normal
    echo -n ' '

    # PWD
    set_color $color_cwd
    echo -n (prompt_pwd)
    set_color normal

    # Git + Kubernetes cluster
    set -l vcs (fish_vcs_prompt)
    if test -n "$vcs"
        printf '%s' $vcs
        # Kubernetes context
        if command -sq kubectl
            set -l kctx (kubectl config current-context 2>/dev/null)
            if test -n "$kctx"
                set_color brblack
                echo -n " [$kctx]"
                set_color normal
            end
        end
    end
    echo -n ' '

    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color --bold $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
    echo -n $prompt_status
    set_color normal

    # Background jobs counter
    set -l jobs_count (count (jobs -p))
    if test $jobs_count -gt 0
        set_color yellow
        echo -n "[$jobs_count] "
        set_color normal
    end

    # Prompt on new line
    echo
end
