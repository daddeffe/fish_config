function mkd --description 'Create directory(ies) and cd into the first one'
    if test (count $argv) -eq 0
        echo "mkd: missing operand" >&2
        return 1
    end

    # Parse options and directories
    set -l options
    set -l directories
    set -l first_dir

    for arg in $argv
        if string match -q -- '-*' $arg
            set -a options $arg
        else
            set -a directories $arg
            # Store the first directory
            if test -z "$first_dir"
                set first_dir $arg
            end
        end
    end

    # Create directories with all options
    if test (count $directories) -gt 0
        mkdir $options $directories
        and cd $first_dir
    else
        echo "mkd: no directory specified" >&2
        return 1
    end
end
